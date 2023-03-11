from bs4 import BeautifulSoup
import requests
import json
import boto3

def lambda_handler(event, context):
#Set up a connection to S3
    s3 = boto3.client('s3')


    Breakfast = ["Breakfast - Spring ",  "Breakfast - Fall ", "Breakfast - Winter ", "Breakfast - Summer "]
    Lunch = ["Lunch - Spring ", "Lunch - Fall ", "Lunch - Winter ", "Lunch - Summer "]
    Dinner = ["Dinner - Spring ", "Dinner - Fall ", "Dinner - Winter ", "Dinner - Summer "]
    AllDay = ["All Day "]
    Brunch = ["Brunch - Spring ", "Brunch - Fall ", "Brunch - Winter ", "Brunch - Spring "]
    meals = {}
    dining = ["Cafe_3", "Clark_Kerr_Campus", "Crossroads", "Foothill"]

    for diner in dining:
        previous = None
        items = []
        url = 'https://caldining.berkeley.edu/menus/?location=' + diner
        response = requests.get(url)
        soup = BeautifulSoup(response.text, 'html.parser')
        meals[diner] = {}

        for halls in soup.find_all("ul", class_="meal-period"):
            for meal in halls.find_all('li'):

                for item in meal.find_all('span', class_= None):
                    #print(item)
                    if item.text in Breakfast:
                        meals[diner][previous] = items
                        previous = "Breakfast"
                        items = []

                    elif item.text in Lunch:
                        meals[diner][previous] = items
                        previous = "Lunch"
                        items = []

                    elif item.text in Dinner:
                        meals[diner][previous] = items
                        previous = "Dinner"
                        items = []

                    elif item.text in AllDay:
                        meals[diner][previous] = items
                        previous = "All Day"
                        items = []

                    elif item.text in Brunch:
                        meals[diner][previous] = items
                        previous = "Brunch"
                        items = []

                    elif item.text.isupper() or item.text in items:
                        pass
                    else:
                        items.append(item.text)

        meals[diner][previous] = items

    for diner in meals:
        del meals[diner][None]

    meals["Cafe 3"] = meals["Cafe_3"]
    del meals["Cafe_3"]

    meals["Clark Kerr Campus"] = meals["Clark_Kerr_Campus"]
    del meals["Clark_Kerr_Campus"]

    # return menu_items
    # Set the name of the S3 bucket and the key for the object
    bucket_name = "ucbdiningmenus"
    key_name = "data.json"

    # Convert the dictionary to a JSON string
    json_data = json.dumps(meals)

    # Store the JSON string in the S3 bucket
    s3.put_object(Bucket=bucket_name, Key=key_name, Body=json_data)

    # Empty return statement
    return "Now go check your S3 bucket"
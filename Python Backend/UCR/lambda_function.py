from bs4 import BeautifulSoup
import requests
import json
import boto3

def lambda_handler(event, context):
#Set up a connection to S3
    s3 = boto3.client('s3')

    halls = {"Glasgow": "03", "Lothian Residential Restaurant": "02"}
    menu = {}
    
    for hall in halls:

        url = 'https://foodpro.ucr.edu/foodpro/shortmenu.asp?sName=University+of+California%2C+Riverside+Dining+Services&locationNum='+halls[hall]
        response = requests.get(url)
        soup = BeautifulSoup(response.text, 'html.parser')
        meals = []
        menu[hall] = {}
        items = []
        count = 0
        for meal in soup.find_all("div", class_="shortmenumeals"):
            meals.append(meal.text)

        for item in soup.find_all("tr", height = "5"): #columns
            items = []
            for food in item.find_all("div", class_ = "shortmenurecipes"): #actual food items
                items.append(food.text.replace('w/', 'with'))
            menu[hall][meals[count]] = items
            count += 1

    #return menu_items
    # Set the name of the S3 bucket and the key for the object
    bucket_name = "ucrdiningmenus"
    key_name = "data.json"

    # Convert the dictionary to a JSON string
    json_data = json.dumps(menu)

    # Store the JSON string in the S3 bucket
    s3.put_object(Bucket=bucket_name, Key=key_name, Body=json_data)

    # Empty return statement
    return "Now go check your S3 bucket"






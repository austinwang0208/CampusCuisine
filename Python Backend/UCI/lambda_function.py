import urllib.request
import requests
from bs4 import BeautifulSoup
import json
import boto3
from selenium import webdriver

def lambda_handler(event, context):
    # Set up a connection to S3
    s3 = boto3.client('s3')

    restaurants = ['Epicuria', 'DeNeve', 'BruinPlate']
    mealtimes = ['Breakfast','Lunch','Dinner']

    # Create dictionary
    AllDiningHalls = {}

    # Loop through each restaurant
    for restaurant in restaurants:
        RestaurantMenu = {}
        for mealtime in mealtimes:
            arr = []
            # Get the name of the restaurant for the title of the txt file
            print("current restaurant: " + restaurant + " " + mealtime)

            # Combine the prestring 'http://menu.dining.ucla.edu/' and the href name of restaurant)
            link = "http://menu.dining.ucla.edu/Menus/" + restaurant + "/" + mealtime
            print("scraping this current link: " + link)
            
            # Use requests to get the HTML of the page
            request = requests.get(link)

            # Parse the HTML with BeautifulSoup
            parsable = BeautifulSoup(request.text, 'html.parser')

            # Find all the menu items in the restaurant
            items = parsable.find_all('a', class_='recipelink')
            
            # Loop through each menu item and write the name to the file
            for item in items:
                #get only the text portion of item
                dish = str(item)
                dish = dish[dish.index('>')+1:]
                dish = dish[:dish.index('<')]
                    
                if not (dish == "Small (12 oz)" or dish == "Medium (16 oz)" or dish == "Large (20 oz)" or dish == "Iced (16 oz)"):
                    arr.append(dish)
            # Add array to dictionary once we are done adding all user friendly menu items
            RestaurantMenu[mealtime] = arr
        if restaurant == "Epicuria":
            AllDiningHalls["Epicuria at Covel"] = RestaurantMenu
        elif restaurant == "DeNeve":
            AllDiningHalls["De Neve"] = RestaurantMenu
        elif restaurant == "BruinPlate":
            AllDiningHalls["Bruin Plate"] = RestaurantMenu

    # Return dictionary, keys = restaurant names, values = array of menu items
    #return AllDiningHalls

    # Set the name of the S3 bucket and the key for the object
    bucket_name = "diningmenus"
    key_name = "data.json"

    # Convert the dictionary to a JSON string
    json_data = json.dumps(AllDiningHalls)

    # Store the JSON string in the S3 bucket
    s3.put_object(Bucket=bucket_name, Key=key_name, Body=json_data)

    # Empty return statement
    return "Now go check your S3 bucket"
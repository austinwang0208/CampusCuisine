import requests
from bs4 import BeautifulSoup
from datetime import date
import json
import boto3

def lambda_handler(event, context):
    # Set up a connection to S3
    s3 = boto3.client('s3')
    
    menu_items = {}
    places = ['Carrillo', 'De La Guerra', 'Ortega', 'Portola']
    meals = ['Breakfast', 'Brunch', 'Lunch', 'Dinner', 'Late-Night']
    current_date = date.today()
    for place in places:
        menu_items[place] = {}
        for meal in meals:
            url = 'https://apps.dining.ucsb.edu/menu/day?dc='+place+'&d='+str(current_date)+'&m='+meal+'&food='
            response = requests.get(url)
            soup = BeautifulSoup(response.text, 'html.parser')

            for panel in soup.select('.panel-body'):
                items = []
                for item in panel.select('dd'):
                    items.append(item.text)
                if len(items) > 0:
                    menu_items[place][meal] = items
        # Edit: To remove - in De-La-Guerra
        if "-" in place:
            menu_items[place.replace("-", " ")] = menu_items.pop(place)
    #return menu_items
    # Set the name of the S3 bucket and the key for the object
    bucket_name = "ucsbdiningmenus"
    key_name = "data.json"

    # Convert the dictionary to a JSON string
    json_data = json.dumps(menu_items)

    # Store the JSON string in the S3 bucket
    s3.put_object(Bucket=bucket_name, Key=key_name, Body=json_data)

    # Empty return statement
    return "Now go check your S3 bucket"




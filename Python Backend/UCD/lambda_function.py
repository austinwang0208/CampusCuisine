import requests
from bs4 import BeautifulSoup
from datetime import datetime
import json
import boto3


# def lambda_handler(event, context):
# Set up a connection to S3
s3 = boto3.client('s3')


dt = datetime.now()
day = dt.strftime('%A')

index = {"Sunday": "h1", "Monday": "h2", "Tuesday": "h3", "Wednesday": "h4", "Thursday": "h5", "Friday": "h6", "Saturday": "h7"}
diningHalls = ['Latitude', 'Segundo', 'Tercero', 'Cuarto']
menu_items = {}

for place in diningHalls:
    url = 'https://housing.ucdavis.edu/dining/menus/dining-commons/' + place + '/'
    response = requests.get(url)
    soup = BeautifulSoup(response.text, 'html.parser')
    menu_items[place] = {}


    for tab in soup.find_all('div', id = 'tab4content'): #tab[number of day of week, so 1 is sunday, 2 is monday
        for meal in tab.find_all('div', class_ = False):
            items = []
            for li_tag in meal.find_all('li'):
                for span_tag in li_tag.find_all('span'):
                    items.append(span_tag.text)

            x = meal.findNext(index[day]).text.capitalize()
            if menu_items[place].get(x) is not None:
                menu_items[place][x] = menu_items[place][x] + items
            else:
                menu_items[place][x] = items
    for hall in menu_items:
        meals = ['Breakfast', 'Lunch', 'Dinner']
        for meal in meals:
            if menu_items[hall].get(meal) is None:
                menu_items[hall][meal] = []

print(menu_items)
    # #return menu_items
    # # Set the name of the S3 bucket and the key for the object
    # bucket_name = "ucddiningmenus"
    # key_name = "data.json"
    #
    # # Convert the dictionary to a JSON string
    # json_data = json.dumps(menu_items)
    #
    # # Store the JSON string in the S3 bucket
    # s3.put_object(Bucket=bucket_name, Key=key_name, Body=json_data)
    #
    # # Empty return statement
    # return "Now go check your S3 bucket"


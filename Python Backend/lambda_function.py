import requests
from bs4 import BeautifulSoup
from datetime import datetime
import json
import boto3

def lambda_handler(event, context):
#Set up a connection to S3
    s3 = boto3.client('s3')


    url = 'https://ucsc.cc/'
    response = requests.get(url)
    soup = BeautifulSoup(response.text, 'html.parser')

    tds = soup.find('td', {'data-checkbox': "date-" + datetime.today().strftime('%Y%m%d')})
    ul = tds.find("ul", class_="inner ordered")  # date section
    menu = {}

    for li in ul.findAll("li"):  # every dining hall open for date
        y = ("".join([c for c in li.findNext("label", {
            "data-orig": ["College Nine/John R Lewis", "Cowell/Stevenson", "Porter/Kresge", "Crown/Merrill"]}).text if
                      c.isalpha() or c == " " or c == "/"]).rstrip().lstrip())
        try:
            z = menu[y]
        except KeyError:
            menu[y] = {}

        for li2 in li.findAll("li", class_="r-meal"):  # every meal
            x = li2.find("label", {"data-orig": ["Breakfast", "Lunch", "Dinner", "Late Night"]}).text
            items = []
            menu[y][x] = []
            for li3 in li2.findAll("li", class_="r-food"):
                items.append(
                    ("".join([c for c in li3.text if c.isalpha() or c == " "])).replace("hidefavorite", "").rstrip())
            menu[y][x] = items

    Halls = ["College Nine/John R Lewis", "Cowell/Stevenson", "Porter/Kresge", "Crown/Merrill"]
    for hall in Halls:
        try:
            z = menu[hall]
        except KeyError:
            menu[hall] = {}

    try:
        z = menu["College Nine/John R Lewis"]
        menu["College Nine and John R Lewis"] = z
        del menu["College Nine/John R Lewis"]
    except:
        pass

    try:
        z = menu["Porter/Kresge"]
        menu["Porter and Kresge"] = z
        del menu["Porter/Kresge"]
    except:
        pass

    try:
        z = menu["Cowell/Stevenson"]
        menu["Cowell and Stevenson"] = z
        del menu["Cowell/Stevenson"]
    except:
        pass

    try:
        z = menu["Crown/Merrill"]
        menu["Crown and Merrill"] = z
        del menu["Crown/Merrill"]
    except:
        pass


    #return menu_items
    # Set the name of the S3 bucket and the key for the object
    bucket_name = "ucscdiningmenus"
    key_name = "data.json"

    # Convert the dictionary to a JSON string
    json_data = json.dumps(menu)

    # Store the JSON string in the S3 bucket
    s3.put_object(Bucket=bucket_name, Key=key_name, Body=json_data)

    # Empty return statement
    print(datetime.today().strftime('%Y%m%d'))

    return "Now go check your S3 bucket"

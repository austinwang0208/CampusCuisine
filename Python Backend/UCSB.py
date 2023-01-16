import requests
from bs4 import BeautifulSoup
from datetime import date

menu_items = {}
places = ['Carrillo', 'De-la-guerra', 'Ortega', 'Portola']
meals = ['Breakfast', 'Brunch', 'Lunch', 'Dinner', 'Late-Night']
date = date.today()
for place in places:
    menu_items[place] = {}
    for meal in meals:
        url = 'https://apps.dining.ucsb.edu/menu/day?dc='+place+'&d='+str(date)+'&m='+meal+'&food='
        response = requests.get(url)
        soup = BeautifulSoup(response.text, 'html.parser')

        for panel in soup.select('.panel-body'):
            items = []
            for item in panel.select('dd'):
                items.append(item.text)
            if len(items) > 0:
                menu_items[place][meal] = items

print(menu_items)

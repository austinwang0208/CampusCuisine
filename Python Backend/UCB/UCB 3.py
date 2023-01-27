from bs4 import BeautifulSoup
import requests

url = 'https://caldining.berkeley.edu/menus/?location=Clark_Kerr_Campus'

response = requests.get(url)
soup = BeautifulSoup(response.text, 'html.parser')
items = []
New = ["Breakfast - Spring ", "Lunch - Spring ", "Dinner - Spring "]


for halls in soup.find_all("ul", class_="meal-period"):
    for meal in halls.find_all('li'):

        for item in meal.find_all('span', class_= None):
            if item.text in New:
                items = []
                print("yes")
            elif item.text.isupper() or item.text in items:
                pass
            else:
                items.append(item.text)
        print(items)


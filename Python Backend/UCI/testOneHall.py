from selenium import webdriver
from bs4 import BeautifulSoup
from selenium.webdriver.common.by import By
from selenium.webdriver.support.select import Select

# Start the browser and navigate to the website
options = webdriver.ChromeOptions()
options.add_argument("--start-maximized")
driver = webdriver.Chrome(options=options)

driver.implicitly_wait(10)
print("succesfully waited 30 seconds")
driver.get('https://uci.campusdish.com/LocationsAndMenus/Brandywine')

# Close Pop Up Promotional
print("going to close pop up")
button = driver.find_element(by = By.CLASS_NAME, value = "sc-ciZhAO.bKsLXl")
#button = driver.find_element_by_xpath("//button[@aria-label='Close']")
button.click()
driver.implicitly_wait(10)
# Find the dropdown menu and select a mealtime
#dropdown = driver.find_element(By.CSS_SELECTOR, "button.sc-eGAhfa.grdPAz.DateMealFilterButton")
#dropdown.click()
#print("successfully cliked dropdown")
# Find mealtime button inside pop up
#mealtime = driver.find_element_by_class_name("select-wrapper-main css-b62m3t-container")
#mealtime.click()

# Use BeautifulSoup to scrape the menu
#soup = BeautifulSoup(driver.page_source, 'html.parser')
#dishes = []
#for dish in soup.find_all('span', class_='location-menu-dish'):
#    dishes.append(dish.text)

#print(dishes)

# Close the browser
driver.quit()
from selenium import webdriver
from selenium.common.exceptions import NoSuchElementException
import login

# Call our login function
driver = login.login('standard_user', 'secret_sauce')

def add_to_cart(driver, inventory_item):
    item_number = 0
    if 'Sauce Labs Bike Light' in inventory_item:
        item_number = 0
    elif 'Sauce Labs Bolt T-Shirt' in inventory_item:
        item_number = 1
    elif 'Sauce Labs Onesie' in inventory_item:
        item_number = 2
    elif 'Test.allTheThings() T-Shirt (Red)' in inventory_item:
        item_number = 3
    elif 'Sauce Labs Backpack' in inventory_item:
        item_number = 4
    elif 'Sauce Labs Fleece Jacket' in inventory_item:
        item_number = 5
    driver.find_element_by_css_selector("div[class='inventory_item'] > div[class='inventory_item_label'] > a[id='item_" + str(item_number) + "_title_link'] > div[class='inventory_item_name']").click()
    driver.find_element_by_class_name("btn_primary").click()
    driver.find_element_by_class_name("inventory_details_back_button").click()

def remove_from_cart(driver, inventory_item):
    item_number = 0
    if 'Sauce Labs Bike Light' in inventory_item:
        item_number = 0
    elif 'Sauce Labs Bolt T-Shirt' in inventory_item:
        item_number = 1
    elif 'Sauce Labs Onesie' in inventory_item:
        item_number = 2
    elif 'Test.allTheThings() T-Shirt (Red)' in inventory_item:
        item_number = 3
    elif 'Sauce Labs Backpack' in inventory_item:
        item_number = 4
    elif 'Sauce Labs Fleece Jacket' in inventory_item:
        item_number = 5
    driver.find_element_by_class_name("shopping_cart_link").click()
    driver.find_element_by_css_selector("div[class='cart_item'] > div[class='cart_item_label'] > a[id='item_" + str(item_number) + "_title_link'] > div[class='inventory_item_name']").click()
    driver.find_element_by_class_name("btn_secondary").click()

# Create a list of all items on the page.   
items = ['Sauce Labs Bike Light', 'Sauce Labs Bolt T-Shirt', 'Sauce Labs Onesie', 'Test.allTheThings() T-Shirt (Red)', 'Sauce Labs Backpack', 'Sauce Labs Fleece Jacket']

# Add all items to the cart
for item in items:
    add_to_cart(driver, item)
    print (item + ' added to cart.')
assert driver.find_element_by_class_name('shopping_cart_badge').text == '6'

# Remove all items from the cart
for item in items:
    remove_from_cart(driver, item)
    print (item + ' removed from cart')

# Check for an empty cart
empty_cart = False
try:
    driver.find_element_by_class_name('shopping_cart_badge')
except NoSuchElementException as e:
    empty_cart = True
if empty_cart:
    print ('All items removed from cart')
else:
    print ('Items are still in the cart')

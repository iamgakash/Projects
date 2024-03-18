# Northwind Traders

## Project Objective

To analyze and enhance the business performance of Northwind Traders by optimizing sales, customer engagement, product performance, on-time delivery rates, revenue, expenses, and market penetration. The goal is to reverse declining trends, improve customer satisfaction, and increase market share in key regions.

## Data Description

### orders

- orderID	- Unique identifier for each order
- customerID - The customer who placed the order
- employeeID -	The employee who processed the order
- orderDate -	The date when the order was placed
- requiredDate -	The date when the customer requested the order to be delivered
- shippedDate -	The date when the order was shipped
- shipperID -	The ID of the shipping company used for the order
- freight -	The shipping cost for the order (USD)

### order_details

- orderID -	The ID of the order this detail belongs to
- productID -	The ID of the product being ordered
- unitPrice -	The price per unit of the product at the time the order was placed (USD - discount not included)
- quantity -	The number of units being ordered
- discount - The discount percentage applied to the price per unit

### customers

- customerID -	Unique identifier for each customer
- companyName -	The name of the customer's company
- contactName	- The name of the primary contact for the customer
- contactTitle - The job title of the primary contact for the customer
- city	- The city where the customer is located
- country	- The country where the customer is located

### products

- productID -	Unique identifier for each product
- productName -	The name of the product
- quantityPerUnit -	The quantity of the product per package
- unitPrice	- The current price per unit of the product (USD)
- discontinued	- Indicates with a 1 if the product has been discontinued
- categoryID	- The ID of the category the product belongs to

### categories

- categoryID	- Unique identifier for each product category
- categoryName	- The name of the category
- description	- A description of the category and its products

### employees

- employeeID	- Unique identifier for each employee
- employeeName	- Full name of the employee
- title	- The employee's job title
- city	- The city where the employee works
- country	- The country where the employee works
- reportsTo	- The ID of the employee's manager

### shippers

- shipperID	- Unique identifier for each shipper
- companyName	- The name of the company that provides shipping services

## Data Model

![image](https://github.com/iamgakash/Projects/assets/159927555/b62aa251-9299-4bfc-bb59-e20f1d7ede58)

## Dashboard Screenshots

![Northwind Traders Report_page-0001](https://github.com/iamgakash/Projects/assets/159927555/7e681cae-717b-4027-b70c-9ce46f567fc2)



https://github.com/iamgakash/Projects/assets/159927555/b9ead78e-6ff1-42e5-9cde-5376050c4662























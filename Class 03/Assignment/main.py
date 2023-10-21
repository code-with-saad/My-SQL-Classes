import db
from query import *
import json

# database connect
db_conn = db.mysqlconnect()


# create a python script that ask following questions

# press 1 to add employee
# press 2 to add customers
# press 3 to add orders
# press 4 to add payment detail
# press 5 to show dashboard stats
# press 6 to show all employees
# press 7 to show all employees (name) along with the city and country name they are
#  working and their job title
# press 8 to show all product name and price and product category name
# press 9 to show all employees name who captures the customer
# press 10 to show all employees who didn't suceed in capturing the customer
# press 11 to show the employee names along with the sale they managed to capture by customer


usr_input = int(input(
    "press 1 to add employee:  \npress 2 to add customers:  \npress 3 to add orders: \npress 4 to add payment detail: \npress 5 to show dashboard stats: \npress 6 to show all employees: \npress 7 to show all employees (name) along with the city and country name they are working and their job title: \npress 8 to show all product name and price and product category name: \npress 9 to show all employees name who captures the customer: \npress 10 to show all employees who didn't suceed in capturing the customer: \npress 11 to show the employee names along with the sale they managed to capture by customer: \n"
))

match usr_input:
    case 1:
        # add employee
        employee_info = {
            "fname": "Muhammad ",
            "lname": "faraz",
            "ext": "x1023",
            "email": "faraz@gmail.com",
            "office_code": 7,
            "report_to": 1102,
            "job_title": "Sales Rep"}
        add_employee = add_employee(db_conn, employee_info)

    case 2:
        # add customer
        customer_info = {
            "customerNumber": 501,
            "customerName": "Rohit Gill",
            "contactLastName": "Gill",
            "contactFirstName": "Rohit",
            "phone": "23652333",
            "addressLine1": "Lorum Ipsum",
            "addressLine2": "Lorum Ipsum",
            "city": "Khi",
            "state": "Sindh",
            "postalCode": "789845",
            "country": "Pakistan",
            "salesRepEmployeeNumber": "1002",
            "creditLimit": "96325"
        }
        add_customer = add_customer(db_conn, customer_info)

    case 3:
        # Add order
        order_details = {
            "orderNumber": 10426,
            "orderDate": "2023-05-30",
            "requiredDate": "2023-06-11",
            "shippedDate": "2023-06-19",
            "status": "Shipped",
            "comments": "Awais Custom shipping instructions were sent to warehouse",
            "customerNumber": 314
        }

        add_order = add_orders(db_conn, order_details)

    case 4:

        # add payment detail
        payment_details = {
            "customerNumber": "103",
            "checkNumber": "AW123456",
            "paymentDate": "2023-06-06",
            "amount": "32641.98"
        }

        add_payment_detail = add_payment_detail(db_conn, payment_details)

    case 5:
        # total employees
        total_emp = get_total_employee(db_conn)
        total_emp = total_emp["total_employee"]

        # total customers
        total_cust = get_total_customer(db_conn)
        total_cust = total_cust["total_customer"]

        # total orders recieved this month
        total_orders = get_total_current_month_orders(db_conn)
        total_orders = total_orders["total_orders"]

        # total payments recieved this month (amount)
        total_payment_received = get_total_monthly_payment_received(db_conn)
        total_payment_received = total_payment_received['total_payment_received']

        print(
            f"Total employees are {total_emp} \nTotal customers are {total_cust} \nTotal Orders are {total_orders} \nTotal Payment received are {total_payment_received}")

    case 6:
        all_employees = show_all_employees(db_conn)
        for row in all_employees:
            print(row["employee_name"])

    case 7:
        all_employees_with_country_city = all_employee_info(db_conn)
        print(f"Employee Name \t Job Title \t Coutry \t City")
        for row in all_employees_with_country_city:
            print(
                f"{row['full_name']} \t {row['job_title']} \t {row['country']} \t {row['city']}")

    case 8:

        all_product_with_category = all_product_info(db_conn)
        print(f"Product Name \t Product Category \t Price")
        for row in all_product_with_category:
            print(
                f"{row['productName']} \t {row['productLine']} \t {row['buyPrice']}")

    case 9:
        all_employee_have_customer = all_employees_capture_customer(db_conn)
        print("List of all employees who captured customers")
        for row in all_employee_have_customer:
            print(
                f"{row['full_name']}")
    case 10:

        all_employee_without_customer = all_employees_failed_capturing_customer(
            db_conn)
        print("List of all employees who didn't captured any customers")
        for row in all_employee_without_customer:
            print(
                f"{row['full_name']}")

    case 11:

        all_employee_customer_payment = employee_with_sales_info(db_conn)
        print("List of all employees who captured any customers with price")
        for row in all_employee_customer_payment:
            print(
                f"{row['full_name']} Sale Managed ${row['amount']} to capture by customer")

    case _:
        print("Invalid Input. Please try again!")


# Add multiple Employees
# add_employees_many(db_conn)

# insert 5 customers
# insert_customers(db_conn)


# insert 3 orders of customer_1 and customer_2 only
# add_customer_order(db_conn)

# insert payment of only 1 customer_1


# dashboard stats
# # total employees
# total_emp = get_total_employee(db_conn)
# total_emp = total_emp["total_employee"]
# print(f"Total employees are {total_emp}")

# # total customers
# total_cust = get_total_customer(db_conn)
# total_cust = total_cust["total_customer"]
# print(f"Total customers are {total_cust}")

# # total orders recieved this month
# total_orders = get_total_current_month_orders(db_conn)
# total_orders = total_orders["total_orders"]
# print(f"Total orders are {total_orders}")

# # total payments recieved this month (amount)
# total_payment_received = get_total_monthly_payment_received(db_conn)
# total_payment_received = total_payment_received['total_payment_received']
# print(f"Total payment received are {total_payment_received}")

# # total num of payments pending
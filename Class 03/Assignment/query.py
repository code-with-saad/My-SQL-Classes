# Get All employees
def get_employees(db_conn):
    cur = db_conn.cursor()
    cur.execute("SELECT * FROM employees")
    return cur.fetchall()


# get max id
def get_max_employee_id(db_conn):
    cur = db_conn.cursor()
    sql = "SELECT MAX(employeeNumber) as id FROM employees"
    cur.execute(sql)
    return cur.fetchone()

# add employee


def add_employee(db_conn, employee_info):
    cur = db_conn.cursor()
    last_entry = get_max_employee_id(db_conn)

    sql = 'INSERT INTO employees values(%s,%s,%s,%s,%s,%s,%s,%s)'
    cur.execute(sql, (last_entry["id"]+1, employee_info["fname"], employee_info["lname"], employee_info["ext"],
                employee_info["email"], employee_info["office_code"], employee_info["report_to"], employee_info["job_title"]))

    db_conn.commit()
    print(cur.rowcount, "record inserted.")


def add_customer(db_conn, customer_info):
    cur = db_conn.cursor()
    sql = 'INSERT INTO customers(customerNumber,customerName,contactLastName,contactFirstName,phone,addressLine1,addressLine2,city,state,postalCode,country,salesRepEmployeeNumber,creditLimit) values (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)'
    # print(sql)
    cur.execute(sql, (customer_info["customerNumber"], customer_info["customerName"], customer_info["contactLastName"], customer_info["contactFirstName"], customer_info["phone"], customer_info["addressLine1"],
                customer_info["addressLine2"], customer_info["city"], customer_info["state"], customer_info["postalCode"], customer_info["country"], customer_info["salesRepEmployeeNumber"], customer_info["creditLimit"]))

    db_conn.commit()
    # print("1 record inserted, ID:", cur.lastrowid)
    print("Customer Added Successfully!")


# add orders
def add_orders(db_conn, order_info):
    cur = db_conn.cursor()
    sql = 'INSERT INTO orders(orderNumber,orderDate,requiredDate,shippedDate,status,comments,customerNumber) values (%s,%s,%s,%s,%s,%s,%s)'
    val = (order_info["orderNumber"], order_info["orderDate"], order_info["requiredDate"],
           order_info["shippedDate"], order_info["status"], order_info["comments"], order_info["customerNumber"])
    cur.execute(sql, val)

    db_conn.commit()

    print("Order Added Successfully!")


# add payment detail


def add_payment_detail(db_conn, payment_details):
    cur = db_conn.cursor()
    sql = 'INSERT INTO payments(customerNumber,checkNumber,paymentDate,amount) values (%s,%s,%s,%s)'
    val = (payment_details["customerNumber"], payment_details["checkNumber"],
           payment_details["paymentDate"], payment_details["amount"])

    cur.execute(sql, val)

    db_conn.commit()

    print("Payment Detail Added Successfully!")

# show dashboard stats


def show_dashboard_stats(db_conn):
    pass

# show all employees


def show_all_employees(db_conn):
    cur = db_conn.cursor()
    cur.execute(
        "SELECT CONCAT(firstName,' ',lastName) as employee_name FROM employees ")
    return cur.fetchall()


# show all employees (name) along with the city and country name they are working and their job title
def all_employee_info(db_conn):
    cur = db_conn.cursor()
    cur.execute("SELECT concat(firstName, ' ', lastName) as full_name,emp.jobTitle as job_title, ofc.city as city, ofc.country as country FROM employees emp inner join offices as ofc on emp.officeCode = ofc.officeCode")
    return cur.fetchall()
# show all product name and price and product category name


def all_product_info(db_conn):
    cur = db_conn.cursor()
    cur.execute('SELECT productName, productLine, buyPrice FROM products')
    return cur.fetchall()

# show all employees name who captures the customer


def all_employees_capture_customer(db_conn):
    cur = db_conn.cursor()
    cur.execute("SELECT CONCAT(firstName,' ',lastName) as full_name FROM employees as emp inner join customers as c on emp.employeeNumber = c.salesRepEmployeeNumber GROUP BY emp.employeeNumber")
    return cur.fetchall()
# show all employees who didn't suceed in capturing the customer


def all_employees_failed_capturing_customer(db_conn):
    cur = db_conn.cursor()
    cur.execute("SELECT emp.employeeNumber,CONCAT(emp.firstName,' ',emp.lastName) as full_name FROM employees as emp WHERE emp.employeeNumber not in (SELECT salesRepEmployeeNumber from customers where salesRepEmployeeNumber is not null)")
    return cur.fetchall()



# show the employee names along with the sale they managed to capture by customer


def employee_with_sales_info(db_conn):
    cur = db_conn.cursor()
    cur.execute("SELECT CONCAT(emp.firstName, ' ', emp.lastName) as full_name, sum(pp.amount) as amount from employees as emp inner join customers as cc on cc.salesRepEmployeeNumber  = emp.employeeNumber INNER JOIN payments pp on pp.customerNumber = cc.customerNumber group by emp.employeeNumber")
    return cur.fetchall()


def add_employees_many(db_conn):
    cur = db_conn.cursor()
    sql = "INSERT INTO employees (employeeNumber, lastName, firstName, extension, email, officeCode, reportsTo, jobTitle) VALUES (%s, %s,%s, %s,%s, %s,%s,%s)"

    val = [
        (1707, 'Peter', 'Hannah', 'x3636', 'abc@abc.com', 6, 1102, 'Sales Rep'),
        (1708, 'Amy', 'Hannah', 'x3636', 'abc1@abc.com', 6, 1102, 'Sales Rep'),
        (1709, 'Hannah', 'Hannah', 'x3636', 'abc2@abc.com', 6, 1102, 'Sales Rep'),
        (1710, 'Michael', 'Hannah', 'x3636', 'abc3@abc.com', 6, 1102, 'Sales Rep'),
        (1711, 'Sandy', 'Hannah', 'x3636', 'abc4@abc.com', 6, 1102, 'Sales Rep'),
        (1712, 'Betty', 'Hannah', 'x3636', 'abc5@abc.com', 6, 1102, 'Sales Rep'),
        (1713, 'Richard', 'Hannah', 'x3636', 'abc6@abc.com', 6, 1102, 'Sales Rep'),
        (1714, 'Susan', 'Hannah', 'x3636', 'abc7@abc.com', 6, 1102, 'Sales Rep'),
        (1715, 'Vicky', 'Hannah', 'x3636', 'abc8@abc.com', 6, 1102, 'Sales Rep'),
        (1716, 'Ben', 'Hannah', 'x3636', 'abc9@abc.com', 6, 1102, 'Sales Rep'),
        (1717, 'William', 'Hannah', 'x3636', 'abc10@abc.com', 6, 1102, 'Sales Rep'),
        (1718, 'Chuck', 'Hannah', 'x3636', 'abc11@abc.com', 6, 1102, 'Sales Rep'),
        (1719, 'Viola', 'Hannah', 'x3636', 'abc12@abc.com', 6, 1102, 'Sales Rep')
    ]

    cur.executemany(sql, val)

    db_conn.commit()
    print("Multiple Employees inserted!")

    # insert 5 customers


def insert_customers(db_conn):
    cur = db_conn.cursor()
    sql = "INSERT INTO customers (customerNumber,customerName, contactLastName, contactFirstName,phone, addressLine1, addressLine2, city, state, postalCode, country,salesRepEmployeeNumber, creditLimit) VALUES (%s, %s,%s, %s,%s, %s,%s,%s,%s,%s,%s,%s,%s)"
    val = [
        (502, 'Peter Hannah1', 'Peter', 'Hannah', '3546512132', 'lorum-ipsum',
            'lorum-ipsum', 'Karachi', 'Sindh', '75660', 'Pakistan', 1102, 25632),
        (503, 'Peter Hannah2', 'Peter', 'Hannah', '3546512132', 'lorum-ipsum',
            'lorum-ipsum', 'Karachi', 'Sindh', '75660', 'Pakistan', 1102, 25632),
        (504, 'Peter Hannah3', 'Peter', 'Hannah', '3546512132', 'lorum-ipsum',
            'lorum-ipsum', 'Karachi', 'Sindh', '75660', 'Pakistan', 1102, 25632),
        (505, 'Peter Hannah4', 'Peter', 'Hannah', '3546512132', 'lorum-ipsum',
            'lorum-ipsum', 'Karachi', 'Sindh', '75660', 'Pakistan', 1102, 25632),
        (506, 'Peter Hannah5', 'Peter', 'Hannah', '3546512132', 'lorum-ipsum',
            'lorum-ipsum', 'Karachi', 'Sindh', '75660', 'Pakistan', 1102, 25632)

    ]

    cur.executemany(sql, val)

    db_conn.commit()
    print("Multiple customer inserted!")


def add_customer_order(db_conn):
    cur = db_conn.cursor()
    sql = "INSERT INTO orders(orderNumber, orderDate,requiredDate,shippedDate,status,comments,customerNumber) values (%s,%s,%s,%s,%s,%s,%s)"
    val = [
        (10427, '2023-05-29', '2023-06-07',
         '2023-07-07', 'In Process', 'LORUM-IPSUM', 502),
        (10428, '2023-06-29', '2023-06-07',
         '2023-07-07', 'In Process', 'LORUM-IPSUM', 502),
        (10429, '2023-07-29', '2023-06-07',
         '2023-07-07', 'In Process', 'LORUM-IPSUM', 503)
    ]

    cur.executemany(sql, val)

    db_conn.commit()
    print("Multiple Order inserted!")

# total employees


def get_total_employee(db_conn):
    cur = db_conn.cursor()
    cur.execute("SELECT count(employeeNumber) as total_employee from employees")
    return cur.fetchone()

# total customers


def get_total_customer(db_conn):
    cur = db_conn.cursor()
    cur.execute("SELECT count(customerNumber) as total_customer from customers")
    return cur.fetchone()

# total orders recieved this month


def get_total_current_month_orders(db_conn):
    cur = db_conn.cursor()
    cur.execute("SELECT count(orderNumber) as total_orders FROM orders WHERE MONTH(orderDate)  = MONTH(now()) AND YEAR(orderDate) = YEAR(NOW())")
    return cur.fetchone()

# total payments recieved this month (amount)


def get_total_monthly_payment_received(db_conn):
    cur = db_conn.cursor()
    cur.execute("SELECT SUM(amount) as total_payment_received FROM payments WHERE MONTH(paymentDate) = MONTH(NOW()) AND YEAR(paymentDate) = 2004")
    return cur.fetchone()
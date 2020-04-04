from config import *

def generate_random_id(stringLength=45):
	lettersAndDigits = string.ascii_letters + string.digits
	return ''.join(random.choice(lettersAndDigits) for i in range(stringLength))

def login(username, password):

	cursor = connection.cursor()
	sql = "SELECT `id`, `password` FROM `users` WHERE `username`=%s"
	cursor.execute(sql, (username))
	result = cursor.fetchone()

	if not result:
		return {'status':'ERR',
				'code':'incorrect_login'}

	user_password = result['password']
	user_id = result['id']

	if user_password != password:
		return {'status':'ERR',
				'code':'incorrect_login'}
	else:
		#create session
		session_id = generate_random_id()
		sql = "INSERT INTO `sessions` (`session_id`, `user_id`) VALUES (%s, %s)"
		cursor.execute(sql, (session_id, user_id))
		connection.commit()
		return {'status':'OK',
				'session_id':session_id}



def verify_session(session_id):

	cursor = connection.cursor()
	sql = "SELECT `user_id` FROM `sessions` WHERE `session_id`=%s"
	cursor.execute(sql, (session_id))
	result = cursor.fetchone()

	if not result or len(result) < 1:
		return {'status':'ERR',
				'code':'invalid_session'}
	else:
		user_id = result['user_id']
		sql = "SELECT `username`, `type`, `firstname`, `lastname` FROM `users` WHERE `id`=%s"
		cursor.execute(sql, (user_id))
		result = cursor.fetchone()
		username = result['username']
		user_type = result['type']
		firstname = result['firstname']
		lastname = result['lastname']
		return {'status':'OK',
				'username':username,
				'user_type':user_type,
				'firstname':firstname,
				'lastname':lastname}


def create_user(username, password, user_type, firstname, lastname):
	cursor = connection.cursor()
	sql = "SELECT COUNT(`username`) FROM `users` WHERE `username`=%s"
	cursor.execute(sql, (username))
	result = cursor.fetchone()
	count = result['COUNT(`username`)']

	if count > 0:
		return {'status': 'ERR',
		       'code': 'user_exists' }
	else:
	    sql = "INSERT INTO `users` (`id`, `username`, `password`, `type`, `firstname`, `lastname`) VALUES (%s, %s, %s, %s, %s, %s)"
	    cursor.execute(sql, (generate_random_id(), username, password, user_type, firstname, lastname))
	    connection.commit()
	    return {'status':'OK'}

def create_order(customer_firstname, customer_lastname):
	cursor = connection.cursor()
	sql = "INSERT INTO `orders` (`customer_firstname`, `customer_lastname`) VALUES (%s, %s)"
	cursor.execute(sql, (customer_firstname, customer_lastname))
	sql = "SELECT order_number FROM orders WHERE customer_firstname = %s AND customer_lastname = %s"
	cursor.execute(sql, (customer_firstname, customer_lastname))
	order_number = cursor.fetchone()

	connection.commit()
	return {'status':'OK', 
			'order_number':order_number
			}

def create_cake_order(order_number, batter_type, cake_type, quantity):
	cursor = connection.cursor()
	sql = "INSERT INTO `order_details` (`order_number`, `batter_type`, `cake_type`, `quantity`) VALUES (%s, %s, %s, %s)"
	cursor.execute(sql, (customer_firstname, customer_lastname))
	connection.commit()
	return {'status':'OK'}			

def get_logs():
	cursor = connection.cursor()
	sql = "SELECT * FROM `orders`"
	cursor.execute(sql)
	connection.commit()
	return{'status':'OK'}

def delete_order(orderNumber):
	cursor = connection.cursor()
	sql = "SELECT order_number FROM order_details WHERE order_number = %s"
	cursor.execute(sql, (orderNumber))
	order_number = cursor.fetchall()

	sql = "DELETE * FROM `order_details` WHERE order_number = %s"
	cursor.execute(sql, (orderNumber))

	connection.commit()
	return{'status':'OK'}

def update_batter_quantity(flavor, quantity):
    cursor = connection.cursor()
    sql = "UPDATE `inventory` SET quantity=quantity WHERE batter_type=flavor"
    cursor.execute(sql, (flavor, quantity))
    connection.commit()
    return{'status':'OK'}
        
def get_batter_quantity(flavor):
    cursor = connection.cursor()
    sql = "SELECT quantity FROM `inventory` WHERE batter_type=flavor"
    cursor.execute(sql, (flavor))
    connection.commit()
    return{'status':'OK'}

from config import *
import api_actions as actions

@app.route('/', methods=['GET'])
def home():
	return '''<h1>API</h1>
<p>Bakery Calculator API Backend</p>'''

@app.route('/api/login', methods=['POST'])
def api_login():
	data = request.get_json()

	username = data['username']
	password = data['password']

	return jsonify(actions.login(username, password))


@app.route('/api/login_with_session', methods=['POST'])
def api_verify_session():
	data = request.get_json()
	session_id = data['session_id']

	return jsonify(actions.verify_session(session_id))


@app.route('/api/logout', methods=['POST'])
def api_logout():
	data = request.get_json()
	session_id = data['session_id']
	return jsonify(actions.logout(session_id))

@app.route('/api/create_user', methods=['POST'])
def api_create_user():
	data = request.get_json()

	session_id = data['session_id']
	username = data['username']
	password = data['password']
	user_type = data['user_type']
	firstname = data['firstname']
	lastname = data['lastname']

	return jsonify(actions.create_user(session_id, username, password, user_type, firstname, lastname))


@app.route('/api/update_user_data', methods=['POST'])
def api_update_user_data():
	data = request.get_json()

	session_id = data['session_id']
	user_id = data['user_id']
	username = data['username']
	user_type = data['user_type']
	firstname = data['firstname']
	lastname = data['lastname']

	return jsonify(actions.update_user_data(session_id, user_id, username, user_type, firstname, lastname))


@app.route('/api/get_users', methods=['GET'])
def api_get_users():

	session_id = request.args.get('session_id')
	return jsonify(actions.get_users(session_id))


@app.route('/api/remove_user', methods=['POST'])
def api_remove_user():
	data = request.get_json()

	session_id = data['session_id']
	user_id = data['user_id']

	return jsonify(actions.remove_user(session_id, user_id))


@app.route('/api/add_customer', methods=['POST'])
def api_add_customer():
	data = request.get_json()

	session_id = data['session_id']
	firstname = data['firstname']
	lastname = data['lastname']
	phone_number = data['phone_number']
	street = data['street']
	city = data['city']
	state = data['state']
	zip = data['zip']

	return jsonify(actions.add_customer(session_id, firstname, lastname, phone_number, street, city, state, zip))

@app.route('/api/get_customers', methods=['GET'])
def api_get_customers():

	session_id = request.args.get('session_id')

	return jsonify(actions.get_customers(session_id))



@app.route('/api/update_customer_data', methods=['POST'])
def api_update_customer_data():
	data = request.get_json()

	session_id = data['session_id']
	customer_id = data['id']
	firstname = data['firstname']
	lastname = data['lastname']
	phone_number = data['phone_number']
	street = data['street']
	city = data['city']
	state = data['state']
	zip = data['zip']

	return jsonify(actions.update_customer_data(session_id, customer_id, firstname, lastname, phone_number, street, city, state, zip))


@app.route('/api/remove_customer', methods=['POST'])
def api_remove_customer():
	data = request.get_json()

	session_id = data['session_id']
	customer_id = data['id']

	return jsonify(actions.remove_customer(session_id, customer_id))



@app.route('/api/add_order', methods=['POST'])
def api_add_order():
	data = request.get_json()
	session_id = data['session_id']
	customer_id = data['customer_id']
	order_notes = data['order_notes']
	items = data['items']

	return jsonify(actions.add_order(session_id, customer_id, items, order_notes))

@app.route('/api/get_orders', methods=['GET'])
def api_get_orders():
	session_id = request.args.get('session_id')
	return jsonify(actions.get_orders(session_id))

@app.route('/api/get_order_items', methods=['GET'])
def api_get_order_items():
	session_id = request.args.get('session_id')
	order_number = request.args.get('order_number')
	return jsonify(actions.get_order_items(session_id, order_number))

@app.route('/api/delete_order', methods=['POST'])
def api_delete_order():
	data = request.get_json()
	session_id = data['session_id']
	order_number = data['order_number']

	return jsonify(actions.delete_order(session_id, order_number))



@app.route('/api/change_user_password', methods=['POST'])
def api_change_user_password():
	data = request.get_json()
	session_id = data['session_id']
	old_password = data['old_password']
	new_password = data['new_password']

	return jsonify(actions.change_user_password(session_id, old_password, new_password))


@app.route('/api/change_user_username', methods=['POST'])
def api_change_user_username():
	data = request.get_json()
	session_id = data['session_id']
	username = data['username']

	return jsonify(actions.change_user_username(session_id, username))

@app.route('/api/get_inventory', methods=['GET'])
def api_get_inventory():
	session_id = request.args.get('session_id')
	return jsonify(actions.get_inventory(session_id))

@app.route('/api/update_inventory', methods=['POST'])
def api_update_inventory():
	data = request.get_json()
	session_id = data['session_id']
	inventory_id = data['inventory_id']
	items = data['items']

	return jsonify(actions.update_inventory(session_id, inventory_id, items))

@app.route('/api/update_inventory_count', methods=['POST'])
def api_update_inventory_count():
	data = request.get_json()
	session_id = data['session_id']
	inventory_id = data['inventory_id']
	items = data['items']

	return jsonify(actions.update_inventory_count(session_id, inventory_id, items))


@app.route('/api/update_batter_quantity', methods=['POST'])
def api_update_batter_quantity():
	request.get_data()
	data = request.form
	batter_type = data['batter_type']
	quantity = data['quantity']

	return jsonify(actions.update_batter_quantity(batter_type, quantity))

@app.route('/api/get_batter_quantity', methods=['GET'])
def api_get_batter_quantity():
	return jsonify(actions.get_batter_quantity(flavor))

@app.route('/api/create_baked_good', methods=['POST'])
def api_create_baked_good():
	request.get_data()
	data = request.form
	name = data['name']
	shape = data['shape']
	batter_type = data['batter_type']
	batter_per_batch = data['batter_per_batch']

	return jsonify(actions.create_baked_good(name, shape, batter_type, batter_per_batch))

@app.route('/api/update_baked_good_quantity', methods=['POST'])
def api_update_baked_good_quantity():
	request.get_data()
	data = request.form
	shape = data['shape']
	batter_type = data['batter_type'] 
	quantity = data['quantity']

	return jsonify(actions.update_baked_good_quantity(shape, batter_type, quantity))

@app.route('/api/calculate_batter()', methods=['POST'])
def api_calculate_batter():
	request.get_data()
	data = request.form
	order_number = data['order_number']

	return jsonify(actions.calculate_batter(order_number))

@app.route('/api/calculate_batches_with_extra_batter', methods=['POST'])
def api_calculate_batches_with_extra_batter():
	request.get_data()
	data = request.form
	shape = data['shape']
	batter_type = data['batter_type']

	return jsonify(actions.calculate_batches_with_extra_batter(flavor, quantity))

@app.route('/api/adjust_formula', methods=['POST'])
def api_adjust_formula():
	request.get_data()
	data = request.form
	shape = data['shape']
	batter_type = data['batter_type']
	batter_per_batch = data['batter_per_batch']

	return jsonify(actions.adjust_formula(shape, batter_type, batter_per_batch))

app.run(host= '0.0.0.0')

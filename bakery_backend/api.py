from config import *
import api_actions as actions

@app.route('/', methods=['GET'])
def home():
    return '''<h1>API</h1>
<p>Bakery Calculator API Backend</p>'''

@app.route('/api/login', methods=['POST'])
def api_login():
	request.get_data()
	data = request.form

	username = data['username']
	password = data['password']

	return jsonify(actions.login(username, password))


@app.route('/api/login_with_session', methods=['POST'])
def api_verify_session():
	request.get_data()
	data = request.form
	session_id = data['session_id']

	return jsonify(actions.verify_session(session_id))


@app.route('/api/create_user', methods=['POST'])
def api_create_user():
	request.get_data()
	data = request.form

	username = data['username']
	password = data['password']
	user_type = data['type']
	firstname = data['firstname']
	lastname = data['lastname']

	return jsonify(actions.create_user(username, password, user_type, firstname, lastname))




#Will need to be redone, check against new database schema in bakery.sql
@app.route('/api/create_order', methods=['POST'])
def api_create_order():
	request.get_data()
	data = request.form
	customer_firstname = data['customer_firstname']
	customer_lastname = data['customer_lastname']

	return jsonify(actions.create_order(customer_firstname, customer_lastname))

@app.route('/api/create_cake_order', methods=['POST'])
def api_create_cake_order():
	request.get_data()
	data = request.form
	order_number = data['order_number']
	batter_type = data['batter_type']
	cake_type = data['cake_type']
	quanity = data['quanity']

	return jsonify(actions.create_cake_order(order_number, batter_type, cake_type, quanity))

@app.route('/api/get_logs', methods=['GET'])
def api_get_logs():
	return jsonify(actions.get_logs())

@app.route('/api/delete_order', methods=['POST'])
def api_delete_order():
	request.get_data()
	data = request.form
	order_number = data['order_number']

	return jsonify(actions.delete_order(order_number))

@app.route('/api/update_batter_quantity', methods=['POST'])
def api_update_batter_quantity():
    request.get_data()
    data = request.form
    batterT = data['batter_type']
    quantity = data['quantity']
    
    return jsonify(actions.update_batter_quantity(flavor, quantity))
    
@app.route('/api/get_batter_quantity', methods=['GET'])
def api_get_batter_quantity():
    
    return jsonify(actions.get_batter_quantity(flavor))

app.run(host= '0.0.0.0')

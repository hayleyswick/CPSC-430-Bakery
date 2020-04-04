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
	customerN = data['customer_name']
	batterT = data['batter_type']
	cakeS = data['cake_shape']
	quant = data ['quantity']

	return jsonify(actions.create_order(customerN, batterT, cakeS, quant))

@app.route('/api/get_logs', methods=['GET'])
def api_get_logs():
	return jsonify(actions.get_logs())

@app.route('/api/edit_order', methods=['POST'])
def api_edit_order():
	request.get_data()
	data = request.form
	orderN = data['order_number']
	batterT = data['batter_type']
	cakeS = data['cake_shape']
	quant = data['quantity']

	return jsonify(actions.edit_order(orderN,batterT,cakeS,quant))

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

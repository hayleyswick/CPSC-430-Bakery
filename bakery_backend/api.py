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

	return jsonify(actions.create_user(username, password, user_type))

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
app.run(host= '0.0.0.0')

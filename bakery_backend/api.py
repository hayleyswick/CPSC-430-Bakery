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


app.run(host= '0.0.0.0')

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
		sql = "SELECT `username`, `type` FROM `users` WHERE `id`=%s"
		cursor.execute(sql, (user_id))
		result = cursor.fetchone()
		username = result['username']
		user_type = result['type']
		return {'status':'OK',
				'username':username,
				'user_type':user_type}


def create_user(username, password, user_type):
	cursor = connection.cursor()
	sql = "SELECT COUNT(`username`) FROM `users` WHERE `username`=%s"
	cursor.execute(sql, (username))
	result = cursor.fetchone()
	count = result['COUNT(`username`)']

	if count > 0:
		return {'status': 'ERR',
		       'code': 'user_exists' }
	else:
	    sql = "INSERT INTO `users` (`id`, `username`, `password`, `type`) VALUES (%s, %s, %s, %s)"
	    cursor.execute(sql, (generate_random_id(), username, password, user_type))
	    connection.commit()
	    return {'status':'OK'}
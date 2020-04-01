import flask
from flask import request, jsonify
import pymysql.cursors
import string
import random

connection = pymysql.connect(host='localhost',
                             user='bakery_calc',
                             password='testpasswd',
                             db='bakery_calc',
                             charset='utf8mb4',
                             cursorclass=pymysql.cursors.DictCursor)


app = flask.Flask(__name__)
app.config["DEBUG"] = True

app.config['DEFAULT_PARSERS'] = [
    'flask.ext.api.parsers.JSONParser',
    'flask.ext.api.parsers.URLEncodedParser',
    'flask.ext.api.parsers.MultiPartParser'
]

def randomString(stringLength=45):
    lettersAndDigits = string.ascii_letters + string.digits
    return ''.join(random.choice(lettersAndDigits) for i in range(stringLength))

@app.route('/', methods=['GET'])
def home():
    return '''<h1>API</h1>
<p>Baker Calculator API Backend</p>'''


# A route to return all of the available entries in our catalog.
@app.route('/api/login_with_session', methods=['POST'])
def api_verify_session():
    request.get_data()
    data = request.form

    res = {'status':'OK'}

    return jsonify(res)



@app.route('/api/create_user', methods=['POST'])
def api_create_user():
    request.get_data()
    data = request.form
    res = {}

    username = data['username']
    password = data['password']

    cursor = connection.cursor()

    sql = "SELECT COUNT(`username`) FROM `users` WHERE `username`=%s"
    cursor.execute(sql, (username))
    result = cursor.fetchone()
    count = result['COUNT(`username`)']

    if count > 0:
        res = {'status': 'ERR',
               'code': 'user_exists' }
    else:
        sql = "INSERT INTO `users` (`id`, `username`, `password`) VALUES (%s, %s, %s)"
        cursor.execute(sql, (randomString(), username, password))
        connection.commit()
        res = {'status':'OK'}


    return jsonify(res)



app.run(host= '0.0.0.0')

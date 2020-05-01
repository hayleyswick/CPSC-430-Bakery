import flask
from flask import request, jsonify
from flaskext.mysql import MySQL
import pymysql
import string
import random

mysql = MySQL()




app = flask.Flask(__name__)
app.config["DEBUG"] = True

app.config['DEFAULT_PARSERS'] = [
    'flask.ext.api.parsers.JSONParser',
    'flask.ext.api.parsers.URLEncodedParser',
    'flask.ext.api.parsers.MultiPartParser'
]

app.config['MYSQL_DATABASE_USER'] = 'bakery_calc'
app.config['MYSQL_DATABASE_PASSWORD'] = 'y3myChfMa0oop0rz5RiOPDdTq93eBLK5RonWpDbrurbLr'
app.config['MYSQL_DATABASE_DB'] = 'bakery_calc'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'
mysql.init_app(app)
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
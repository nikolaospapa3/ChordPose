from flask import Flask, render_template, request, url_for, flash, redirect, jsonify, abort
from flask_httpauth import HTTPBasicAuth
import mysql.connector
#import psycopg2 
import random
from datetime import datetime, timedelta
from .add_lyrics_chords import *
from .help_routes import *
from .transporto import *

#from .accept import *

app = Flask(__name__)
auth = HTTPBasicAuth()
db_name = "songs"

app.jinja_env.filters['zip'] = zip

# for MySQL
 
db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",                       # that's because I do not use a password... you may change it for your DBMS
    database=db_name,   # a database I created to play with...
    charset = "utf8",
    use_unicode = True
)

cursor = db.cursor()
cursor.execute("SET NAMES utf8;")
cursor.execute("SET CHARACTER SET utf8;")
cursor.execute("SET character_set_connection = utf8;")
cursor.close()

'''  # for PostgreSQL

app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://username:password@localhost/db_name'
db = psycopg2.connect(
    host="localhost",
    database=db_name,   # a database I created to play with...
    user="root",
    password=""     # that's because I do not use a password... you may change it for your DBMS
)
'''

@app.route('/', methods = ['GET', 'POST'])
def home_route():
    return home(db)

@app.route('/add-song', methods = ['GET', 'POST'])
def add_song_route():
    return add_lyrics(db)

@app.route('/<song_id>/update-lyrics', methods = ['GET', 'POST'])
def update_lyrics_route(song_id):
    return add_lyrics(db, song_id=song_id, update=True)

@app.route('/<song_id>/add-chords', methods = ['GET', 'POST'])
def add_chords_route(song_id):
    return add_chords(db, song_id)

@app.route('/<song_id>/update-chords', methods = ['GET', 'POST'])
def update_chords_route(song_id):
    return add_chords(db, song_id, update = True)


@app.route('/<song_id>/song-transpose', methods = ['GET', 'POST'])
def song_transpose_route(song_id):
    return song_transpose(db, song_id)

@app.route('/<song_id>/permanent-transporto', methods = ['GET', 'POST'])
def permanent_transporto_route(song_id):
    return song_transpose(db, song_id, permanent=True)

if __name__ == '__main__':
    app.run(debug=True)

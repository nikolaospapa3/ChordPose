from flask import Flask, render_template, request, url_for, flash, redirect, jsonify, abort
from flask_httpauth import HTTPBasicAuth
#import psycopg2 
import random
from datetime import datetime, timedelta

#from .accept import *

app = Flask(__name__)
auth = HTTPBasicAuth()
db_name = "songs"

app.jinja_env.filters['zip'] = zip

''' # for MySQL
 
db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",                       # that's because I do not use a password... you may change it for your DBMS
    database=db_name   # a database I created to play with...
)

'''

'''  # for PostgreSQL

app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://username:password@localhost/db_name'
db = psycopg2.connect(
    host="localhost",
    database=db_name,   # a database I created to play with...
    user="root",
    password=""     # that's because I do not use a password... you may change it for your DBMS
)
'''

major = ['A', 'A#', 'B', 'C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#']

def transpose(chords: str, transporto: int) -> str:
    transposed_chords = ''
    i = 0
    while (i < len(chords)):   # for each letter in chords string
        if chords[i:i+2] in major:      # check if it is A#, C#, ...
            k = major.index(chords[i:i+2])
            transposed_chords += major[(k + transporto) % 12]
            i += 2
        elif chords[i] in major:      # check if it is A, B, C, ...
            k = major.index(chords[i])
            transposed_chords += major[(k + transporto) % 12]
            i += 1
        else:
            transposed_chords += chords[i]
            i += 1
    return transposed_chords

@app.route('/')
def home():
    return 'Home page for ChordPose <br>'

@app.route('/add-lyrics')
def add_lyrics(update = False):
    if update == True:
        title = "Αυτά τα δέντρα"
        composer = "Μίκης Θεοδωράκης"
        lyricist = "Γιάννης Ρίτσος"
        lyrics = '''Αυτά τα δέντρα δεν βολεύονται με λιγότερο ουρανό
Αυτές οι πέτρες δεν βολεύονται, κάτω απ' τα, απ' τα ξένα βήματα
Αυτά τα πρόσωπα δεν βολεύονται παρά μόνο στον η η η λιο
Αυτές οι καρδιές δεν βολεύονται παρά μόνο στο δί ι ι ι κιο'''
    else:
        title = ""
        composer = ""
        lyricist = ""
        lyrics = ''
    return render_template('add-lyrics.html', title = title, composer=composer, lyricist=lyricist, lyrics=lyrics)

@app.route('/<song>/add-chords')
def add_chords(song, update = False):
    '''
    song = "Αυτά τα δέντρα+Γιάννης Ρίτσος"
    '''
    # title, composer, lyricist = song.split('+') # get info from url
    title = "Αυτά τα δέντρα"
    composer = "Μίκης Θεοδωράκης"
    lyricist = "Γιάννης Ρίτσος"
    lyrics = '''Αυτά τα δέντρα δεν βολεύονται με λιγότερο ουρανό
Αυτές οι πέτρες δεν βολεύονται, κάτω απ' τα, απ' τα ξένα βήματα
Αυτά τα πρόσωπα δεν βολεύονται παρά μόνο στον η η η λιο
Αυτές οι καρδιές δεν βολεύονται παρά μόνο στο δί ι ι ι κιο'''
    if update == True:
        chords = '''Dm      A#              C         Dm      C   Dm
Dm                  A#    C       Dm      C   Dm

'''
    else:
        chords = '\n'.join(len(lyrics.split('\n')) * [''])
    return render_template('add-chords.html', title=title, composer=composer, lyricist=lyricist, lyrics=lyrics, chords=chords, zip=zip)

@app.route('/<song>/song-transpose', methods = ['GET', 'POST'])
def song_transpose(song, permanent = False, transporto = 0):
    transporto = request.form.get('transporto') if request.method == 'POST' else 0
    title = "Αυτά τα δέντρα"
    composer = "Μίκης Θεοδωράκης"
    lyricist = "Γιάννης Ρίτσος"
    lyrics = '''Αυτά τα δέντρα δεν βολεύονται με λιγότερο ουρανό
Αυτές οι πέτρες δεν βολεύονται, κάτω απ' τα, απ' τα ξένα βήματα
Αυτά τα πρόσωπα δεν βολεύονται παρά μόνο στον η η η λιο
Αυτές οι καρδιές δεν βολεύονται παρά μόνο στο δί ι ι ι κιο'''
    chords = '''Dm      A#              C         Dm      C   Dm
Dm                  A#    C       Dm      C   Dm

'''
    try:
        transporto = int(transporto)
        chords = transpose(chords, transporto)
    except:
        return "<h1> Please insert valid transporto number </h1>"
    if permanent:
        # here I should update the chords string into the Database...
        pass
    return render_template('song-transpose.html', title=title, composer=composer, lyricist=lyricist, lyrics=lyrics, chords=chords, zip=zip, transporto=transporto)

@app.route('/styles')
def styles():
    return render_template('styles.css')

if __name__ == '__main__':
    app.run(debug=True)

from flask import Flask, render_template, request, url_for, flash, redirect, jsonify, abort, g
from flask_httpauth import HTTPBasicAuth
import mysql.connector
#import psycopg2 

from add_lyrics_chords import *
from help_routes import *
from transporto import *

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
    database=db_name,   # a database I created to play with...
    charset = "utf8",
    use_unicode = True
)

cursor = db.cursor()
cursor.execute("SET NAMES utf8;")
cursor.execute("SET CHARACTER SET utf8;")
cursor.execute("SET character_set_connection = utf8;")
cursor.close()
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

users = {
    "AN": "ablaoublas"
}

# Verify the username and password for each request
@auth.verify_password
def verify_password(username, password):
    if username in users and password == users[username]: #or username==get_admin()[0] and password==get_admin()[1]:
        return username


@app.route('/', methods = ['GET', 'POST'])
def home_route():
    return home()

@app.route('/add-song', methods = ['GET', 'POST'])
@auth.login_required
def add_song_route():
    return add_lyrics()

@app.route('/<song_id>/update-lyrics', methods = ['GET', 'POST'])
@auth.login_required
def update_lyrics_route(song_id):
    return add_lyrics(song_id=song_id, update=True)

@app.route('/<song_id>/add-chords', methods = ['GET', 'POST'])
@auth.login_required
def add_chords_route(song_id):
    return add_chords(song_id)

@app.route('/<song_id>/update-chords', methods = ['GET', 'POST'])
@auth.login_required
def update_chords_route(song_id):
    return add_chords(song_id, update = True)


@app.route('/<song_id>/song-transpose', methods = ['GET', 'POST'])
def song_transpose_route(song_id):
    return song_transpose(song_id)

@app.route('/<song_id>/permanent-transporto', methods = ['GET', 'POST'])
@auth.login_required
def permanent_transporto_route(song_id):
    return song_transpose(song_id, permanent=True)

@app.route('/previous/<int:song_id>')
def previous(song_id):
    previous_song_id = song_id - 1
    return redirect(f'/{previous_song_id}/song-transpose')

@app.route('/next/<int:song_id>')
def next(song_id):
    next_song_id = song_id + 1
    return redirect(f'/{next_song_id}/song-transpose')

@app.route('/check')
def check():

    songs_list = '''Απόψε λέω να μην κοιμηθούμε
Δεν ζητάω πολλά
Που να βρω μια να σου μοιάζει
Που να βρω γυναίκα να σου μοιάζει
Ας ερχόσουν για λίγο
Εσένα που σε ξέρω τόσο λίγο
Τι έπαιξα στο Λαύριο
Κάποτε θα ´ρθουν
Να μ'αγαπάς
Μια βραδιά στο λούκι
Πικρία
Θεσσαλονίκη
Πες μου μια λέξη
Γυρίζω τις πλάτες μου στο μέλλον
Φανή
Αεροπλάνα
Σαπιοκάραβο
Ένας Τούρκος στο Παρίσι
Μάτια δίχως λογική
Φύλακας Άγγελος
Σ αγαπάω
Κάτι να γυαλίζει
Ήτανε μια φορά
Η μπαλάντα του κυρ Μέντιου
Νύχτωσε νύχτα
Μη μιλάς άλλο για αγάπη
Άρνηση
Στρώσε το στρώμα σου
Το Άγαλμα
Μεθυσε αποψε το κοριτσι μου
Το δίχτυ
Τσιγάρο ατέλειωτο
Πριγκηπέσα
Εκεί στο Νότο
Μη γυρίσεις
Οι παλιες αγαπες πανε στον παραδεισο
Πυροσβεστήρας
Εξαιρέσεις
Το φιλαράκι
Κακές συνήθειες
Wonderful Tonight
Τα ήσυχα βράδια
Καθρέφτης
Ένας σκύλος στο κολωνάκι
Ο κόσμος που αλλάζει
Μπαγάσας
Φλασάκι
Μάτια βουρκωμένα
Φραγκοσυριανή
Αργοσβήνεις μόνη
Δεν θα ξαναγαπήσω
Ρόζα
Δεν ξέρω πόσο σ´ αγαπώ
Αγάπη που ´γινες δίκοπο μαχαίρι
Ξημερώνει Κυριακή
Καμαρούλα
Μπαλάντα του Ούρι
Γέλα πουλί μου 
Δημοσθενους λεξις
Περσείδες
Ανδρομέδα
Πούλα με
Ταξίδι
Μίλησέ μου
Μαργαριτα Μαργαρώ
Μια πόλη μαγική
Μάρκος και Άννα
Κι όλο σερφάρω
Σκόνη
Έτσι κι αλλιώς
Κηπουρός
Το καλοκαιράκι
Δεν κάνει κρύο στην Ελλάδα
Μισή πίστη
Στα είπα όλα
Ωδή στον Γεώργιο Καραϊσκάκη
Μ´ αρέσει να μη λέω πολλά
Στην Κ
Πάντα γελαστοί
Παραμύθι με λυπημένο τέλος
Πεχλιβάνης
Κεμάλ
Στην Πόλυ
Με την πρώτη σταγόνα της βροχής
Σιωπή
Μιλώ για σένα
Αεροπλάνα και βαπόρια 
Έκλαψα χθες
Χρυσοπράσινο φύλλο
Η αγάπη θέλει δύο
Άσπρη μέρα'''.split('\n')
    
    db_songs = all_songs()
    for song in db_songs:
        song = song.strip()
        song = song.replace("'",'')
    for song in songs_list:
        song = song.strip()
        song = song.replace("'",'')
    out = "The following songs from the list are not in the Database: <br>"
    for song in songs_list:
        if song not in db_songs: out += f"{song} <br>"
    return out

if __name__ == '__main__':
    app.run(debug=True)

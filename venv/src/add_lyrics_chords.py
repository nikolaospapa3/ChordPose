from flask import Flask, render_template, request, url_for, flash, redirect, jsonify, abort, g
from flask_httpauth import HTTPBasicAuth
import mysql.connector
#import psycopg2 

from help_routes import *
from __init__ import get_db
from all import *


def home():
    db = get_db()
    cursor = db.cursor()
    sql = "select title from song"
    cursor.execute(sql)
    songs = [x[0] for x in cursor.fetchall()]
    ids = []
    selected = ''
    if request.method == 'POST':
        selected = request.form.get('find') 
        print(selected)
        sql = f"""select id from song where title="{selected}" """
        cursor.execute(sql)
        ids = [x[0] for x in cursor.fetchall()]
        print(ids)
    return render_template('home.html', songs=songs, ids=ids, selected=selected)

def add_lyrics(song_id = '', update = False):
    
    if request.method == 'GET':
        if update == True:
            title, lyrics, _, composers, lyricists = get_song_by_id(song_id)
        else:
            title = ""
            composers = ""
            lyricists = ""
            lyrics = ''
        return render_template('add-lyrics.html', title = title, composers=composers, lyricists=lyricists, lyrics=lyrics, all_composers = all_composers(), all_lyricists = all_lyricists(), songs = all_songs())
    elif request.method == 'POST':
        title = request.form.get('title')
        composers = request.form.get('composer')
        lyricists = request.form.get('lyricist')
        lyrics = request.form.get('lyrics')
        #print("I got the submitted info from the form")
        if update:
            message = update_song(song_id, title, composers, lyricists, lyrics)
            if message: return f"<h1>{message}</h1>"
            return f"Successful Updation! <br> <a href='/{song_id}/update-chords'>Update chords</a> <br> <a href='/'>Home</a> <br>"
        message, song_id = insert_song(title, composers, lyricists, lyrics)
        if message: return f"<h1>{message}</h1>"
        return f"Successful Insertion!  <br> <a href='/{song_id}/add-chords'>Add chords</a> <br> <a href='/'>Home</a> <br>"
    else:
        pass

def add_chords(song_id, update = False):
    
    title, lyrics, chords, composers, lyricists = get_song_by_id(song_id)
    if request.method == 'GET':
        if chords=='' or update==False or chords is None:
            chords = '\n'.join(len(lyrics.split('\n')) * [''])
        elif len(chords.split('\n')) != len(lyrics.split('\n')):    # if rows of lyrics != rows of chords
            k = len(lyrics.split('\n')) - len(chords.split('\n'))
            chords += k*'\n'                                       # make rows the same
        chords_list = [ x + (100 - len(x)) * ' '  for x in chords.split('\n')]  # because 100 is max input size
        lyrics_list = lyrics.split('\n')
        return render_template('add-chords.html', title=title, composers=composers, lyricists=lyricists, lyrics_list=lyrics_list, chords_list=chords_list, song_id=song_id, i=0, zip=zip) 
    elif request.method == 'POST':
        lines = len(lyrics.split('\n'))
        lyrics = []
        chords = []
        for i in range(lines):
            lyrics_line = request.form.get(f'lyricsLine-{i+1}')
            lyrics_line = lyrics_line if lyrics_line else ''
            chords_line = request.form.get(f'chordsLine-{i+1}')
            chords_line = chords_line.rstrip() if chords_line else ''
            lyrics.append(lyrics_line)  # get list of inputs
            chords.append(chords_line) 
        lyrics = '\n'.join(lyrics) # list -> str
        chords = '\n'.join(chords)
        update_lyrics_chords(song_id, lyrics, chords)
        return f"<h1> Lyrics and Chords Updated successfully </h1> <br> <a href='/{song_id}/song-transpose'>See song</a> <br> <a href='/'>Home</a>"
        
    else:
        pass

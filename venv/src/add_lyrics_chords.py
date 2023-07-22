from flask import Flask, render_template, request, url_for, flash, redirect, jsonify, abort
from flask_httpauth import HTTPBasicAuth
import mysql.connector
#import psycopg2 
import random
from datetime import datetime, timedelta
from .help_routes import *

def home(db):
    cursor = db.cursor()
    sql = "select title from Song"
    cursor.execute(sql)
    songs = [x[0] for x in cursor.fetchall()]
    ids = []
    selected = ''
    if request.method == 'POST':
        selected = request.form.get('find') 
        print(selected)
        sql = f"select id from Song where title='{selected}'"
        cursor.execute(sql)
        ids = [x[0] for x in cursor.fetchall()]
        print(ids)
    return render_template('home.html', songs=songs, ids=ids, selected=selected)

def add_lyrics(db, song_id = '', update = False):
    if request.method == 'GET':
        if update == True:
            title, lyrics, _, composers, lyricists = get_song_by_id(db, song_id)
        else:
            title = ""
            composers = ""
            lyricists = ""
            lyrics = ''
        return render_template('add-lyrics.html', title = title, composers=composers, lyricists=lyricists, lyrics=lyrics)
    elif request.method == 'POST':
        title = request.form.get('title')
        composers = request.form.get('composer')
        lyricists = request.form.get('lyricist')
        lyrics = request.form.get('lyrics')
        #print("I got the submitted info from the form")
        if update:
            message = update_song(db, song_id, title, composers, lyricists, lyrics)
            if message: return f"<h1>{message}</h1>"
            return f"Successful Updation! <br> <a href='/{song_id}/update-chords'>Update chords</a> <br> <a href='/'>Home</a> <br>"
        message, song_id = insert_song(db, title, composers, lyricists, lyrics)
        if message: return f"<h1>{message}</h1>"
        return f"Successful Insertion!  <br> <a href='/{song_id}/add-chords'>Add chords</a> <br> <a href='/'>Home</a> <br>"
    else:
        pass

def add_chords(db, song_id, update = False):
    title, lyrics, chords, composers, lyricists = get_song_by_id(db, song_id)
    if request.method == 'GET':
        if chords=='' or update==False:
            chords = '\n'.join(len(lyrics.split('\n')) * [''])
        elif len(chords.split('\n')) != len(lyrics.split('\n')):    # if rows of lyrics != rows of chords
            k = len(lyrics.split('\n')) - len(chords.split('\n'))
            chords += k*'\n'                                       # make rows the same
        return render_template('add-chords.html', title=title, composers=composers, lyricists=lyricists, lyrics=lyrics, chords=chords, song_id=song_id, i=0, zip=zip)
    elif request.method == 'POST':
        lines = len(lyrics.split('\n'))
        lyrics = []
        chords = []
        for i in range(lines):
            lyrics_line = request.form.get(f'lyricsLine-{i+1}')
            lyrics_line = lyrics_line if lyrics_line else ''
            chords_line = request.form.get(f'chordsLine-{i+1}')
            chords_line = chords_line if chords_line else ''
            lyrics.append(lyrics_line)  # get list of inputs
            chords.append(chords_line) 
        lyrics = '\n'.join(lyrics) # list -> str
        chords = '\n'.join(chords)
        update_lyrics_chords(db, song_id, lyrics, chords)
        return f"<h1> Lyrics and Chords Updated successfully </h1> <br> <a href='/{song_id}/song-transpose'>See song</a> <br> <a href='/'>Home</a>"
        
    else:
        pass

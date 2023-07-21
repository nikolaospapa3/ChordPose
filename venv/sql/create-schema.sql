DROP SCHEMA IF EXISTS songs;
DROP SCHEMA IF EXISTS songs_backup;
CREATE SCHEMA songs;
USE songs;

DROP TABLE IF EXISTS Song; 
DROP TABLE IF EXISTS Composer;
DROP TABLE IF EXISTS Lyricist;
DROP TABLE IF EXISTS WroteMusic; 
DROP TABLE IF EXISTS WroteLyrics;
DROP TABLE IF EXISTS User;

create table User (
    username varchar(20),
    password varchar(20),
    primary key (username)
);

create table Song (
    id int(20) AUTO_INCREMENT,
    title varchar(50),
    lyrics text,
    chords text default '',
    likes int(10) default 0,
    made_by varchar(20) default 'AntonisNikos', -- User varchar(20)
    public boolean default 0,
    primary key (id),
    constraint foreign key (made_by) references User(username) on update restrict on delete restrict
);

create table Composer (
    name varchar(50),
    primary key (name)
);

create table Lyricist (
    name varchar(50),
    primary key (name)
);

create table WroteMusic (
    composer varchar(50),
    song_id int(20),
    primary key (composer, song_id),
    constraint foreign key (composer) references Composer(name) on update restrict on delete restrict,
    constraint foreign key (song_id) references Song(id) on update restrict on delete restrict
);

create table WroteLyrics (
    lyricist varchar(50),
    song_id int(20),
    primary key (lyricist, song_id),
    constraint foreign key (lyricist) references Lyricist(name) on update restrict on delete restrict,
    constraint foreign key (song_id) references Song(id) on update restrict on delete restrict
);

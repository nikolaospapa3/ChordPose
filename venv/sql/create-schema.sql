DROP SCHEMA IF EXISTS songs;
DROP SCHEMA IF EXISTS songs_backup;
CREATE SCHEMA songs;
USE songs;

DROP TABLE IF EXISTS song; 
DROP TABLE IF EXISTS composer;
DROP TABLE IF EXISTS lyricist;
DROP TABLE IF EXISTS wrotemusic; 
DROP TABLE IF EXISTS wrotelyrics;
DROP TABLE IF EXISTS user;

create table user (
    username varchar(20),
    password varchar(20),
    primary key (username)
);

create table song (
    id int(20) AUTO_INCREMENT,
    title varchar(50),
    lyrics text,
    chords text default '',
    likes int(10) default 0,
    made_by varchar(20) default 'AntonisNikos', -- User varchar(20)
    public boolean default 0,
    primary key (id),
    constraint foreign key (made_by) references user(username) on update restrict on delete restrict
);

create table composer (
    name varchar(50),
    primary key (name)
);

create table lyricist (
    name varchar(50),
    primary key (name)
);

create table wrotemusic (
    composer varchar(50),
    song_id int(20),
    primary key (composer, song_id),
    constraint foreign key (composer) references composer(name) on update restrict on delete restrict,
    constraint foreign key (song_id) references song(id) on update restrict on delete restrict
);

create table wrotelyrics (
    lyricist varchar(50),
    song_id int(20),
    primary key (lyricist, song_id),
    constraint foreign key (lyricist) references lyricist(name) on update restrict on delete restrict,
    constraint foreign key (song_id) references song(id) on update restrict on delete restrict
);

create table team (
    name varchar(50),
    primary key (name)
);

create table member_of_team (
    username varchar(20),
    teamname varchar(50) default 'NTUA',
    points int(20),
    primary key (teamname, username),
    constraint foreign key (teamname) references team(name) on update restrict on delete restrict,
    constraint foreign key (username) references user(username) on update restrict on delete restrict
);

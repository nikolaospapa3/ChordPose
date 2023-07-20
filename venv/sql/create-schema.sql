DROP SCHEMA IF EXISTS songs;
DROP SCHEMA IF EXISTS songs_backup;
CREATE SCHEMA songs;
USE songs;

DROP TABLE IF EXISTS Song; 

create table Song (
    title varchar(50),
    composer varchar(50),
    lyricist varchar(50),
    lyrics text,
    chords text
);
# ChordPose
A simple app to save songs with lyrics and chords, and maybe transpose chords to other music tonality.

## Deploy Code in Host

```bash
rm -r /home/musicteams/ChordPose
```
```bash
cd /home/musicteams/
git clone https://github.com/ntua-el20069/ChordPose.git
cd ChordPose
vim src/__init__.py
```

## Restore Database from the backup In the host database console (MySQL interpreter) 
```bash
source ~/ChordPose/backup_db_instance/backup-1-11-2023.sql;
```
Don't forget to remove some `song demands` and `recordings`.

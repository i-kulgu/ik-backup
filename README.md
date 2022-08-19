# ik-backup

Simple backup system for police officiers who can send a backup message by command to other police officiers who are on duty.

## Usage

Use the /backup command with the message id (configured 3) you want to send.
Example usage :

### /backup 1

This wil send the next alert to on duty police officiers:
```
title = "Backup Needed"
message = "Officier "..name.." needs immediate backup at his location!"
```

### /backup 2
```
title = "Shots Fired"
message = "There is shootout at the location of officier "..name
```
### /backup 3
```
title = "Officier Down"
message = "Officier "..name.." is down and needs help!"
```

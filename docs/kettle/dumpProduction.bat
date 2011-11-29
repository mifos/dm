@echo off
mysqldump --add-drop-table -h%1 -P%6 -u%2 -p%3 %4 > %5
echo done
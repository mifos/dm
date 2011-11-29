@echo off
mysql -h%1 -u%2 -P%6 -p%3 %4 < %5
@echo on
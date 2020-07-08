#!/bin/bash

while read file; do 
	file_slash= "${file//:/$'/'}"
	echo $file_slash
	rsync -av "$file" /Users/bkilleen/Desktop/For_Steve/
; done /Users/bkilleen/Desktop/Coding/Bash-Scripts/ToMove.txt

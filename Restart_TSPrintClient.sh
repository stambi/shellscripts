#!/bin/bash
# Scrip to restart TSPrint Client if no print job is active. Run with admin rights
# 21.05.209 / STA

printstatus=$(lpstat) 
if [[ -z "$printstatus" ]]
then	
	echo "printstaus is empty, restart TSPrintClient"
	killall TSPrintClient; open -a /Applications/TSPrintClient.app/Contents/MacOS/TSPrintClient
else
	echo "print in progress, do not restart TSPrintClient"
fi
exit 0

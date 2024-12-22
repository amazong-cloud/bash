#!/bin/bash

function print_banner () {
	
	
	echo " 1: $1			      "
	echo "|------------------------------|"
	echo " 1. Fast       		      "
	echo " 2. All ports            	      "
	echo " 3. Full scan            	      "
	echo " 4. All of the above (default)  "
	echo "|------------------------------|"

}

function fast_scan () {

	echo "[+] Fast scanning..."
	nmap -F -Pn $1
	echo "***				[DONE]				***" 

}

function all_ports_scan () {
	echo "[+] Scanning all ports..."
	nmap -Pn -sS --defeat-rst-ratelimit $1
	echo "***				[DONE]				***" 

}

function full_scan () {
	file_name=$1".nmap"
	echo "[+] Full scanning..."
	nmap -sV -sC -Pn -sS --defeat-rst-ratelimit -p- $1 -oN $file_name
	echo "***				[DONE]				***" 

}

function all_scans () {
	fast_scan $1
	all_ports_scan $1
	full_scan $1
}

## input_validation

if [ "$#" != 1 ];then
		echo "Usage: $0 IP"
		exit 1
fi

## main_code
print_banner $1
read -r scan_mode

case $scan_mode in

	"1")
		fast_scan $1
		echo "1"
		;;
	"2")
		all_ports_scan $1
		;;
	"3")
		full_scan $1
		;;
	"4")
		all_scans $1
		;;
		
esac


#!/bin/bash

#logfile="@"
logfile=$1

#echo $logfile


### compute avg
#grep  "MCX simulation speed" $logfile | awk -F " "  '{print $4}' |\
#	awk '{ total += $1; count++ } END { print total/count }'

### find the max 
grep  "MCX simulation speed" $logfile | awk -F " "  '{print $4}' |\
	awk -v max=0 '{if($1>max){max=$1}}END{print max} ' 

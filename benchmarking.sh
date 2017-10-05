#!/bin/bash

select_dev_and_run()
{
devid=$1
MAXITERS=$2

#------------------------------------------------------------------------------
# baseline
#------------------------------------------------------------------------------
echo -e "\nBaseline (-G $devid)" | tee -a reportSummary
cd baseline/src
make clean
make
cd ../example/benchmark/

#-----------------------
echo -n "benchmark1 : " | tee -a  ../../../reportSummary
#-----------------------
if [ -f ben1_log ];then
	rm ben1_log
fi

touch ben1_log

for (( i=0; i<$MAXITERS; i++ ))
do
  ./run_benchmark1.sh -G $devid  >> ./ben1_log
done

../../../getThroughput.sh  ben1_log | tee -a ../../../reportSummary

cd ../../../

##-----------------------
#echo -n "benchmark2 : "  | tee -a ../../../reportSummary
##-----------------------
#if [ -f ben2_log ];then
#	rm ben2_log
#fi
#
#touch ben2_log
#
#for (( i=0; i<$MAXITERS; i++ ))
#do
#  ./run_benchmark2.sh -G $devid  >> ./ben2_log
#done
#
#../../../getThroughput.sh  ben2_log  | tee -a  ../../../reportSummary
#
#
##-----------------------
#echo -n "benchmark2a : " | tee -a ../../../reportSummary
##-----------------------
#if [ -f ben2a_log ];then
#	rm ben2a_log
#fi
#
#touch ben2a_log
#
#for (( i=0; i<$MAXITERS; i++ ))
#do
#  ./run_benchmark2a.sh -G $devid  >> ./ben2a_log
#done
#
#../../../getThroughput.sh  ben2a_log | tee -a  ../../../reportSummary



##------------------------------------------------------------------------------
## opt1 
##------------------------------------------------------------------------------
#cd ../../../
#echo -e "\nOpt1_fastmath" | tee -a reportSummary
#
#cd opt1_fastmath/src
#make clean
#make
#cd ../example/benchmark/
#
##-----------------------
#echo -n "benchmark1 : " | tee -a  ../../../reportSummary
##-----------------------
#if [ -f ben1_log ];then
#	rm ben1_log
#fi
#
#touch ben1_log
#
#for (( i=0; i<$MAXITERS; i++ ))
#do
#  ./run_benchmark1.sh -G $devid  >> ./ben1_log
#done
#
#../../../getThroughput.sh  ben1_log | tee -a ../../../reportSummary
#
##-----------------------
#echo -n "benchmark2 : "  | tee -a ../../../reportSummary
##-----------------------
#if [ -f ben2_log ];then
#	rm ben2_log
#fi
#
#touch ben2_log
#
#for (( i=0; i<$MAXITERS; i++ ))
#do
#  ./run_benchmark2.sh -G $devid  >> ./ben2_log
#done
#
#../../../getThroughput.sh  ben2_log  | tee -a  ../../../reportSummary
#
#
##-----------------------
#echo -n "benchmark2a : " | tee -a ../../../reportSummary
##-----------------------
#if [ -f ben2a_log ];then
#	rm ben2a_log
#fi
#
#touch ben2a_log
#
#for (( i=0; i<$MAXITERS; i++ ))
#do
#  ./run_benchmark2a.sh -G $devid  >> ./ben2a_log
#done
#
#../../../getThroughput.sh  ben2a_log | tee -a  ../../../reportSummary
#
#
#
#
##------------------------------------------------------------------------------
## opt2 
##------------------------------------------------------------------------------
#cd ../../../
#echo -e "\nOpt2_persistent" | tee -a reportSummary
#
#cd opt2_persistent/src
#make clean
#make
#cd ../example/benchmark/
#
##-----------------------
#echo -n "benchmark1 : " | tee -a  ../../../reportSummary
##-----------------------
#if [ -f ben1_log ];then
#	rm ben1_log
#fi
#
#touch ben1_log
#
#for (( i=0; i<$MAXITERS; i++ ))
#do
#  ./run_benchmark1.sh -G $devid  >> ./ben1_log
#done
#
#../../../getThroughput.sh  ben1_log | tee -a ../../../reportSummary
#
##-----------------------
#echo -n "benchmark2 : "  | tee -a ../../../reportSummary
##-----------------------
#if [ -f ben2_log ];then
#	rm ben2_log
#fi
#
#touch ben2_log
#
#for (( i=0; i<$MAXITERS; i++ ))
#do
#  ./run_benchmark2.sh -G $devid  >> ./ben2_log
#done
#
#../../../getThroughput.sh  ben2_log  | tee -a  ../../../reportSummary
#
#
##-----------------------
#echo -n "benchmark2a : " | tee -a ../../../reportSummary
##-----------------------
#if [ -f ben2a_log ];then
#	rm ben2a_log
#fi
#
#touch ben2a_log
#
#for (( i=0; i<$MAXITERS; i++ ))
#do
#  ./run_benchmark2a.sh -G $devid  >> ./ben2a_log
#done
#
#../../../getThroughput.sh  ben2a_log | tee -a  ../../../reportSummary
#
#
#
#
##------------------------------------------------------------------------------
## opt3 
##------------------------------------------------------------------------------
#cd ../../../
#echo -e "\nOpt3_persistent" | tee -a reportSummary
#
#cd opt3_persistent_macros/src 
#make clean
#make
#cd ../example/benchmark/
#
##-----------------------
#echo -n "benchmark1 : " | tee -a  ../../../reportSummary
##-----------------------
#if [ -f ben1_log ];then
#	rm ben1_log
#fi
#
#touch ben1_log
#
#for (( i=0; i<$MAXITERS; i++ ))
#do
#  ./run_benchmark1.sh -G $devid  >> ./ben1_log
#done
#
#../../../getThroughput.sh  ben1_log | tee -a ../../../reportSummary
#
##-----------------------
#echo -n "benchmark2 : "  | tee -a ../../../reportSummary
##-----------------------
#if [ -f ben2_log ];then
#	rm ben2_log
#fi
#
#touch ben2_log
#
#for (( i=0; i<$MAXITERS; i++ ))
#do
#  ./run_benchmark2.sh -G $devid  >> ./ben2_log
#done
#
#../../../getThroughput.sh  ben2_log  | tee -a  ../../../reportSummary
#
#
##-----------------------
#echo -n "benchmark2a : " | tee -a ../../../reportSummary
##-----------------------
#if [ -f ben2a_log ];then
#	rm ben2a_log
#fi
#
#touch ben2a_log
#
#for (( i=0; i<$MAXITERS; i++ ))
#do
#  ./run_benchmark2a.sh -G $devid  >> ./ben2a_log
#done
#
#../../../getThroughput.sh  ben2a_log | tee -a  ../../../reportSummary
#
#
##----------
## clean up
##----------
#cd ../../../
#cd baseline/src/ && make clean && cd ../../
#cd opt1_fastmath/src/ && make clean && cd ../../
#cd opt2_persistent/src/ && make clean && cd ../../
#cd opt3_persistent_macros/src/ && make clean && cd ../../


}

#------------------------------------------------------------------------------
# Main
#------------------------------------------------------------------------------
if [ -f reportSummary ];then rm reportSummary;fi 
touch reportSummary


#------------------------------------------------------------------------------
# Simulation Parameters 
#------------------------------------------------------------------------------
maxiters=2
devid_array=

#------------------------------------------------------------------------------
# Specify device to run on the target platform 
#------------------------------------------------------------------------------
## check hostname
if [[ $(hostname -s) = homedesktop ]]; then
  echo -e "Run MCXCL Benchmarking on $(hostname -s)\n" | tee -a  reportSummary
  devid_array=(010 001)   # gtx 950, gtx 760

elif [[ $(hostname -s) = kepler1 ]]; then
  echo -e "Run MCXCL Benchmarking on $(hostname -s)\n" | tee -a  reportSummary
  devid_array=(10 01)   # k40c, k20c 

else
  echo "Unknow platform! Exit."
  exit 1
fi


for gid in ${devid_array[@]}
do
	echo $gid
	select_dev_and_run $gid $maxiters
done


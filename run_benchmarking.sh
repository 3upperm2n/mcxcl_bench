#!/bin/bash

#------------------------------------------------------------------------------
# Simulation Parameters 
#------------------------------------------------------------------------------
MAXITERS=2
devid=

if [ -f reportSummary ];then rm reportSummary;fi 
touch reportSummary

#------------------------------------------------------------------------------
# Specify device to run on the target platform 
#------------------------------------------------------------------------------
## check hostname
if [[ $(hostname -s) = homedesktop ]]; then
  echo "Run MCXCL Benchmarking on $(hostname -s)" | tee -a  reportSummary
  echo -e "\n"
  devid=010
fi


### check devid
if [ -n "$devid" ]; then
  echo "Running on -G $devid" | tee -a  reportSummary
else
  echo "Error: devid empty! Exit."
  exit 1
fi


#------------------------------------------------------------------------------
# baseline
#------------------------------------------------------------------------------
echo -e "\nBaseline" | tee -a reportSummary
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

#-----------------------
echo -n "benchmark2 : "  | tee -a ../../../reportSummary
#-----------------------
if [ -f ben2_log ];then
	rm ben2_log
fi

touch ben2_log

for (( i=0; i<$MAXITERS; i++ ))
do
  ./run_benchmark2.sh -G $devid  >> ./ben2_log
done

../../../getThroughput.sh  ben2_log  | tee -a  ../../../reportSummary


#-----------------------
echo -n "benchmark2a : " | tee -a ../../../reportSummary
#-----------------------
if [ -f ben2a_log ];then
	rm ben2a_log
fi

touch ben2a_log

for (( i=0; i<$MAXITERS; i++ ))
do
  ./run_benchmark2a.sh -G $devid  >> ./ben2a_log
done

../../../getThroughput.sh  ben2a_log | tee -a  ../../../reportSummary



#------------------------------------------------------------------------------
# opt1 
#------------------------------------------------------------------------------
cd ../../../
echo -e "\nOpt1_fastmath" | tee -a reportSummary

cd opt1_fastmath/src
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

#-----------------------
echo -n "benchmark2 : "  | tee -a ../../../reportSummary
#-----------------------
if [ -f ben2_log ];then
	rm ben2_log
fi

touch ben2_log

for (( i=0; i<$MAXITERS; i++ ))
do
  ./run_benchmark2.sh -G $devid  >> ./ben2_log
done

../../../getThroughput.sh  ben2_log  | tee -a  ../../../reportSummary


#-----------------------
echo -n "benchmark2a : " | tee -a ../../../reportSummary
#-----------------------
if [ -f ben2a_log ];then
	rm ben2a_log
fi

touch ben2a_log

for (( i=0; i<$MAXITERS; i++ ))
do
  ./run_benchmark2a.sh -G $devid  >> ./ben2a_log
done

../../../getThroughput.sh  ben2a_log | tee -a  ../../../reportSummary




#------------------------------------------------------------------------------
# opt2 
#------------------------------------------------------------------------------
cd ../../../
echo -e "\nOpt2_persistent" | tee -a reportSummary

cd opt2_persistent/src
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

#-----------------------
echo -n "benchmark2 : "  | tee -a ../../../reportSummary
#-----------------------
if [ -f ben2_log ];then
	rm ben2_log
fi

touch ben2_log

for (( i=0; i<$MAXITERS; i++ ))
do
  ./run_benchmark2.sh -G $devid  >> ./ben2_log
done

../../../getThroughput.sh  ben2_log  | tee -a  ../../../reportSummary


#-----------------------
echo -n "benchmark2a : " | tee -a ../../../reportSummary
#-----------------------
if [ -f ben2a_log ];then
	rm ben2a_log
fi

touch ben2a_log

for (( i=0; i<$MAXITERS; i++ ))
do
  ./run_benchmark2a.sh -G $devid  >> ./ben2a_log
done

../../../getThroughput.sh  ben2a_log | tee -a  ../../../reportSummary




#------------------------------------------------------------------------------
# opt3 
#------------------------------------------------------------------------------
cd ../../../
echo -e "\nOpt3_persistent" | tee -a reportSummary

cd opt3_persistent_macros/src 
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

#-----------------------
echo -n "benchmark2 : "  | tee -a ../../../reportSummary
#-----------------------
if [ -f ben2_log ];then
	rm ben2_log
fi

touch ben2_log

for (( i=0; i<$MAXITERS; i++ ))
do
  ./run_benchmark2.sh -G $devid  >> ./ben2_log
done

../../../getThroughput.sh  ben2_log  | tee -a  ../../../reportSummary


#-----------------------
echo -n "benchmark2a : " | tee -a ../../../reportSummary
#-----------------------
if [ -f ben2a_log ];then
	rm ben2a_log
fi

touch ben2a_log

for (( i=0; i<$MAXITERS; i++ ))
do
  ./run_benchmark2a.sh -G $devid  >> ./ben2a_log
done

../../../getThroughput.sh  ben2a_log | tee -a  ../../../reportSummary


# clean up
cd ../../../
cd baseline/src/ && make clean && cd ../../
cd opt1_fastmath/src/ && make clean && cd ../../
cd opt2_persistent/src/ && make clean && cd ../../
cd opt3_persistent_macros/src/ && make clean && cd ../../


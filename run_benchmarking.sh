#!/bin/bash

select_dev_and_run()
{
devid=$1
MAXITERS=$2
photons=1e7

#------------------------------------------------------------------------------
# baseline
#------------------------------------------------------------------------------
echo -e "\nBaseline (-G $devid)" | tee -a reportSummary
cd baseline/src
make clean all > /dev/null
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
  ./run_benchmark1.sh -G $devid -n $photons >> ./ben1_log
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
  ./run_benchmark2.sh -G $devid -n $photons >> ./ben2_log
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
  ./run_benchmark2a.sh -G $devid -n $photons >> ./ben2a_log
done

../../../getThroughput.sh  ben2a_log | tee -a  ../../../reportSummary



#------------------------------------------------------------------------------
# opt1 
#------------------------------------------------------------------------------
cd ../../../
echo -e "\nOpt1_fastmath" | tee -a reportSummary

cd opt1_fastmath/src
make clean all > /dev/null
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
  ./run_benchmark1.sh -G $devid -n $photons >> ./ben1_log
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
  ./run_benchmark2.sh -G $devid -n $photons >> ./ben2_log
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
  ./run_benchmark2a.sh -G $devid -n $photons >> ./ben2a_log
done

../../../getThroughput.sh  ben2a_log | tee -a  ../../../reportSummary




#------------------------------------------------------------------------------
# opt2 
#------------------------------------------------------------------------------
cd ../../../
echo -e "\nOpt2_persistent" | tee -a reportSummary

cd opt2_persistent/src
make clean all > /dev/null
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
  ./run_benchmark1.sh -G $devid -n $photons >> ./ben1_log
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
  ./run_benchmark2.sh -G $devid -n $photons >> ./ben2_log
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
  ./run_benchmark2a.sh -G $devid -n $photons >> ./ben2a_log
done

../../../getThroughput.sh  ben2a_log | tee -a  ../../../reportSummary




#------------------------------------------------------------------------------
# opt3 
#------------------------------------------------------------------------------
cd ../../../
echo -e "\nOpt3_persistent_macro" | tee -a reportSummary

cd opt3_persistent_macros/src 
make clean all > /dev/null
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
  ./run_benchmark1.sh -G $devid -n $photons >> ./ben1_log
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
  ./run_benchmark2.sh -G $devid -n $photons >> ./ben2_log
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
  ./run_benchmark2a.sh -G $devid -n $photons >> ./ben2a_log
done

../../../getThroughput.sh  ben2a_log | tee -a  ../../../reportSummary

#------------------------
# back to the top level
#------------------------
cd ../../../
}

#------------------------------------------------------------------------------
# Main
#------------------------------------------------------------------------------
if [ -f reportSummary ];then rm reportSummary;fi 
touch reportSummary


#------------------------------------------------------------------------------
# Simulation Parameters 
#------------------------------------------------------------------------------
maxiters=3
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

elif [[ $(hostname -s) = hoyi ]]; then
  echo -e "Run MCXCL Benchmarking on $(hostname -s)\n" | tee -a  reportSummary
  devid_array=(100 010)   # TITAN X, GTX 980 Ti

elif [[ $(hostname -s) = fuxi ]]; then
  echo -e "Run MCXCL Benchmarking on $(hostname -s)\n" | tee -a  reportSummary
  devid_array=(100)   # GTX 1080 

elif [[ $(hostname -s) = mcx1 ]]; then
  echo -e "Run MCXCL Benchmarking on $(hostname -s)\n" | tee -a  reportSummary
  devid_array=(100)   # GTX 1080 Ti

elif [[ $(hostname -s) = taote ]]; then
  echo -e "Run MCXCL Benchmarking on $(hostname -s)\n" | tee -a  reportSummary
  devid_array=(100 010 001)   # GTX 1080 Ti, 980Ti, i7-7700k

elif [[ $(hostname -s) = zodiac ]]; then
  echo -e "Run MCXCL Benchmarking on $(hostname -s)\n" | tee -a  reportSummary
  devid_array=(010 100 001)   # AMD R480, R9 nano, dual Xeon 48 cores
  
else
  echo "Unknow platform! Exit."
  exit 1
fi

#------------------------------------------------------------------------------
# Enable Intel OpenCL support
#------------------------------------------------------------------------------
export LD_LIBRARY_PATH=/pub/intel/opencl-1.2-6.4.0.25/lib64/:$LD_LIBRARY_PATH

for gid in ${devid_array[@]}
do
	echo $gid
	select_dev_and_run $gid $maxiters
done


#----------
# clean up
#----------
cd baseline/src/ && make clean && cd ../../
cd opt1_fastmath/src/ && make clean && cd ../../
cd opt2_persistent/src/ && make clean && cd ../../
cd opt3_persistent_macros/src/ && make clean && cd ../../

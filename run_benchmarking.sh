#!/bin/bash

extraopt=( "-A 0 -t 16384 -T 64" "-A 0 -t 16384 -T 64 -J -DMCX_USE_NATIVE" "-J -DMCX_USE_NATIVE -A 3" "-J -DMCX_USE_NATIVE -A 3 -J -DMCX_SIMPLIFY_BRANCH -J -DMCX_VECTOR_INDEX" );
photons=1e8
hostid=$(hostname -s)

select_dev_and_run()
{
devid=$1
MAXITERS=$2
testid=$(($3-1))

hostid=$hostid

#------------------------------------------------------------------------------
# running test
#------------------------------------------------------------------------------
echo -e "\nRunning test $testid on device (-G $devid) using flags: -G $devid -n $photons ${extraopt[$testid]}" | tee -a report_${hostid}

cd mcxcl/example/benchmark/

#-----------------------
echo -n "benchmark1 : " | tee -a  ../../../report_${hostid}
#-----------------------
if [ -f ben1_log_${hostid}_${devid}_${testid} ];then
	rm ben1_log_${hostid}_${devid}_${testid}
fi

touch ben1_log_${hostid}_${devid}_${testid}

for (( i=0; i<$MAXITERS; i++ ))
do
  ./run_benchmark1.sh -G $devid -n $photons ${extraopt[$testid]} >> "./ben1_log_${hostid}_${devid}_${testid}"
done

../../../getThroughput.sh  "ben1_log_${hostid}_${devid}_${testid}" | tee -a ../../../report_${hostid}


#-----------------------
echo -n "benchmark2 : "  | tee -a ../../../report_${hostid}
#-----------------------
if [ -f ben2_log_${hostid}_${devid}_${testid} ];then
	rm ben2_log_${hostid}_${devid}_${testid}
fi

touch ben2_log_${hostid}_${devid}_${testid}

for (( i=0; i<$MAXITERS; i++ ))
do
  ./run_benchmark2.sh -G $devid -n $photons ${extraopt[$testid]} >> "./ben2_log_${hostid}_${devid}_${testid}"
done

../../../getThroughput.sh  "ben2_log_${hostid}_${devid}_${testid}"  | tee -a  ../../../report_${hostid}


#-----------------------
echo -n "benchmark2a : " | tee -a ../../../report_${hostid}
#-----------------------
if [ -f ben2a_log_${hostid}_${devid}_${testid} ];then
	rm ben2a_log_${hostid}_${devid}_${testid}
fi

touch ben2a_log_${hostid}_${devid}_${testid}

for (( i=0; i<$MAXITERS; i++ ))
do
  ./run_benchmark2a.sh -G $devid -n $photons ${extraopt[$testid]} >> "./ben2a_log_${hostid}_${devid}_${testid}"
done

../../../getThroughput.sh  "ben2a_log_${hostid}_${devid}_${testid}" | tee -a  ../../../report_${hostid}

#------------------------
# back to the top level
#------------------------
cd ../../../
}

#------------------------------------------------------------------------------
# Main
#------------------------------------------------------------------------------
if [ -f report_${hostid} ];then rm report_${hostid};fi 
touch report_${hostid}

#------------------------------------------------------------------------------
# Checkout master branch from upstream
#------------------------------------------------------------------------------

git clone https://github.com/fangq/mcxcl.git
cd mcxcl/src
git pull
rm *.o
if [[ $hostid = mcx1 ]]; then
    git checkout nvidiaomp
fi
make
cd ../../

#------------------------------------------------------------------------------
# Simulation Parameters 
#------------------------------------------------------------------------------
maxiters=3
devid_array=

#------------------------------------------------------------------------------
# Specify device to run on the target platform 
#------------------------------------------------------------------------------
## check hostname
if [[ $hostid = homedesktop ]]; then
  echo -e "Run MCXCL Benchmarking on $hostid\n" | tee -a  report_${hostid}
  devid_array=(010 001)   # gtx 950, gtx 760

elif [[ $hostid = kepler1 ]]; then
  echo -e "Run MCXCL Benchmarking on $hostid\n" | tee -a  report_${hostid}
  devid_array=(10 01)   # k40c, k20c 

elif [[ $hostid = hoyi ]]; then
  echo -e "Run MCXCL Benchmarking on $hostid\n" | tee -a  report_${hostid}
  devid_array=(100 010)   # TITAN X, GTX 980 Ti

elif [[ $hostid = wazu ]]; then
  echo -e "Run MCXCL Benchmarking on $hostid\n" | tee -a  report_${hostid}
  devid_array=(010 001)   # GTX 590, i7-2600K

elif [[ $hostid = fuxi ]]; then
  echo -e "Run MCXCL Benchmarking on $hostid\n" | tee -a  report_${hostid}
  devid_array=(100)   # GTX 1080 

elif [[ $hostid = mcx1 ]]; then
  echo -e "Run MCXCL Benchmarking on $hostid\n" | tee -a  report_${hostid}
  devid_array=(1 11 111 1111 11111 111111 1111111 11111111)   # GTX 1080 Ti
  photons=1e9
  extraopt=("${extraopt[@]:3}")

elif [[ $hostid = taote ]]; then
  echo -e "Run MCXCL Benchmarking on $hostid\n" | tee -a  report_${hostid}
  devid_array=(100 010 001)   # GTX 1080 Ti, 980Ti, i7-7700k

elif [[ $hostid = zodiac ]]; then
  echo -e "Run MCXCL Benchmarking on $hostid\n" | tee -a  report_${hostid}
  devid_array=(010 100 001)   # AMD R480, R9 nano, dual Xeon 48 cores

elif [[ $hostid = dayu ]]; then
  echo -e "Run MCXCL Benchmarking on $hostid\n" | tee -a  report_${hostid}
  devid_array=(100)   # Intel HD 520 GPU

elif [[ $hostid = zen ]]; then
  echo -e "Run MCXCL Benchmarking on $hostid\n" | tee -a  report_${hostid}
  devid_array=(100 001)   # GTX 1050Ti, zen

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
	for testid in $(seq ${#extraopt[@]})
	do
	    select_dev_and_run $gid $maxiters $testid
	done
done


#----------
# clean up
#----------
#cd mcxcl/src/ && make clean && cd ../../

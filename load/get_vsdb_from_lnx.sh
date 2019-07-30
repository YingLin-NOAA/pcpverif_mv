#!/bin/bash
set -x

# Argument for this job:
#   1. erly/late
#   2 & 3. day1/day2: starting/ending date of VSDB
#   4. "mod1, mod2, mod3...."

# NDATE is defined in prod_util
# finddate is not, but UTILROOT is defined in prod_util
$ Looks like merely running a bash script does not invoke .bashrc.  Define
# UTILROOT here: 
UTILROOT=/gpfs/dell1/nco/ops/nwprod/prod_util.v1.1.2
FINDDATE=$UTILROOT/ush/finddate.sh


if [ $# -lt 4 ]; then
  echo This scripts needs at four arguments:
  echo   1. erly/late
  echo   2 & 3. day1/day2: starting/ending date of VSDB
  echo   4. "mod1, mod2, mod3...."
  exit
else
  vsdbtype=$1
  day1=$2
  day2=$3
  models=$4
fi

VSDBARCH=/export/emc-lw-ylin/wd22yl/tempest/vsdb
VMACHINE=vm-lnx-metviewdev-process1.ncep.noaa.gov
PTMP=/gpfs/dell2/ptmp/Ying.Lin
if [ $vsdbtype = erly ]; then
  vsdbdir=$PTMP/awsload/vsdb.erly
elif [ $vsdbtype = late ]; then
  vsdbdir=$PTMP/awsload/vsdb
else
  echo $vsdbtype needs to be either erly or late!  Exit.
  exit
fi

if [ -d $vsdbdir ]; then
  rm -f $vsdbdir/*
else
  mkdir -p $vsdbdir
fi

cd $vsdbdir

day=$day1
while [ $day -le $day2 ]
do 
  for mod in $models
  do
    scp wd22yl@$VMACHINE:$VSDBARCH/$mod/${mod}_$day.vsdb .
  done
  day=`$FINDDATE $day d+1`
done

exit

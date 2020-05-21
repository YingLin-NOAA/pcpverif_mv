#!/bin/sh
set -x

# Load prod and dev vsdbs for $daym9

# also can run interactively with an argument (day0)

prodvsdbdir=/gpfs/dell1/nco/ops/com/verf/prod/vsdb/precip
 devvsdbdir=/gpfs/dell2/ptmp/Ying.Lin/verf.dat/vsdb

PTMP=/gpfs/dell2/ptmp/Ying.Lin/awsload
dirvsdb=$PTMP/vsdb

for dir in $dirvsdberly $dirvsdb
do
  if [ -d $dir ]
  then
    rm -f $dir/*
  else
    mkdir -p $dir
  fi
done

if [ $# -eq 0 ]; then
  daym9=`date +%Y%m%d -d "9 day ago"`
else
  day0=$1
  FINDDATE=/gpfs/dell1/nco/ops/nwprod/prod_util.v1.1.2/ush/finddate.sh
  daym9=`$FINDDATE $day0 d-9`
fi

# prod vsdbs:
cp {prodvsdbdir}/*/*_${daym9}.vsdb .

# dev vsdbs:
cp $devvsdbdir/*/*_${daym9}.vsdb .
  
# Now load to AWS MV:
# $AWSMV defined in .bashrc.
STATS=$PTMP
$AWSMV/mv_load_to_aws.sh ying.lin $STATS $AWSMV/load/load_pcp_add.xml

exit

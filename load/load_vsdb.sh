#!/bin/sh
set -x

# Load prod and dev vsdbs for $daym9

# also can run interactively with an argument (day0)

prdvsdbdir=/gpfs/dell1/nco/ops/com/verf/prod/vsdb/precip
devvsdbdir=/gpfs/dell2/ptmp/Ying.Lin/verf.dat/vsdb

PTMP=/gpfs/dell2/ptmp/Ying.Lin/awsload
dirvsdb=$PTMP/vsdb

if [ -d $dirvsdb ]
then
  rm -f $dirvsdb/*
else
  mkdir -p $dirvsdb
fi

if [ $# -eq 0 ]; then
  daym9=`date +%Y%m%d -d "9 day ago"`
else
  daym9=$1
fi

# prod vsdbs:
cp ${prdvsdbdir}/*/*_${daym9}.vsdb $dirvsdb/.

# dev vsdbs:
cp $devvsdbdir/*/*_${daym9}.vsdb $dirvsdb/.
  
# Now load to AWS MV:
# $AWSMV defined in .bashrc.
STATS=$PTMP
$AWSMV/mv_load_to_aws.sh ying.lin $STATS $AWSMV/load/load_pcp_vsdb.xml

exit

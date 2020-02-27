#!/bin/sh
set -x

# this is the manual version of load_cron.sh, assuming that VSDBs are already
# in $STATS/vsdb/ and $STATS/vsdb.erly/.  This script can be used to load 
# previously-missing verif stats to the databases.

if [ $# -eq 0 ]; then
  day=`date +%Y%m%d -d "2 days ago"`
else
  day=$1
fi

SCRIPTS=/gpfs/dell2/emc/verification/noscrub/Ying.Lin/awsmv
STATS=/gpfs/dell2/ptmp/Ying.Lin/awsload.href-dell

if [ -d $STATS/hrefs ]
then
  rm -f $STATS/hrefs/*
else
  mkdir -p $STATS/hrefs
fi

proddir=/gpfs/dell2/ptmp/Ying.Lin/verf.dat.v4.3.2/vsdb/href
paradir=/gpfs/dell2/ptmp/Ying.Lin/verf.dat.v4.4.0/vsdb/hrefv3

prodvsdb=$proddir/href_${day}.vsdb
paravsdb=$paradir/hrefv3_${day}.vsdb
scp $prodvsdb wd22yl@vm-lnx-metviewdev-process1:/export/emc-lw-ylin/wd22yl/tempest/vsdb.dell/href/.
scp $paravsdb wd22yl@vm-lnx-metviewdev-process1:/export/emc-lw-ylin/wd22yl/tempest/vsdb.dell/hrefv3/.

cp $prodvsdb $paravsdb $STATS/hrefs/. 

$SCRIPTS/mv_load_to_aws.sh ying.lin $STATS $SCRIPTS/load/load_pcp_href.xml

exit


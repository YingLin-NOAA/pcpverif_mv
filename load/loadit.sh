#!/bin/sh
set -x

# this is the manual version of load_cron.sh, assuming that VSDBs are already
# in $STATS/vsdb/ and $STATS/vsdb.erly/.  This script can be used to load 
# previously-missing verif stats to the databases.

SCRIPTS=/gpfs/dell2/emc/verification/noscrub/Ying.Lin/awsmv
# note that the stats files are under $STATS/vsdb/ and $STATS/vsdb_erly/:
STATS=/gpfs/dell2/ptmp/Ying.Lin/awsload
$SCRIPTS/mv_load_to_aws.sh ying.lin $STATS $SCRIPTS/load/load_pcp_erly_add.xml
$SCRIPTS/mv_load_to_aws.sh ying.lin $STATS $SCRIPTS/load/load_pcp_add.xml

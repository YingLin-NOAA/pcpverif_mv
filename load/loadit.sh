#!/usr/bin/env bash

SCRIPTS=/gpfs/dell2/emc/verification/noscrub/Ying.Lin/awsmv
# note that the stats files are under $STATS/vsdb/ and $STATS/vsdb_erly/:
STATS=/gpfs/dell2/ptmp/Ying.Lin/awsload
$SCRIPTS/mv_load_to_aws.sh ying.lin $STATS $SCRIPTS/load/load_pcp_erly_new.xml
#$SCRIPTS/mv_load_to_aws.sh ying.lin $STATS $SCRIPTS/load/load_pcp_add.xml

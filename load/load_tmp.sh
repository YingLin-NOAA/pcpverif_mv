#!/bin/sh
set -x
AWSMV=/gpfs/dell2/emc/verification/noscrub/Ying.Lin/awsmv
STATS=/gpfs/dell2/ptmp/Ying.Lin/awsload
$AWSMV/mv_load_to_aws.sh ying.lin $STATS $AWSMV/load/load_pcp_add.xml

exit

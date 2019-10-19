#!/usr/bin/env bash

# Load PCPRTMA vs. PCPRTMA2p8 stats:
SCRIPTS=/gpfs/dell2/emc/verification/noscrub/Ying.Lin/awsmv

STATSWRK=/gpfs/dell2/ptmp/Ying.Lin/awsload.metplus.rtma-urma

cd $STATSWRK/stats.dir

# subdir under $STATS defined in the xml script: 
#     <folder_tmpl>/base_dir/{type}</folder_tmpl>
#              ....
#       <val>stats.dir</val>

$SCRIPTS/mv_load_to_aws.sh ying.lin $STATSWRK $SCRIPTS/load.rtma-urma/load_metplus_add.xml


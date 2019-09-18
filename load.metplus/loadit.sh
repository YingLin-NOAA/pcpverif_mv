#!/usr/bin/env bash

# Load PCPRTMA vs. PCPRTMA2p8 stats:
SCRIPTS=/gpfs/dell2/emc/verification/noscrub/Ying.Lin/awsmv
STATS=/gpfs/dell2/ptmp/Ying.Lin/awsload
# subdir under $STATS defined in the xml script: 
#     <folder_tmpl>/base_dir/{type}</folder_tmpl>
#              ....
#       <val>met.stats</val>

$SCRIPTS/mv_load_to_aws.sh ying.lin $STATS $SCRIPTS/load.metplus/load_metplus_add.xml


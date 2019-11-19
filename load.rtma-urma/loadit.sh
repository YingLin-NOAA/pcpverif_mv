#!/usr/bin/env bash

# Load PCPRTMA vs. PCPRTMA2p8 stats:
SCRIPTS=/gpfs/dell2/emc/verification/noscrub/Ying.Lin/awsmv

STATSARCH=/gpfs/dell2/emc/verification/noscrub/Ying.Lin/metplus.stats/rtma-urma
STATSWRK=/gpfs/dell2/ptmp/Ying.Lin/awsload.metplus.rtma-urma

if [ -d $STATSWRK/stats.dir ]; then
  rm -rf $STATSWRK/stats.dir/*
else
  mkdir -p $STATSWRK/stats.dir
fi

cd $STATSWRK/stats.dir

for vday in 20191015 20191016 20191017 20191018 20191019
do
  cp -p $STATSARCH/$vday/*.stat . 
done

# subdir under $STATS defined in the xml script: 
#     <folder_tmpl>/base_dir/{type}</folder_tmpl>
#              ....
#       <val>stats.dir</val>

$SCRIPTS/mv_load_to_aws.sh ying.lin $STATSWRK $SCRIPTS/load.rtma-urma/load_metplus_add.xml


#!/usr/bin/env bash

# Load PCPRTMA vs. PCPRTMA2p8 stats:
SCRIPTS=/gpfs/dell2/emc/verification/noscrub/Ying.Lin/awsmv

STATSARCH=/gpfs/dell2/emc/verification/noscrub/Ying.Lin/metplus.stats
STATSWRK=/gpfs/dell2/ptmp/Ying.Lin/awsload.metplus

if [ -d $STATSWRK/stats.dir ]; then
  rm -rf $STATSWRK/stats.dir/*
else
  mkdir -p $STATSWRK/stats.dir
fi

cd $STATSWRK/stats.dir

for dd in 01 02 03 04 05 06
do
  cp -p $STATSARCH/201910${dd}/*10${dd}_21*.stat . 
done

cp -p $STATSARCH/20191007/*.stat . 
cp -p $STATSARCH/20191008/*.stat . 

# subdir under $STATS defined in the xml script: 
#     <folder_tmpl>/base_dir/{type}</folder_tmpl>
#              ....
#       <val>stats.dir</val>

$SCRIPTS/mv_load_to_aws.sh ying.lin $STATSWRK $SCRIPTS/load.metplus/load_metplus_add.xml


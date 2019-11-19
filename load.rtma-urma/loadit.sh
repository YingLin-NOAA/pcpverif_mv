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

vday1=20191011
vday2=20191117

vday=$vday1

while [ $vday -le $vday2 ]
do
  cp -p $STATSARCH/$vday/*.stat . 
  vday=`date -d "$vday + 1 day" +%Y%m%d`
done

# subdir under $STATS defined in the xml script: 
#     <folder_tmpl>/base_dir/{type}</folder_tmpl>
#              ....
#       <val>stats.dir</val>

$SCRIPTS/mv_load_to_aws.sh ying.lin $STATSWRK $SCRIPTS/load.rtma-urma/load_metplus_add.xml


#!/usr/bin/env bash
set -x

# 
SCRIPTS=/gpfs/dell2/emc/verification/noscrub/Ying.Lin/awsmv

STATSARCH=/gpfs/dell2/emc/verification/noscrub/Ying.Lin/metplus.stats
STATSWRK=/gpfs/dell2/ptmp/Ying.Lin/awsload.metplus

if [ -d $STATSWRK/stats.dir ]; then
  rm -rf $STATSWRK/stats.dir/*
else
  mkdir -p $STATSWRK/stats.dir
fi

cd $STATSWRK/stats.dir

day1=20191017
day2=20191201

day=$day1

while [ $day -le $day2 ];
do
  cp -p $STATSARCH/$day/*.stat . 
  day=`date -d "$day + 1 day" +%Y%m%d`

done


# subdir under $STATS defined in the xml script: 
#     <folder_tmpl>/base_dir/{type}</folder_tmpl>
#              ....
#       <val>stats.dir</val>

$SCRIPTS/mv_load_to_aws.sh ying.lin $STATSWRK $SCRIPTS/load.metplus/load_metplus_add.xml


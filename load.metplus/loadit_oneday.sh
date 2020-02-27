#!/usr/bin/env bash
set -x

# 
SCRIPTS=/gpfs/dell2/emc/verification/noscrub/Ying.Lin/awsmv

STATSARCH=/gpfs/dell2/emc/verification/noscrub/Ying.Lin/metplus.stats
STATSWRK=/gpfs/dell2/ptmp/Ying.Lin/awsload.metplus

if [ $# -eq 0 ]; then
  vday=`date +%Y%m%d -d "2 days ago"`
else
  vday=$1
fi

if [ -d $STATSWRK/stats.dir ]; then
  rm -rf $STATSWRK/stats.dir/*
else
  mkdir -p $STATSWRK/stats.dir
fi

cd $STATSWRK/stats.dir

cp -p $STATSARCH/$vday/*.stat . 

# subdir under $STATS defined in the xml script: 
#     <folder_tmpl>/base_dir/{type}</folder_tmpl>
#              ....
#       <val>stats.dir</val>

$SCRIPTS/mv_load_to_aws.sh ying.lin $STATSWRK $SCRIPTS/load.metplus/load_metplus_add.xml


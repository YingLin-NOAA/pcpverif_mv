#!/bin/sh
set -x
# Wrapper script to submit plotting routines

# Do the following subsitution in plt_oneregion.xml:
#   Replace %VDAY1%/%VDAY2% with $vday1 and $vday2  (yyyy-mm-dd)
#   optional argument: today
  
AWSMV=/gpfs/dell2/emc/verification/noscrub/Ying.Lin/awsmv
ylscripts=$AWSMV/batch/rglfv3/sar-paper
wrkdir=/gpfs/dell2/stmp/Ying.Lin/mvplot

if [ -d $wrkdir ]
then
  rm -rf $wrkdir/*
else
  mkdir $wrkdir
fi

mkdir -p $wrkdir/scripts $wrkdir/plots

# 
vday1=20190315
vday2=20190416
vday1dash=${vday1:0:4}-${vday1:4:2}-${vday1:6:2}
vday2dash=${vday2:0:4}-${vday2:4:2}-${vday2:6:2}

# FSS vs. HSIZE:
for thresh in 005.0
do
  for fhour in 60
  do 
    cat $ylscripts/rgl_fss06_v_hsize_conf_int.xml \
        | sed "s/%VDAY1%/$vday1dash/g"    \
        | sed "s/%VDAY2%/$vday2dash/g"    \
        | sed "s/%THRESH%/$thresh/g"    \
        | sed "s/%FHOUR%/$fhour/g"    \
        > $wrkdir/scripts/plt_rgl_fss06_v_hsize.xml
    $AWSMV/mv_batch_on_aws.sh ying.lin \
      $wrkdir/plots $wrkdir/scripts/plt_rgl_fss06_v_hsize.xml
  done
done

exit

for fhr in 36 60 
do 
  cat $ylscripts/rgl_ets_conf_interval.xml \
    | sed "s/%VDAY1%/$vday1dash/g"    \
    | sed "s/%VDAY2%/$vday2dash/g"    \
    | sed "s/%FHR%/$fhr/g"    \
    > $wrkdir/scripts/plt_rgl_ets.xml

  $AWSMV/mv_batch_on_aws.sh ying.lin $wrkdir/plots $wrkdir/scripts/plt_rgl_ets.xml
done

# FSS vs. fcst hour:




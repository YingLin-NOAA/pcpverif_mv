#!/bin/sh
set -x
# Wrapper script to submit plotting routines

# Do the following subsitution in plt_oneregion.xml:
#   Replace %VDAY1%/%VDAY2% with $vday1 and $vday2  (yyyy-mm-dd)
#   optional argument: today
if [ $# -eq 0 ]; then
  now=`date -u +%Y%m%d%H`
else
  today=$1
  now=${today}12
fi
  
AWSMV=/gpfs/dell2/emc/verification/noscrub/Ying.Lin/awsmv
ylscripts=$AWSMV/batch/rglfv3
wrkdir=/gpfs/dell2/stmp/Ying.Lin/mvplot

if [ -d $wrkdir ]
then
  rm -rf $wrkdir/*
else
  mkdir $wrkdir
fi

mkdir -p $wrkdir/scripts $wrkdir/plots

# 
# -------------------
# test
vday1=20190817
vday2=20190907
vday1dash=${vday1:0:4}-${vday1:4:2}-${vday1:6:2}
vday2dash=${vday2:0:4}-${vday2:4:2}-${vday2:6:2}

cat $ylscripts/rgl_ets.xml \
    | sed "s/%VDAY1%/$vday1dash/g"    \
    | sed "s/%VDAY2%/$vday2dash/g"    \
    > $wrkdir/scripts/plt_rgl_ets.xml

$AWSMV/mv_batch_on_aws.sh ying.lin $wrkdir/plots $wrkdir/scripts/plt_rgl_ets.xml

# FSS vs. fcst hour:

vday1=20190801
vday2=20190831
vday1dash=${vday1:0:4}-${vday1:4:2}-${vday1:6:2}
vday2dash=${vday2:0:4}-${vday2:4:2}-${vday2:6:2}
for thresh in 002.0 005.0 010.0 020.0 
do
  for hsize in 024 052 100
  do 
    cat $ylscripts/rgl_fss06_v_fhr.xml \
        | sed "s/%VDAY1%/$vday1dash/g"    \
        | sed "s/%VDAY2%/$vday2dash/g"    \
        | sed "s/%THRESH%/$thresh/g"    \
        | sed "s/%HSIZE%/$hsize/g"    \
        > $wrkdir/scripts/plt_rgl_fss06_v_fhr.xml
    $AWSMV/mv_batch_on_aws.sh ying.lin \
      $wrkdir/plots $wrkdir/scripts/plt_rgl_fss06_v_fhr.xml
  done
done



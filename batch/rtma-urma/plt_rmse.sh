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
ylscripts=$AWSMV/batch/rtma-urma
wrkdir=/gpfs/dell2/stmp/Ying.Lin/mvplot

if [ -d $wrkdir ]
then
  rm -rf $wrkdir/*
else
  mkdir $wrkdir
fi

mkdir -p $wrkdir/scripts $wrkdir/plots

analysis=RTMA
for drange in 20190801-20190831 20190901-20190930 20191001-20191019
do 
  vday1=`echo $drange | awk -F"-" '{print $1}'`
  vday2=`echo $drange | awk -F"-" '{print $2}'`
  vday1dash=${vday1:0:4}-${vday1:4:2}-${vday1:6:2}
  vday2dash=${vday2:0:4}-${vday2:4:2}-${vday2:6:2}

  for stat in rmse
  do 
    cat $ylscripts/$stat.xml \
      | sed "s/%VDAY1%/$vday1dash/g"    \
      | sed "s/%VDAY2%/$vday2dash/g"    \
      | sed "s/%ANL%/$analysis/g"    \
      > $wrkdir/scripts/plt_${stat}.xml

    $AWSMV/mv_batch_on_aws.sh ying.lin $wrkdir/plots $wrkdir/scripts/plt_${stat}.xml
    mv $wrkdir/plots/$stat.png $ylscripts/plot.save/${analysis}_${stat}_${drange}.png
  done
done

analysis=URMA
for drange in 20190914-20190930 20191001-20191019
do 
  vday1=`echo $drange | awk -F"-" '{print $1}'`
  vday2=`echo $drange | awk -F"-" '{print $2}'`
  vday1dash=${vday1:0:4}-${vday1:4:2}-${vday1:6:2}
  vday2dash=${vday2:0:4}-${vday2:4:2}-${vday2:6:2}

  for stat in rmse
  do 
    cat $ylscripts/$stat.xml \
      | sed "s/%VDAY1%/$vday1dash/g"    \
      | sed "s/%VDAY2%/$vday2dash/g"    \
      | sed "s/%ANL%/$analysis/g"    \
      > $wrkdir/scripts/plt_${stat}.xml

    $AWSMV/mv_batch_on_aws.sh ying.lin $wrkdir/plots $wrkdir/scripts/plt_${stat}.xml
    mv $wrkdir/plots/$stat.png $ylscripts/plot.save/${analysis}_${stat}_${drange}.png 
  done
done



#!/bin/sh
set -x
# Wrapper script to submit plotting routines

# Do the following subsitution in plt_oneregion.xml:
#   Replace %VDAY1%/%VDAY2% with $vday1 and $vday2  (yyyy-mm-dd)
#   optional argument: today
  
AWSMV=/gpfs/dell2/emc/verification/noscrub/Ying.Lin/awsmv
ylscripts=$AWSMV/batch/rtma-urma/plot3
wrkdir=/gpfs/dell2/stmp/Ying.Lin/mvplot

if [ -d $wrkdir ]
then
  rm -rf $wrkdir/*
else
  mkdir $wrkdir
fi

mkdir -p $wrkdir/scripts $wrkdir/plots

region=CNSRFCS

anl1=PCPRTMA
anl2=PCPRTMA2P8
anl3=PCPURMA2P8
for drange in 20190916-20191115
do 
  vday1=`echo $drange | awk -F"-" '{print $1}'`
  vday2=`echo $drange | awk -F"-" '{print $2}'`
  vday1dash=${vday1:0:4}-${vday1:4:2}-${vday1:6:2}
  vday2dash=${vday2:0:4}-${vday2:4:2}-${vday2:6:2}

  for region in ABRFC CBRFC CNRFC LMRFC MARFC MBRFC NCRFC NERFC NWRFC OHRFC SERFC WGRFC
  do 
  for stat in ets bias rmse
  do 
    cat $ylscripts/$stat.xml \
      | sed "s/%VDAY1%/$vday1dash/g"    \
      | sed "s/%VDAY2%/$vday2dash/g"    \
      | sed "s/%ANL1%/$anl1/g"    \
      | sed "s/%ANL2%/$anl2/g"    \
      | sed "s/%ANL3%/$anl3/g"    \
      | sed "s/%REGION%/$region/g"    \
      > $wrkdir/scripts/plt_${stat}.xml

    $AWSMV/mv_batch_on_aws.sh ying.lin $wrkdir/plots $wrkdir/scripts/plt_${stat}.xml
    mv $wrkdir/plots/$stat.png $ylscripts/plot.o/${stat}_${drange}_${region}.png
  done 
  done
done


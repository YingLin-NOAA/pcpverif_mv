#!/bin/bash
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
  
NDATE=/export/emc-lw-ylin/wd22yl/utils/ndate.fd/ndate

YLDIR=/metviewer/staging/wd22yl
ylscripts=$YLDIR/scripts/batch/fv3
# 
tmpscripts=$YLDIR/sudo.scripts
tmpplots=$YLDIR/sudo.plots
tmpdata=$YLDIR/sudo.data

rm -f $tmpscripts/* $tmpdata/* $tmpplots/*

# 24-hour ETS/bias

vday1=`$NDATE -744 $now | cut -c 1-8`
vday2=`$NDATE  -24 $now | cut -c 1-8`
vday1dash=${vday1:0:4}-${vday1:4:2}-${vday1:6:2}
vday2dash=${vday2:0:4}-${vday2:4:2}-${vday2:6:2}

#for fhour in 24 48 72 96 120 144 168 
for fhour in 24 168 
do 
  cat $ylscripts/glb_ets.xml          \
    | sed "s/%VDAY1%/$vday1dash/g"    \
    | sed "s/%VDAY2%/$vday2dash/g"    \
    | sed "s/%FHOUR%/$fhour/g"        \
    > $tmpscripts/plt_glb_ets.xml
  /usr1/metviewer/metviewer/bin/mv_batch.sh $tmpscripts/plt_glb_ets.xml

  cat $ylscripts/glb_bias.xml          \
    | sed "s/%VDAY1%/$vday1dash/g"    \
    | sed "s/%VDAY2%/$vday2dash/g"    \
    | sed "s/%FHOUR%/$fhour/g"        \
    > $tmpscripts/plt_glb_bias.xml
  /usr1/metviewer/metviewer/bin/mv_batch.sh $tmpscripts/plt_glb_bias.xml
done

exit
# 3-hourly diurnal cycles

vday1=`$NDATE -768 $now | cut -c 1-8`
vday2=`$NDATE  -48 $now | cut -c 1-8`
vday1dash=${vday1:0:4}-${vday1:4:2}-${vday1:6:2}
vday2dash=${vday2:0:4}-${vday2:4:2}-${vday2:6:2}

for cyc in 00 06 12 18
do
  cat $ylscripts/glb_3hcyc.xml \
      | sed "s/%VDAY1%/$vday1dash/g"    \
      | sed "s/%VDAY2%/$vday2dash/g"    \
      | sed "s/%CYC%/$cyc/g"    \
      > $tmpscripts/plt_glb_3hcyc_${CYC}z.xml
  /usr1/metviewer/metviewer/bin/mv_batch.sh $tmpscripts/plt_glb_3hcyc_${CYC}z.xml
done
exit

# -------------------
# FSS06: 

vday1=`$NDATE -912 $now | cut -c 1-8`  #todaym38
vday2=`$NDATE -216 $now | cut -c 1-8`  #todaym9
vday1dash=${vday1:0:4}-${vday1:4:2}-${vday1:6:2}
vday2dash=${vday2:0:4}-${vday2:4:2}-${vday2:6:2}

for thresh in 005.0
do
  for fhour in 36
  do 
    cat $ylscripts/glb_fss06_v_hsize.xml \
        | sed "s/%VDAY1%/$vday1dash/g"    \
        | sed "s/%VDAY2%/$vday2dash/g"    \
        | sed "s/%THRESH%/$thresh/g"    \
        | sed "s/%FHOUR%/$fhour/g"    \
        > $tmpscripts/plt_glb_fss06_v_hsize.xml
    /usr1/metviewer/metviewer/bin/mv_batch.sh \
       $tmpscripts/plt_glb_fss06_v_hsize.xml
  done
done

exit

# FSS vs. fcst hour:

#for thresh in 002.0 005.0 010.0 020.0 
for thresh in 010.0
do
  for hsize in 052
  do 
    cat $ylscripts/glb_fss06_v_fhr.xml \
        | sed "s/%VDAY1%/$vday1dash/g"    \
        | sed "s/%VDAY2%/$vday2dash/g"    \
        | sed "s/%THRESH%/$thresh/g"    \
        | sed "s/%HSIZE%/$hsize/g"    \
        > $tmpscripts/plt_glb_fss06_v_fhr.xml
    /usr1/metviewer/metviewer/bin/mv_batch.sh \
       $tmpscripts/plt_glb_fss06_v_fhr.xml
  done
done

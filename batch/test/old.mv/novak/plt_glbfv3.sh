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
ylscripts=$YLDIR/scripts/batch/fv3/novak
# 
tmpscripts=$YLDIR/sudo.scripts
tmpplots=$YLDIR/sudo.plots.novak
tmpdata=$YLDIR/sudo.data

rm -f $tmpscripts/* $tmpdata/* $tmpplots/*

# 24-hour ETS/bias

vday1=20181001 
vday2=20190316
vday1dash=${vday1:0:4}-${vday1:4:2}-${vday1:6:2}
vday2dash=${vday2:0:4}-${vday2:4:2}-${vday2:6:2}

for fhour in 24 48 72
do 
#  cat $ylscripts/glb_ets.xml          \
#    | sed "s/%VDAY1%/$vday1dash/g"    \
#    | sed "s/%VDAY2%/$vday2dash/g"    \
#    | sed "s/%FHOUR%/$fhour/g"        \
#    > $tmpscripts/plt_glb_ets.xml
#  /usr1/metviewer/metviewer/bin/mv_batch.sh $tmpscripts/plt_glb_ets.xml

  cat $ylscripts/glb_bias.xml          \
    | sed "s/%VDAY1%/$vday1dash/g"    \
    | sed "s/%VDAY2%/$vday2dash/g"    \
    | sed "s/%FHOUR%/$fhour/g"        \
    > $tmpscripts/plt_glb_bias.xml
  /usr1/metviewer/metviewer/bin/mv_batch.sh $tmpscripts/plt_glb_bias.xml
done

exit

# FSS vs. fcst hour:

for thresh in 005.0 020.0 
do
  for hsize in 052
  do 
    cat $ylscripts/../glb_fss06_v_fhr.xml \
        | sed "s/%VDAY1%/$vday1dash/g"    \
        | sed "s/%VDAY2%/$vday2dash/g"    \
        | sed "s/%THRESH%/$thresh/g"    \
        | sed "s/%HSIZE%/$hsize/g"    \
        > $tmpscripts/plt_glb_fss06_v_fhr.xml
    /usr1/metviewer/metviewer/bin/mv_batch.sh \
       $tmpscripts/plt_glb_fss06_v_fhr.xml
  done
done

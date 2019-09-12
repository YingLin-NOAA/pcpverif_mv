#!/bin/bash
set -x
# Wrapper script to submit plotting routines

YLDIR=/metviewer/staging/wd22yl
ylscripts=$YLDIR/scripts/batch/fv3
# 
tmpscripts=$YLDIR/sudo.scripts
tmpplots=$YLDIR/sudo.plots
tmpdata=$YLDIR/sudo.data

rm -f $tmpscripts/* $tmpdata/* $tmpplots/*

# 24-hour ETS/bias

vday1=20190101
vday2=20190131
vday1dash=${vday1:0:4}-${vday1:4:2}-${vday1:6:2}
vday2dash=${vday2:0:4}-${vday2:4:2}-${vday2:6:2}

# regional (00z cycles only, so plot 36/60h combined)

cat $ylscripts/rgl_bias.xml \
    | sed "s/%VDAY1%/$vday1dash/g"    \
    | sed "s/%VDAY2%/$vday2dash/g"    \
    > $tmpscripts/plt_rgl_bias.xml
/usr1/metviewer/metviewer/bin/mv_batch.sh $tmpscripts/plt_rgl_bias.xml

exit

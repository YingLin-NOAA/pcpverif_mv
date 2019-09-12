#!/bin/bash
set -x
#
# for the Dec 2018 retro.  1-31 Dec for FV3GFs, 18-31 Dec for regional.
#   (FV3NEST began 18 Dec). 
# Wrapper script to submit plotting routines


NDATE=/export/emc-lw-ylin/wd22yl/utils/ndate.fd/ndate

YLDIR=/metviewer/staging/wd22yl
ylscripts=$YLDIR/scripts/batch/fv3
# 
tmpscripts=$YLDIR/sudo.scripts
tmpplots=$YLDIR/sudo.plots
tmpdata=$YLDIR/sudo.data

rm -f $tmpscripts/* $tmpdata/* $tmpplots/*

# 24-hour ETS/bias
# date for regional:
vday1=20181219
vday2=20181231
vday1dash=${vday1:0:4}-${vday1:4:2}-${vday1:6:2}
vday2dash=${vday2:0:4}-${vday2:4:2}-${vday2:6:2}

# regional (00z cycles only, so plot 36/60h combined)
cat $ylscripts/rgl_ets.xml \
    | sed "s/%VDAY1%/$vday1dash/g"    \
    | sed "s/%VDAY2%/$vday2dash/g"    \
    > $tmpscripts/plt_rgl_ets.xml
/usr1/metviewer/metviewer/bin/mv_batch.sh $tmpscripts/plt_rgl_ets.xml

cat $ylscripts/rgl_bias.xml \
    | sed "s/%VDAY1%/$vday1dash/g"    \
    | sed "s/%VDAY2%/$vday2dash/g"    \
    > $tmpscripts/plt_rgl_bias.xml
/usr1/metviewer/metviewer/bin/mv_batch.sh $tmpscripts/plt_rgl_bias.xml

# FV3GFS vs. GFS: plot 1, 2. ... 7 days:
vday1=20181201
vday2=20181231
vday1dash=${vday1:0:4}-${vday1:4:2}-${vday1:6:2}
vday2dash=${vday2:0:4}-${vday2:4:2}-${vday2:6:2}
for fhour in 24 48 72 96 120 144 168 
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

# regional: 00Z cyc only:
vday1=20181218
vday2=20181231
vday1dash=${vday1:0:4}-${vday1:4:2}-${vday1:6:2}
vday2dash=${vday2:0:4}-${vday2:4:2}-${vday2:6:2}
cat $ylscripts/rgl_3hcyc.xml \
    | sed "s/%VDAY1%/$vday1dash/g"    \
    | sed "s/%VDAY2%/$vday2dash/g"    \
    > $tmpscripts/plt_rgl_3hcyc.xml
/usr1/metviewer/metviewer/bin/mv_batch.sh $tmpscripts/plt_rgl_3hcyc.xml

# global:
vday1=20181201
vday2=20181231
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

# FSS06: 

# FSS vs. fcst hour:

for thresh in 002.0 005.0 010.0 020.0 
do
  for hsize in 024 052 100
  do 
    vday1=20181218
    vday2=20181231
    vday1dash=${vday1:0:4}-${vday1:4:2}-${vday1:6:2}
    vday2dash=${vday2:0:4}-${vday2:4:2}-${vday2:6:2}
    cat $ylscripts/rgl_fss06_v_fhr.xml \
        | sed "s/%VDAY1%/$vday1dash/g"    \
        | sed "s/%VDAY2%/$vday2dash/g"    \
        | sed "s/%THRESH%/$thresh/g"    \
        | sed "s/%HSIZE%/$hsize/g"    \
        > $tmpscripts/plt_rgl_fss06_v_fhr.xml
    /usr1/metviewer/metviewer/bin/mv_batch.sh \
       $tmpscripts/plt_rgl_fss06_v_fhr.xml

    vday1=20181201
    vday2=20181231
    vday1dash=${vday1:0:4}-${vday1:4:2}-${vday1:6:2}
    vday2dash=${vday2:0:4}-${vday2:4:2}-${vday2:6:2}
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

# FSS vs. spatial scale: 

# regional:
vday1=20181218
vday2=20181231
vday1dash=${vday1:0:4}-${vday1:4:2}-${vday1:6:2}
vday2dash=${vday2:0:4}-${vday2:4:2}-${vday2:6:2}

for thresh in 002.0 005.0 010.0 020.0
do
  for fhour in 06 12 24 48 60
  do 
    cat $ylscripts/rgl_fss06_v_hsize.xml \
        | sed "s/%VDAY1%/$vday1dash/g"    \
        | sed "s/%VDAY2%/$vday2dash/g"    \
        | sed "s/%THRESH%/$thresh/g"    \
        | sed "s/%FHOUR%/$fhour/g"    \
        > $tmpscripts/plt_rgl_fss06_v_hsize.xml
    /usr1/metviewer/metviewer/bin/mv_batch.sh \
       $tmpscripts/plt_rgl_fss06_v_hsize.xml
  done
done

# global:
vday1=20181201
vday2=20181231
vday1dash=${vday1:0:4}-${vday1:4:2}-${vday1:6:2}
vday2dash=${vday2:0:4}-${vday2:4:2}-${vday2:6:2}
for thresh in 002.0 005.0 010.0 020.0
do
  for fhour in 24 48 72 96 120 144 168
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

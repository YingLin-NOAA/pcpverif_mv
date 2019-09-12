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
htmlonly=N
NDATE=/export/emc-lw-ylin/wd22yl/utils/ndate.fd/ndate

YLDIR=/metviewer/staging/wd22yl
ylscripts=$YLDIR/scripts/batch/fv3
# 
tmpscripts=$YLDIR/sudo.scripts
tmpplots=$YLDIR/sudo.plots
tmpdata=$YLDIR/sudo.data

rm -f $tmpscripts/* $tmpdata/*

if [ $htmlonly = N ]; then 


# FSS06: 

vday1=`$NDATE -912 $now | cut -c 1-8`  #todaym38
vday2=`$NDATE -216 $now | cut -c 1-8`  #todaym9
vday1dash=${vday1:0:4}-${vday1:4:2}-${vday1:6:2}
vday2dash=${vday2:0:4}-${vday2:4:2}-${vday2:6:2}

# FSS vs. fcst hour:

for thresh in 002.0 005.0 010.0 020.0 
do
  for hsize in 024 052 100
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

fi

# make web page:
cat > $tmpplots/index.html <<EOF1
<HTML>
<HEAD>
<TITLE>QPF Verification Scores for FV3 runs</TITLE>
</HEAD>
<style type="text/css">
table{
margin-left: 25px
}
</style>
<center>
<H1>QPF Verification Scores for FV3 runs</H1>
<H2>Last updated: `date -u`</H2>
<B>Scores on this page are for the past 30 days, unless otherwise noted</B>
<P>
FV3GFS: real-time parallel runs (currently NCO's parallle)<BR
FV3SAR: verif began 7 Oct 2018.  00/12Z cycles.  Eric’s run with DA<BR>
FV3REG: began 29 Nov 2018.  00Z cycles only.  Ben’s run, cold-started<BR>
FV3NEST: began 18 Dec 2018.  00Z cycles only.  Ben’s nested run<BR>
<P>

6h FSS scores have a 9-day lag(using the final version of CCPA)
<P>
<HR>
</center>
<H2>Regional FV3 (compare CONUSNEST, FV3GFS, FV3NEST, FV3REG, FV3SAR):
<b>12-36h and 36-60h forecasts:</b>
<ul>
  <li><a href="rgl_24h_ets.png">ETS/GSS</a>
  <li><a href="rgl_24h_bias.png">Forecast Bias</a>
</ul>
<P>
<a href="rgl_3hcyc.png"><b>3-hourly ConUS-average precip amount vs. fcst hour:</b></a>
<P>

<B>6-hourly fractions skill scores <i>vs.</i> horizontal spatial scale:</B>
<TABLE BORDER=1 CELLSPACING=1 CELLPADDING=0>
  <TR>
    <TH COLSPAN=7>&nbsp &nbsp &nbsp &nbsp &nbsp Forecast hours</TH>
  </TR>
  <TR>
    <TH ROWSPAN=2>
      Threshold
    </TH>
  </TR>
  <TR>
    <TD> 06-12 </TD>
    <TD> 18-24 </TD>
    <TD> 42-48 </TD>
    <TD> 54-60 </TD>
  </TR>
  <TR>
    <TD ALIGN=CENTER> > 2mm/6hr</TD>
    <TH><A HREF="rgl_fss06_v_hsize_002.0_12.png">X</A></TH>
    <TH><A HREF="rgl_fss06_v_hsize_002.0_24.png">X</A></TH>
    <TH><A HREF="rgl_fss06_v_hsize_002.0_48.png">X</A></TH>
    <TH><A HREF="rgl_fss06_v_hsize_002.0_60.png">X</A></TH>
  </TR>
  <TR>
    <TD ALIGN=CENTER> > 5mm/6hr</TD>
    <TH><A HREF="rgl_fss06_v_hsize_005.0_12.png">X</A></TH>
    <TH><A HREF="rgl_fss06_v_hsize_005.0_24.png">X</A></TH>
    <TH><A HREF="rgl_fss06_v_hsize_005.0_48.png">X</A></TH>
    <TH><A HREF="rgl_fss06_v_hsize_005.0_60.png">X</A></TH>
  </TR>
  <TR>
    <TD ALIGN=CENTER> > 10mm/6hr</TD>
    <TH><A HREF="rgl_fss06_v_hsize_010.0_12.png">X</A></TH>
    <TH><A HREF="rgl_fss06_v_hsize_010.0_24.png">X</A></TH>
    <TH><A HREF="rgl_fss06_v_hsize_010.0_48.png">X</A></TH>
    <TH><A HREF="rgl_fss06_v_hsize_010.0_60.png">X</A></TH>
  </TR>
  <TR>
    <TD ALIGN=CENTER> > 20mm/6hr</TD>
    <TH><A HREF="rgl_fss06_v_hsize_020.0_12.png">X</A></TH>
    <TH><A HREF="rgl_fss06_v_hsize_020.0_24.png">X</A></TH>
    <TH><A HREF="rgl_fss06_v_hsize_020.0_48.png">X</A></TH>
    <TH><A HREF="rgl_fss06_v_hsize_020.0_60.png">X</A></TH>
  </TR>
</TABLE>
<P>

<B>6-hourly fractions skill scores <i>vs.</i> forecast hours:</B>
<TABLE BORDER=1 CELLSPACING=1 CELLPADDING=0>
  <TR>
    <TH COLSPAN=4>&nbsp &nbsp &nbsp &nbsp &nbsp Horizontal spatial scale</TH>
  </TR>
  <TR>
    <TH ROWSPAN=2>
      Threshold 
    </TH>
  </TR>
  <TR>
    <TD> < 24km </TD>
    <TD> < 52km </TD>
    <TD> < 100km </TD>
  </TR>
  <TR>
    <TD ALIGN=CENTER> > 2mm/6hr</TD>
    <TH><A HREF="rgl_fss06_v_fhr_002.0_024.png">X</A></TH>
    <TH><A HREF="rgl_fss06_v_fhr_002.0_052.png">X</A></TH>
    <TH><A HREF="rgl_fss06_v_fhr_002.0_100.png">X</A></TH>
  </TR>
  <TR>
    <TD ALIGN=CENTER> > 5mm/6hr</TD>
    <TH><A HREF="rgl_fss06_v_fhr_005.0_024.png">X</A></TH>
    <TH><A HREF="rgl_fss06_v_fhr_005.0_052.png">X</A></TH>
    <TH><A HREF="rgl_fss06_v_fhr_005.0_100.png">X</A></TH>
  </TR>
  <TR>
    <TD ALIGN=CENTER> > 10mm/6hr</TD>
    <TH><A HREF="rgl_fss06_v_fhr_010.0_024.png">X</A></TH>
    <TH><A HREF="rgl_fss06_v_fhr_010.0_052.png">X</A></TH>
    <TH><A HREF="rgl_fss06_v_fhr_010.0_100.png">X</A></TH>
  </TR>
  <TR>
    <TD ALIGN=CENTER> > 20mm/6hr</TD>
    <TH><A HREF="rgl_fss06_v_fhr_020.0_024.png">X</A></TH>
    <TH><A HREF="rgl_fss06_v_fhr_020.0_052.png">X</A></TH>
    <TH><A HREF="rgl_fss06_v_fhr_020.0_100.png">X</A></TH>
  </TR>
</TABLE>
<P>
<HR>
<P>
<H2>GFS/FV3GFS</H2>

<B>24h (12Z-12Z) ETS/bias:</B><br>
<TABLE BORDER=1 CELLSPACING=1 CELLPADDING=0>
  <TR>
    <TD>     </TD>
    <TD>day 1</TD>
    <TD>day 2</TD>
    <TD>day 3</TD>
    <TD>day 4</TD>
    <TD>day 5</TD>
    <TD>day 6</TD>
    <TD>day 7</TD>
  </TR>
  <TR>
    <TD ALIGN=CENTER>ETS/GSS</TD>
    <TH><A HREF="glb_24h_ets_f24.png">X</A></TH>
    <TH><A HREF="glb_24h_ets_f48.png">X</A></TH>
    <TH><A HREF="glb_24h_ets_f72.png">X</A></TH>
    <TH><A HREF="glb_24h_ets_f96.png">X</A></TH>
    <TH><A HREF="glb_24h_ets_f120.png">X</A></TH>
    <TH><A HREF="glb_24h_ets_f144.png">X</A></TH>
    <TH><A HREF="glb_24h_ets_f168.png">X</A></TH>
  </TR>
  <TR>
    <TD ALIGN=CENTER>FBIAS</TD>
    <TH><A HREF="glb_24h_bias_f24.png">X</A></TH>
    <TH><A HREF="glb_24h_bias_f48.png">X</A></TH>
    <TH><A HREF="glb_24h_bias_f72.png">X</A></TH>
    <TH><A HREF="glb_24h_bias_f96.png">X</A></TH>
    <TH><A HREF="glb_24h_bias_f120.png">X</A></TH>
    <TH><A HREF="glb_24h_bias_f144.png">X</A></TH>
    <TH><A HREF="glb_24h_bias_f168.png">X</A></TH>
  </TR>
</TABLE>
<P>
<B>3-hourly ConUS-average precip amount vs. fcst hour:</B>
<UL>
  <LI><A HREF="glb_3hcyc_00z.png">00Z cycles</A><br>
  <LI><A HREF="glb_3hcyc_06z.png">06Z cycles</A><br>
  <LI><A HREF="glb_3hcyc_12z.png">12Z cycles</A><br>
  <LI><A HREF="glb_3hcyc_18z.png">18Z cycles</A><br>
</UL>
<P>
<B>6-hourly fractions skill scores <i>vs.</i> horizontal spatial scale:</B>
<TABLE BORDER=1 CELLSPACING=1 CELLPADDING=0>
  <TR>
    <TH COLSPAN=7>&nbsp &nbsp &nbsp &nbsp &nbsp Forecast hours</TH>
  </TR>
  <TR>
    <TH ROWSPAN=2>
      Threshold
    </TH>
  </TR>
  <TR>
    <TD> 18-24 </TD>
    <TD> 42-48 </TD>
    <TD> 66-72 </TD>
  </TR>
  <TR>
    <TD ALIGN=CENTER> > 2mm/6hr</TD>
    <TH><A HREF="glb_fss06_v_hsize_002.0_24.png">X</A></TH>
    <TH><A HREF="glb_fss06_v_hsize_002.0_48.png">X</A></TH>
    <TH><A HREF="glb_fss06_v_hsize_002.0_72.png">X</A></TH>
  </TR>
  <TR>
    <TD ALIGN=CENTER> > 5mm/6hr</TD>
    <TH><A HREF="glb_fss06_v_hsize_005.0_24.png">X</A></TH>
    <TH><A HREF="glb_fss06_v_hsize_005.0_48.png">X</A></TH>
    <TH><A HREF="glb_fss06_v_hsize_005.0_72.png">X</A></TH>
  </TR>
  <TR>
    <TD ALIGN=CENTER> > 10mm/6hr</TD>
    <TH><A HREF="glb_fss06_v_hsize_010.0_24.png">X</A></TH>
    <TH><A HREF="glb_fss06_v_hsize_010.0_48.png">X</A></TH>
    <TH><A HREF="glb_fss06_v_hsize_010.0_72.png">X</A></TH>
  </TR>
  <TR>
    <TD ALIGN=CENTER> > 20mm/6hr</TD>
    <TH><A HREF="glb_fss06_v_hsize_020.0_24.png">X</A></TH>
    <TH><A HREF="glb_fss06_v_hsize_020.0_48.png">X</A></TH>
    <TH><A HREF="glb_fss06_v_hsize_020.0_72.png">X</A></TH>
  </TR>
</TABLE>
<P>

<B>6-hourly fractions skill scores <i>vs.</i> forecast hours:</B>
<TABLE BORDER=1 CELLSPACING=1 CELLPADDING=0>
  <TR>
    <TH COLSPAN=4>&nbsp &nbsp &nbsp &nbsp &nbsp Horizontal spatial scale</TH>
  </TR>
  <TR>
    <TH ROWSPAN=2>
      Threshold 
    </TH>
  </TR>
  <TR>
    <TD> < 24km </TD>
    <TD> < 52km </TD>
    <TD> < 100km </TD>
  </TR>
  <TR>
    <TD ALIGN=CENTER> > 2mm/6hr</TD>
    <TH><A HREF="glb_fss06_v_fhr_002.0_024.png">X</A></TH>
    <TH><A HREF="glb_fss06_v_fhr_002.0_052.png">X</A></TH>
    <TH><A HREF="glb_fss06_v_fhr_002.0_100.png">X</A></TH>
  </TR>
  <TR>
    <TD ALIGN=CENTER> > 5mm/6hr</TD>
    <TH><A HREF="glb_fss06_v_fhr_005.0_024.png">X</A></TH>
    <TH><A HREF="glb_fss06_v_fhr_005.0_052.png">X</A></TH>
    <TH><A HREF="glb_fss06_v_fhr_005.0_100.png">X</A></TH>
  </TR>
  <TR>
    <TD ALIGN=CENTER> > 10mm/6hr</TD>
    <TH><A HREF="glb_fss06_v_fhr_010.0_024.png">X</A></TH>
    <TH><A HREF="glb_fss06_v_fhr_010.0_052.png">X</A></TH>
    <TH><A HREF="glb_fss06_v_fhr_010.0_100.png">X</A></TH>
  </TR>
  <TR>
    <TD ALIGN=CENTER> > 20mm/6hr</TD>
    <TH><A HREF="glb_fss06_v_fhr_020.0_024.png">X</A></TH>
    <TH><A HREF="glb_fss06_v_fhr_020.0_052.png">X</A></TH>
    <TH><A HREF="glb_fss06_v_fhr_020.0_100.png">X</A></TH>
  </TR>
</TABLE>
<P>
EOF1


cat >> index.html <<EOF2
<P>
<A HREF="/mmb/ylin/pcpverif/scores/metviewer.html">Plot scores on EMC MetViewer server</A>
<A HREF="/mmb/ylin/pcpverif/daily/">Daily precip fcst vs. analysis page</A><br>
<A HREF="/mmb/ylin/pcpverif/scores/">
   Monthly/month-to-date operational QPF scores page</A><br>
<A HREF="http://www.emc.ncep.noaa.gov/users/Alicia.Bentley/fv3gfs/">
   Alicia Bentley's main FV3GFS evaluation portal</A><br>
<A HREF="http://www.emc.ncep.noaa.gov/mmb/gmanikin/fv3gfs/fv3images.html">
   Geoff Manikin's GFS vs. FV3GFS Comparisons page</A><br>
<A HREF="http://www.emc.ncep.noaa.gov/gmb/emc.glopara/vsdb/prfv3rt1/">
   FV3GFS Parallel Execution Group's performance statistics page</A><br>
<A HREF="https://drive.google.com/drive/folders/0B5RfvOqYcm81ZUJYbXp3anZnYkU">
   FV3GFS weekly meetings<A><br>
</HTML>

EOF2

RZDMDIR=/home/www/emc/htdocs/mmb/ylin/pcpverif/scores.fv3

###############################################################
# These are sent to emcrzdm:

# On the first day of the month, save the previous month's data to 
# $RZDMDIR/prev/prevmon.

cd $tmpplots
#scp index.html *.png wd22yl@emcrzdm:$RZDMDIR/.

exit


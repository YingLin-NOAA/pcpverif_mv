#!/bin/bash
# make web page:
set -x
today=`date -u +%Y%m%d`

# On the 3rd day, move the existing '30days/' to prev/$yyyymm
dd=${today:6:2}

plotdir=/metviewer/staging/wd22yl/sudo.plots
if ! [ -s $plotdir/done.$today ]; then
  echo $plotdir/done.$today not found.  EXIT w/o updating scores page
  Mail -s "MV plots: web page not made" Ying.Lin@noaa.gov <<EOF
    done.$today not found
EOF
  exit
fi

RZDMMAIN=/home/www/emc/htdocs/mmb/ylin/pcpverif/scores.fv3/
RZDMDIR=$RZDMMAIN/30days

if [ $dd -eq 03 ]; then
  todaym3=`~/utils/ndate.fd/ndate -72 ${today}12`
  prevyyyymm=${todaym3:0:6}
  ssh wd22yl@emcrzdm "cd ${RZDMMAIN}; mv 30days prev/$prevyyyymm"
  ssh wd22yl@emcrzdm "mkdir -p $RZDMDIR"
fi

cd $plotdir
scp *.png wd22yl@emcrzdm:$RZDMDIR/.

htmldir=/metviewer/staging/wd22yl/html.wrkdir
cd $htmldir

# First make regional scores page:
cat > $htmldir/regional.html <<EOF1
<HTML>
<HEAD>
<TITLE>QPF Verification Scores for Regional FV3 Parallel runs</TITLE>
</HEAD>
<style type="text/css">
table{
margin-left: 25px
}
</style>
<center>
<H1>QPF Verification Scores for Regional FV3 Parallel Runs</H1>
<H2>Score plots made:</H2>
EOF1

tail -1 $plotdir/done.$today >> regional.html

cat >> regional.html <<EOF2
<p>
<B>Scores on this page are for the past 30 days, unless otherwise noted</B><br>
6h FSS scores have a 9-day lag(using the final version of CCPA)
<P>
<HR>
<H3>Compare CONUSNEST, FV3GFS, FV3NEST, FV3SAR, FV3SARDA</H3>

</center>
<b>12-36h and 36-60h forecasts:</b>
<ul>
  <li><a href="rgl_24h_ets.png">ETS/GSS</a>
  <li><a href="rgl_24h_bias.png">Forecast Bias</a>
</ul>
<a href="../../scores/docs/ets_bias.gif">About the ETS/Bias</a>
<P>
<a href="rgl_3hcyc.png"><b>3-hourly ConUS-average precip amount vs. fcst hour:</b></a>
<P>

<B>6-hourly <a href="../../scores/docs/fss.gif">fractions skill scores</a> <i>vs.</i> horizontal spatial scale:</B>
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

<B>6-hourly <a href="../../scores/docs/fss.gif">fractions skill scores</a> <i>vs.</i> forecast hours:</B>
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
<a href="index.html">FV3GFS QPF scores for this month</a>
<p>
<a href="/mmb/ylin/pcpverif/scores.fv3/rglpara.html">Return to main regional FV3 parallel QPF scores page/previous months</a>
</HTML>
EOF2

# Now make global scores page: 

cat > $htmldir/index.html <<EOF3
<HTML>
<HEAD>
<TITLE>QPF Verification Scores for FV3GFS runs</TITLE>
</HEAD>
<style type="text/css">
table{
margin-left: 25px
}
</style>
<center>
<H1>QPF Verification Scores for FV3GFS Parallel Runs</H1>
<H2>Score plots made:</H2>
EOF3

tail -1 $plotdir/done.$today >> index.html

cat >> index.html <<EOF4
<p>
<B>Scores on this page are for the past 30 days, unless otherwise noted</B><br>
6h FSS scores have a 9-day lag(using the final version of CCPA)
<P>
<HR>
</center>
<P>
<H2>GFS/FV3GFS</H2>

<B>24h (12Z-12Z) <a href="../../scores/docs/ets_bias.gif">ETS/bias</a>:</B><br>
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
<B>6-hourly  <a href="../../scores/docs/fss.gif">fractions skill scores</a> <i>vs.</i> horizontal spatial scale:</B>
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

<B>6-hourly <a href="../../scores/docs/fss.gif">fractions skill scores</a> <i>vs.</i> forecast hours:</B>
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
<a href="/mmb/ylin/pcpverif/scores.fv3/">Main FV3GFS parallel QPF scores page/previous months' scores</a>
</HTML>

EOF4

scp regional.html index.html wd22yl@emcrzdm:$RZDMDIR/.

###############################################################
# These are sent to emcrzdm:

# On the first day of the month, save the previous month's data to 
# $RZDMDIR/prev/prevmon.

cd /metviewer/staging/wd22yl
datestamp=`date -u +%Y%m%d%H%M`
tar cvfz /export/emc-lw-ylin/wd22yl/tempest/verf.sss/fv3scores.$datestamp.tar.gz  html.wrkdir/index.html sudo.plots/*.png

exit


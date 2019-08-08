#!/bin/sh
set -x

# Run in cron job each day
# VSDBs are from prod and dev.  Get prod vsdbs from prod machine.
# 1)  get ${model}_${daym2}.vsdb for mv_ylin_pcp_erly
# 2)  get ${model}_${daym9}.vsdb for mv_ylin_pcp
# 3) load ${model}_${daym2}.vsdb for mv_ylin_pcp_erly
# 4) load ${model}_${daym9}.vsdb for mv_ylin_pcp

# also can run interactively with an argument (day0)

proddell=`cat /etc/prod`

if [ $proddell = mars ]; then
  prod1disk=tp1
  dev1disk=gp1
elif [ $proddell = venus ]; then
  prod1disk=gp1
  dev1disk=tp1
else
  echo proddell $proddell unknow.  Exit.
fi

prodvsdbdir=/gpfs/$prod1disk/nco/ops/com/verf/prod/vsdb/precip
 devvsdbdir=/gpfs/$dev1disk/ptmp/Ying.Lin/verf.dat/vsdb

PTMP=/gpfs/dell2/ptmp/Ying.Lin/awsload
dirvsdberly=$PTMP/vsdb.erly
dirvsdb=$PTMP/vsdb

for dir in $dirvsdberly $dirvsdb
do
  if [ -d $dir ]
  then
    rm -f $dir/*
  else
    mkdir -p $dir
  fi
done

if [ $# -eq 0 ]; then
  daym2=`date +%Y%m%d -d "2 day ago"`
  daym9=`date +%Y%m%d -d "9 day ago"`
else
  day0=$1
  FINDDATE=/gpfs/dell1/nco/ops/nwprod/prod_util.v1.1.2/ush/finddate.sh
  daym2=`$FINDDATE $day0 d-2`
  daym9=`$FINDDATE $day0 d-9`
fi

# Get erly data:
cd $dirvsdberly

# erly prod: 
for model in conusnest gfs hrrr nam rap 
do
  scp Ying.Lin@${proddell}:${prodvsdbdir}/${model}/${model}_${daym2}.vsdb .
done

# erly dev: 
for model in fv3nest fv3sar fv3sarx gfsv14
do
  cp  $devvsdbdir/${model}/${model}_${daym2}.vsdb .
done

# Get late data:
cd $dirvsdb

# late prod: 
for model in conusnest gfs href hrrr nam rap 
do
  scp Ying.Lin@${proddell}:${prodvsdbdir}/${model}/${model}_${daym9}.vsdb .
done

# late dev: 
for model in fv3nest fv3sar fv3sarx gfsv14
do
  cp  $devvsdbdir/${model}/${model}_${daym9}.vsdb .
done
  
# Now load to AWS MV:
# $AWSMV defined in .bashrc.
STATS=$PTMP
$AWSMV/mv_load_to_aws.sh ying.lin $STATS $AWSMV/load/load_pcp_erly_add.xml
$AWSMV/mv_load_to_aws.sh ying.lin $STATS $AWSMV/load/load_pcp_add.xml

exit

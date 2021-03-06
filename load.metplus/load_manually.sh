#!/bin/sh
#BSUB -J METpl_load
#BSUB -P VERF-T2O
#BSUB -n 1
#BSUB -o /gpfs/dell2/ptmp/Ying.Lin/cron.out/metplus_load.%J
#BSUB -e /gpfs/dell2/ptmp/Ying.Lin/cron.out/metplus_load.%J
#BSUB -W 10:58
#BSUB -q "dev_shared"
#BSUB -R "rusage[mem=1500]"
#BSUB -R affinity[core(1)]
#BSUB -R "span[ptile=1]"
set -x

# Use this script to load stats outside of regular daily loading (e.g. when
# an additional METplus run is made for a model for $vday, when stats for other
# models have already been loaded to the MV server.  
# 
# stats are already placed in $STATSWRK/stats.dir/ before running this script.

SCRIPTS=/gpfs/dell2/emc/verification/noscrub/Ying.Lin/awsmv
STATSWRK=/gpfs/dell2/ptmp/Ying.Lin/awsload.metplus

cd $STATSWRK/stats.dir

for file in `ls -1 *ECMWF*.stat`
do
  mv $file $file.ori
  sed 's/TP       m/APCP_24  kg\/m\^2/g' $file.ori > $file
  rm $file.ori
done

# subdir under $STATS defined in the xml script: 
#     <folder_tmpl>/base_dir/{type}</folder_tmpl>
#              ....
#       <val>stats.dir</val>

$SCRIPTS/mv_load_to_aws.sh ying.lin $STATSWRK $SCRIPTS/load.metplus/load_metplus_add.xml



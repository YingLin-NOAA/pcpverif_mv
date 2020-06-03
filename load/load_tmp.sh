#!/bin/sh
#BSUB -J VSDB_load
#BSUB -P VERF-T2O
#BSUB -n 1
#BSUB -o /gpfs/dell2/ptmp/Ying.Lin/cron.out/vsdb_load.%J
#BSUB -e /gpfs/dell2/ptmp/Ying.Lin/cron.out/vsdb_load.%J
#BSUB -W 5:58
#BSUB -q "dev_shared"
#BSUB -R "rusage[mem=1500]"
#BSUB -R affinity[core(1)]
#BSUB -R "span[ptile=1]"
set -x

# Load prod and dev vsdbs for $daym9

# also can run interactively with an argument (day0)

prdvsdbdir=/gpfs/dell1/nco/ops/com/verf/prod/vsdb/precip
devvsdbdir=/gpfs/dell2/ptmp/Ying.Lin/verf.dat/vsdb

PTMP=/gpfs/dell2/ptmp/Ying.Lin/awsload
dirvsdb=$PTMP/vsdb
  
# Now load to AWS MV:
# $AWSMV defined in .bashrc.
STATS=$PTMP
$AWSMV/mv_load_to_aws.sh ying.lin $STATS $AWSMV/load/load_pcp_vsdb.xml

exit

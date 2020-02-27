#!/bin/sh
# quick test to see of batch run works.  Plot is found under ./plots.out/
YLDIR=/gpfs/dell2/emc/verification/noscrub/Ying.Lin/awsmv
$YLDIR/mv_batch_on_aws.sh ying.lin $YLDIR/batch/plots.out $YLDIR/batch/plt_rgl_bias.xml

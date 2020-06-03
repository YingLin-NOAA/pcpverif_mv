#!/bin/sh
# copy over stats from $day1 to $day2 to a temp directory
#
day1=20191005
day2=20200524

STATSDIR=/gpfs/dell2/emc/verification/noscrub/Ying.Lin/metplus.stats
#tmpdir=/gpfs/dell2/stmp/Ying.Lin/met.stats.for.mars
tmpdir=/gpfs/dell2/ptmp/Ying.Lin/awsload.metplus/stats.dir

cd $STATSDIR
for day in `ls -1 | grep 20`
do
  if [ $day -ge $day1 -a $day -le $day2 ];
  then
    cp $day/*.stat $tmpdir/.
  fi
done

exit

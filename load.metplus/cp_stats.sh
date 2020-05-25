#!/bin/sh
# copy over stats from $day1 to $day2 to a temp directory
#
day1=20190914
day2=20200331

STATSDIR=/gpfs/dell2/emc/verification/noscrub/Ying.Lin/metplus.stats
tmpdir=/gpfs/dell2/stmp/Ying.Lin/met.stats.for.mars
cd $STATSDIR
for day in `ls -1 | grep 20`
do
  if [ $day -ge $day1 -a $day -le $day2 ];
  then
    cp $day/*.stat $tmpdir/.
  fi
done

exit

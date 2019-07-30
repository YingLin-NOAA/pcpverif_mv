#!/bin/bash
set -x
./get_vsdb_from_lnx.sh erly 20190630 20190713 \
  "conusnest fv3nest fv3sar fv3sarx gfs gfsv14 hrrr nam rap"
./get_vsdb_from_lnx.sh late 20190111 20190706 \
  "conusnest fv3gfs fv3nest fv3sar fv3sarx fv3sarda gfs gfsv14 href hrrr nam rap"
exit

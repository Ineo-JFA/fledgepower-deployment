#!/usr/bin/env bash

##--------------------------------------------------------------------
## Copyright (c) 2020 Dianomic Systems
##
## Licensed under the Apache License, Version 2.0 (the "License");
## you may not use this file except in compliance with the License.
## You may obtain a copy of the License at
##
##     http://www.apache.org/licenses/LICENSE-2.0
##
## Unless required by applicable law or agreed to in writing, software
## distributed under the License is distributed on an "AS IS" BASIS,
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
## See the License for the specific language governing permissions and
## limitations under the License.
##--------------------------------------------------------------------

##
## Author: Yannick Marchetaux
##

source /tmp/versions.sh

cd /tmp
wget -O ./fledgepower-filter-hnztopivot.tar.gz https://github.com/fledge-power/fledgepower-filter-hnztopivot/archive/refs/$VERSION_HNZ_TO_PIVOT.tar.gz
tar -xf fledgepower-filter-hnztopivot.tar.gz
mv fledgepower-filter-hnztopivot-* fledgepower-filter-hnztopivot
cd fledgepower-filter-hnztopivot
chmod +x mkversion

mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release -DFLEDGE_INCLUDE=/usr/local/fledge/include/ -DFLEDGE_LIB=/usr/local/fledge/lib/ ..
make
if [ ! -d "${FLEDGE_ROOT}/plugins/filter/hnz_pivot_filter" ] 
then
    sudo mkdir -p ${FLEDGE_ROOT}/plugins/filter/hnz_pivot_filter
fi
sudo cp libhnz_pivot_filter.so ${FLEDGE_ROOT}/plugins/filter/hnz_pivot_filter

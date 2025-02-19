#!/bin/bash

# Copyright 2019 The Vitess Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# this script brings down the tablets for customer/0 keyspace

source ./env.sh

vtctlclient Reshard Complete customer.cust2cust

for i in 200 201 202; do
	CELL=zone1 TABLET_UID=$i ./scripts/vttablet-down.sh
	CELL=zone1 TABLET_UID=$i ./scripts/mysqlctl-down.sh
done

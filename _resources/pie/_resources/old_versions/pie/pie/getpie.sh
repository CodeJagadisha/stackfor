#!/bin/bash

#  PROJECT: pie
# FILENAME: getpie.sh
#    BUILD: 170316
#
# Copyright 2017 A Pretty Cool Program
#
# pie is licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in
# compliance with the License. You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on
# an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations under the License.
#
# For more information about pie, please visit http://aprettycoolprogram.com/pie.

# WARNING
# This script will install the latest version of pie. It will overwrite any existing version of pie, including log
# files, cusomizations, and other data. This script should only be executed on systems where pie is not installed.
# If an installation of pie exists, run "pie update pie" from a command line, and that version will be updated to
# the lastest version.

rm -rf $HOME/pie/ $HOME/bin/pie*
mkdir -p $HOME/pie/{logs,temp}
wget -P $HOME/pie/temp http://aprettycoolprogram.com/pie/pie.tar.gz > $HOME/pie/logs/downloadpie.sh-download.log 2>&1

# PRODUCTION
#tar zxvf $HOME/pie/temp/pie.tar.gz -C $HOME/pie > $HOME/pie/logs/unarchive_pie.sh-download.log 2>&1

# DEVELOPMENT
cp /media/sf_Development/Projects/Applications/pie/* $HOME/pie/

rm -rf $HOME/pie/temp/*
$HOME/pie/slices/pie.sh install


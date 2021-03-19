#!/bin/bash

set -e
set -x

PATH_OF_WORKING_DIRECTORY=$(cd "$(dirname "$0")";pwd)
PATH_OF_OUTPUT="${PATH_OF_WORKING_DIRECTORY}/product"

flutter packages upgrade
flutter packages get

flutter build ios-framework --output=$PATH_OF_OUTPUT --no-release --no-profile -v

echo 'success'

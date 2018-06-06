#!/bin/bash
. $(dirname $0)/lib/logging

start_time=$(date +%s)

global_return_code=0

if [[ $1 == "-c" ]]; then
    loginfo "Cleaning previous builds..."
    dotnet clean Common
    dotnet clean AuthService
    dotnet clean SolarMonitorApi
fi

loginfo "Building Common solution..."
dotnet build Common

loginfo "Building AuthService solution..."
dotnet build AuthService

loginfo "Building SolarMonitorApi solution..."
dotnet build SolarMonitorApi

rc=$? 
if [[ $rc != 0 ]]; then 
  global_return_code=$rc
  logerr "Solution failed to build." 
else
  loginfo "Solution built successfully." 
fi
end_time=$(date +%s)

loginfo "Done."
logdbg "Total time: $(($end_time - $start_time)) seconds."
exit $global_return_code

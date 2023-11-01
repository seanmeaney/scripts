#!/bin/bash

mkdir -p .vscode


get_executable_from_cmake() {
  if [ -e CMakeLists.txt ]; then
    # Use awk to directly extract the executable name and remove "PROJ_NAME" part
    temp=$(awk -F '[()]' '/set\(PROJ_NAME/ {sub(/PROJ_NAME /, "", $2); print $2; exit}' CMakeLists.txt)
  fi
}

# If argument provided, use that as the executable name
if [ $# -eq 1 ]; then
    temp=$1
# If no argument provided, check for CMakeLists.txt and parse executable name
else  
    get_executable_from_cmake
    if [ -z "$temp" ]; then
        echo "Error: No argument provided, and no executable name found in CMakeLists.txt or Makefile."
        exit 1
    fi
fi

# Simple JSON config
result='{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "C++ Launch",
            "type": "cppdbg",
            "request": "launch",
            "program": "${workspaceFolder}/build/'"${temp}"'",
            "args": [],
            "environment": [{ "name": "config", "value": "Debug" }],
            "cwd": "${workspaceFolder}",
            "linux": {
                "MIMode": "gdb",
                "miDebuggerPath": "/usr/bin/gdb"
            }
        }
    ]
}'

echo "$result" > .vscode/launch.json

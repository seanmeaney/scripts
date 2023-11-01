#!/bin/bash

mkdir -p .vscode

get_executable_from_cmake() {
  if [ -e CMakeLists.txt ]; then
    temp=$(grep -o 'set(PROJ_NAME [^)]*)' CMakeLists.txt | sed 's/set(PROJ_NAME \([^)]*\))/\1/')
  fi
}

get_executable_from_makefile() {
  if [ -e Makefile ]; then
    temp=$(grep -o '^\s*[^#]*:.*' Makefile | awk -F ':' '{print $1}' | awk '{print $1; exit}')
  fi
}

# If argument provided then use that as executable name
if [ $# -eq 1 ]; then
    temp=$1
else
    # If no argument provided, check for CMakeLists.txt and Makefile
    get_executable_from_cmake
    if [ -z "$temp" ]; then
        get_executable_from_makefile
    fi

    if [ -z "$temp" ]; then
        echo "Error: No argument provided, and no executable name found in CMakeLists.txt or Makefile."
        exit 1
    fi
fi

# Your JSON configuration
result='{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "C++ Launch",
            "type": "cppdbg",
            "request": "launch",
            "program": "'"\${workspaceFolder}/build/${temp}"'",
            "args": [],
            "environment": [{ "name": "config", "value": "Debug" }],
            "cwd": "'"\${workspaceFolder}"'",
            "linux": {
                "MIMode": "gdb",
                "miDebuggerPath": "/usr/bin/gdb"
            }
        }
    ]
}'

echo "$result" > .vscode/launch.json

#!/bin/bash

# SCRIPT_PATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
# 使用 BASH_SOURCE 获取脚本的完整路径，再通过 dirname 获取目录
SCRIPT_PATH=$(dirname "${BASH_SOURCE[0]}")
# 使用 -P 参数处理符号链接，确保得到真实路径
ABSOLUTE_SCRIPT_PATH=$(cd "$SCRIPT_PATH" && pwd -P)
echo "ABSOLUTE_SCRIPT_PATH : $ABSOLUTE_SCRIPT_PATH"
export SYCL_DEVICE_FILTER=cnrt
export DPCPP_HOME=$ABSOLUTE_SCRIPT_PATH
export PATH=$DPCPP_HOME/build/bin:$PATH
export LD_LIBRARY_PATH=$DPCPP_HOME/build/lib:$LD_LIBRARY_PATH

export NEUWARE_HOME=/usr/local/neuware
export LD_LIBRARY_PATH=${NEUWARE_HOME}/lib64:${LD_LIBRARY_PATH}

message(STATUS "Including the PI API CNRT backend.")

 # cannot rely on cmake support for CNRT; it assumes runtime API is being used.
 # we only require the CNRT driver API to be used
 # CNRT_CNRT_LIBRARY variable defines the path to libcnrt.so, the CNRT Driver API library.

set(CNRT_ROOT "/usr/local/neuware")
set(CNRT_CNRT_LIBRARY ${CNRT_ROOT}/lib64)
set(CNRT_INCLUDE_DIRS ${CNRT_ROOT}/include)

# cnrt do not have CNRTConfig.cmake / cnrt-config.cmake
# find_package(CNRT REQUIRED ${CNRT_ROOT})

# Make imported library global to use it within the project.

if (SYCL_ENABLE_XPTI_TRACING)
  set(XPTI_PROXY_SRC "${CMAKE_SOURCE_DIR}/../xpti/src/xpti_proxy.cpp")
endif()


add_sycl_plugin(cnrt
  SOURCES
    "${sycl_inc_dir}/sycl/detail/pi.h"
    "${sycl_inc_dir}/sycl/detail/pi.hpp"
    "pi_cnrt.hpp"
    "pi_cnrt.cpp"
    # "tracing.cpp"
  INCLUDE_DIRS
    ${sycl_plugin_dir}
)

set_target_properties(pi_cnrt PROPERTIES LINKER_LANGUAGE CXX)
add_library(cnrtdrv SHARED IMPORTED GLOBAL)
add_library(cnrtrt SHARED IMPORTED GLOBAL)

set_target_properties(
  cnrtdrv PROPERTIES 
    IMPORTED_LOCATION             ${CNRT_CNRT_LIBRARY}/libcndrv.so
    INTERFACE_INCLUDE_DIRECTORIES ${CNRT_INCLUDE_DIRS}
    INTERFACE_SYSTEM_INCLUDE_DIRECTORIES "${CNRT_INCLUDE_DIRS}"
)

set_target_properties(
  cnrtrt PROPERTIES 
    IMPORTED_LOCATION             ${CNRT_CNRT_LIBRARY}/libcnrt.so
    INTERFACE_INCLUDE_DIRECTORIES ${CNRT_INCLUDE_DIRS}
    INTERFACE_SYSTEM_INCLUDE_DIRECTORIES "${CNRT_INCLUDE_DIRS}"
)

target_link_libraries(pi_cnrt PUBLIC cnrtdrv cnrtrt)

target_include_directories(pi_cnrt
  PRIVATE
    ${sycl_inc_dir}
    ${CNRT_INCLUDE_DIRS}
)


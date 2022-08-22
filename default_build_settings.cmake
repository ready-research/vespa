# Copyright Yahoo. Licensed under the terms of the Apache 2.0 license. See LICENSE in the project root.

include(VespaExtendedDefaultBuildSettings OPTIONAL)

function(setup_vespa_default_build_settings_rhel_6_10)
  message("-- Setting up default build settings for rhel 6.10")
  set(DEFAULT_EXTRA_INCLUDE_DIRECTORY "${VESPA_DEPS}/include" "/usr/include/openblas" PARENT_SCOPE)
  set(DEFAULT_CMAKE_SHARED_LINKER_FLAGS "-lrt" PARENT_SCOPE)
endfunction()

function(setup_vespa_default_build_settings_rhel_7)
  message("-- Setting up default build settings for rhel 7")
  set(DEFAULT_EXTRA_LINK_DIRECTORY "${VESPA_DEPS}/lib64" "/usr/lib64/llvm7.0/lib" PARENT_SCOPE)
  set(DEFAULT_EXTRA_INCLUDE_DIRECTORY "${VESPA_DEPS}/include" "/usr/include/llvm7.0" PARENT_SCOPE)
  set(DEFAULT_VESPA_LLVM_VERSION "7" PARENT_SCOPE)
endfunction()

function(setup_vespa_default_build_settings_rhel_8)
  message("-- Setting up default build settings for rhel 8")
  set(DEFAULT_EXTRA_INCLUDE_DIRECTORY "${VESPA_DEPS}/include" PARENT_SCOPE)
  set(DEFAULT_VESPA_LLVM_VERSION "12" PARENT_SCOPE)
endfunction()

function(setup_vespa_default_build_settings_centos_7)
  message("-- Setting up default build settings for centos 7")
  set(DEFAULT_EXTRA_LINK_DIRECTORY "${VESPA_DEPS}/lib64" "/usr/lib64/llvm7.0/lib" PARENT_SCOPE)
  set(DEFAULT_EXTRA_INCLUDE_DIRECTORY "${VESPA_DEPS}/include" "/usr/include/llvm7.0" PARENT_SCOPE)
  set(DEFAULT_VESPA_LLVM_VERSION "7" PARENT_SCOPE)
endfunction()

function(setup_vespa_default_build_settings_centos_8)
  message("-- Setting up default build settings for centos 8")
  set(DEFAULT_EXTRA_INCLUDE_DIRECTORY "${VESPA_DEPS}/include" PARENT_SCOPE)
  if (VESPA_OS_DISTRO_NAME STREQUAL "CentOS Stream")
    set(DEFAULT_VESPA_LLVM_VERSION "14" PARENT_SCOPE)
  else()
    set(DEFAULT_VESPA_LLVM_VERSION "12" PARENT_SCOPE)
  endif()
endfunction()

function(setup_vespa_default_build_settings_centos_stream_9)
  message("-- Setting up default build settings for centos stream 9")
  set(DEFAULT_EXTRA_INCLUDE_DIRECTORY "${VESPA_DEPS}/include" "/usr/include/openblas" PARENT_SCOPE)
  set(DEFAULT_VESPA_LLVM_VERSION "14" PARENT_SCOPE)
endfunction()

function(setup_vespa_default_build_settings_rocky_8_6)
  message("-- Setting up default build settings for rocky 8.6")
  set(DEFAULT_EXTRA_INCLUDE_DIRECTORY "${VESPA_DEPS}/include" PARENT_SCOPE)
  set(DEFAULT_VESPA_LLVM_VERSION "13" PARENT_SCOPE)
endfunction()

function(setup_vespa_default_build_settings_almalinux_8_6)
  message("-- Setting up default build settings for almalinux 8.6")
  set(DEFAULT_EXTRA_INCLUDE_DIRECTORY "${VESPA_DEPS}/include" PARENT_SCOPE)
  set(DEFAULT_VESPA_LLVM_VERSION "13" PARENT_SCOPE)
endfunction()

function(setup_vespa_default_build_settings_almalinux_9_0)
  message("-- Setting up default build settings for almalinux 9.0")
  set(DEFAULT_EXTRA_INCLUDE_DIRECTORY "${VESPA_DEPS}/include" "/usr/include/openblas" PARENT_SCOPE)
  set(DEFAULT_VESPA_LLVM_VERSION "13" PARENT_SCOPE)
endfunction()

function(setup_vespa_default_build_settings_darwin)
  message("-- Setting up default build settings for darwin")
  set(DEFAULT_VESPA_LLVM_VERSION "14" PARENT_SCOPE)
  set(DEFAULT_CMAKE_PREFIX_PATH "${VESPA_DEPS}" "/usr/local/opt/bison" "/usr/local/opt/flex" "/usr/local/opt/openssl@1.1" "/usr/local/opt/openblas" "/usr/local/opt/icu4c" PARENT_SCOPE)
  set(DEFAULT_EXTRA_LINK_DIRECTORY "${VESPA_DEPS}/lib" "/usr/local/opt/bison/lib" "/usr/local/opt/flex/lib" "/usr/local/opt/icu4c/lib" "/usr/local/opt/openssl@1.1/lib" "/usr/local/opt/openblas/lib")
  list(APPEND DEFAULT_EXTRA_LINK_DIRECTORY "/usr/local/lib")
  set(DEFAULT_EXTRA_LINK_DIRECTORY "${DEFAULT_EXTRA_LINK_DIRECTORY}" PARENT_SCOPE)
  set(DEFAULT_EXTRA_INCLUDE_DIRECTORY "${VESPA_DEPS}/include" "/usr/local/opt/flex/include" "/usr/local/opt/icu4c/include" "/usr/local/opt/openssl@1.1/include" "/usr/local/opt/openblas/include")
  list(APPEND DEFAULT_EXTRA_INCLUDE_DIRECTORY "/usr/local/include")
  set(DEFAULT_EXTRA_INCLUDE_DIRECTORY "${DEFAULT_EXTRA_INCLUDE_DIRECTORY}" PARENT_SCOPE)
endfunction()

function(setup_vespa_default_build_settings_fedora_35)
  message("-- Setting up default build settings for fedora 35")
  set(DEFAULT_EXTRA_INCLUDE_DIRECTORY "${VESPA_DEPS}/include" "/usr/include/openblas" PARENT_SCOPE)
  set(DEFAULT_VESPA_LLVM_VERSION "13" PARENT_SCOPE)
endfunction()

function(setup_vespa_default_build_settings_fedora_36)
  message("-- Setting up default build settings for fedora 36")
  set(DEFAULT_EXTRA_INCLUDE_DIRECTORY "${VESPA_DEPS}/include" "/usr/include/openblas" PARENT_SCOPE)
  set(DEFAULT_VESPA_LLVM_VERSION "14" PARENT_SCOPE)
endfunction()

function(setup_vespa_default_build_settings_fedora_37)
  message("-- Setting up default build settings for fedora 37")
  set(DEFAULT_EXTRA_INCLUDE_DIRECTORY "${VESPA_DEPS}/include" "/usr/include/openblas" PARENT_SCOPE)
  set(DEFAULT_VESPA_LLVM_VERSION "14" PARENT_SCOPE)
endfunction()

function(setup_vespa_default_build_settings_fedora_38)
  message("-- Setting up default build settings for fedora 38")
  set(DEFAULT_EXTRA_INCLUDE_DIRECTORY "${VESPA_DEPS}/include" "/usr/include/openblas" PARENT_SCOPE)
  set(DEFAULT_VESPA_LLVM_VERSION "14" PARENT_SCOPE)
endfunction()

function(setup_vespa_default_build_settings_amzn_2)
  message("-- Setting up default build settings for amzn 2")
  set(DEFAULT_EXTRA_LINK_DIRECTORY "${VESPA_DEPS}/lib64" "/usr/lib64/llvm7.0/lib" PARENT_SCOPE)
  set(DEFAULT_EXTRA_INCLUDE_DIRECTORY "${VESPA_DEPS}/include" "/usr/include/llvm7.0" PARENT_SCOPE)
  set(DEFAULT_VESPA_LLVM_VERSION "7" PARENT_SCOPE)
endfunction()

function(setup_vespa_default_build_settings_amzn_2022)
  message("-- Setting up default build settings for amzn 2022")
  set(DEFAULT_EXTRA_INCLUDE_DIRECTORY "${VESPA_DEPS}/include" "/usr/include/openblas" PARENT_SCOPE)
  set(DEFAULT_VESPA_LLVM_VERSION "13" PARENT_SCOPE)
endfunction()

function(setup_vespa_default_build_settings_ubuntu)
  message("-- Setting up default build settings for ubuntu")
  SET(CMAKE_FIND_PACKAGE_SORT_ORDER NATURAL)
  SET(CMAKE_FIND_PACKAGE_SORT_DIRECTION DEC)
  find_package(LLVM REQUIRED CONFIG)
  message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
  message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")
  set(DEFAULT_VESPA_LLVM_VERSION ${LLVM_VERSION_MAJOR} PARENT_SCOPE)
  set(DEFAULT_EXTRA_LINK_DIRECTORY "${VESPA_DEPS}/lib" ${LLVM_LIBRARY_DIRS} PARENT_SCOPE)
  set(DEFAULT_EXTRA_INCLUDE_DIRECTORY "${VESPA_DEPS}/include" ${LLVM_INCLUDE_DIRS} PARENT_SCOPE)
endfunction()

function(setup_vespa_default_build_settings_debian)
  message("-- Setting up default build settings for debian")
  set(DEFAULT_EXTRA_LINK_DIRECTORY "${VESPA_DEPS}/lib" PARENT_SCOPE)
  set(DEFAULT_EXTRA_INCLUDE_DIRECTORY "${VESPA_DEPS}/include" PARENT_SCOPE)
  SET(CMAKE_FIND_PACKAGE_SORT_ORDER NATURAL)
  SET(CMAKE_FIND_PACKAGE_SORT_DIRECTION DEC)
  find_package(LLVM REQUIRED CONFIG)
  message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
  message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")
  set(DEFAULT_VESPA_LLVM_VERSION ${LLVM_VERSION_MAJOR} PARENT_SCOPE)
endfunction()

function(vespa_use_default_vespa_unprivileged)
  if(NOT DEFINED VESPA_UNPRIVILEGED)
    message("-- Setting VESPA_UNPRIVILEGED to yes")
    set(VESPA_UNPRIVILEGED "yes" PARENT_SCOPE)
  endif()
endfunction()

function(vespa_use_default_cmake_install_prefix)
  if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
    if(VESPA_UNPRIVILEGED STREQUAL "no")
      set(DEFAULT_CMAKE_INSTALL_PREFIX "/opt/vespa")
      if(COMMAND vespa_use_specific_install_prefix)
        vespa_use_specific_install_prefix()
      endif()	 
    else()
      set(DEFAULT_CMAKE_INSTALL_PREFIX "$ENV{HOME}/vespa")
    endif()
    message("-- Setting CMAKE_INSTALL_PREFIX to ${DEFAULT_CMAKE_INSTALL_PREFIX}")
    set(CMAKE_INSTALL_PREFIX "${DEFAULT_CMAKE_INSTALL_PREFIX}" CACHE PATH "Install prefix for vespa project" FORCE)
  endif()
endfunction()

function(vespa_use_default_vespa_user)
  if(NOT DEFINED VESPA_USER)
    if(VESPA_UNPRIVILEGED STREQUAL "no")
      set(DEFAULT_VESPA_USER "vespa")
      if(COMMAND vespa_use_specific_vespa_user)
        vespa_use_specific_vespa_user()
      endif()
    else()
      set(DEFAULT_VESPA_USER "$ENV{USER}")
    endif()
    message("-- Setting VESPA_USER to ${DEFAULT_VESPA_USER}")
    set(VESPA_USER "${DEFAULT_VESPA_USER}" PARENT_SCOPE)
  endif()
endfunction()

function(vespa_use_default_vespa_group)
  if(NOT DEFINED VESPA_GROUP)
    if(VESPA_UNPRIVILEGED STREQUAL "no")
      set(DEFAULT_VESPA_GROUP "vespa")
      if(COMMAND vespa_use_specific_vespa_group)
        vespa_use_specific_vespa_group()
      endif()
    else()
      execute_process(COMMAND id -gn ${VESPA_USER} OUTPUT_VARIABLE DEFAULT_VESPA_GROUP)
      string(STRIP ${DEFAULT_VESPA_GROUP} DEFAULT_VESPA_GROUP)
    endif()
    message("-- Setting VESPA_GROUP to ${DEFAULT_VESPA_GROUP}")
    set(VESPA_GROUP "${DEFAULT_VESPA_GROUP}" PARENT_SCOPE)
  endif()
endfunction()

function(vespa_use_default_build_settings)
  set(VESPA_DEPS "/opt/vespa-deps")
  unset(DEFAULT_VESPA_LLVM_VERSION)
  unset(DEFAULT_CMAKE_PREFIX_PATH)
  unset(DEFAULT_EXTRA_LINK_DIRECTORY)
  unset(DEFAULT_EXTRA_INCLUDE_DIRECTORY)
  unset(DEFAULT_VESPA_CPU_ARCH_FLAGS)
  unset(DEFAULT_CMAKE_SHARED_LINKER_FLAGS)
  if(APPLE)
    if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
      set(VESPA_DEPS "/opt/vespa-deps-clang")
    elseif("${CMAKE_CXX_COMPILER_ID}" STREQUAL "AppleClang")
      set(VESPA_DEPS "/opt/vespa-deps-appleclang")
    endif()
  endif()
  if(COMMAND vespa_use_specific_vespa_deps)
    vespa_use_specific_vespa_deps()
  endif()
  if(COMMAND vespa_use_specific_compiler_rpath)
    vespa_use_specific_compiler_rpath()
  endif()
  if(COMMAND vespa_use_specific_llvm_version)
    vespa_use_specific_llvm_version()
  endif()
  if(VESPA_OS_DISTRO_COMBINED STREQUAL "rhel 6.10")
    setup_vespa_default_build_settings_rhel_6_10()
  elseif(VESPA_OS_DISTRO STREQUAL "rhel" AND
      VESPA_OS_DISTRO_VERSION VERSION_GREATER_EQUAL "7" AND
      VESPA_OS_DISTRO_VERSION VERSION_LESS "8")
    setup_vespa_default_build_settings_rhel_7()
  elseif(VESPA_OS_DISTRO STREQUAL "rhel" AND
      VESPA_OS_DISTRO_VERSION VERSION_GREATER_EQUAL "8" AND
      VESPA_OS_DISTRO_VERSION VERSION_LESS "9")
    setup_vespa_default_build_settings_rhel_8()
  elseif(VESPA_OS_DISTRO_COMBINED STREQUAL "centos 7")
    setup_vespa_default_build_settings_centos_7()
  elseif(VESPA_OS_DISTRO_COMBINED STREQUAL "centos 8")
    setup_vespa_default_build_settings_centos_8()
  elseif(VESPA_OS_DISTRO_COMBINED STREQUAL "centos 9")
    setup_vespa_default_build_settings_centos_stream_9()
  elseif(VESPA_OS_DISTRO_COMBINED STREQUAL "rocky 8.6")
    setup_vespa_default_build_settings_rocky_8_6()
  elseif(VESPA_OS_DISTRO_COMBINED STREQUAL "almalinux 8.6")
    setup_vespa_default_build_settings_almalinux_8_6()
  elseif(VESPA_OS_DISTRO_COMBINED STREQUAL "almalinux 9.0")
    setup_vespa_default_build_settings_almalinux_9_0()
  elseif(VESPA_OS_DISTRO STREQUAL "darwin")
    setup_vespa_default_build_settings_darwin()
  elseif(VESPA_OS_DISTRO_COMBINED STREQUAL "fedora 35")
    setup_vespa_default_build_settings_fedora_35()
  elseif(VESPA_OS_DISTRO_COMBINED STREQUAL "fedora 36")
    setup_vespa_default_build_settings_fedora_36()
  elseif(VESPA_OS_DISTRO_COMBINED STREQUAL "fedora 37")
    setup_vespa_default_build_settings_fedora_37()
  elseif(VESPA_OS_DISTRO_COMBINED STREQUAL "fedora 38")
    setup_vespa_default_build_settings_fedora_38()
  elseif(VESPA_OS_DISTRO_COMBINED STREQUAL "amzn 2")
    setup_vespa_default_build_settings_amzn_2()
  elseif(VESPA_OS_DISTRO_COMBINED STREQUAL "amzn 2022")
    setup_vespa_default_build_settings_amzn_2022()
  elseif(VESPA_OS_DISTRO STREQUAL "ubuntu")
    setup_vespa_default_build_settings_ubuntu()
  elseif(VESPA_OS_DISTRO STREQUAL "debian")
    setup_vespa_default_build_settings_debian()
  else()
    message(FATAL_ERROR "-- Unknown vespa build platform ${VESPA_OS_DISTRO_COMBINED}")
  endif()
  if(NOT DEFINED VESPA_LLVM_VERSION AND NOT DEFINED DEFAULT_VESPA_LLVM_VERSION)
    message(FATAL_ERROR "-- Unknown default llvm version")
  endif()
  if(NOT DEFINED DEFAULT_CMAKE_PREFIX_PATH)
    set(DEFAULT_CMAKE_PREFIX_PATH "${VESPA_DEPS}")
  endif()
  if(NOT DEFINED DEFAULT_EXTRA_LINK_DIRECTORY)
    set(DEFAULT_EXTRA_LINK_DIRECTORY "${VESPA_DEPS}/lib64")
  endif()
  if(NOT DEFINED DEFAULT_EXTRA_INCLUDE_DIRECTORY)
    set(DEFAULT_EXTRA_INCLUDE_DIRECTORY "${VESPA_DEPS}/include")
  endif()
  if(DEFINED DEFAULT_CMAKE_SHARED_LINKER_FLAGS)
    message("-- DEFAULT_CMAKE_SHARED_LINKER_FLAGS is ${DEFAULT_CMAKE_SHARED_LINKER_FLAGS}")
    set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} ${DEFAULT_CMAKE_SHARED_LINKER_FLAGS}" PARENT_SCOPE)
  endif()
  if(NOT DEFINED DEFAULT_VESPA_CPU_ARCH_FLAGS)
    message("-- CMAKE_SYSTEM_PROCESSOR = ${CMAKE_SYSTEM_PROCESSOR}")
    if(CMAKE_SYSTEM_PROCESSOR STREQUAL "x86_64")
      if(VESPA_OS_DISTRO STREQUAL "fedora" AND "${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
        set(DEFAULT_VESPA_CPU_ARCH_FLAGS "-march=westmere -mtune=haswell")
      elseif(APPLE AND (("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang") OR ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "AppleClang")))
      else()
        set(DEFAULT_VESPA_CPU_ARCH_FLAGS "-mtune=intel")
      endif()
    elseif(CMAKE_SYSTEM_PROCESSOR STREQUAL "aarch64")
      set(DEFAULT_VESPA_CPU_ARCH_FLAGS "-march=armv8.2-a+fp16+rcpc+dotprod+crypto -mtune=neoverse-n1")
    endif()
  endif()
  if(DEFINED DEFAULT_CMAKE_PREFIX_PATH)
    message("-- DEFAULT_CMAKE_PREFIX_PATH is ${DEFAULT_CMAKE_PREFIX_PATH}")
  endif()
  if(DEFINED DEFAULT_EXTRA_LINK_DIRECTORY)
    message("-- DEFAULT_EXTRA_LINK_DIRECTORY is ${DEFAULT_EXTRA_LINK_DIRECTORY}")
  endif()
  if(DEFINED DEFAULT_EXTRA_INCLUDE_DIRECTORY)
    message("-- DEFAULT_EXTRA_INCLUDE_DIRECTORY is ${DEFAULT_EXTRA_INCLUDE_DIRECTORY}")
  endif()
  if(DEFINED DEFAULT_VESPA_LLVM_VERSION)
    message("-- DEFAULT_VESPA_LLVM_VERSION is ${DEFAULT_VESPA_LLVM_VERSION}")
  endif()
  message("-- DEFAULT_VESPA_CPU_ARCH_FLAGS is ${DEFAULT_VESPA_CPU_ARCH_FLAGS}")
  if(NOT DEFINED CMAKE_PREFIX_PATH AND DEFINED DEFAULT_CMAKE_PREFIX_PATH)
    message("-- Setting CMAKE_PREFIX_PATH to ${DEFAULT_CMAKE_PREFIX_PATH}")
    set(CMAKE_PREFIX_PATH "${DEFAULT_CMAKE_PREFIX_PATH}" PARENT_SCOPE)
  endif()
  if(NOT DEFINED EXTRA_INCLUDE_DIRECTORY AND DEFINED DEFAULT_EXTRA_INCLUDE_DIRECTORY)
    message("-- Setting EXTRA_INCLUDE_DIRECTORY to ${DEFAULT_EXTRA_INCLUDE_DIRECTORY}")
    set(EXTRA_INCLUDE_DIRECTORY "${DEFAULT_EXTRA_INCLUDE_DIRECTORY}" PARENT_SCOPE)
  endif()
  if(NOT DEFINED EXTRA_LINK_DIRECTORY AND DEFINED DEFAULT_EXTRA_LINK_DIRECTORY)
    message("-- Setting EXTRA_LINK_DIRECTORY to ${DEFAULT_EXTRA_LINK_DIRECTORY}")
    set(EXTRA_LINK_DIRECTORY "${DEFAULT_EXTRA_LINK_DIRECTORY}" PARENT_SCOPE)
    set(EXTRA_LINK_DIRECTORY "${DEFAULT_EXTRA_LINK_DIRECTORY}")
  endif()
  if(NOT DEFINED CMAKE_INSTALL_RPATH)
    if(NOT "${VESPA_COMPILER_RPATH}" STREQUAL "${CMAKE_INSTALL_PREFIX}/lib64")
      list(APPEND CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/lib64")
    endif()
    if(DEFINED EXTRA_LINK_DIRECTORY)
      list(APPEND CMAKE_INSTALL_RPATH "${EXTRA_LINK_DIRECTORY}")
    endif()
    if(DEFINED VESPA_COMPILER_RPATH)
      list(APPEND CMAKE_INSTALL_RPATH "${VESPA_COMPILER_RPATH}")
    endif()
    message("-- Setting CMAKE_INSTALL_RPATH to ${CMAKE_INSTALL_RPATH}")
    set(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_RPATH}" PARENT_SCOPE)
  endif()
  if(NOT DEFINED CMAKE_BUILD_RPATH AND DEFINED VESPA_COMPILER_RPATH)
    if(DEFINED EXTRA_LINK_DIRECTORY)
      list(APPEND CMAKE_BUILD_RPATH "${EXTRA_LINK_DIRECTORY}")
    endif()
    list(APPEND CMAKE_BUILD_RPATH "${VESPA_COMPILER_RPATH}")
    if(DEFINED CMAKE_BUILD_RPATH)
      message("-- Setting CMAKE_BUILD_RPATH to ${CMAKE_BUILD_RPATH}")
      set(CMAKE_BUILD_RPATH "${CMAKE_BUILD_RPATH}" PARENT_SCOPE)
    endif()
  endif()
  if(NOT DEFINED VESPA_LLVM_VERSION AND DEFINED DEFAULT_VESPA_LLVM_VERSION)
    message("-- Setting VESPA_LLVM_VERSION to ${DEFAULT_VESPA_LLVM_VERSION}")
    set(VESPA_LLVM_VERSION "${DEFAULT_VESPA_LLVM_VERSION}" PARENT_SCOPE)
  endif()
  if(NOT DEFINED VESPA_CPU_ARCH_FLAGS AND DEFINED DEFAULT_VESPA_CPU_ARCH_FLAGS)
    message("-- Setting VESPA_CPU_ARCH_FLAGS to ${DEFAULT_VESPA_CPU_ARCH_FLAGS}")
    set(VESPA_CPU_ARCH_FLAGS "${DEFAULT_VESPA_CPU_ARCH_FLAGS}" PARENT_SCOPE)
  endif()
endfunction()

function(vespa_use_default_cxx_compiler)
  if (DEFINED CMAKE_C_COMPILER AND DEFINED CMAKE_CXX_COMPILER)
    return()
  endif()
  unset(DEFAULT_CMAKE_C_COMPILER)
  unset(DEFAULT_CMAKE_CXX_COMPILER)
  if(NOT DEFINED VESPA_COMPILER_VARIANT OR VESPA_COMPILER_VARIANT STREQUAL "gcc")
    if(APPLE)
      set(DEFAULT_CMAKE_C_COMPILER "/usr/local/bin/gcc-12")
      set(DEFAULT_CMAKE_CXX_COMPILER "/usr/local/bin/g++-12")
    elseif(VESPA_OS_DISTRO_COMBINED STREQUAL "amzn 2")
      set(DEFAULT_CMAKE_C_COMPILER "/usr/bin/gcc10-gcc")
      set(DEFAULT_CMAKE_CXX_COMPILER "/usr/bin/gcc10-g++")
    endif()
  elseif(VESPA_COMPILER_VARIANT STREQUAL "clang")
    if(APPLE)
      set(DEFAULT_CMAKE_C_COMPILER, "/usr/local/opt/llvm/bin/clang")
      set(DEFAULT_CMAKE_CXX_COMPILER "/usr/local/opt/llvm/bin/clang++")
    elseif(VESPA_OS_DISTRO STREQUAL "fedora")
      set(DEFAULT_CMAKE_C_COMPILER "/usr/bin/clang")
      set(DEFAULT_CMAKE_CXX_COMPILER "/usr/bin/clang++")
    else()
      message(FATAL_ERROR "-- clang compiler variant not supported for ${VESPA_OS_DISTRO_COMBINED}")
    endif()
  elseif(VESPA_COMPILER_VARIANT STREQUAL "appleclang")
    if(APPLE)
      set(DEFAULT_CMAKE_C_COMPILER "/usr/bin/clang")
      set(DEFAULT_CMAKE_CXX_COMPILER "/usr/bin/clang++")
    else()
      message(FATAL_ERROR "-- appleclang compiler variant not supported for ${VESPA_OS_DISTRO_COMBINED}")
    endif()
  else()
    message(FATAL_ERROR "-- unknown compiler variant ${VESPA_COMPILER_VARIANT}")
  endif()
  if(COMMAND vespa_use_specific_cxx_compiler)
    vespa_use_specific_cxx_compiler()
  endif()
  if(DEFINED DEFAULT_CMAKE_C_COMPILER)
    message("-- DEFAULT_CMAKE_C_COMPILER is ${DEFAULT_CMAKE_C_COMPILER}")
  endif()
  if(DEFINED DEFAULT_CMAKE_CXX_COMPILER)
    message("-- DEFAULT_CMAKE_CXX_COMPILER is ${DEFAULT_CMAKE_CXX_COMPILER}")
  endif()
  if(DEFINED DEFAULT_EXTRA_LINK_DIRECTORY)
    message("-- DEFAULT_EXTRA_LINK_DIRECTORY is ${DEFAULT_EXTRA_LINK_DIRECTORY}")
  endif()
  if(NOT DEFINED CMAKE_C_COMPILER AND DEFINED DEFAULT_CMAKE_C_COMPILER)
    message("-- Setting CMAKE_C_COMPILER to ${DEFAULT_CMAKE_C_COMPILER}")
    set(CMAKE_C_COMPILER "${DEFAULT_CMAKE_C_COMPILER}" PARENT_SCOPE)
  endif()
  if(NOT DEFINED CMAKE_CXX_COMPILER AND DEFINED DEFAULT_CMAKE_CXX_COMPILER)
    message("-- Setting CMAKE_CXX_COMPILER to ${DEFAULT_CMAKE_CXX_COMPILER}")
    set(CMAKE_CXX_COMPILER "${DEFAULT_CMAKE_CXX_COMPILER}" PARENT_SCOPE)
  endif()
endfunction()

function(vespa_use_default_java_home)
  if (DEFINED JAVA_HOME)
    return()
  endif()
  set(DEFAULT_JAVA_HOME "/usr/lib/jvm/java-17-openjdk")
  if(APPLE)
    execute_process(COMMAND "/usr/libexec/java_home" OUTPUT_VARIABLE DEFAULT_JAVA_HOME)
    string(STRIP "${DEFAULT_JAVA_HOME}" DEFAULT_JAVA_HOME)
  elseif(VESPA_OS_DISTRO STREQUAL "ubuntu" OR VESPA_OS_DISTRO STREQUAL "debian")
    set(DEFAULT_JAVA_HOME "/usr/lib/jvm/java-17-openjdk-amd64" PARENT_SCOPE)
  endif()
  if(COMMAND vespa_use_specific_java_home)
    vespa_use_specific_java_home()
  endif()
  message("-- DEFAULT_JAVA_HOME is ${DEFAULT_JAVA_HOME}")
  if(NOT DEFINED JAVA_HOME AND DEFINED DEFAULT_JAVA_HOME)
    message("-- Setting JAVA_HOME to ${DEFAULT_JAVA_HOME}")
    set(JAVA_HOME "${DEFAULT_JAVA_HOME}" PARENT_SCOPE)
  endif()
endfunction()

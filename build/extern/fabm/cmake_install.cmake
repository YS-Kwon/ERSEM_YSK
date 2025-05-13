# Install script for directory: /mnt/HDD1/Fabm-ersem_new/ersem/fabm

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/root/local/gotm")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/mnt/HDD1/Fabm-ersem_new/ersem/build/extern/fabm/libfabm.a")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/mnt/HDD1/Fabm-ersem_new/ersem/build/extern/fabm/modules/${BUILD_TYPE}/")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE FILE FILES
    "/mnt/HDD1/Fabm-ersem_new/ersem/fabm/src/../include/fabm.h"
    "/mnt/HDD1/Fabm-ersem_new/ersem/fabm/src/../include/fabm_version.h"
    "/mnt/HDD1/Fabm-ersem_new/ersem/fabm/src/drivers/gotm/fabm_driver.h"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/cmake/fabmConfig.cmake")
    file(DIFFERENT EXPORT_FILE_CHANGED FILES
         "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/cmake/fabmConfig.cmake"
         "/mnt/HDD1/Fabm-ersem_new/ersem/build/extern/fabm/CMakeFiles/Export/cmake/fabmConfig.cmake")
    if(EXPORT_FILE_CHANGED)
      file(GLOB OLD_CONFIG_FILES "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/cmake/fabmConfig-*.cmake")
      if(OLD_CONFIG_FILES)
        message(STATUS "Old export file \"$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/cmake/fabmConfig.cmake\" will be replaced.  Removing files [${OLD_CONFIG_FILES}].")
        file(REMOVE ${OLD_CONFIG_FILES})
      endif()
    endif()
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/cmake" TYPE FILE FILES "/mnt/HDD1/Fabm-ersem_new/ersem/build/extern/fabm/CMakeFiles/Export/cmake/fabmConfig.cmake")
  if("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/cmake" TYPE FILE FILES "/mnt/HDD1/Fabm-ersem_new/ersem/build/extern/fabm/CMakeFiles/Export/cmake/fabmConfig-release.cmake")
  endif()
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/mnt/HDD1/Fabm-ersem_new/ersem/build/extern/fabm/models/akvaplan/cmake_install.cmake")
  include("/mnt/HDD1/Fabm-ersem_new/ersem/build/extern/fabm/models/au/cmake_install.cmake")
  include("/mnt/HDD1/Fabm-ersem_new/ersem/build/extern/fabm/models/bb/cmake_install.cmake")
  include("/mnt/HDD1/Fabm-ersem_new/ersem/build/extern/fabm/models/csiro/cmake_install.cmake")
  include("/mnt/HDD1/Fabm-ersem_new/ersem/build/extern/fabm/models/ersem/cmake_install.cmake")
  include("/mnt/HDD1/Fabm-ersem_new/ersem/build/extern/fabm/models/examples/cmake_install.cmake")
  include("/mnt/HDD1/Fabm-ersem_new/ersem/build/extern/fabm/models/gotm/cmake_install.cmake")
  include("/mnt/HDD1/Fabm-ersem_new/ersem/build/extern/fabm/models/iow/cmake_install.cmake")
  include("/mnt/HDD1/Fabm-ersem_new/ersem/build/extern/fabm/models/jrc/cmake_install.cmake")
  include("/mnt/HDD1/Fabm-ersem_new/ersem/build/extern/fabm/models/msi/cmake_install.cmake")
  include("/mnt/HDD1/Fabm-ersem_new/ersem/build/extern/fabm/models/nersc/cmake_install.cmake")
  include("/mnt/HDD1/Fabm-ersem_new/ersem/build/extern/fabm/models/niva/cmake_install.cmake")
  include("/mnt/HDD1/Fabm-ersem_new/ersem/build/extern/fabm/models/pml/cmake_install.cmake")
  include("/mnt/HDD1/Fabm-ersem_new/ersem/build/extern/fabm/models/selma/cmake_install.cmake")
  include("/mnt/HDD1/Fabm-ersem_new/ersem/build/extern/fabm/models/su/cmake_install.cmake")
  include("/mnt/HDD1/Fabm-ersem_new/ersem/build/extern/fabm/models/uhh/cmake_install.cmake")

endif()


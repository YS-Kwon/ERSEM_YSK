#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "fabm" for configuration "Release"
set_property(TARGET fabm APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(fabm PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "Fortran"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libfabm.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS fabm )
list(APPEND _IMPORT_CHECK_FILES_FOR_fabm "${_IMPORT_PREFIX}/lib/libfabm.a" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)

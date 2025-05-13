#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "gotm::airsea" for configuration "Release"
set_property(TARGET gotm::airsea APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(gotm::airsea PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "Fortran"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libairsea.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS gotm::airsea )
list(APPEND _IMPORT_CHECK_FILES_FOR_gotm::airsea "${_IMPORT_PREFIX}/lib/libairsea.a" )

# Import target "gotm::util" for configuration "Release"
set_property(TARGET gotm::util APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(gotm::util PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "Fortran"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libutil.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS gotm::util )
list(APPEND _IMPORT_CHECK_FILES_FOR_gotm::util "${_IMPORT_PREFIX}/lib/libutil.a" )

# Import target "gotm::turbulence" for configuration "Release"
set_property(TARGET gotm::turbulence APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(gotm::turbulence PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "Fortran"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libturbulence.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS gotm::turbulence )
list(APPEND _IMPORT_CHECK_FILES_FOR_gotm::turbulence "${_IMPORT_PREFIX}/lib/libturbulence.a" )

# Import target "gotm::gotm_fabm" for configuration "Release"
set_property(TARGET gotm::gotm_fabm APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(gotm::gotm_fabm PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "Fortran"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libgotm_fabm.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS gotm::gotm_fabm )
list(APPEND _IMPORT_CHECK_FILES_FOR_gotm::gotm_fabm "${_IMPORT_PREFIX}/lib/libgotm_fabm.a" )

# Import target "gotm::input_manager" for configuration "Release"
set_property(TARGET gotm::input_manager APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(gotm::input_manager PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "Fortran"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libinput_manager.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS gotm::input_manager )
list(APPEND _IMPORT_CHECK_FILES_FOR_gotm::input_manager "${_IMPORT_PREFIX}/lib/libinput_manager.a" )

# Import target "gotm::config" for configuration "Release"
set_property(TARGET gotm::config APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(gotm::config PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "Fortran"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libconfig.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS gotm::config )
list(APPEND _IMPORT_CHECK_FILES_FOR_gotm::config "${_IMPORT_PREFIX}/lib/libconfig.a" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)

if(FAST_MODULE_Clarius)
    # User has to supply the path to the claris sdk
    set(CLARIUS_SDK_DIR "NOT_SET" CACHE PATH "Path to the clarius listen API.")
    if(${CLARIUS_SDK_DIR} STREQUAL "NOT_SET")
      message(FATAL_ERROR "-- Clarius ultrasound module was enabled, but Clarius SDK dir has not been set in CMake")
    else()
      message(STATUS "-- Clarius ultrasound module enabled. Clarius SDK dir set to: ${CLARIUS_SDK_DIR}")
    endif()

    list(APPEND FAST_INCLUDE_DIRS ${CLARIUS_SDK_DIR}/include/)
    if(WIN32)
      list(APPEND LIBRARIES ${CLARIUS_SDK_DIR}/lib/listen.lib)
    else()
      list(APPEND LIBRARIES ${CLARIUS_SDK_DIR}/lib/liblisten.so)
    endif()
endif()

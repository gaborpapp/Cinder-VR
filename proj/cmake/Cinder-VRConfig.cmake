if( NOT TARGET Cinder-VR )
	get_filename_component( CINDERVR_ROOT_PATH
		"${CMAKE_CURRENT_LIST_DIR}/../.." ABSOLUTE )

	list( APPEND CINDERVR_SOURCES
		${CINDERVR_ROOT_PATH}/src/cinder/vr/Camera.cpp
		${CINDERVR_ROOT_PATH}/src/cinder/vr/Context.cpp
		${CINDERVR_ROOT_PATH}/src/cinder/vr/Controller.cpp
		${CINDERVR_ROOT_PATH}/src/cinder/vr/DeviceManager.cpp
		${CINDERVR_ROOT_PATH}/src/cinder/vr/Environment.cpp
		${CINDERVR_ROOT_PATH}/src/cinder/vr/Hmd.cpp
		${CINDERVR_ROOT_PATH}/src/cinder/vr/SessionOptions.cpp
		${CINDERVR_ROOT_PATH}/src/cinder/vr/openvr/Context.cpp
		${CINDERVR_ROOT_PATH}/src/cinder/vr/openvr/Controller.cpp
		${CINDERVR_ROOT_PATH}/src/cinder/vr/openvr/DeviceManager.cpp
		${CINDERVR_ROOT_PATH}/src/cinder/vr/openvr/Hmd.cpp
		${CINDERVR_ROOT_PATH}/src/cinder/vr/openvr/OpenVr.cpp
	)

	if( CINDER_MSW )
		list( APPEND CINDERVR_SOURCES
			${CINDERVR_ROOT_PATH}/src/cinder/vr/oculus/Context.cpp
			${CINDERVR_ROOT_PATH}/src/cinder/vr/oculus/Controller.cpp
			${CINDERVR_ROOT_PATH}/src/cinder/vr/oculus/DeviceManager.cpp
			${CINDERVR_ROOT_PATH}/src/cinder/vr/oculus/Hmd.cpp
			${CINDERVR_ROOT_PATH}/src/cinder/vr/oculus/Oculus.cpp
		)
	endif()

	add_library( Cinder-VR ${CINDERVR_SOURCES} )


	list( APPEND CINDERVR_INCLUDE_DIRS
		${CINDERVR_ROOT_PATH}/include
		${CINDERVR_ROOT_PATH}/ext/OpenVR/headers
	)

	if( CINDER_MSW )
		list( APPEND CINDERVR_INCLUDE_DIRS
			${CINDERVR_ROOT_PATH}/ext/LibOVR/Include
		)
	endif()

	if( CINDER_LINUX )
		list( APPEND CINDERVR_LIBRARIES
			${CINDERVR_ROOT_PATH}/ext/OpenVR/bin/linux/x86_64/libopenvr_api.a
		)
	endif()

	target_link_libraries( Cinder-VR PUBLIC ${CINDERVR_LIBRARIES} )

	target_include_directories( Cinder-VR PUBLIC
		"${CINDERVR_INCLUDE_DIRS}" )

	if( NOT TARGET cinder )
		include( "${CINDER_PATH}/proj/cmake/configure.cmake" )
		find_package( cinder REQUIRED PATHS
			"${CINDER_PATH}/${CINDER_LIB_DIRECTORY}"
			"$ENV{CINDER_PATH}/${CINDER_LIB_DIRECTORY}" )
	endif()

	target_link_libraries( Cinder-VR PRIVATE cinder )
endif()

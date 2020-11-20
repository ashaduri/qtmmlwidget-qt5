cmake_minimum_required(VERSION 3.0)

# set the project name
project(qtmmlwidget-qt5 VERSION 2.4.2)

# specify the C++ standard
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# Set QTMMLWIDGET_DYNAMIC to FALSE to compile a static library
if (NOT DEFINED QTMMLWIDGET_DYNAMIC)
	set(QTMMLWIDGET_DYNAMIC TRUE)
endif()


set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

if(CMAKE_VERSION VERSION_LESS "3.7.0")
    set(CMAKE_INCLUDE_CURRENT_DIR ON)
endif()

find_package(Qt5 COMPONENTS Xml Gui Widgets REQUIRED)


set(qtmmlwidget_LIB_SOURCES
	src/QtMmlDocument
	src/QtMmlWidget
	src/qtmmlwidget.cpp
	src/qtmmlwidget.h
)


if (QTMMLWIDGET_DYNAMIC)
	add_library(qtmmlwidget SHARED ${qtmmlwidget_LIB_SOURCES})
	if (WIN32)
		target_compile_definitions(qtmmlwidget
			PRIVATE
				QT_QTMMLWIDGET_EXPORT
			INTERFACE
				QT_QTMMLWIDGET_IMPORT
		)
		# Put the import library along with dll
		set_target_properties(qtmmlwidget PROPERTIES ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}")
	endif()
else()
	add_library(qtmmlwidget STATIC ${qtmmlwidget_LIB_SOURCES})
endif()

if (CMAKE_CXX_COMPILER_ID STREQUAL "GNU" OR CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
	target_compile_options(qtmmlwidget PRIVATE
		-Wno-shadow -Wno-format-security -Wno-conversion -Wno-redundant-decls -Wno-cast-qual
		-Wno-zero-as-null-pointer-constant -Wno-unused-macros
	)
	if (CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
		target_compile_options(qtmmlwidget PRIVATE -Wno-unreachable-code -Wno-deprecated-declarations)
	endif()
	if (CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
		target_compile_options(qtmmlwidget PRIVATE -Wno-implicit-fallthrough)
	endif()
endif()

# This library doesn't use gcc visibility attributes under non-win32, so
# set the default to visible
if (NOT WIN32)
	target_compile_options(qtmmlwidget PRIVATE -fvisibility=default)
endif()

target_link_libraries(qtmmlwidget
	PUBLIC  # These are part of the API
		Qt5::Xml
		Qt5::Gui
		Qt5::Widgets
)

target_include_directories(qtmmlwidget
	SYSTEM INTERFACE
		${CMAKE_CURRENT_SOURCE_DIR}/src
)


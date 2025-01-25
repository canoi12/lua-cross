cmake_minimum_required(VERSION 3.15.0 FATAL_ERROR)
project(lua5.3 VERSION 1.0.0 LANGUAGES C)

include(CheckLibraryExists)

message("Host System Name: ${CMAKE_HOST_SYSTEM_NAME}")
message("Host System Architecture: ${CMAKE_HOST_SYSTEM_PROCESSOR}")
message("Building for ${CMAKE_SYSTEM_NAME} ${CMAKE_SYSTEM_PROCESSOR} target")
message("WIN32: ${WIN32}")

file(GLOB LUA_SOURCES source/src/*.c)
list(REMOVE_ITEM LUA_SOURCES ${CMAKE_CURRENT_SOURCE_DIR}/source/src/lua.c)
list(REMOVE_ITEM LUA_SOURCES ${CMAKE_CURRENT_SOURCE_DIR}/source/src/luac.c)

if (NOT ${MSVC})
set(CMAKE_C_FLAGS "-O2 -Wall -Wextra")
set(CMAKE_EXE_LINKER_FLAGS "-lm")
endif ()
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DLUA_COMPAT_5_2")

if (${CMAKE_SYSTEM_NAME} STREQUAL "Linux")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DLUA_USE_LINUX")
    check_library_exists("dl;" dlopen "" HAS_DLOPEN)
    if (${DL_OPEN})
        set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -ldl")
    endif ()
endif ()

add_library(${PROJECT_NAME} STATIC ${LUA_SOURCES})
if (NOT ${MSVC})
target_link_libraries(${PROJECT_NAME} m)
endif ()

add_library(${PROJECT_NAME}Shared SHARED ${LUA_SOURCES})
if (NOT ${MSVC})
target_link_libraries(${PROJECT_NAME}Shared m)
endif ()

set_target_properties(${PROJECT_NAME}Shared PROPERTIES OUTPUT_NAME ${PROJECT_NAME})
if (${CMAKE_SYSTEM_NAME} STREQUAL "Windows")
    set_target_properties(${PROJECT_NAME}Shared PROPERTIES PREFIX "")
    set_target_properties(${PROJECT_NAME}Shared PROPERTIES SUFFIX ".dll")
endif ()

add_executable(lua ${CMAKE_CURRENT_SOURCE_DIR}/source/src/lua.c)
target_link_libraries(lua ${PROJECT_NAME})
check_library_exists("readline;" readline "" HAS_READLINE)
if (${HAS_READLINE})
    message("Linking to readline")
    target_link_libraries(lua readline)
endif()


add_executable(luac ${CMAKE_CURRENT_SOURCE_DIR}/source/src/luac.c)
target_link_libraries(luac ${PROJECT_NAME})
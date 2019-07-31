cmake_minimum_required(VERSION 2.8)

project(spc)

SET(CMAKE_BUILD_TYPE "Debug") 

set(plugin_manager_SOURCES
    ${CMAKE_SOURCE_DIR}/src/main.c
    ${CMAKE_SOURCE_DIR}/src/spcinit.c
    ${CMAKE_SOURCE_DIR}/src/spcdip.c
    ${CMAKE_SOURCE_DIR}/src/spcalarm.c
    ${CMAKE_SOURCE_DIR}/src/spclist.c
)

include_directories(${CMAKE_SOURCE_DIR}/inc/)

SET(CMAKE_CXX_FLAGS_DEBUG "$ENV{CXXFLAGS} -O0 -Wall -g -ggdb")

add_executable(spc ${plugin_manager_SOURCES})
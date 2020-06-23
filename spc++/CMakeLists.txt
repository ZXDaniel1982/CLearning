cmake_minimum_required(VERSION 2.8)

project(spc)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wextra -Wno-unused-parameter -Werror --std=c++17 -O3 -g3")

set(spc_SOURCES
    ${CMAKE_SOURCE_DIR}/src/main.cc
    ${CMAKE_SOURCE_DIR}/src/engin.cc
    ${CMAKE_SOURCE_DIR}/src/state.cc
    ${CMAKE_SOURCE_DIR}/src/helper.cc
)

include_directories(${CMAKE_SOURCE_DIR}/inc/)

add_executable(spc ${spc_SOURCES})
cmake_minimum_required (VERSION 3.8)
project(inverter)
add_library(inverter "${CMAKE_CURRENT_LIST_DIR}/inverter.cpp")
target_include_directories(inverter PUBLIC "${CMAKE_CURRENT_LIST_DIR}/inc")
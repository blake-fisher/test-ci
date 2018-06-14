cmake_minimum_required (VERSION 3.8)
project(inverter-test)

add_executable(inverter-test inverter-test.cpp)
target_link_libraries(inverter-test inverter gtest_main)
add_test(inverter-test inverter-test)
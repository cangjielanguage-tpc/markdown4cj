# the minimum version of CMake.
cmake_minimum_required(VERSION 3.10)

project(DrawRoundRect)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

include_directories("./")

add_library(text_to_img SHARED text_to_img.cpp)

# 添加头文件路径
target_include_directories(text_to_img PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})

target_link_libraries(text_to_img PRIVATE native_drawing)

add_compile_definitions(__OHOS__)

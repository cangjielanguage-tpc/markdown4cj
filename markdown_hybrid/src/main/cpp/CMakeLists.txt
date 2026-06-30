cmake_minimum_required(VERSION 3.10)
project(text_to_img)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

include_directories("./")

add_library(text_to_img SHARED
    text_to_img.cpp
    napi_init.cpp
)

target_include_directories(text_to_img PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})

target_link_libraries(text_to_img PRIVATE
    ace_napi.z
    native_drawing
)

add_compile_definitions(__OHOS__)

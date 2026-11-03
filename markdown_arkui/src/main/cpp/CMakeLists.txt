cmake_minimum_required(VERSION 3.10)
project(arkui_texttoimg)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

include_directories("./")

add_library(arkui_texttoimg SHARED
    arkui_texttoimg.cpp
    napi_init.cpp
)

target_include_directories(arkui_texttoimg PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})

target_link_libraries(arkui_texttoimg PRIVATE
    ace_napi.z
    native_drawing
)

add_compile_definitions(__OHOS__)

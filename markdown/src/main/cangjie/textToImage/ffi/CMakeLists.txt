cmake_minimum_required(VERSION 3.5)
project(text_to_img)


# check if compiler has c++11 support

include(CheckCXXCompilerFlag)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -w")

file(GLOB_RECURSE SRC "cpp/*.cpp")


# check operating system

message(STATUS "We are working on ohos")

# compile options

add_compile_definitions(__OHOS__)
add_link_options(-static-libstdc++ -Wl)

add_library(text_to_img SHARED ${SRC})

target_link_libraries(text_to_img native_drawing)

#only in Release type use strip
if(CMAKE_BUILD_TYPE)
    if(${CMAKE_BUILD_TYPE} STREQUAL "Release")
        add_custom_command(TARGET ${PROJECT_NAME}
                    POST_BUILD
                    COMMAND ${CMAKE_STRIP} -s "$<TARGET_FILE:${PROJECT_NAME}>"
                )
    endif()
endif()
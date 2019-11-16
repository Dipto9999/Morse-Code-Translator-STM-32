project(csdc5 C CXX ASM)

cmake_minimum_required(VERSION 3.6)
enable_language(ASM)
if (NOT CMAKE_BUILD_TYPE)
    message(STATUS "No build type selected, default to Debug")
    set(CMAKE_BUILD_TYPE "Debug")
endif()

# put binaries in ./bin
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY bin)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY bin)

# all our sources are under ./src
file(GLOB_RECURSE SOURCES src/*.cpp src/*.h)
set(ASM_SOURCES src/startup/startup.s src/startup/isr_vec.s)
include_directories(src)
include_directories(config)
aux_source_directory(packages/hal/Src HAL_SOURCES)

# includes from external packages
include_directories(packages/cmsis)
include_directories(packages/hal/Inc)

add_executable(out.elf ${SOURCES} ${ASM_SOURCES} ${HAL_SOURCES})

add_compile_options("-Wall" "-Wextra" "-fexceptions")

# when the build is complete, show how much flash memory we've used up
add_custom_command(
  TARGET out.elf
  POST_BUILD
  COMMAND ${CMAKE_SIZE} bin/out.elf
)

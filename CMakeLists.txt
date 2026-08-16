cmake_minimum_required(VERSION 3.16)
project(pwdgen CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

if(MSVC)
    add_compile_options(/W4 /Zc:__cplusplus)
    add_compile_definitions(NOMINMAX)
else()
    add_compile_options(-Wall -Wextra)
endif()

# set(CMAKE_CXX_STANDARD_LIBRARIES "${CMAKE_CXX_STANDARD_LIBRARIES} m")

add_executable(pwdgen
    src/main.cpp
    src/charset.cpp
    src/password.cpp
    src/cli.cpp
)

if(WIN32)
    target_sources(pwdgen PRIVATE src/csprng_win.cpp)
    target_link_libraries(pwdgen PRIVATE bcrypt)
elseif(APPLE)
    target_sources(pwdgen PRIVATE src/csprng_mac.cpp)
    target_link_libraries(pwdgen PRIVATE "-framework Security")
else()
    target_sources(pwdgen PRIVATE src/csprng_linux.cpp)
endif()

# Libraries
add_library(password STATIC src/password.cpp)
add_library(charset STATIC src/charset.cpp)

# Tests
enable_testing()
add_subdirectory(tests)

# Install rules
include(GNUInstallDirs)
install(TARGETS pwdgen
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
)
install(FILES README.md LICENSE DESTINATION ${CMAKE_INSTALL_DOCDIR})

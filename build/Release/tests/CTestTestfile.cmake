# CMake generated Testfile for 
# Source directory: D:/AI/vibecoding/password_generator_C++/tests
# Build directory: D:/AI/vibecoding/password_generator_C++/build/Release/tests
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
if(CTEST_CONFIGURATION_TYPE MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
  add_test(password_tests "D:/AI/vibecoding/password_generator_C++/build/Release/tests/Debug/test_pwdgen.exe")
  set_tests_properties(password_tests PROPERTIES  _BACKTRACE_TRIPLES "D:/AI/vibecoding/password_generator_C++/tests/CMakeLists.txt;18;add_test;D:/AI/vibecoding/password_generator_C++/tests/CMakeLists.txt;0;")
elseif(CTEST_CONFIGURATION_TYPE MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
  add_test(password_tests "D:/AI/vibecoding/password_generator_C++/build/Release/tests/Release/test_pwdgen.exe")
  set_tests_properties(password_tests PROPERTIES  _BACKTRACE_TRIPLES "D:/AI/vibecoding/password_generator_C++/tests/CMakeLists.txt;18;add_test;D:/AI/vibecoding/password_generator_C++/tests/CMakeLists.txt;0;")
elseif(CTEST_CONFIGURATION_TYPE MATCHES "^([Mm][Ii][Nn][Ss][Ii][Zz][Ee][Rr][Ee][Ll])$")
  add_test(password_tests "D:/AI/vibecoding/password_generator_C++/build/Release/tests/MinSizeRel/test_pwdgen.exe")
  set_tests_properties(password_tests PROPERTIES  _BACKTRACE_TRIPLES "D:/AI/vibecoding/password_generator_C++/tests/CMakeLists.txt;18;add_test;D:/AI/vibecoding/password_generator_C++/tests/CMakeLists.txt;0;")
elseif(CTEST_CONFIGURATION_TYPE MATCHES "^([Rr][Ee][Ll][Ww][Ii][Tt][Hh][Dd][Ee][Bb][Ii][Nn][Ff][Oo])$")
  add_test(password_tests "D:/AI/vibecoding/password_generator_C++/build/Release/tests/RelWithDebInfo/test_pwdgen.exe")
  set_tests_properties(password_tests PROPERTIES  _BACKTRACE_TRIPLES "D:/AI/vibecoding/password_generator_C++/tests/CMakeLists.txt;18;add_test;D:/AI/vibecoding/password_generator_C++/tests/CMakeLists.txt;0;")
else()
  add_test(password_tests NOT_AVAILABLE)
endif()

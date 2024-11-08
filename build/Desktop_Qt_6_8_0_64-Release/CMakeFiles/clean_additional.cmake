# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Release")
  file(REMOVE_RECURSE
  "CMakeFiles/appblackjack_autogen.dir/AutogenUsed.txt"
  "CMakeFiles/appblackjack_autogen.dir/ParseCache.txt"
  "appblackjack_autogen"
  )
endif()

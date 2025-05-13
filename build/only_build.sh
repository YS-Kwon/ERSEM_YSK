cd build
cmake ../gotm -DFABM_BASE=../fabm -DFABM_ERSEM_BASE=../ersem $CMAKE_FLAG
make install -j $CPU


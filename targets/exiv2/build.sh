#!/bin/bash
cd $TARGET/repo
#. ../../common.sh $1

echo "start compiling $PWD with $MODE"

# rm -rf build_$MODE bin_$MODE
# mkdir $OUT/build_$MODE
# pushd $OUT/build_$MODE
# rm -rf
cmake . -DCMAKE_INSTALL_PREFIX=$OUT -DBUILD_SHARED_LIBS=OFF -DEXIV2_ENABLE_SHARED=OFF -DEXIV2_ENABLE_BROTLI=OFF -DEXIV2_BUILD_DOC=ON
# ../code/configure --disable-shared --prefix=$OUT/bin_$MODE
if [[ $MODE == "asan" ]]; then
    bear -- make -j$JOBS || exit 1
else
    make -j$JOBS || exit 1
fi

make doc
make install || exit 1

popd

echo "end compiling $PWD with $MODE"

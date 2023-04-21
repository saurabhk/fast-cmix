#!/bin/bash -x

#SEED="$1"
#UPDATE_LIMIT="$2"

SEED="923"
UPDATE_LIMIT="3000"

rm -rf pgo_data 
mkdir -p pgo_data 

# building with PGO
CFLAGS_DEFINES="-DSEED=$SEED -DUPDATE_LIMIT=$UPDATE_LIMIT"
make CFLAGS_DEFINES="$CFLAGS_DEFINES" prof_gen -j 

./cmix -c ./prof_input/input ./prof_comp > ./prof_output
rm ./prof_comp ./prof_output 
llvm-profdata-13 merge -output=default.profdata ./pgo_data/*
mv default.profdata pgo_data/

make CFLAGS_DEFINES="$CFLAGS_DEFINES" prof_use -j
upx-ucl -9 cmix 

# this is a directory where the compressor binary will be placed 
DIR=run
mkdir -p ./$DIR
ROOT=$(pwd)
cp ./cmix $DIR/cmix_orig
git diff > $DIR/patch

# building a selfextracting binary 
pushd $DIR
# creating a compressed version of dictionary
./cmix_orig -c $ROOT/dictionary/english.dic ./comp_dict
# creating a compressed verions of a file with new order
./cmix_orig -c $ROOT/src/readalike_prepr/data/new_article_order ./comp_order
# creating a header with size of the above files
./cmix_orig -h $(wc -c ./comp_dict | awk '{print $1}') $(wc -c ./comp_order | awk '{print $1}') 0

# merging the above files and setting permissions for the final executable file
cat ./cmix_orig ./comp_dict ./comp_order header.dat > ./cmix
chmod +x ./cmix

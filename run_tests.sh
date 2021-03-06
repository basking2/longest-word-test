#!/bin/bash

echo "Get corpus"

if [ ! -f corpus.txt ]; then
    wget https://s3.wasabisys.com/correct-horse-battery-staple/trd/corpus.txt
fi

echo "Bash"
./bash.sh corpus.txt

echo "Python"
python3 test.py

echo "Ruby"
ruby test.rb

echo "JRuby"
jruby -J-Xmx15G test.rb

echo "Cython"
python3 setup.py build_ext --inplace
python3 run_cythoned_test.py

echo "Rust"
cd ./find_longest_word/
cargo build --release
./target/release/find_longest_word corpus.txt
cd ..

echo "JS"
node --experimental-worker test_stream.js

echo "Golang"
go run ./timer.go

echo "C++"
g++ -march=native -Ofast -fomit-frame-pointer -fopenmp main.cpp timer.cpp
./a.out

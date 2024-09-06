#!/bin/bash

# Compile the C++ program
g++ -std=c++11 -o main main.cpp

# Function to run a test case
run_test() {
    local test_num=$1
    local input_file="test_case_$test_num.txt"
    local expected_file="expected_output_$test_num.txt"
    local output_file="output_$test_num.txt"

    echo "Running Test Case $test_num"
    ./main< "$input_file" > "$output_file"
    
    if diff -q "$expected_file" "$output_file" > /dev/null; then
        echo "Test Case $test_num: PASSED"
    else
        echo "Test Case $test_num: FAILED"
        echo "Expected:"
        cat "$expected_file"
        echo "Got:"
        cat "$output_file"
    fi
    echo
}

# Run all test cases
for i in {1..11}
do
    run_test $i
done

# Clean up
# rm -f percolation_solver output_*.txt

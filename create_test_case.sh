#!/bin/bash

# Function to create a test case file
create_test_case() {
    local test_num=$1
    local content=$2
    echo "$content" > "test_case_$test_num.txt"
}

# Function to create an expected output file
create_expected_output() {
    local test_num=$1
    local percolates=$2
    local grid=$3
    
    {
        if [ "$percolates" = true ]; then
            echo "The system percolates."
            echo "$grid"
        else
            echo "The system does not percolate."
        fi
    } > "expected_output_$test_num.txt"
}

# Create test cases and expected outputs
create_test_case 1 "5 5
.....
.#.#.
.#.#.
.#.#.
....."
create_expected_output 1 true "
----- 
-#-#- 
-#-#- 
-#-#- 
-----"

create_test_case 2 "5 5
.....
.###.
..#..
.###.
....."
create_expected_output 2 true "-----
-###-
--#--
-###-
-----"

create_test_case 3 "5 5
#.###
#.###
#.###
#.###
#.###"
create_expected_output 3 true "#-### 
#-### 
#-### 
#-### 
#-###"

create_test_case 4 "5 5
#####
.....
#####
#####
#####"
create_expected_output 4 false

create_test_case 5 "7 7
.......
###.###
..#.#..
.##.##.
.#...#.
.#####.
......."
create_expected_output 5 false

create_test_case 6 "5 5
.....
.....
.....
.....
....."
create_expected_output 6 true "----- 
----- 
----- 
----- 
-----"

create_test_case 7 "5 5
#####
#####
#####
#####
#####"
create_expected_output 7 false

create_test_case 8 "8 8
########
#......#
#.####.#
#.#....#
#.#.##.#
#.#.##.#
#......#
########"
create_expected_output 8 false

create_test_case 9 "6 6
......
.#..#.
.#..#.
.#..#.
.#..#.
......"
create_expected_output 9 true "------ 
-#--#- 
-#--#- 
-#--#- 
-#--#- 
------"

create_test_case 10 "10 10
..........
.#########
..........
####.#####
..........
#####.####
..........
####.#####
..........
#########."
create_expected_output 10 true "---------- 
-######### 
---------- 
####-##### 
---------- 
#####-#### 
---------- 
####-##### 
---------- 
#########-"

create_test_case 11 "7 7
.......
######.
.......
.######
.......
######.
......."
create_expected_output 11 true "------- 
######- 
------- 
-###### 
------- 
######- 
-------"


echo "Test files created successfully."

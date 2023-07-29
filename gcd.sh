#!/bin/bash

gcd() {
    local a=$1
    local b=$2

    while [ $b -ne 0 ]; do
        local temp=$b
        b=$(($a % $b))
        a=$temp
    done

    echo $a
    # echo "$1 $2 => $a"
}

# Check args.
if [ $# -ne 2 ]; then
    echo "Usage: $0 num1 num2"
    exit 1
fi

# Check number
is_natural_number() {
    if ! [[ $1 =~ ^[0-9]+$ ]]; then
        echo "Error: $1 is not a natural number."
        exit 1
    fi

    if [[ $1 = "0" ]]; then
        echo "Error: num is a zero."
        exit 1
    fi

}

# Check two args.
is_natural_number $1
is_natural_number $2

# Execute gcd
gcd $1 $2

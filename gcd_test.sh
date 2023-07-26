#!/bin/bash

test_gcd() {
    local val
    val=$(./gcd.sh $1 $2)

    if [ "$val" -ne "$3" ]; then
        echo "Test failed: gcd of $1 and $2, expected $3, got $val"
        exit 1
    fi
}

test_error() {
    output=$(./gcd.sh $1 $2 2>&1)
    expected=$3

    if [[ $output != $expected ]]; then
        echo "Test failed: expected \"$expected\", got \"$output\""
        exit 1
    fi
}


# 正常系テスト
test_gcd 36 24 12
test_gcd 48 18 6
test_gcd 101 103 1 # 互いに素の数

# 異常系テスト
test_error 36 -24 "Error: -24 is not a number." # 負の数
test_error 36 0 "Error: 0 is a zero." # ゼロ
test_error 36 "" "Usage: ./gcd.sh num1 num2" # 引数不足
test_error 36 abc "Error: abc is not a number." # 数値でない

echo "全てのテストがクリアされました。"

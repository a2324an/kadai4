#!/bin/bash

something_error=0

test_gcd() {
    local val
    val=$(./gcd.sh $1 $2)

    if [ "$val" -ne "$3" ]; then
        echo "Test failed(${BASH_LINENO[0]}): gcd of $1 and $2, expected $3, got $val"
        something_error=1
    fi
}

test_error() {
    output=$(./gcd.sh $1 $2 2>&1)
    expected=$3

    if [[ $output != $expected ]]; then
        echo "Test failed(${BASH_LINENO[0]}): expected \"$expected\", got \"$output\""
        something_error=1
    fi
}


# 正常系テスト
test_gcd 36 24 12
test_gcd 48 18 6
test_gcd 1 1 1
test_gcd 3 3 3
test_gcd 101 103 1 # 互いに素の数

# 異常系テスト
test_error 24 -24 "Error: -24 is not a natural number." # 負の数
test_error -1 53 "Error: -1 is not a natural number." # 負の数
test_error 75 0 "Error: 0 is a zero." # ゼロ
test_error 0 0 "Error: 0 is a zero." # ゼロ
test_error 106 "" "Usage: ./gcd.sh num1 num2" # 引数不足
test_error "" "" "Usage: ./gcd.sh num1 num2" # 引数不足
test_error "" 123 "Usage: ./gcd.sh num1 num2" # 引数不足
test_error 123 abc "Error: abc is not a natural number." # 数値でない
test_error abc 44 "Error: abc is not a natural number." # 数値でない
test_error 1.0 2.0 "Error: 1.0 is not a natural number." # 自然数ではない
test_error 3 2.0 "Error: 2.0 is not a natural number." # 自然数ではない

if [ $something_error -ne 0 ]
then
 echo "Error"
 exit $something_error
fi

echo "全てのテストがクリアされました。"

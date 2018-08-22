#!/bin/bash

# 0.1. define function to print title and subtitle
# print same characters
same_char() {
	for ((i = 0; i <= $1; i++)); do
		printf "$2"
	done
}
# section
section() {
	n=$(expr \( 80 - ${#1} \) / 2)
	# printf "=%.0s" {0..${x}}	# this function not avaliable for bash, only zsh
	same_char $n "="
	printf " %s " $1
	same_char $n "="
	printf "\n"
}

# sub section
sub_section() {
	n=$(expr \( 80 - ${#1} \) / 2)
	# printf "=%.0s" {0..${x}}	# this function not avaliable for bash, only zsh
	same_char $n "-"
	printf " %s " $1
	same_char $n "-"
	printf "\n"
}

# new line
newline() {
	printf "\n"
}

# # 1. variable
newline
section variable
for skill in Ada Coffe Action Java; do
	echo "I am good at ${skill}Script"
done
# change variable
name="alibabaq"
echo ${name}
name="tencent"
echo ${name}
# readonly variable
readonly name
# name="mi" # will cause error
echo ${name}

# 2. string
newline
section string
str="alibaba"
echo "string length = ${#str}"                    # string length
echo "string length = $(expr length ${str})"      # string length
echo "'b' index in $str: $(expr index "$str" ib)" # find string

sub_section "split string"
str="I and my brothers love Alibaba, Tencent and Mi"
echo "raw str: ${str}"
echo "remove from left until the first pattern: ${str#*and}"
echo "ratain from left until the last pattern: ${str##*and}"
echo "remove from right until the first pattern: ${str%and*}"
echo "remove from right until the last pattern: ${str%%and*}"
echo "str[3: 3+5]: ${str:3:5}"
echo "str[3:]: ${str:3}"
echo "str[-10:-10+5]: ${str:0-10:5}"
echo "str[-10:]: ${str:0-10}"

# 3. array
newline
section array
array=(val01 val02 val03 val04)
echo "array list:"
for a in ${array[@]}; do
	echo "$a"
done
echo "array list: ${array[*]}"
echo "array list: ${array[@]}"
echo "array[0] = ${array[3]}"
echo "array size = ${#array}"
echo "array size = ${#array[@]}"
echo "array size = ${#array[*]}"
echo "array[1] length = ${#array[1]}"

# 4. parameters
newline
section parameters
param_func() {
	echo "file name/function name: $0"
	echo "param numbers: $#"
	echo "all params: $*, and list: "
	for v in "$*"; do
		echo $v
	done
	echo "all params: $@, and list: "
	for v in "$@"; do
		echo $v
	done

	echo "param[0]: $1"
	echo "param[1]: $2"
	echo "param[2]: $3"

	if [ -n "$4" ]; then
		echo "have 4th param"
		if [ -n "$5" ]; then
			echo "have 5th param"
		else
			echo "don't have 5th param"
		fi
	else
		echo "don't have 4th param"
	fi

	echo "current process ID: $$"
	echo "last background process ID: $!"
	echo "shell options: $-"
	echo "exist status: $?"
}
param_func x1 x2 x3 x4

# 5. operators
newline
section operators
a=45
b=20
echo "a + b = $(expr $a + $b)"
echo "a - b = $(expr $a - $b)"
echo "a * b = $(expr $a \* $b)"
echo "a / b = $(expr $a / $b)"
echo "a % b = $(expr $a % $b)"
if [ $a == $b ]; then
	echo "a == b"
fi
if [ $a != $b ]; then
	echo "a != b"
fi
# =, !=, >, <, >=, <=
if [ $a -eq $b ]; then echo "a == b"; fi
if [ $a -ne $b ]; then echo "a != b"; fi
if [ $a -gt $b ]; then echo "a > b"; fi
if [ $a -lt $b ]; then echo "a < b"; fi
if [ $a -ge $b ]; then echo "a >= b"; fi
if [ $a -le $b ]; then echo "a <= b"; fi
# bool and logic operation, !, -o, -a, &&, ||
if [[ $a -lt 100 && $b -gt 100 ]]; then
	echo "a > 100 and b < 10"
fi
if [[ $a -lt 100 || $b -gt 100 ]]; then
	echo "a > 100 or b > 100"
fi

section "unfinish tutorials"

# x. othes
newline
section others
for item in $(ls ~/Documents); do
	echo ${item}
done

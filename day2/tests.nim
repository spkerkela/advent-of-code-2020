import unittest
import day2

suite "day 2 suite":
    echo "Starting tests"

    setup:
        echo "Run before each tests"
    
    teardown:
        echo "Run after each tests"
    test "Truth":
        check(true)
    test "Lists are equal":
        check([1,2,3] == [1,2,3])
    
    test "Handle line":
        check(PasswordRequirement(c:'a', min:1, max:3) == parsePasswordRequirement("1-3 a"))
        check(PasswordRequirement(c:'b', min:1, max:3) == parsePasswordRequirement("1-3 b"))
        check(PasswordRequirement(c:'c', min:2, max:9) == parsePasswordRequirement("2-9 c"))
    
    test "Check password":
        check(isValidPassword("abcde", PasswordRequirement(c:'a', min:1, max:3)))
        check(not isValidPassword("cdefg", PasswordRequirement(c:'b', min:1, max:3)))
        check(isValidPassword("ccccccccc", PasswordRequirement(c:'c', min:2, max:9)))
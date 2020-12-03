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
    
    test "ParseRequirement":
        check(PasswordRequirement(c:'a', min:1, max:3) == parsePasswordRequirement("1-3 a"))
        check(TruePasswordRequirement(c:'a', first:1, second:3) == parseTruePasswordRequirement("1-3 a"))
        check(PasswordRequirement(c:'b', min:1, max:3) == parsePasswordRequirement("1-3 b"))
        check(TruePasswordRequirement(c:'b', first:1, second:3) == parseTruePasswordRequirement("1-3 b"))
        check(PasswordRequirement(c:'c', min:2, max:9) == parsePasswordRequirement("2-9 c"))
        check(TruePasswordRequirement(c:'c', first:2, second:9) == parseTruePasswordRequirement("2-9 c"))
    
    test "Check password":
        check(isValidPassword("abcde", PasswordRequirement(c:'a', min:1, max:3)))
        check(not isValidPassword("cdefg", PasswordRequirement(c:'b', min:1, max:3)))
        check(isValidPassword("ccccccccc", PasswordRequirement(c:'c', min:2, max:9)))

        check(isValidTruePassword("abcde", TruePasswordRequirement(c:'a', first:1, second:3)))
        check(not isValidTruePassword("cdefg", TruePasswordRequirement(c:'b', first:1, second:3)))
        check(not isValidTruePassword("ccccccccc", TruePasswordRequirement(c:'c', first:2, second:9)))
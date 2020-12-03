import strutils
type PasswordRequirement* = object
    c*: char    
    min*: int
    max*: int

type TruePasswordRequirement* = object
    c*: char
    first*: int
    second*: int

proc isValidPassword*(password: string, requirement: PasswordRequirement) : bool =
    var count = 0
    for ch in password:
        if ch == requirement.c:
            count += 1
    result = count >= requirement.min and count <= requirement.max

proc isValidTruePassword*(password: string, requirement: TruePasswordRequirement) : bool =
    let
        firstIsOk = password[requirement.first-1] == requirement.c
        secondIsOk = password[requirement.second-1] == requirement.c
    result = firstIsOk xor secondIsOk

proc parseTruePasswordRequirement*(str : string) : TruePasswordRequirement =
    let
        ruleParts = str.splitWhitespace()
        c = ruleParts[1].strip()[0]
        firstAndSecond = ruleParts[0].split('-')
        first = parseInt(firstAndSecond[0])
        second = parseInt(firstAndSecond[1])
        passwordRequirement = TruePasswordRequirement(c:c, first:first, second:second)
    result = passwordRequirement

proc parsePasswordRequirement*(str : string) : PasswordRequirement =
    let
        ruleParts = str.splitWhitespace()
        c = ruleParts[1].strip()[0]
        minAndMax = ruleParts[0].split('-')
        min = parseInt(minAndMax[0])
        max = parseInt(minAndMax[1])
        passwordRequirement = PasswordRequirement(c:c, min:min, max:max)
    result = passwordRequirement

proc handleLine*(l : string, useCorrect:bool=true) : bool =
    let
        parts = split(l, ':')
        rule = parts[0]
        password = parts[1].strip()
    if useCorrect:
        result = isValidTruePassword(password, parseTruePasswordRequirement(rule))
    else:
        result = isValidPassword(password, parsePasswordRequirement(rule))

proc run*(fileName: string) =
    let file = readFile(fileName)
    let lines = splitLines(file)
    var valid = 0
    for line in lines:
        if handleLine(line, false):
            valid += 1
    echo valid
    valid = 0
    for line in lines:
        if handleLine(line, true):
            valid += 1
    echo valid


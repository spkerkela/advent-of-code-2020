import strutils
type PasswordRequirement* = object
    c*: char    
    min*: int
    max*: int

proc isValidPassword*(password: string, requirement: PasswordRequirement) : bool =
    var count = 0
    for ch in password:
        if ch == requirement.c:
            count += 1
    result = count >= requirement.min and count <= requirement.max

proc parsePasswordRequirement*(str : string) : PasswordRequirement =
    let
        ruleParts = str.splitWhitespace()
        c = ruleParts[1].strip()[0]
        minAndMax = ruleParts[0].split('-')
        min = parseInt(minAndMax[0])
        max = parseInt(minAndMax[1])
        passwordRequirement = PasswordRequirement(c:c, min:min, max:max)
    result = passwordRequirement

proc handleLine*(l : string) : bool =
    let
        parts = split(l, ':')
        rule = parts[0]
        passwordRequirement = parsePasswordRequirement(rule)
        password = parts[1].strip()
    result = isValidPassword(password, passwordRequirement)

proc run*(fileName: string) =
    let file = readFile(fileName)
    let lines = splitLines(file)
    var valid = 0
    for line in lines:
        if handleLine(line):
            valid += 1
    echo valid

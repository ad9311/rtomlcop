# RTomlCop

## What is RTomlCop?

RTomlCop is a linter tool built in ruby for [toml](https://toml.io/en/index) files.</br>
This tool will check for errors in a toml file and display them for the user to fix.

## Content
* [What it does](#what-it-does)
* [Getting Started](#getting-started)
* [Contributing](#contributing)
* [Author](#author)
* [License](#license)

## What it does

RTomlCop will check for errors line by line in a toml file.</br>
Then it will display the line where the error was found and the aproximate error.
This tool follows the official [toml](https://toml.io/en/index) to parse toml files.</br>
Currently RTomlCop only parses the following data:
- Comments
- One line strings
- Integers
  - Decimal
  - Hexadecimal
  - Octal
  - Binary
- Floats
- Date that include time

Other values are yet not supported.

### Comments
#### Comments must have space after the # symbol
```
# This is a good comment
#Bad comment
int0 = 0 # Comments can also be beside code
int1 = 7 #Also a bad comment
f = 'aasdad' # Not supported
```

### Strings
#### Strings must be closed.
```
str0 = "Hello World!" # Valid string
str1 = "Hello world! # Invalid, unclosed string
```
**Note that currently only double-quoted strings are supported.**

### Integers
#### Integers are parse with ruby. Integers include decimal, hexadecimal, octal and binary.
```
int1 = +99 
int2 = 42k # Invalid integer
int3 = 0
int4 = -17

# Hex, oct and bin integer can contain uppercase letters
hex1 = 0xDEADBEEF
hex2 = 0xdeadbeef
bin1 = 0b120 # Invalid binary
oct1 = 0o01234567

Note that negative values are also allowed for hex, bin and oct integers.
```

### Integers
#### Integers are parse with ruby. Integers include decimal, hexadecimal, octal and binary.
```
flt1 = +1.0
flt2 = 3.1415f # Invalid float
flt3 = -0.01
flt4 = 5e+22 # Floats can cointa scientific notation
flt5 = 1e06 
flt6 = -2E-2
flt8 = 224_617.445_991_228 # _separator are also allowed
```

### Dates and time
#### Dates are also pares with the Date class in ruby
```
odt1 = 1979-05-27T07:32:00Z
odt2 = 1979-05-27T00:32:00-07:00
odt3 = 1979-05-27T00:32:00.999999-07:00
ldt1 = 1979333-05-27T07:32:00 # Invalid date
ldt2 = 1979-05-27T00:32:00.999999
ld1 = 1979-05-27
lt1 = 07:32:00 # Hour format is not supported
```

**This is how the program outputs errors found**
```
Checking for errors...
 
Error at line 1: Invalid integer value for integer variable "int1". Begining at "f"
        Check => +99f
 
Error at line 3: Unclosed string.
        Check => str1 = "The quick brown fox jumps over the lazy dog.
 
Error at line 4: Invalid value for float.
        Check => 0.l
 
Error at line 5: Invalid integer value for integer variable "int4". Begining at "w"
        Check => -17w
 
Error at line 6: Missing whitespace after #.
        Check => #bad comment
 
Error at line 9: Missing whitespace after #.
        Check => #bad comment
 
Error at line 10: Invalid value for float.
        Check => +1.0f

Number of errors found: 7
```

## Getting Started

### Using RTomlCop
To begin using RTomlCop follow these steps:
- Clone this project `git clone https://github.com/ad9311/rtomlcop.git` using your terminal.
- Then change directory `cd rtomlcop`
- There is already a sample.toml file you can use or provide another one.
- Pass the filename with its extentsion as an argument `bin/rtomlcop.rb <file_name_with_extension>`
- If no file provided or the file does not exists the program will terminate.
- If you want to check several files do them one by one.</br>

### Rspec
To check rspec just type in the terminal `rspec` and it will run the tests.

**Make sure to select a file that is in the root folder as if it is in another folder will not work.**

### Contributing

Contributions, issues and feature requests are welcome!
You can do it on [Issues Page](https://github.com/ad9311/rtomlcop/issues).

## Author

**Ángel Díaz**

- GitHub: [Angel Diaz](https://github.com/ad9311)
- Twitter: [Angel Diaz](https://twitter.com/adiaz9311)
- LinkedIn: [Angel Diaz](https://www.linkedin.com/in/ad9311/)

## License

- This project is [MIT](./LICENSE) licensed.

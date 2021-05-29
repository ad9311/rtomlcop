# RTomlCop

## What is RTomlCop?

RTomlCop is a linter tool built in ruby for [toml](https://toml.io/en/index) files.</br>
This tool will inspect a toml file and search for errors to display them.

## Content
* [What it does](#what-it-does)
* [Dependencies](#dependencies)
* [Getting Started](#getting-started)
* [Contributing](#contributing)
* [Author](#author)
* [License](#license)

## What it does

RTomlCop searches for errors line by line in a toml file.</br>
If an error is found it will display them and their corresponding lines.
This tool follows the official [toml](https://toml.io/en/index) to parse toml files.</br>
Currently RTomlCop only parses the following data:
- Comments & comments beside code
- One line double-quoted strings
- Integers in the format of:
  - Decimal
  - Hexadecimal
  - Octal
  - Binary
- Floats
- Booleans
- Date and time format.

Other elements such as arrays and multiline code are not supported.

### Comments
#### Comments must have space after the number sign if the next character is not a number sign or whitespace.
```
# This is a good comment
#Bad comment
int0 = 0 # Comments can also be beside code
int1 = 7 #Also a bad comment
```

### Strings
```
str0 = "Hello World!" # Valid string
str1 = "Hello world! # Invalid, unclosed string
str2 = 'Single-quoted strings are not supported'
```
**Note that currently only double-quoted strings are supported.**

### Integers
#### Integers are parsed with ruby. Integers include decimal, hexadecimal, octal and binary.
```
int1 = +99 
int2 = 42k # Invalid integer
int3 = 05 # Zero-padded integers are not allowed
int4 = -17

# Hex, oct and bin integer can contain uppercase letters
hex1 = 0xDEADBEEF
hex2 = 0xdeadbeef
bin1 = 0b120 # Invalid binary
oct1 = 0o01234567

# Hexadecimal, binary and octal numbers allow negative numbers.
```

### Floating-point numbers
```
flt1 = +1.0
flt2 = 3.1415f # Invalid float
flt3 = -0.01
flt4 = 5e+22 # Floats can contain scientific notation
flt5 = 1e06 
flt6 = -2E-2
flt8 = 224_617.445_991_228 # _separator are also allowed
```

### Dates and time
#### Dates are parsed with the Date class in ruby
```
# Date format must be {yyyy}-{mm}-{dd}
odt1 = 1979-14-27T07:32:00Z # out of range format
odt2 = 1979-05-27T00:32:00-07:00
ldt1 = 1979333-05-27T07:32:00 # Invalid date
ld1 = 1979-05-27
lt1 = 07:32:00 # Time format are all 24Hrs
lt2 = 30:66:70 # Out or range time
```

## Dependencies

**Currently RTomlCop works only by default on linux operative systems.**</br>
Before beginning with RTomlCop, make sure that ruby is installed. To do so, run `ruby --version` command on a terminal (Command Prompt).</br>
If no version listed, please install [ruby](https://www.ruby-lang.org/en/).</br>
Next install bundler running `gem install bundler` command.

## Getting Started
### Using RTomlCop
To begin using RTomlCop follow these steps:
- Clone this project `git clone https://github.com/ad9311/rtomlcop.git` using your terminal.
- Then change directory `cd rtomlcop`
Once inside the root folder run the following command `bundle install` to install the necessary dependencies.</br>
Then inspect files following these two options:
- Run RTomlCop `./bin/rtomlcop.rb --all` to inspect all files that contain the .toml extension. **--all keyword must have two dashes.**
- Alternatively you can inspect individual files `./bin/rtomlcop.rb <name_of_file>` i.e `./bin/rtomlcop.rb sample.toml` to inspect the provided sample file.</br></br>
Follow [Microverse Ruby Capstone Project - RTomlCop](https://youtu.be/b6LrwOET28I) for a video tutorial.</br><br>
**Note:**</br>
**If a file that does not exist is provided or no .toml files are present then the program will terminate.**</br>
**It is possible to inspect files that do not have the .toml extension but keep in mind that unexpected results may appear.**</br>

### This is what it would look like with the --al- flag</br>
![-all](https://raw.githubusercontent.com/ad9311/ad9311.github.io/main/resources/rtomlcop/all.png)
### Choosing a non .toml file will output a warning
![no.toml](https://raw.githubusercontent.com/ad9311/ad9311.github.io/main/resources/rtomlcop/notoml.png)

### Rspec
[Rspec](https://rspec.info/) is a tool that runs test scenarios for ruby.
To run rspec use command `rspec` inside the root folder and it will run the tests.

## Contributing

Contributions, issues and feature requests are welcome!
You can do it on [Issues Page](https://github.com/ad9311/rtomlcop/issues).

## Author

**Ángel Díaz**

- GitHub: [Ángel Díaz](https://github.com/ad9311)
- Twitter: [Ángel Díaz](https://twitter.com/adiaz9311)
- LinkedIn: [Ángel Díaz](https://www.linkedin.com/in/ad9311/)

## License

- This project is [MIT](./LICENSE) licensed.

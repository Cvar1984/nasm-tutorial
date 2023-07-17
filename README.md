# nasm-tutorial
![](https://img.shields.io/badge/haxor-approved%20by%20nasa-blue)
![](https://img.shields.io/badge/language-god-white)


# references
[Linux syscall tables](https://chromium.googlesource.com/chromiumos/docs/+/HEAD/constants/syscalls.md)

[Flags](https://en.wikipedia.org/wiki/FLAGS_register)

[NASM official docs](https://nasm.us/docs.php)

[NASM tutorial](https://cs.lmu.edu/~ray/notes/nasmtutorial/)

## compile
```sh
nasm -f elf64 hello.asm -o hello.o
```
```sh
ld hello.o -o hello
```
```sh
./hello
```
## compile C and assembly with gcc
```sh
nasm -f elf64 hello.asm -o hello.o
```
```sh
gcc -no-pie -nostdlib say.c -c
```
```sh
ld say.o hello.o -o say
```

## clean mess
```sh
git clean -xdfn
```

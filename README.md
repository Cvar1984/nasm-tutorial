# nasm-tutorial
![](https://img.shields.io/badge/haxor-approved%20by%20nasa-blue)
![](https://img.shields.io/badge/language-god-white)


# references
[Linux syscall tables](https://chromium.googlesource.com/chromiumos/docs/+/HEAD/constants/syscalls.md)

[Flags](https://en.wikipedia.org/wiki/FLAGS_register)

[NASM official docs](https://nasm.us/docs.php)

[NASM tutorial](https://cs.lmu.edu/~ray/notes/nasmtutorial/)

# REcommended tools for practice
- [pwndbg](https://github.com/pwndbg/pwndbg/)
![image](https://github.com/user-attachments/assets/99657225-cddf-4af0-8e03-10cd7ecc3c6a)

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
git clean -xdf
```

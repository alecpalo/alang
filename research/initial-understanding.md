# Research for this proejct

## What is a compiler

1. Frontend

- This is where the analysis of the compiler is done

2. Backend

- synthesizer, generates code (can be another language) but generally asm

## Frontend

Lexer -> (tokens) -> Parser -> (AST)

1. Lexing

- generates a sequence of tokens from some text

ex.

```c
// function

int foo(int x) {
    return x + 1;
}
```

would be broke down into:
int
foo
(
int
x
)
{
return
x
+
1
}

The lexer does NOT give meaning to anything, it breaks it down into important bits, and typically removes whitespace

### Lexing with Ocaml (Ocamllex)

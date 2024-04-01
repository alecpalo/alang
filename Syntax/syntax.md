## Basic Syntax
First iteration

```
// comment

fn printVals(int a, int b) {
    print(f'vals are $a and $b');
}

fn getVals(int x) -> (int, int) {
    if x mod 2 == 0 {
        return 1, 2;
    } else {
        return 3, 4;
    }
}


fn main() -> int {
    int a = 0;
    val1, val2 := getVals(a);
    printVals(val1, val2);
    return 0;
}

```

# Explanation:

This language feels very similar to Rust and C++ with how it feels, which is kinda what I'm going for. I like how strict those languages feel and I think being very strict with syntax for my first language would be incredible helpful

Things I am trying to go for:
1. I want static typing that is clearly defined
    a) I want it to be sorta GoLang style, where it is static but it can infer the type
2. return multiple variables, of multiple types
3. minimize () for statements (if, for, while)
4. increase the number of keywords, decrease the number of symbols
5. print statements that can escape variables into a string with the '' rather than ""
6. return type for functions like Rust, for multiple return types use (), returns as a tuple

Things that I want that aren't in this example:
1. immutability
2. pointers
3. classes
    a) I want to always use the . operator for classes / structs even if it is a pointer

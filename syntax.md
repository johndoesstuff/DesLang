# DesLang Documentation

A DesLang program consists of statements separated by `;` which can represent different ideas. Each statement can consist of an [expression](#expressions), [folder](#folders), [table](#tables), [context](#contexts), [note](#notes), [image](#images), [simulation](#simulations), or [settings](#settings).

## Expressions

Expressions are denoted very similarly to their Desmos counterparts to maximize readability and ease of use. Expressions can consist of a combination of [variables](#variables), [numbers](#numbers), [functions](#functions), [lists](#lists), [piecewises](#piecewises), [binary operators](#binary-operators), and [unary operators](#unary-operators). An Expression can have display properties added using `?` and setting the property by referencing the property name and its value. Boolean properties such as `hidden` do not necessarily need a value and will be assumed true if specified. Different properties can take different inputs, for example `color` takes in text input whereas `colorLatex` takes an expression. Multiple properties can be assigned per expression, for example:
```
y = x ? color = #ffffff;
y = x ? color = red;
y = x ? colorLatex = hsv(hue, sat, vib);
y = x ? lineOpacity = 0.5 ? lineWidth = 3 ? hidden;
```

### Variables

Variables can be alphanumeric but must start with a letter. For example `variable` and `var01` are valid variable names however `01var` is an invalid variable name. Variables consist of [predefined variables](#list-of-predefined-variables), [Desmos variables](#list-of-desmos-variables), [special variables](#list-of-special-variables), temporary variables, and regular variables. 
* Predefined variables include constants like `pi` and `e`, they cannot have a value assigned to them but their value can be read. 
* Desmos variables are variables that are built into Desmos but don't have a predefined value such as `alpha`, `beta`, and many more Greek characters.
* Special variables are variables used by the graphing calculator for various purposes, usually to graph functions, these include `x`, `theta`, and more.
* Temporary variables can only be accessed within the line they are confined to and can be denoted by starting with a `#` such as `#temp`. They serve a purpose as not cluttering variable space when setting up functions such as `sum` or `prod`.
* Regular variables are any variable that does not fall into one of the categories above, they have no special properties that you wouldn't expect from a variable.

Variables can be assigned a value using `=`. For example:
```
b = 5;
alpha = b / pi;
```

### Numbers

Numbers can be split into 3 groups

 * Decimal
 * Hexadecimal
 * Binary

Decimal Numbers consist of digits `0` through `9` and are interpreted in base 10. I shouldn't have to explain this you know how to count

Hexadecimal Numbers are denoted by the prefix `0x` and consist of digits `[0-9a-fA-F]`. They are interpreted in base 16 and converted to base 10 during compilation. For example `0xFF` would become `255` after compiling however they still serve a readability use for programs utilizing bases of 2.

Binary Numbers are similarly denoted by the prefix `0b` and consist of digits `0` and `1`. They are interpreted in base 2 and converted to base 10 during compilation. For example `0b101` would become `5` after compiling. Similarly they serve a readability purpose in base 2.

### Functions

Functions consist of a variable and series of arguments enclosed by parentheses and separated by commas. For example `f(a, b)` can be referenced and assigned a value like a variable except utilizing also the variables passed into it. For example:
```
f(alpha, beta) = sqrt(alpha) + (beta * alpha);
gamma(phi) = f(phi, 2);
```
Functions can either be user defined or native with Desmos. Native functions include `sqrt`, `abs`, and [more](#normal-functions).

### Lists

Lists contain an array of expressions enclosed by brackets and separated by commas. For example `[1, 3+2, n]`. Lists can also bet iterated for brevity using `@`. For example `[1, @5]` is equivalent to `[1, 2, 3, 4, 5]` and `[0, 0.5, @2]` is equivalent to `[0, 0.5, 1, 1.5, 2]`. Important: lists cannot contain lists.

### Piecewises

Piecewises are formed from boolean expressions that can map to specific expressions. A piecewise is enclosed in braces and each term of the piecewise is separated by a comma. The terms are mapped as `( boolean ) : ( expression )` and it is possible for the last expression to not have a boolean preceding it. For example `{ n == 0 : n + 1, 3 - n }` will return `n + 1` when `n == 0` and `3 - n` if not.

### Binary Operators

Binary operators take in 2 inputs using infix notation and return the output using [pemdas](#order-of-operations). For example `3 + 2` or `29 - 3**(1 + 2)`.

### Unary Operators

Unary operators take in 1 input. Unary operators come first in [pemdas](#order-of-operations). For example `!true` or `~0b0101`.

## Folders

Folders are a way of organizing [expressions](#expressions), [tables](#tables), [notes](#notes), [images](#images), [contexts](#contexts), and [simulations](#simulations). Folder syntax consists of `folder` followed by parentheses enclosing the folder name (text input) and braces surrounding the contents of the folder, for example:
```
folder (my folder) {
	y = x**2;
	r = sin(theta / 2);
};
```
Folders can contain expressions, notes, tables, images, contexts, and simulations but not other folders or [settings](#settings).

## Tables

Tables are convenient for entering large amounts of data especially in a table format (duh). They can be created by specifying `table` then parentheses enclosing a list of variable name arguments to assign the values to followed by braces surrounding the contents of the table. For example:
```
table (x0, y0) {
	//contents
};
```
The contents of a table are made of a series of values separated horizontally by `,` and vertically by `;`. For example:
```
table (x0, y0) {
	5, 2;
	3, 1;
	2, 6;
} ? hidden;
```

## Contexts
A context is a shift in variable naming for convenience, all variables within a context can be referenced outside the context using `contextName.variableName`. The default context for DesLang is `main`. Contexts are also able to stack, for example `main.contextName1.contextName2.variableName` is possible. Variables within the context can be referred to normally. Contexts are declared using 
```
context (contextName) {
	//contents
};
```
To demonstrate:
```
a = 1;
context (layer1) {
	b = 2;
	c = main.a;
	context (layer2) {
		d = main.layer1.b + main.layer1.a;
	};
	f = main.layer1.layer2.d;
};
g = layer1.f;
```

## Notes

Notes are like comments but that will appear in the compiled Desmos graph. They can be created using `note () { text you want to make note of };`

## Images

Images only need an image url assigned to them to function however extra properties can be specified. To create an image use `img (https://example.com/image.jpg) {};`

## Simulations

Simulations are a way of assigning a value to a variable and allowing it to update at a regular interval. Simulations consist of 
```
simulation (fps) {
	//contents
};
```
The contents of a simulation are expressions denoted by `=>` instead of `=` to represent the assignment of a value. For example `x0 => x0 + 1;`.
```
x0 = 1;
y0 = 1;
simulation (60) {
	x0 => sin(x0);
	y0 => x0 * y0;
};
```
It's important to mention that all variables used inside a simulation must be initialized outside the simulation.

## Settings

Settings are a way to modify the metadata of a graph (aka its settings). To modify a property use `propertyName = propertyValue`. All properties in `Calc.getState().graph` are supported and setting `randomSeed` is also supported. For example
```
settings () {
	showXAxis = false;
	xAxisArrowMode = BOTH;
	viewport.xmin = -5;
	viewport.xmax = 5;
};
```

## Comments

Single line comments are denoted by starting with `//` and multiline comment start with `/*` and end with `*/`.
```
// Single line comment
/* 
   Multiline
   Comment
*/
```

# Technicalities
### Variables
#### List of predefined variables
* `pi` 3.1415...
* `tau` 6.2831...
* `e` 2.7182...
* `inf` or `infty` evaluates to undefined but can be used in the context of infinity, such as `1/inf == 0` evaluates to true
* `true` 1
* `false` undefined
* `undefined` undefined
#### List of Desmos Variables
 * `alpha`
 * `beta`
 * `gamma`
 * `Gamma`
 * `delta`
 * `Delta`
 * `epsilon`
 * `zeta`
 * `eta`
 * `Theta`
 * `iota`
 * `kappa`
 * `lambda`
 * `Lambda`
 * `mu`
 * `nu`
 * `Pi`
 * `rho`
 * `sigma`
 * `Sigma`
 * `upsilon`
 * `Upsilon`
 * `phi`
 * `Phi`
 * `chi`
 * `psi`
 * `Psi`
 * `omega`
 * `Omega`
#### List of Special Variables
 * `x`
 * `y`
 * `theta` represents angle, used in conjunction with `r`
 * `t` (within parametrics)
 * `r` represents radius
### Functions
#### Normal Functions
These functions behave exactly like the would normally in Desmos.
 * `sqrt`
 * `floor`
 * `ceil`
 * `abs`
 * `round`
 * `sin`
 * `cos`
 * `tan`
 * `csc`
 * `sec`
 * `cot`
 * `arcsin`
 * `arccos`
 * `arctan`
 * `arccsc`
 * `arcsec`
 * `arccot`
 * `sinh`
 * `cosh`
 * `tanh`
 * `csch`
 * `sech`
 * `coth`
 * `arcsinh`
 * `arccosh`
 * `arctanh`
 * `arccsch`
 * `arcsech`
 * `arccoth`
 * `total`
 * `len` or `length`
 * `mean`
 * `median`
 * `min`
 * `max`
 * `quartile`
 * `quantile`
 * `stdev`
 * `stdevp`
 * `mad`
 * `var`
 * `cov`
 * `corr`
 * `spearman`
 * `nCr`
 * `nPr`
 * `stats`
 * `ttest`
 * `tscore`
 * `ittest`
 * `histogram`
 * `dotplot`
 * `boxplot`
 * `normaldist`
 * `tdist`
 * `poissondist`
 * `binomialdist`
 * `uniformdist`
 * `pdf`
 * `cdf`
 * `inversecdf`
 * `random` or `rand`
 * `join`
 * `sort`
 * `shuffle`
 * `lcm`
 * `gcd`
 * `mod`
 * `sign` or `sgn`
 * `exp`
 * `ln`
 * `polygon`
 * `factorial`
 * `hsv`
#### Special Functions
These functions are native to DesLang but could require elaboration
 * `log(number, base)`
 * `sum(indexDeclaration, end, expression)`
	 * `sum(#n = 1, 5, #n)` (triangular number 5)
 * `prod(indexDeclaration, end, expression)`
	 * `prod(#n = 1, 5, #n)` (5 factorial)
 * `int(lower, upper, integrand, varOfIntegration)`
	 * `int(0, 1, sin(#n), #n)` (integrate `sin(#n)` from `0` to `1` with respect to `n`)
 * `nthroot(number, root)`
 * `percof(number, percent)`
 * `derivative(expression, varOfDifferentiation)`

### Order of operations
Symbols on the same line denote equal precedence
 * `=`,`=>`,`~=` Value Assignment
	 * `=` Assign value to variable
	 * `=>` Used in simulations to denote updating a variable
	 * `~=` Regression assignment
 * `&&`,`||` Boolean Logic
	 * `&&` Boolean and
	 * `||` Boolean or
 * `==`,`!=`,`<=`,`>=`,`<`,`>` Boolean Comparisons
	 * `==` Test value equivalence
	 * `!=` Test value inequivalence
	 * `<=` Test if less than or equal to
	 * `>=` Test if greater than or equal to
	 * `<` Test if less than
	 * `>` Test if greater than
 * `+`,`-`,`^`,`|`,`&`,`<<`,`>>` Addition Subtraction and Bitwise
	 * `+` Addition
	 * `-` Subtraction
	 * `^` Bitwise xor
	 * `|` Bitwise or
	 * `&` Bitwise and
	 * `<<` Bitwise left shift
	 * `>>` Bitwise right shift
 * `*`,`/`,`%` Multiplication Division Modulus
	 * `*` Multiplication
	 * `/` Division
	 * `%` Modulus
 * `**` Exponents
 * `~`,`!`,`@` Unary Operations
	 * `~` Bitwise not
	 * `!` Boolean not
	 * `@` List iterator

Putting parentheses around an operation will give it highest precedence.
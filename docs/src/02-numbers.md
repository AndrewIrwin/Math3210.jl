# Numbers

The first thing to learn about when solving mathematical problems on a computer is the different ways of representing and working with numbers. We are familiar with many different sets of numbers from mathematics class, for example: counting numbers, integers, rational numbers, irrational numbers, real numbers, and complex numbers.

There are many ways to represent numbers on a computer. Two important kinds are integers and approximations to real numbers called floating point numbers. 

Integers seem straightforward: you need 0, 1, -1, 2, -2, etc. In math, there are an infinite number of integers (just add one to your largest), but there is no way a computer, which is finite, can represent an infinite number of things. In practice computers allocate a fixed number of bits (binary digits) to store an integer. Current practice is to use 64 bits for integers, but for specialized purposes that use smaller numbers its possible to use 32, 16, or even 8 bits. There is always a smallest and largest integer on a computer and calculations that exceed these limits may give surprising results.

Floating point numbers are a lot like numbers on a calculator. There is a sign, an exponent (power of 10, which places the decimal point) and a "number" part (called mantissa or [significand](https://en.wikipedia.org/wiki/Significand)). Like integers there is a maximum and minimum part to the exponent and the mantissa. Since there are a finite number of floating point numbers (the exact number determined by the number of bits to represent the number; usually 64), they differ from real numbers in another important way -- they don't form a continuum since they are discrete. This means that there is always a next smallest and next largest floating point number. In addition to a set of rational numbers, there are four special numbers: infinity (Inf), negative infinity (-Inf), and not-a-number (NaN). There is also a special value missing (called NA in other systems), but it is not an integer or a floating point number.

A major challenge with floating point numbers is that you may not be able to represent the number you want exactly. The computer will find the closest floating point number and give you that value as the result of a calculation. For example, clearly there is no floating point number exactly equal to $\pi$ or $\sqrt{2}$. You probably won't be surprised that there is no floating point number equal to $1/3$ since the decimal expansion is infinite (but repeating.) Since the computer uses binary numbers to represent numbers internally, the decimal expansion is less important than the binary expansion. So $1/2$ is represented exactly. What might be surprising is that $11/5 = 2.2$ and $11/50 = 0.22$ can't be represented exactly as floating point numbers. What's worse is that floating point 2.2 is more than $11/5$ while floating point 0.22 is less than $11/50$.



## Specialized types of numbers

Julia can represent rational numbers by keeping track of the numerator and denominator. Similarly, there are complex numbers and functions for computing with them. There are "Big" versions of both integers and floating point numbers, where you can specify the number of bits to represent the number. The size of these numbers is only limited by your computer's storage. Calculations with these arbitrary precision numbers tends to be quite a lot slower than with the basic integer and floating point types. Many other types are possible, of course. Two we will use in this course are [interval numbers](https://en.wikipedia.org/wiki/Interval_arithmetic), which represent an interval of the real line (or box in $\mathbb{R}^n$), and [dual numbers](https://en.wikipedia.org/wiki/Dual_number), which are useful for computing derivatives.

More generally, all these numbers can be places into vectors, matrices, and higher dimensional arrays as well as other data structures.

## Julia introduction

Entering integers, floating point numbers, rational numbers, complex numbers, BigInt, BigFloat
Arithmetic
What is 1/2? Some systems say 0 since we started with integers, the result should be an integer), but Julia converts to floating point and gives 0.2. People will often write 1.0/2.0 (or obscure versions like 1./2) to be sure that a floating point number is the result. If you want integer division, make a rational number with //.
Typeof
typemin, typemax
Floatmin, floatmax
Eps
Nextfloat
Prevfloat

## Self-study exercises

What is log(0)? log(-10)? exp(-Inf)? 1/0? -1/0? 0/0? sin(Inf)

What is prevfloat(Inf)? nextfloat(-Inf)? prevfloat(NaN)? 


## Arbitrary precision arithmetic

```@repl
sqrt(BigFloat(2.0))
setprecision(1024)
sqrt(BigFloat(2.0))
factorial(BigInt(1000))
```

## Later

Arithmetic problems that arise from floating point.

Vectors, Matrices, Arrays

## References

There are lots more details to be learned if you want. See the [Integers and Floating-point numbers](https://docs.julialang.org/en/v1/manual/integers-and-floating-point-numbers/) section of the Julia manual.



# Introduction to Julia


Installing packages


Creating Vectors

Functions on vectors


Create arrays (matrices).

Functions on matrices.


Benchmarks

```@repl
using BenchmarkTools
@btime sin(5)
@btime sin.(1:1000);
```

+++
cover = false
+++

# Write a Blog Post with Code

Make an informative post on how to code a particular method, or simply write about some code you find useful.

```julia
function foo(x::Float64, y::Float64)
  x^2 + y^2
end

function bar(z::Float64)
  z^2 + 0.5z
end

# Pipes are nice
foo(5.0, 2.0) |> bar
```

Sytax highlight is available for many languages.

```python
def foo(x, y):
    return x**2 + y**2

def bar(z):
    return z**2 + 0.5*z

# No pipe 
bar(foo(5.0, 2.0))
```
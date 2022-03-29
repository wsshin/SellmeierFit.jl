# Installation
`SellmeierFit.jl` is a Julia package, so it requires Julia installation.  Download Julia from the [official website](https://julialang.org) and install it.  You can also build Julia from the [source](https://github.com/julialang/julia) if you wish.

Once Julia is installed, start Julia.  The Julia console (a.k.a. "REPL") looking something like the following will show up:
```julia-repl
               _
   _       _ _(_)_     |  Documentation: https://docs.julialang.org
  (_)     | (_) (_)    |
   _ _   _| |_  __ _   |  Type "?" for help, "]?" for Pkg help.
  | | | | | | |/ _` |  |
  | | |_| | | | (_| |  |  Version 1.7.2-pre.0 (2021-12-23)
 _/ |\__'_|_|_|\__'_|  |  release-1.7/3f024fd0ab (fork: 433 commits, 292 days)
|__/                   |

julia>
```

Press the `]` key, and the prompt will turn from `julia>` to `pkg>`, indicating the REPL is now in the [package manager mode](https://docs.julialang.org/en/v1/stdlib/Pkg/).  To install `SellmeierFit.jl`, execute the following command:
```julia-repl
(@v1.7) pkg> add SellmeierFit
```

Exit from the package manager mode by pressing the backspace key (or the delete key in macOS).  The prompt will change from `pkg>` back to `julia>`.  To use `SellmeierFit.jl`, execute the following command:
```julia-repl
julia> using SellmeierFit
```

To verify the correct installation of the package, try a simple example script as
```julia-repl
julia> include(joinpath(pathof(SellmeierFit), "..", "..", "example", "no_plot.jl"))
```
Here, `joinpath(...)` returns the path of the test script `no_plot.jl` in the `example/` directory of the `SellmeierFit.jl` package, and `include(...)` executes the script.

To write your own code using `SellmeierFit.jl`, see [Tutorials](@ref).
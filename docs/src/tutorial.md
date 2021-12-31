# Tutorials
Concrete example scripts are included in the `example/` directory.

## Reading refractive index data
`SellmeierFit.read()` reads refractive index data and outputs wavelengths ``λ`` and dielectric constants ``ε_\mathrm{r}``.  The function supports various keyword arguments to read input data in various formats.  See [`SellmeierFit.read()`](@ref) for the details of available keyword arguments.

### From a CSV file
Suppose a CSV file named `refindex.csv` in the present working directory contains wavelengths ``λ`` in units of µm as the first column and the corresponding refractive indices ``n`` as the second column.  The following code stores wavelengths in units of meters (not µm) and dielectric constants in variables `λ` and `ε` via [property destructuring of `NamedTuple`](https://julialang.org/blog/2021/11/julia-1.7-highlights/#property_destructuring):
```julia
(; λ, ε) = SellmeierFit.read("./refindex.csv")
```
`λ` and `ε` can be equally obtained by
```julia
result = SellmeierFit.read("./refindex.csv")
λ = result.λ
ε = result.ε
```
or
```julia
result = SellmeierFit.read("./refindex.csv")
λ = result[1]
ε = result[2]
```

### From a text file
Suppose a text file named `refindex.txt` contains wavelengths in units of µm and the corresponding refractive indices as follows:
```
Refractive Index
wl 	n
0.21	1.53835762
0.2174	1.530846431
0.2251	1.524078907
0.233	1.518041768
0.2412	1.512572116
...
```
The first two lines of the file are a header.  Variable `λ` storing wavelengths in units of meters (not µm) and variable `ε` storing the corresponding dielectric constants are created by
```julia
(; λ, ε) = SellmeierFit.read(path, header=2)
```

### From a website
Websites such as [RefractiveIndex.info](https://refractiveindex.info) provide refractive index data of various materials in CSV format.  The link to these data files can be directly passed to `SellmeierFit.read()`:
```julia
(; λ, ε) = SellmeierFit.read("https://refractiveindex.info/tmp/data/main/SiO2/Malitson.csv")
```

## Fitting data to the Sellmeier equation
Once you have a vector `λ` of wavelengths in units of meters and a vector `ε` of dielectric constants, fitting these data to the Sellmeier equation is performed by
```julia
(; mdl, err) = fit_sellmeier(λ, ε)
```
Here, `mdl::SellmeierModel` has `str` and `λres` as fields; they correspond to ``B_i``'s and ``\sqrt{C_i}``'s of the Sellmeier equation and represent the strengths and resonance wavelengths of the terms in the Sellmeier equation.  `err` is the root-mean-square error between the Sellmeier equation and the entries of `ε`.
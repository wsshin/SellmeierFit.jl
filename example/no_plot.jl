# Same as example/from_csv.jl, but without the time-consuming plot.

using SellmeierFit
using SimpleConstants  # for micro = 1e-6

## Main section
# Load a set of measured refractive index data from Malitson.csv
dir = @__DIR__
path = joinpath(dir, "data", "Malitson.csv")
(; λ, ε) = SellmeierFit.read(path)

# Fit the loaded data to the Sellmeier equation.
(; mdl, err) = fit_sellmeier(λ, ε)

## Analysis section
# The calculated fit parameters are the same as those shown in RefractiveIndex.info's
# Dispersion formula section.
println("B = $(mdl.str)")
println("√C (µm) = $(mdl.λres ./ micro)")
println("Error between data and fit = $err")
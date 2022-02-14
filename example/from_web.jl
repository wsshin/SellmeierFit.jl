using SellmeierFit
using SimpleConstants  # for micro = 1e-6
using CairoMakie

## Main section
# Load a set of measured refractive index data from https://RefractiveIndex.info.
path = "https://refractiveindex.info/tmp/data/main/SiO2/Malitson.csv"
(; λ, ε) = SellmeierFit.read(path)

# Fit the loaded data to the Sellmeier equation.
(; mdl, err) = fit_sellmeier(λ, ε)

## Analysis section
# The calculated fit parameters are the same as those shown in RefractiveIndex.info's
# Dispersion formula section.
println("B = $(mdl.str)")
println("√C (µm) = $(mdl.λres ./ micro)")
println("Error between data and fit = $err")

# Visualize the measured data and fit Sellmeier equation; note that n = √ε.
fontsize = 20
fig = Figure(; fontsize)
Axis(fig[1,1], title="Refractive Index of SiO₂", xlabel="λ (meter)", ylabel="n")
scatter!(λ, .√ε, label="Measurement", color=:black)
lines!(λ, .√mdl.(λ), label="Sellmeier equation", color=:red)
axislegend(; position=:rt)
display(fig)

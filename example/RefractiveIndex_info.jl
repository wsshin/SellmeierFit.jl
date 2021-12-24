using SellmeierFit
using SimpleConstants  # for micro = 1e-6
using CairoMakie

## Main section
# Load a set of measured refractive index data from https://RefractiveIndex.info.
uri = "https://refractiveindex.info/data_csv.php?datafile=data/main/SiO2/Malitson.yml"  # link to RefractiveIndex.info's SiO₂
(; λ, ε) = SellmeierFit.read(uri)

# Fit the loaded data to the Sellmeier equation.
(; mdl) = fit_sellmeier(λ, ε)

## Analysis section
# Compare the fit parameters with RefractiveIndex.info's Dispersion formula section.
println("B = $(mdl.str)")
println("√C = $(mdl.λres ./ micro)")

# Visualize the measured data and fit Sellmeier equation; note that n = √ε.
fontsize = 20
fig = Figure(; fontsize)
Axis(fig[1,1], title="Refractive Index of SiO₂", xlabel="λ (µm)", ylabel="n")
lines!(λ, .√mdl.(λ), label="Sellmeier equation")
scatter!(λ, .√ε, label="Measurement")
axislegend(; position=:rt)
display(fig)

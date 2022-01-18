var documenterSearchIndex = {"docs":
[{"location":"types_funs/#Types-and-Functions","page":"Types and Functions","title":"Types and Functions","text":"","category":"section"},{"location":"types_funs/#Index-of-all-types-and-functions","page":"Types and Functions","title":"Index of all types and functions","text":"","category":"section"},{"location":"types_funs/","page":"Types and Functions","title":"Types and Functions","text":"","category":"page"},{"location":"types_funs/#Types","page":"Types and Functions","title":"Types","text":"","category":"section"},{"location":"types_funs/","page":"Types and Functions","title":"Types and Functions","text":"Modules = [SellmeierFit]\nOrder   = [:type]","category":"page"},{"location":"types_funs/#SellmeierFit.SellmeierModel","page":"Types and Functions","title":"SellmeierFit.SellmeierModel","text":"SellmeierModel{N}\n\nSellmeier model representing the Sellmeier equation ε(λ) = 1 + ∑ᵢ [Bᵢ λ² / (λ² - Cᵢ)], where the sum is for 1 ≤ i ≤ N.\n\nFields\n\nstr::SVector{N,Float64}: str[i] is the strength of the ith term in the Sellmeier equation; corresponds to Bᵢ.\nλres::SVector{N,Float64}: λres[i] is the resonance wavelength of the ith term in the Sellmeier equation; corresponds to √Cᵢ.\n\n\n\n\n\n","category":"type"},{"location":"types_funs/#SellmeierFit.SellmeierModel-Tuple{Real}","page":"Types and Functions","title":"SellmeierFit.SellmeierModel","text":"(::SellmeierModel)(λ::Real)\n\nEvaluate the Sellmeier equation represented by the given SellmeierModel at a wavelngth λ in units of meters.\n\n\n\n\n\n","category":"method"},{"location":"types_funs/#SellmeierFit.SpectralVariable","page":"Types and Functions","title":"SellmeierFit.SpectralVariable","text":"SpectralVariable\n\nUsed to specify the type of the spectral variable which the refractive index is a function of.  The available instances are WAVELENGTH for wavelength, FREQUENCY for frequency, and ENERGY for photon energy.\n\n\n\n\n\n","category":"type"},{"location":"types_funs/#Functions","page":"Types and Functions","title":"Functions","text":"","category":"section"},{"location":"types_funs/","page":"Types and Functions","title":"Types and Functions","text":"Modules = [SellmeierFit]\nOrder   = [:function]","category":"page"},{"location":"types_funs/#Base.length-Union{Tuple{SellmeierModel{N}}, Tuple{N}} where N","page":"Types and Functions","title":"Base.length","text":"Base.length(sm::SellmeierModel)\n\nReturn the number of terms in the sum of the Sellmeier equation represented by the given SellmeierModel.\n\n\n\n\n\n","category":"method"},{"location":"types_funs/#SellmeierFit.fit_sellmeier-Tuple{AbstractVector{Float64}, AbstractVector{Float64}, Integer, Integer}","page":"Types and Functions","title":"SellmeierFit.fit_sellmeier","text":"fit_sellmeier(λ, ε, Nₙ, Nₚ)\n\nFit the dielectric constant data ε sampled at wavelengths λ to the Sellmeier equation with exactly Nₙ terms below and Nₚ terms above the range of λ.\n\n\n\n\n\n","category":"method"},{"location":"types_funs/#SellmeierFit.fit_sellmeier-Tuple{AbstractVector{Float64}, AbstractVector{Float64}}","page":"Types and Functions","title":"SellmeierFit.fit_sellmeier","text":"fit_sellmeier(λ, ε; Nmax=10, rtol_λres=1e-3)\n\nFit the dielectric constant data ε sampled at wavelengths λ to the Sellmeier equation with up to Nmax terms.  If λres of different terms have relative difference less than rtol_λres, they are considered the same term and merged.\n\n\n\n\n\n","category":"method"},{"location":"types_funs/#SellmeierFit.fit_sellmeier-Union{Tuple{N}, Tuple{AbstractVector{Float64}, AbstractVector{Float64}, Val{N}}} where N","page":"Types and Functions","title":"SellmeierFit.fit_sellmeier","text":"fit_sellmeier(λ, ε, Val(N))\n\nFit the dielectric constant data ε sampled at wavelengths λ to the Sellmeier equation with exactly N terms.  Out of the N terms, some are below and the other are above the range of λ.\n\n\n\n\n\n","category":"method"},{"location":"types_funs/#SellmeierFit.read-Tuple{String}","page":"Types and Functions","title":"SellmeierFit.read","text":"read(path; <keyword arguments>)\n\nRead the refractive index file at path, and return the wavelength λ and the dielectric constant vector ε as a named tuple.\n\nArguments\n\npath::String: the path of the refractive index file; usually *.csv, but it can be any file readable by CSV.read(), such as *.txt.\ns_var::SpectralVariable=WAVELENGTH: WAVELENGTH, FREQUENCY, or ENERGY if the refractive index file describes refractive index as a function of wavelength, frequency, or photon energy.\nunit_prefix::Real=micro: the prefix to multiply to the values of the spectral variable to convert their units to the SI units.  For example, 1e-6 for wavelengths in units of µm; 1.602176643 for photon energies in units of eV.\ns_col::Integer=1: the index of the spectral variable column in the refractive index file.\nn_col::Integer=2: the index of the refractive index column in the refractive index file.\nkwargs...: the keyword arguments to pass to CSV.read()\n\n\n\n\n\n","category":"method"},{"location":"tutorials/","page":"Tutorials","title":"Tutorials","text":"include(\"../../example/from_csv.jl\")","category":"page"},{"location":"tutorials/#Tutorials","page":"Tutorials","title":"Tutorials","text":"","category":"section"},{"location":"tutorials/#Reading-refractive-index-data","page":"Tutorials","title":"Reading refractive index data","text":"","category":"section"},{"location":"tutorials/","page":"Tutorials","title":"Tutorials","text":"SellmeierFit.read() reads refractive index data, and outputs wavelengths λ and dielectric constants ε_mathrmr.  The function supports various keyword arguments to read refractive index data in various formats.  See SellmeierFit.read() for the details of available keyword arguments.","category":"page"},{"location":"tutorials/#From-a-CSV-file","page":"Tutorials","title":"From a CSV file","text":"","category":"section"},{"location":"tutorials/","page":"Tutorials","title":"Tutorials","text":"Suppose a CSV file named refindex.csv in the present working directory contains wavelengths λ in units of µm and the corresponding refractive indices n as the first and second columns, respectively.  The following code stores wavelengths in units of meters (not µm) and dielectric constants in variables λ and ε via property destructuring of NamedTuple:","category":"page"},{"location":"tutorials/","page":"Tutorials","title":"Tutorials","text":"(; λ, ε) = SellmeierFit.read(\"refindex.csv\")","category":"page"},{"location":"tutorials/","page":"Tutorials","title":"Tutorials","text":"λ and ε can be equally obtained by","category":"page"},{"location":"tutorials/","page":"Tutorials","title":"Tutorials","text":"result = SellmeierFit.read(\"refindex.csv\")\nλ = result.λ\nε = result.ε","category":"page"},{"location":"tutorials/","page":"Tutorials","title":"Tutorials","text":"or","category":"page"},{"location":"tutorials/","page":"Tutorials","title":"Tutorials","text":"result = SellmeierFit.read(\"refindex.csv\")\nλ = result[1]\nε = result[2]","category":"page"},{"location":"tutorials/","page":"Tutorials","title":"Tutorials","text":"Only the first method using property destructuring will be discussed in the following sections, but the other methods are applicable there as well.","category":"page"},{"location":"tutorials/#From-a-text-file","page":"Tutorials","title":"From a text file","text":"","category":"section"},{"location":"tutorials/","page":"Tutorials","title":"Tutorials","text":"Suppose a text file named refindex.txt contains wavelengths in units of µm and the corresponding refractive indices as follows:","category":"page"},{"location":"tutorials/","page":"Tutorials","title":"Tutorials","text":"Refractive Index\nwl \tn\n0.21\t1.53835762\n0.2174\t1.530846431\n0.2251\t1.524078907\n0.233\t1.518041768\n0.2412\t1.512572116\n...","category":"page"},{"location":"tutorials/","page":"Tutorials","title":"Tutorials","text":"In this case, the information that the first two lines of the file are a header needs to be provided to SellmeierFit.read():","category":"page"},{"location":"tutorials/","page":"Tutorials","title":"Tutorials","text":"(; λ, ε) = SellmeierFit.read(path, header=2)","category":"page"},{"location":"tutorials/#From-a-website","page":"Tutorials","title":"From a website","text":"","category":"section"},{"location":"tutorials/","page":"Tutorials","title":"Tutorials","text":"Websites such as RefractiveIndex.info provide refractive index data of various materials in CSV format.  The link to these data files can be directly passed to SellmeierFit.read():","category":"page"},{"location":"tutorials/","page":"Tutorials","title":"Tutorials","text":"(; λ, ε) = SellmeierFit.read(\"https://refractiveindex.info/tmp/data/main/SiO2/Malitson.csv\")","category":"page"},{"location":"tutorials/#Fitting-data-to-the-Sellmeier-equation","page":"Tutorials","title":"Fitting data to the Sellmeier equation","text":"","category":"section"},{"location":"tutorials/","page":"Tutorials","title":"Tutorials","text":"Once you have a vector λ of wavelengths in units of meters and a vector ε of dielectric constants, fitting these data to the Sellmeier equation is performed by","category":"page"},{"location":"tutorials/","page":"Tutorials","title":"Tutorials","text":"(; mdl, err) = fit_sellmeier(λ, ε)","category":"page"},{"location":"tutorials/","page":"Tutorials","title":"Tutorials","text":"Here, mdl is an instance of SellmeierModel that has str and λres as fields; they represent the strengths and resonance wavelengths of the terms in the Sellmeier equation, and correspond to B_i's and sqrtC_i's, resectively.  err is the root-mean-square error of the entries of ε with respect to the fitting Sellmeier equation.","category":"page"},{"location":"tutorials/#Concrete-examples","page":"Tutorials","title":"Concrete examples","text":"","category":"section"},{"location":"tutorials/","page":"Tutorials","title":"Tutorials","text":"Concrete example scripts are included in the example/ directory.  Here is the plot generated by example/from_csv.jl:","category":"page"},{"location":"tutorials/","page":"Tutorials","title":"Tutorials","text":"save(\"SiO₂.png\", fig)  # hide\nnothing  # hide","category":"page"},{"location":"tutorials/","page":"Tutorials","title":"Tutorials","text":"(Image: SiO₂)","category":"page"},{"location":"tutorials/","page":"Tutorials","title":"Tutorials","text":"Note that the fitting Sellmeier equation passes through all the data points almost exactly.  The calculated fitting parameters as shown in the output of example/from_csv.jl are","category":"page"},{"location":"tutorials/","page":"Tutorials","title":"Tutorials","text":"println(\"B = $(mdl.str)\")  # hide\nprintln(\"√C = $(mdl.λres ./ micro)\")  # hide","category":"page"},{"location":"tutorials/","page":"Tutorials","title":"Tutorials","text":"and agree well with the values shown in the Dispersion formula section here.","category":"page"},{"location":"#SellmeierFit.jl","page":"Home","title":"SellmeierFit.jl","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Julia package to fit lossless refractive index data to the Sellmeier equation.","category":"page"},{"location":"#Overview-of-the-Sellmeier-equation","page":"Home","title":"Overview of the Sellmeier equation","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"The Sellmeier equation is a widely used equation describing refractive index n as a function of wavelength λ.  It is used in the wavelength range where the material is lossless (i.e., k(λ) = 0 for complex refractive index n(λ) - ⅈ  k(λ)).  The equation is typically expressed as","category":"page"},{"location":"","page":"Home","title":"Home","text":"ε_mathrmr(λ) = n(λ)^2 = 1 + sum_i fracB_i  λ^2λ^2 - C_i","category":"page"},{"location":"","page":"Home","title":"Home","text":"where ε_mathrmr(λ) equiv ε(λ)  ε_0 is relative electric permittivity, also known as dielectric constant.","category":"page"},{"location":"","page":"Home","title":"Home","text":"The Wikipedia article claims that the Sellmeier equation is just an empirical relationship, but in fact it has a theoretical foundation.  Assume that the material of interest consists of electrons bound to positively charged ions.  We can imagine that the ions generate multiple stationary equilibrium sites indexed i for the electrons (e.g., depending on electron orbitals).  Around these equilibrium sites, harmonic potentials characterized by natural angular frequencies ω_i of oscillation are created.  Suppose that the damping coefficient of motion is Γ_i for the ith equilibrium site.  Then, for an external E-field oscillating at an angular frequency ω, we can solve the equation of motion as dictated by Newton's second law.  The solution describes the electron displacement from the equilibrium positions.  The displacement induces polarization density, from which dielectric constant is calculated.  ","category":"page"},{"location":"","page":"Home","title":"Home","text":"The above microscopic picture describing the interaction between an external E-field and material is called the Lorentz model, and the resulting expression for dielectric constant is","category":"page"},{"location":"","page":"Home","title":"Home","text":"ε_mathrmr(ω) = 1 + sum_ifracω_mathrmpi^2ω_0i^2 - ω^2 + ⅈ  ω  Γ_i","category":"page"},{"location":"","page":"Home","title":"Home","text":"where ω_mathrmpi = sqrtn_i  q_mathrme^2  m_mathrme  ε_0 is plasma frequency determined by electron density n_i associated with the ith equilibrium site, electron charge q_mathrme, and electron mass m_mathrme.  (The plus sign in front of ⅈ  ω  Γ_i in the denominator is when the harmonic time dependence of the external E-field is e^+ⅈ  ω  t; if the time dependence is e^-ⅈ  ω  t, the minus sign is used.)","category":"page"},{"location":"","page":"Home","title":"Home","text":"The Sellmeier equation is the simplification of the Lorentz model in the regime where damping can be ignored such that refractive index becomes lossless.  This happens when ω  Γ_i, for which we have","category":"page"},{"location":"","page":"Home","title":"Home","text":"ε_mathrmr(ω)  1 + sum_ifracω_mathrmpi^2ω_0i^2 - ω^2","category":"page"},{"location":"","page":"Home","title":"Home","text":"This is exactly of the form of the Sellmeier equation as ω = 2πc_0  λ.  Therefore, the Sellmeier equation is nothing but the Lorentz model in the lossless regime.","category":"page"},{"location":"#Fitting-data-to-the-Sellmeier-equation","page":"Home","title":"Fitting data to the Sellmeier equation","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Even though the Sellmeier equation is widely used formula to which refractive indices are fitted, the author found that finding the coefficients B_i and C_i was not straightforward.  The author tried LsqFit.jl, but some reasonable initial guesses for these parameters didn't produce a successful fit.","category":"page"},{"location":"","page":"Home","title":"Home","text":"After several attempts, the author realized that it is crucial to recognize that the Sellmeier equation is the lossless version of the Lorentz model as described earlier.  In the Lorentz model, ω = ω_0i is the resonance frequency around which loss is maximized.  Because the Sellmeier equation is used for a range of ω for which the material is lossless, ω = ω_0i, or λ = sqrtC_i equivalently, should lie outside the spectral range of the measured refractive indices.  Therefore, good initial guesses for sqrtC_i should be placed outside the wavelength range of measurement.  Once this condition is satisfied, simple application of LsqFit.jl produces a successful fit.","category":"page"},{"location":"","page":"Home","title":"Home","text":"The only remaining question is how many sqrtC_i's to put below the wavelength range of measurement and how many above.  SellmeierFit.jl automatically tries all combinations of the numbers of sqrtC_i's below and above the wavelength range of measurement and chooses the best fit with the minimum number of terms.","category":"page"}]
}

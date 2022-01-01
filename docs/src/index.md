# SellmeierFit.jl

*A Julia package for fitting measured refractive indices of a material to the Sellmeier equation.*

## Overview of the Sellmeier equation
The Sellmeier equation is a widely used equation describing refractive index ``n`` as a function of wavelength ``λ``.  It is used in the wavelength range where the material is lossless (i.e., ``k(λ) = 0`` for complex refractive index ``n(λ) - i \, k(λ)``).  The equation is typically expressed as
```math
ε_\mathrm{r}(λ) = n(λ)^2 = 1 + \sum_{i} \frac{B_i \, λ^2}{λ^2 - C_i},
```
where ``ε_\mathrm{r}(λ) \equiv ε(λ) / ε_0`` is relative electric permittivity, also known as dielectric constant.

The [Wikipedia article](https://en.wikipedia.org/wiki/Sellmeier_equation) claims that the Sellmeier equation is just an empirical relationship, but in fact it has a theoretical foundation.  Assume that the material of interest consists of electrons bound to positively charged ions.  We can imagine that the ions generate multiple stationary equilibrium sites indexed ``i`` for the electrons (e.g., depending on electron orbitals).  Around these equilibrium sites, harmonic potentials characterized by natural angular frequencies ``ω_i`` of oscillation are created.  Suppose that the damping coefficient of motion is ``Γ_i`` for the ``i``th equilibrium site.  Then, for an external _E_-field oscillating at an angular frequency ``ω``, we can solve the equation of motion as dictated by Newton's second law.  The solution describes the electron displacement from the equilibrium positions.  The displacement induces polarization density, from which dielectric constant is calculated.  

The above microscopic picture describing the interaction between an external _E_-field and material is called the *Lorentz model*, and the resulting expression for dielectric constant is
```math
ε_\mathrm{r}(ω) = 1 + \sum_{i}\frac{ω_{\mathrm{p},i}^2}{ω_{0,i}^2 - ω^2 + i \, ω \, Γ_i},
```
where ``ω_{\mathrm{p},i} = \sqrt{n_i \, q_\mathrm{e}^2 / m_\mathrm{e} \, ε_0}`` is plasma frequency determined by electron density ``n_i`` associated with the ``i``th equilibrium site, electron charge ``q_\mathrm{e}``, and electron mass ``m_\mathrm{e}``.  (The plus sign in front of ``i \, ω \, Γ_i`` in the denominator is when the harmonic time dependence of the external _E_-field is ``e^{+i \, ω \, t}``; if the time dependence is ``e^{-i \, ω \, t}``, the minus sign is used.)

The Sellmeier equation is the simplification of the Lorentz model in the regime where damping can be ignored such that refractive index becomes lossless.  This happens when ``ω ≫ Γ_i``, for which we have
```math
ε_\mathrm{r}(ω) ≈ 1 + \sum_{i}\frac{ω_{\mathrm{p},i}^2}{ω_{0,i}^2 - ω^2}.
```
This is exactly of the form of the Sellmeier equation as ``ω = 2πc_0 / λ``.  Therefore, the Sellmeier equation is nothing but the Lorentz model in the lossless regime.

## Fitting data to the Sellmeier equation
Even though the Sellmeier equation is widely used formula to which refractive indices are fitted, the author found that finding the coefficients ``B_i`` and ``C_i`` was not straightforward.  The author tried `LsqFit.jl`, but some reasonable initial guesses for these parameters didn't produce a successful fit.

After several attempts, the author realized that it is crucial to recognize that the Sellmeier equation is the lossless version of the Lorentz model as described earlier.  In the Lorentz model, ``ω = ω_{0,i}`` is the resonance frequency around which loss is maximized.  Because the Sellmeier equation is used for a range of ``ω`` for which the material is lossless, ``ω = ω_{0,i}``, or ``λ = \sqrt{C_i}`` equivalently, should lie outside the spectral range of the measured refractive indices.  Therefore, good initial guesses for ``\sqrt{C_i}`` should be placed outside the wavelength range of measurement.  Once this condition is satisfied, simple application of `LsqFit.jl` produces a successful fit.

The only remaining question is how many ``\sqrt{C_i}``'s to put below the wavelength range of measurement and how many above.  `SellmeierFit.jl` automatically tries all combinations of the numbers of ``\sqrt{C_i}``'s below and above the wavelength range of measurement and chooses the best fit with the minimum number of terms.

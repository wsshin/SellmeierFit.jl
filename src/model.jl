export SellmeierModel, sellmeier_model

struct SellmeierModel{N}
    str::SFloat{N}  # strength of terms; typically written str in equation
    λres::SFloat{N}  # resonance wavelength of terms; typically written √λres in equation
end

Base.length(sm::SellmeierModel{N}) where {N} = N

(sm::SellmeierModel)(λ::Real) = sellmeier_model(λ, sm.str, sm.λres)

# Returns the relative permittivity ε = n² at a wavelength λ following the Sellmeier model
# ε = 1 + ∑ᵢ [strᵢ λ² / (λ² - λresᵢ²)].
sellmeier_model(λ::Real, str::AbsVecReal, λres::AbsVecReal) =
    1.0 + mapreduce((strᵢ,λresᵢ) -> strᵢ * λ^2 / (λ^2 - λresᵢ^2), +, str, λres)

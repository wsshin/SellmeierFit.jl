export SellmeierModel, sellmeier_model

struct SellmeierModel{N}
    B::SFloat{N}
    C::SFloat{N}
end

Base.length(sm::SellmeierModel{N}) where {N} = N

(sm::SellmeierModel)(λ::Real) = sellmeier_model(λ, sm.B, sm.C)

# Returns the relative permittivity ε = n² at a wavelength λ following the Sellmeier model
# ε = 1 + ∑ᵢ [Bᵢ λ² / (λ² - Cᵢ²)].
sellmeier_model(λ::Real, B::AbsVecReal, C::AbsVecReal) =
    1.0 + mapreduce((Bᵢ,Cᵢ) -> Bᵢ * λ^2 / (λ^2 - Cᵢ^2), +, B, C)

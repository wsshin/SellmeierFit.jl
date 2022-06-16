export SellmeierModel, sellmeier_model


"""
    SellmeierModel{N}

Sellmeier model representing the Sellmeier equation ε(λ) = 1 + ∑ᵢ [Bᵢ λ² / (λ² - Cᵢ)], where
the sum is for `1 ≤ i ≤ N`.

# Fields
- `str::SVector{N,Float64}`: `str[i]` is the strength of the `i`th term in the Sellmeier equation; corresponds to Bᵢ.
- `λres::SVector{N,Float64}`: `λres[i]` is the resonance wavelength of the `i`th term in the Sellmeier equation; corresponds to √Cᵢ.
"""
struct SellmeierModel{N}
    str::SFloat{N}  # strength of terms; typically written str in equation
    λres::SFloat{N}  # resonance wavelength of terms; typically written √λres in equation

    SellmeierModel{N}(str::SReal{N}, λres::SReal{N}) where {N} = (p = sortperm(λres); new(str[p], λres[p]))
end

SellmeierModel(str::AbsVecReal, λres::AbsVecReal) = (N = length(str); SellmeierModel{N}(SFloat{N}(str), SFloat{N}(λres)))
SellmeierModel(εconst::Real) = (str = SFloat{1}(εconst-1); λres = SFloat{1}(0.0); SellmeierModel(str,λres))

"""
    Base.length(sm::SellmeierModel)

Return the number of terms in the sum of the Sellmeier equation represented by the given
`SellmeierModel`.
"""
Base.length(sm::SellmeierModel{N}) where {N} = N

"""
    (::SellmeierModel)(λ::Real)

Evaluate the Sellmeier equation represented by the given `SellmeierModel` at a wavelngth `λ`
in units of meters.
"""
(sm::SellmeierModel)(λ::Real) = sellmeier_model(λ, sm.str, sm.λres)

# Returns the relative permittivity ε = n² at a wavelength λ following the Sellmeier model.
# The fitting equation is ε (= n²) rather than n, because ε is sometimes evaluated negative
# during the optimization procedure; n = √ε is not defined for real negative ε.
sellmeier_model(λ::Real, str::AbsVecReal, λres::AbsVecReal) =
    1.0 + mapreduce((strᵢ,λresᵢ) -> strᵢ / (1.0 - (λresᵢ/λ)^2), +, str, λres)

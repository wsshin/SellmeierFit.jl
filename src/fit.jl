export fit_sellmeier

const GUESS_MARGIN = 0.05  # how much λres guesses are separated from range of measured λ

function has_similar(λres::AbsVecReal; rtol=1e-3)  # assume λres is sorted
    for i in eachindex(λres)[begin:end-1]
        isapprox(λres[i], λres[i+1]; rtol) && return true  # if poles are different by less than 0.1%, return true
    end

    return false
end

"""
    fit_sellmeier(λ::AbstractVector{<:Real}, ε::AbstractVector{<:Real}; Nmax::Integer=10, rtol_λres::Real=1e-3)

Fit the dielectric constant data `ε` sampled at wavelengths `λ` to the Sellmeier equation
with up to `Nmax` terms.  If `λres` of different terms have relative difference less than
`rtol_λres`, they are considered the same term and merged.
"""
fit_sellmeier(λ::AbsVecReal, ε::AbsVecReal; kwargs...) = fit_sellmeier(float(λ), float(ε); kwargs...)
function fit_sellmeier(λ::AbsVecFloat,  # wavelengths where ε was measured
                       ε::AbsVecFloat;  # measured relative permittivities (= squared refractive indices)
                       Nmax::Integer=10,  # maximum number of terms in Sellmeier equation
                       rtol_λres::Real=1e-3)  # relative tolerance to distinguish λres
    me = fit_sellmeier(λ, ε, Val(1))  # me: model and error
    for N = 2:Nmax
        me′ = fit_sellmeier(λ, ε, Val(N))
        if me′.err > me.err  # if more terms than necessary are used, error starts to increase
            break
        elseif has_similar(me′.mdl.λres; rtol=rtol_λres)  # terms with similar poles are unnecessary
            break
        else
            me = me′
        end
    end

    return me
end

"""
    fit_sellmeier(λ::AbstractVector{<:Real}, ε::AbstractVector{<:Real}, N::Integer)

Fit the dielectric constant data `ε` sampled at wavelengths `λ` to the Sellmeier equation
with exactly `N` terms.  Among the `N` terms, some are below and the other are above the
range of `λ`.
"""
fit_sellmeier(λ::AbsVecReal, ε::AbsVecReal, N::Integer) = fit_sellmeier(λ, ε, Val(N))
fit_sellmeier(λ::AbsVecReal, ε::AbsVecReal, ::Val{N}) where {N} = fit_sellmeier(float(λ), float(ε), Val(N))
function fit_sellmeier(λ::AbsVecFloat,  # wavelengths where ε was measured
                       ε::AbsVecFloat,  # measured relative permittivities (= squared refractive indices)
                       ::Val{N}  # number of terms in Sellmeier model
                       ) where {N}
    local me
    err_min = Inf
    for Nₙ = 0:N
        Nₚ = N - Nₙ
        me′ = fit_sellmeier(λ, ε, Nₙ, Nₚ)
        if me′.err < err_min
            err_min = me′.err
            me = me′
        end
    end

    return me
end

"""
    fit_sellmeier(λ::AbstractVector{<:Real}, ε::AbstractVector{<:Real}, Nₙ::Integer, Nₚ::Integer)

Fit the dielectric constant data `ε` sampled at wavelengths `λ` to the Sellmeier equation
with exactly `Nₙ` terms below and `Nₚ` terms above the range of `λ`.
"""
fit_sellmeier(λ::AbsVecReal, ε::AbsVecReal, Nₙ::Integer, Nₚ::Integer) = fit_sellmeier(float(λ), float(ε), Nₙ, Nₚ)
function fit_sellmeier(λ::AbsVecFloat,
                       ε::AbsVecFloat,
                       Nₙ::Integer,  # number of terms with poles below λ range
                       Nₚ::Integer)  # number of terms with poles above λ range
    issorted(λ) || @error "λ = $λ should be sorted."

    N = Nₙ + Nₚ

    # Normaize λ.
    λₙ, λₚ = λ[1], λ[end]
    λ₀ = √(λₙ*λₚ)
    λnorm = λ ./ λ₀
    Nλ = length(λ)

    # Create guess parameters.
    cₙ, cₚ = (1-GUESS_MARGIN)λnorm[1], (1+GUESS_MARGIN)λnorm[end]

    p₀mat = ones(N,2)
    p₀mat[1:Nₙ,2] .= cₙ
    p₀mat[Nₙ+1:end,2] .= cₚ
    p₀ = reshape(p₀mat, :)

    # Perform fitting.
    fit = curve_fit((λ,p)->(BC = reshape(p,:,2);
                            str = Ref(@view(BC[:,1]));
                            λres = Ref(@view(BC[:,2]));
                            sellmeier_model.(λ, str, λres)),
                    λnorm, ε, p₀)

    str = @view(fit.param[1:N])  # entries of str are dimensionless, so no need to unnormalize them
    λres = @view(fit.param[N+1:2N]) .* λ₀  # entries of λres are wavelengths, so unnormalize them
    err = sqrt(sum(abs2, fit.resid) / Nλ)  # RMS error

    mdl = SellmeierModel(str, λres)

    return (; mdl, err)
end

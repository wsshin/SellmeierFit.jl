export sellmeier_model, fit_sellmeier

const GUESS_MARGIN = 0.05

sellmeier_model(λ::Real, B::AbsVecReal, C::AbsVecReal) =
    1.0 + mapreduce((Bᵢ,Cᵢ) -> Bᵢ * λ^2 / (λ^2 - Cᵢ^2), +, B, C)  # ε

function fit_sellmeier(λ::AbsVecFloat,  # wavelengths where ε was measured
                       ε::AbsVecFloat,  # measured relative permittivities (= squared refractive indices)
                       N::Integer)  # number of terms in Sellmeier model
    Nλ = length(λ)

    # Normaize λ.
    λₙ, λₚ = λ[1], λ[end]
    λ₀ = √(λₙ*λₚ)
    λnorm = λ ./ λ₀

    err_min = Inf
    B, C = zeros(N), zeros(N)
    for Nₙ = 0:N
        Nₚ = N - Nₙ
        fit = fit_sellmeier_impl(λnorm, ε, Nₙ, Nₚ)
        err = sqrt(sum(abs2, fit.resid) / Nλ)
        if err < err_min
            B .= @view(fit.param[1:N])  # entries of B are dimensionless, so no need to unnormalize them
            C .= @view(fit.param[N+1:2N]) .* λ₀  # entries of C are wavelengths, so unnormalize them
            err_min = err
        end
    end

    return (B=B, C=C, err=err_min)
end

function fit_sellmeier_impl(λnorm::AbsVecFloat, ε::AbsVecFloat,
                            Nₙ::Integer,  # number of terms with poles below λ range
                            Nₚ::Integer)  # number of terms with poles above λ range
    issorted(λnorm) || @error "λnorm = $λnorm should be sorted."

    N = Nₙ + Nₚ

    # Create guess parameters.
    cₙ, cₚ = (1-GUESS_MARGIN)λnorm[1], (1+GUESS_MARGIN)λnorm[end]

    p₀mat = ones(N,2)
    p₀mat[1:Nₙ,2] .= cₙ
    p₀mat[Nₙ+1:end,2] .= cₚ
    p₀ = reshape(p₀mat, :)

    # Perform fitting.
    fit = curve_fit((λ,p)->(BC = reshape(p,:,2);
                            B = Ref(@view(BC[:,1]));
                            C = Ref(@view(BC[:,2]));
                            sellmeier_model.(λ, B, C)),
                    λnorm, ε, p₀)

    return fit
end

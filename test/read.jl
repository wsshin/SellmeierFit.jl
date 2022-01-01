@testset "read" begin
    dir = @__DIR__
    file = joinpath(dir,  "..", "example", "data", "Malitson.csv")
    r0 = SellmeierFit.read(file, unit_prefix=1.0)

    r1 = SellmeierFit.read(file, unit_prefix=1.0, s_col=2, n_col=1)
    @test (r1.λ .^2 == sort(r0.ε)) && (sort(r1.ε) == r0.λ .^ 2)

    r2 = SellmeierFit.read(file)
    @test (r2.λ == micro .* r0.λ) && r2.ε==r0.ε

    r3 = SellmeierFit.read(file, s_var=FREQUENCY, unit_prefix=1.0)
    @test (r3.λ == reverse(c₀ ./ r0.λ)) && (r3.ε == reverse(r0.ε))

    r4 = SellmeierFit.read(file, s_var=ENERGY, unit_prefix=1.0)
    @test (r4.λ == reverse(ℎc₀ ./ r0.λ)) && (r4.ε == reverse(r0.ε))
end  # @testset "read"

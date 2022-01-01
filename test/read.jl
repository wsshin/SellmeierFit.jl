@testset "read" begin
    dir = @__DIR__
    file = joinpath(dir,  "..", "example", "data", "Malitson.csv")
    d0 = SellmeierFit.read(file, unit_prefix=1.0)

    d1 = SellmeierFit.read(file, unit_prefix=1.0, s_col=2, n_col=1)
    @test (d1.λ .^2 == sort(d0.ε)) && (sort(d1.ε) == d0.λ .^ 2)

    d2 = SellmeierFit.read(file)
    @test (d2.λ == micro .* d0.λ) && d2.ε==d0.ε

    d3 = SellmeierFit.read(file, s_var=FREQUENCY, unit_prefix=1.0)
    @test (d3.λ == reverse(c₀ ./ d0.λ)) && (d3.ε == reverse(d0.ε))

    d4 = SellmeierFit.read(file, s_var=ENERGY, unit_prefix=1.0)
    @test (d4.λ == reverse(ℎc₀ ./ d0.λ)) && (d4.ε == reverse(d0.ε))
end  # @testset "read"

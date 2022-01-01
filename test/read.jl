@testset "read" begin
    dir = @__DIR__
    file = joinpath(dir,  "..", "example", "data", "Malitson.csv")

    d0 = SellmeierFit.read(file)
    d1 = SellmeierFit.read(file, unit_prefix=1.0)
    @test (d0.λ == micro .* d1.λ) && d0.ε==d1.ε

    d2 = SellmeierFit.read(file, unit_prefix=1.0, s_col=2, n_col=1)
    @test (d2.λ .^2 == sort(d1.ε)) && (sort(d2.ε) == d1.λ .^ 2)

    d3 = SellmeierFit.read(file, s_var=FREQUENCY)
    @test (d3.λ == reverse(c₀ ./ d0.λ)) && (d3.ε == reverse(d0.ε))

    d4 = SellmeierFit.read(file, s_var=ENERGY)
    @test (d4.λ == reverse(ℎc₀ ./ d0.λ)) && (d4.ε == reverse(d0.ε))

    url = "https://refractiveindex.info/tmp/data/main/SiO2/Malitson.csv"
    try
        d5 = SellmeierFit.read(url)
        @test d5 == d0
    catch e
        @test e isa Downloads.RequestError
    end
end  # @testset "read"

@testset "fit" begin
    dir = @__DIR__
    file = joinpath(dir,  "..", "example", "data", "Malitson.csv")
    data = SellmeierFit.read(file)

    (; mdl, err) = fit_sellmeier(data.λ, data.ε)
    @test err ≤ 1e-13

    mdl1 = fit_sellmeier(data.λ, data.ε, Val(3)).mdl
    @test mdl1 == mdl

    mdl2 = fit_sellmeier(data.λ, data.ε, 2, 1).mdl
    @test mdl2 == mdl
end  # @testset "fit"

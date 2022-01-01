@testset "model" begin
    N = 10
    sm = SellmeierModel(rand(N), rand(N))

    @test length(sm) == N
    @test sm(0.0) == 1.0
    @test sm(Inf) == 1.0 + sum(sm.str)
end  # @testset "model"

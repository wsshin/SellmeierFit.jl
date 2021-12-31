using Documenter, SellmeierFit

makedocs(
    modules = [SellmeierFit],
    format = Documenter.HTML(; prettyurls = get(ENV, "CI", nothing) == "true"),
    authors = "Wonseok Shin",
    sitename = "SellmeierFit.jl",
    pages = Any[
        "Home" => "index.md"
        "Tutorials" => "tutorial.md"
        "Types and Functions" => "type_fun.md"
    ]
    # strict = true,
    # clean = true,
    # checkdocs = :exports,
)

deploydocs(
    repo = "github.com/wsshin/SellmeierFit.jl.git",
    devbranch = "main",  # see https://github.com/JuliaDocs/Documenter.jl/issues/1443#issuecomment-735905544
    push_preview = true
)

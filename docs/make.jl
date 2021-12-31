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
    push_preview = true
)

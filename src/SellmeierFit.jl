module SellmeierFit

using LsqFit
using CSV, DataFrames, Downloads  # used in util.jl
using AbbreviatedTypes
using SimpleConstants

include("util.jl")
include("fit.jl")

end # module

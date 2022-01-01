module SellmeierFit

using LsqFit
using CSV, DataFrames, Downloads  # used in read.jl
using AbbreviatedTypes
using SimpleConstants

include("read.jl")
include("model.jl")
include("fit.jl")

end # module

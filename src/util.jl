@enum DomainType WAVELENGTH FREQUENCY ENERGY

# Read a file containing λ and n as the first and second column, and return them.
function read(uri::String;  # location of CSV file containing λ, n, and possibly k columns
              dom_type::DomainType=WAVELENGTH,
              dom_unit::Real=micro,  # e.g., micro for μm; tera for THz; e⁺ for eV
              dom_col::Integer=1,  # column index of domain quantity
              n_col::Integer=2,  # column index of refractive index
              kwargs...)  # keyword arguments for CSV.read; can be used to read .txt
    if splitpath(uri)[1]=="https:"
        df = CSV.read(Downloads.download(uri), DataFrame; kwargs...)
    else
        df = CSV.read(uri, DataFrame; kwargs...)
    end

    num_col = size(df, 2)
    num_col≥2 || @error "Data at $uri contains $num_col columns, but should contain at least two columns corresponding to measurement domain λ and refractive index n."
    dom = df[:,dom_col] .* dom_unit
    n = df[:,n_col]
    ε = n.^2

    if dom_type==WAVELENGTH
        λ = dom
    elseif dom_type==FREQUENCY
        λ = c₀ ./ dom  # λ = c₀ / ν
    else  # dom_type==ENERGY
        λ = ℎc₀ ./ dom  # λ = c₀ / ν = hc₀ / hν = ℎc₀ / E
    end

    # If sorted in descending order, reverse it.
    issorted(λ) || issorted(λ, rev=true) || @error "λ = $λ should be sorted in ascending or descending order."
    if issorted(λ, rev=true)  # sorted in descending order
        reverse!(λ)
        reverse!(ε)
    end

    return (λ=λ, ε=ε)
end

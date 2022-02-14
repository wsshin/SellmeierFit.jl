"""
    SpectralVariable

Used to specify the type of the spectral variable which the refractive index is a function
of.  The available instances are `WAVELENGTH` for wavelength, `FREQUENCY` for frequency, and
`ENERGY` for photon energy.
"""
@enum SpectralVariable WAVELENGTH FREQUENCY ENERGY
for ins in instances(SpectralVariable); @eval export $(Symbol(ins)); end  # export all instances

"""
    read(path::String; <keyword arguments>)

Read the refractive index file at `path`, and return the wavelength `λ` and the dielectric
constant vector `ε` as a named tuple.

# Keywords
- `s_var::SpectralVariable=WAVELENGTH`: `WAVELENGTH`, `FREQUENCY`, or `ENERGY` if the refractive index file describes refractive index as a function of wavelength, frequency, or photon energy.
- `unit_prefix::Real=micro`: the prefix to multiply to the values of the spectral variable to convert their units to the SI units.  For example, `1e-6` for wavelengths in units of µm; `1.602176643` for photon energies in units of eV.
- `s_col::Integer=1`: the index of the spectral variable column in the refractive index file.
- `n_col::Integer=2`: the index of the refractive index column in the refractive index file.
- `kwargs...`: the keyword arguments to pass to `CSV.read()`
"""
function read(path::String;  # location of CSV file containing λ, n, and possibly k columns
              s_var::SpectralVariable=WAVELENGTH,
              unit_prefix::Real=micro,  # e.g., micro for μm; tera for THz; e⁺ for eV
              s_col::Integer=1,  # column index of spectral variable
              n_col::Integer=2,  # column index of refractive index
              kwargs...)  # keyword arguments for CSV.read; can be used to read .txt
    local df
    if splitpath(path)[1]=="https:"
        try
            print("First attempt to download from $path...  ")
            df = CSV.read(Downloads.download(path), DataFrame; kwargs...)
            println("Succeeds!")
        catch
            try
                println("Fails.")
                print("Second attempt to download from $path...  ")
                df = CSV.read(Downloads.download(path), DataFrame; kwargs...)
                println("Succeeds!")
            catch
                try
                    println("Fails.")
                    print("Final attempt to download from $path...  ")
                    df = CSV.read(Downloads.download(path), DataFrame; kwargs...)
                    println("Succeeds!")
                catch e
                    println("Fails.")
                    throw(e)
                end
            end
        end
    else
        df = CSV.read(path, DataFrame; kwargs...)
    end

    num_col = size(df, 2)
    num_col≥2 || @error "Data at $path contains $num_col columns, but should contain at least two columns corresponding to spectral variable λ and refractive index n."
    s = df[:,s_col] .* unit_prefix
    n = df[:,n_col]
    ε = n.^2

    if s_var==WAVELENGTH
        λ = s
    elseif s_var==FREQUENCY  # s = ν
        λ = c₀ ./ s  # λ = c₀ / ν
    else  # s_var==ENERGY; s = E
        λ = ℎc₀ ./ s  # λ = c₀ / ν = hc₀ / hν = ℎc₀ / E
    end

    # If sorted in descending order, reverse it.
    issorted(λ) || issorted(λ, rev=true) || @error "λ = $λ should be sorted in ascending or descending order."
    if issorted(λ, rev=true)  # sorted in descending order
        reverse!(λ)
        reverse!(ε)
    end

    return (; λ, ε)
end

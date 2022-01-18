# SellmeierFit.jl

*Julia package to fit lossless refractive index data to the Sellmeier equation*

| **Documentation** | **Build Status** |
|:-----------------:|:----------------:|
| [![**STABLE**][docs-stable-img]][docs-stable-url] [![**DEV**][docs-dev-img]][docs-dev-url] | [![Build Status][CI-img]][CI-url] [![Code Coverage][codecov-img]][codecov-url] |

[docs-stable-img]: https://img.shields.io/badge/docs-stable-blue.svg
[docs-stable-url]: https://wsshin.github.io/SellmeierFit.jl/stable
[docs-dev-img]: https://img.shields.io/badge/docs-dev-blue.svg
[docs-dev-url]: https://wsshin.github.io/SellmeierFit.jl/dev

[CI-img]: https://github.com/wsshin/SellmeierFit.jl/workflows/CI/badge.svg
[CI-url]: https://github.com/wsshin/SellmeierFit.jl/actions

[codecov-img]: http://codecov.io/github/wsshin/SellmeierFit.jl/coverage.svg?branch=main
[codecov-url]: http://codecov.io/github/wsshin/SellmeierFit.jl?branch=main

**SellmeierFit** reads the refractive index data of a lossless material and calculates the optimal fitting [Sellmeier equation](https://en.wikipedia.org/wiki/Sellmeier_equation).  The main contributions of the package are

- the determination of good initial guesses of the Sellmeier equation parameters considering the material is lossless, and
- the determination of the optimal number of terms in the Sellmeier equation.

With these, the optimization itself is carried out by the [`LsqFit.jl`](https://github.com/JuliaNLSolvers/LsqFit.jl) package.

The following is the plot generated by one of the example scripts in `example/`, visually demonstrating the performance of `SellmeierFit`.  See the [documentation](https://wsshin.github.io/SellmeierFit.jl/stable) for the details of the implementation and usage.

![SiO₂](https://wsshin.github.io/SellmeierFit.jl/dev/SiO₂.png)

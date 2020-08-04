using Math3210
using Documenter

makedocs(;
    modules=[Math3210],
    authors="Andrew Irwin",
    repo="https://github.com/AndrewIrwin/Math3210.jl/blob/{commit}{path}#L{line}",
    sitename="Math3210.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://AndrewIrwin.github.io/Math3210.jl",
        assets=String[],
    ),
    pages=[
        # "Home" => "index.md",
        # "Welcome" => "01-welcome.md",
        # "Numbers" => "02-numbers.md",
        # "Intro to Julia" => "03-introduction-to-julia.jmd",
        # "Root Finding Overview" => "10-root-finding-overview.md",
        # "Root Finding Bisection" => "11-root-finding-bisection.md",
        # "Root Finding Fixed points" => "12-root-finding-fixed-points.jmd"
    ],
)

deploydocs(;
    repo="github.com/AndrewIrwin/Math3210.jl",
)

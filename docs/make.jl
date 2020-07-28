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
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/AndrewIrwin/Math3210.jl",
)

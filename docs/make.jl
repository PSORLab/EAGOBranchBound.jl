using Documenter, EAGOBranchBound

makedocs(# options
         modules = [EAGOBranchBound],
         doctest=true)

         deploydocs(deps   = Deps.pip("mkdocs", "python-markdown-math"),
         repo = "github.com/MatthewStuber/EAGOBranchBound.jl.git",
         julia  = "0.6.0",
         osname = "linux"))

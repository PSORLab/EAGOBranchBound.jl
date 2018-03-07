using Documenter, EAGOBranchBound

makedocs(modules=[EAGOBranchBound],
         doctest=false, clean=true,
         format =:markdown,
         sitename="EAGO.jl",
         authors="Matthew Wilhelm",
         pages = Any[
         "Home" => "index.md",
         "Tutorials" => Any[
           "tutorials/page1.md",
           "tutorials/page2.md",
           "tutorials/page3.md"
         ],
         "EAGOBranchBound" => Any[
           "userdocs/page1.md",
         ]
         ])

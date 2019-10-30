using Test
using Random, Printf
using GRUtils

Random.seed!(111)
examplesdir = joinpath(dirname(pathof(GRUtils)), "../examples/docstrings")

GRUtils.GR.inline("pdf")

functionlist = (
    ("Line plots", ("plot", "oplot", "stair", "plot3", "polar")),
    ("Scatter plots", ("scatter", "scatter3")),
    ("Stem plots", ("stem",)),
    ("Bar plots", ("barplot",)),
    ("Vector fields", ("quiver", "quiver3")),
    ("Histograms", ("histogram", "polarhistogram", "hexbin")),
    ("Contour plots", ("contour", "contourf", "tricont")),
    ("Surface plots", ("surface", "trisurf", "wireframe")),
    ("Volume rendering", ("volume",)),
    ("Heatmaps", ("heatmap", "polarheatmap", "shade")),
    ("Images", ("imshow",)),
    ("Isosurfaces", ("isosurface",)),
    ("Attributes", ("aspectratio", "ticks")),
    ("Control", ("subplot",)),
    ("Colors", ("colorscheme", "colormap"))
)

# GR.gr3 has an issue in some systems
win = Sys.iswindows()
in_gr3 = ("surface", "volume", "shade", "isosurface")

#Plotting functions
@testset "$(functionlist[g][1])" for g in 1:length(functionlist)
    funs = functionlist[g][2]
    for f in funs
        if f ∉ in_gr3
            include(joinpath(examplesdir, "$f.jl"))
            @test true
        end
    end
end

file_path = ENV["GKS_FILEPATH"]
@test isfile(file_path)
GRUtils.GR.reset()
rm(file_path)

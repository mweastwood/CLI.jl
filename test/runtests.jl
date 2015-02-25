using CLI
using Base.Test

run(`julia testprogram.jl command1 --foo foo1 foo2 --bar 1 2 3 4`)


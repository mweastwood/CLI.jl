using CLI
using Base.Test

import TestProgram
@test TestProgram.parse_args(["command1","--foo","foo1","foo2","--bar","1","2","3","4"]) == ("command1",Dict{UTF8String,Any}("--foo"=>["foo1","foo2"],"--bar"=>[1,2,3,4]))
run(`julia testprogram.jl command1 --foo foo1 foo2 --bar 1 2 3 4`)


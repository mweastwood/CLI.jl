using CLI
using Base.Test
include("TestProgram.jl")

function test_is_equal(args,expected_result)
    expected_command,expected_args = expected_result
    command,parsed_args = TestProgram.parse_args(args)

    @test expected_command == command
    for key in keys(expected_args)
        @test haskey(parsed_args,key)
        @test expected_args[key] == parsed_args[key]
    end
    for key in keys(parsed_args)
        @test haskey(expected_args,key)
    end
end

args = ["command1","--foo","foo1","foo2",
                   "--bar","1","2","3","4",
                   "--required-flag"]
parsed_args = ("command1",
               Dict{UTF8String,Any}("--foo"=>UTF8String["foo1","foo2"],
                                    "--bar"=>[1,2,3,4],
                                    "--required-flag"=>nothing))
test_is_equal(args,parsed_args)

# Float parsing
args = ["command1","--foo","foo1","foo2",
                   "--bar","1","2","3","4",
                   "--required-flag",
                   "--float","1.2345"]
parsed_args = ("command1",
               Dict{UTF8String,Any}("--foo"=>UTF8String["foo1","foo2"],
                                    "--bar"=>[1,2,3,4],
                                    "--required-flag"=>nothing,
                                    "--float"=>1.2345))
test_is_equal(args,parsed_args)

# Missing required arguments
args = ["command1","--foo","foo1","foo2",
                   "--bar","1","2","3","4"]
@test_throws ErrorException TestProgram.parse_args(args)

# Wrong type
args = ["command1","--foo","foo1","foo2",
                   "--bar","1","2","3","4",
                   "--required-flag",
                   "--float","hello"]
@test_throws ErrorException TestProgram.parse_args(args)

# Unknown flag
args = ["command1","--foo","foo1","foo2",
                   "--bar","1","2","3","4",
                   "--required-flag",
                   "--unknown-flag"]
@test_throws ErrorException TestProgram.parse_args(args)

# Conflicting flags
args = ["command2","--flag-a"]
parsed_args = ("command2",Dict{UTF8String,Any}("--flag-a"=>nothing))
test_is_equal(args,parsed_args)

args = ["command2","--flag-b"]
parsed_args = ("command2",Dict{UTF8String,Any}("--flag-b"=>nothing))
test_is_equal(args,parsed_args)

args = ["command2","--flag-a","--flag-b"]
@test_throws ErrorException TestProgram.parse_args(args)

# Run from the command line
# (just to confirm this doesn't error)
run(`$JULIA_HOME/julia testprogram.jl command1 --foo foo1 foo2 --bar 1 2 3 4 --required-flag`)


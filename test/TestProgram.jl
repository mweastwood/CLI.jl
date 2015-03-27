module TestProgram

using CLI

CLI.set_name("testprogram.jl")
CLI.set_banner("""
    This is a test program for the CLI package.
    """)

CLI.print_banner()

push!(CLI.commands,Command("command1","Help text for command1."))
push!(CLI.commands,Command("command2","Help text for command2."))

CLI.options["command1"] = [
    Option("--foo","""
        A list of foos.""",
        UTF8String,true,1,Inf),
    Option("--bar","""
        A list of bars.""",
        Int,true,1,Inf),
    Option("--flag","""
        A flag.""",
        false),
    Option("--required-flag","""
        A required flag.""",
        true),
    Option("--float","""
        A float.""",
        Float64,false)]

CLI.options["command2"] = [
    Option("--flag-a","""
        Conflicts with --flag-b.""",
        Nothing,false,0,0,["--flag-b"]),
    Option("--flag-b","""
        Conflicts with --flag-a.""",
        Nothing,false,0,0,["--flag-a"])]

parse_args(args) = CLI.parse_args(args)

end


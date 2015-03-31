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
        T=UTF8String,
        required=true,
        min=1,
        max=Inf),
    Option("--bar","""
        A list of bars.""",
        T=Int,
        required=true,
        min=1,
        max=Inf),
    Option("--flag","""
        A flag."""),
    Option("--required-flag","""
        A required flag.""",
        required=true),
    Option("--float","""
        A float.""",
        T=Float64,
        min=1,
        max=1)]

CLI.options["command2"] = [
    Option("--flag-a","""
        Conflicts with --flag-b.""",
        conflicts=["--flag-b"]),
    Option("--flag-b","""
        Conflicts with --flag-a.""",
        conflicts=["--flag-a"])]

parse_args(args) = CLI.parse_args(args)

end


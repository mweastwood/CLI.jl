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
        UTF8String,true,1,Inf)
    Option("--bar","""
        A list of bars.""",
        Int,true,1,Inf)]

CLI.options["command2"] = [
    Option("--foo","""
        A list of foos.""",
        UTF8String,true,1,Inf)
    Option("--bar","""
        A list of bars.""",
        Int,false,1,Inf)]

parse_args(args) = CLI.parse_args(args)

end


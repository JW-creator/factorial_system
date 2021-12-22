%%%-------------------------------------------------------------------
%%% @author DDLgame-Dev-01
%%% @copyright (C) 2021, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 14. Dec 2021 2:58 PM
%%%-------------------------------------------------------------------
{application, factorial_system, [
    {description, "Factorial Calculator"},
    {vsn, "2"},
    {modules, [factorial_client, factorial_system, factorial_logic, factorial_server, factorial_supervisor, database_server, database_logic]},
    {registered, [database_server, factorial_server]},
    {applications, [
        kernel,
        stdlib
        %%mnesia
    ]},
    {mod, {factorial_system, []}},
    {env, []}
]}.
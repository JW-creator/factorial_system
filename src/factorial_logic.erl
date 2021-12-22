%%%-------------------------------------------------------------------
%%% @author DDLgame-Dev-01
%%% @copyright (C) 2021, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 13. Dec 2021 3:43 PM
%%%-------------------------------------------------------------------
-module(factorial_logic).
-author("DDLgame-Dev-01").

%% ====================================================================
%% API functions
%% ====================================================================
-export([factorial_handler/0, factorial/2, factorial/3]).

%% ====================================================================
%% Private functions
%% ====================================================================

factorial(Int, Acc)
    when Int > 0 ->
    factorial(Int-1,Acc * Int);
factorial(0, Acc) ->
    Acc.

factorial(Int, Acc, IoDevice)
    when Int > 0 ->
    io:format(IoDevice, "Current Factorial Log: ~p~n",[Acc]),
    factorial(Int-1,Acc * Int,IoDevice);
factorial(0, Acc,IoDevice) ->
    io:format(IoDevice, "Factorial Results: ~p~n",[Acc]).

%% ====================================================================
%% Public functions
%% ====================================================================
factorial_handler() ->
    receive
        {factorial, Int}->
            io:format("Factorial for ~p is ~p ~n",[Int, factorial(Int, 1)]),
            factorial_handler();

        {factorialRecorder, Int, File}->
            {ok, IoDevice} = file:open(File, write),
            factorial(Int,1,IoDevice),
            io:format("Factorial Recorder Done. ~n",[]),
            file:close(IoDevice),
            factorial_handler();

    %% Everything else
        Other->
            io:format("Invalid Match for ~p~n" ,[Other]),
            factorial_handler()
    end.
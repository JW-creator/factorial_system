%%%-------------------------------------------------------------------
%%% @author DDLgame-Dev-01
%%% @copyright (C) 2021, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 13. Dec 2021 3:44 PM
%%%-------------------------------------------------------------------
-module(factorial_client).
-author("DDLgame-Dev-01").

%% API
-export([factorial/1, factorialRecorder/2]).
-export([storeComments/2,getComment/1,getCommentWithStamp/1,deleteComment/1]).

factorial(Val)->
    factorial_server:factorial(Val).

factorialRecorder(Val,IoDevice) ->
    factorial_server:factorial(Val, IoDevice).

storeComments(NodeName,Comment) ->
    database_server:store(NodeName,Comment).

getComment(NodeName) ->
    database_server:getDB(NodeName).

getCommentWithStamp(NodeName) ->
    database_server:getDBTwo(NodeName).

deleteComment(NodeName) ->
    database_server:delete(NodeName).
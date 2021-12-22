%%%-------------------------------------------------------------------
%%% @author DDLgame-Dev-01
%%% @copyright (C) 2021, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 14. Dec 2021 10:52 AM
%%%-------------------------------------------------------------------
-module(factorial_supervisor).
-author("DDLgame-Dev-01").

-behaviour(supervisor).

%% API
-export([start_link/0, start_link_shell/0]).

%% Supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).

%%%===================================================================
%%% API functions
%%%===================================================================
start_link_shell() ->
    {ok, Pid} = supervisor:start_link({global, ?SERVER}, ?MODULE, []),
    unlink(Pid).

%% @doc Starts the supervisor
start_link() ->
    supervisor:start_link({global, ?SERVER}, ?MODULE, []).

%%%===================================================================
%%% Supervisor callbacks
%%%===================================================================

%% @private
%% @doc Whenever a supervisor is started using supervisor:start_link/[2,3],
%% this function is called by the new process to find out about
%% restart strategy, maximum restart frequency and child
%% specifications.
-spec(init(Args :: term()) ->
    {ok, {SupFlags :: {RestartStrategy :: supervisor:strategy(),
        MaxR :: non_neg_integer(), MaxT :: non_neg_integer()},
        [ChildSpec :: supervisor:child_spec()]}}
    | ignore | {error, Reason :: term()}).
init([]) ->
    MaxRestarts = 3,
    MaxSecondsBetweenRestarts = 5,
    SupFlags = #{strategy => one_for_all,
        intensity => MaxRestarts,
        period => MaxSecondsBetweenRestarts},

    AChild = #{id => factorialServerId,
        start => {factorial_server, start_link, []},
        restart => permanent,
        shutdown => infinity,
        type => worker,
        modules => [factorial_server]},

    MChild = #{id => mnesiaServerId,
        start => {database_server, start_link, []},
        restart => permanent,
        shutdown => infinity,
        type => worker,
        modules => [database_server]},

    {ok, {SupFlags, [AChild,MChild]}}.

%%%===================================================================
%%% Internal functions
%%%===================================================================

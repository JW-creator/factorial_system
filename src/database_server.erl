%%%-------------------------------------------------------------------
%%% @author DDLgame-Dev-01
%%% @copyright (C) 2021, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 22. Dec 2021 11:18 AM
%%%-------------------------------------------------------------------
-module(database_server).
-author("DDLgame-Dev-01").

-behaviour(gen_server).

%% API
-export([start_link/0]).

%% gen_server callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2,
    code_change/3]).

-export([store/2,getDB/1,getDBTwo/1,delete/1]).

-define(SERVER, ?MODULE).

-record(database_server_state, {}).

%%%===================================================================
%%% API
%%%===================================================================

%% @doc Spawns the server and registers the local name (unique)
-spec(start_link() ->
    {ok, Pid :: pid()} | ignore | {error, Reason :: term()}).
start_link() ->
    gen_server:start_link({global, ?SERVER}, ?MODULE, [], []).

store(NodeName, Comment) ->
    gen_server:call({global,?MODULE},{store,NodeName,Comment}).

getDB(NodeName) ->
    gen_server:call({global,?MODULE},{getDB,NodeName}).

getDBTwo(NodeName) ->
    gen_server:call({global,?MODULE},{getDBTwo,NodeName}).

delete(NodeName) ->
    gen_server:call({global,?MODULE},{delete,NodeName}).

%%%===================================================================
%%% gen_server callbacks
%%%===================================================================

%% @private
%% @doc Initializes the server
-spec(init(Args :: term()) ->
    {ok, State :: #database_server_state{}} | {ok, State :: #database_server_state{}, timeout() | hibernate} |
    {stop, Reason :: term()} | ignore).
init([]) ->
    process_flag(trap_exit, true),
    io:format("~p (~p) starting..... ~n", [{global, ?MODULE}, self()]),
    database_logic:initDB(),
    {ok, #database_server_state{}}.

%% @private
%% @doc Handling call messages
-spec(handle_call(Request :: term(), From :: {pid(), Tag :: term()},
        State :: #database_server_state{}) ->
    {reply, Reply :: term(), NewState :: #database_server_state{}} |
    {reply, Reply :: term(), NewState :: #database_server_state{}, timeout() | hibernate} |
    {noreply, NewState :: #database_server_state{}} |
    {noreply, NewState :: #database_server_state{}, timeout() | hibernate} |
    {stop, Reason :: term(), Reply :: term(), NewState :: #database_server_state{}} |
    {stop, Reason :: term(), NewState :: #database_server_state{}}).

handle_call({store, NodeName, Comment}, _From, State = #database_server_state{}) ->
    database_logic:storeDB(NodeName, Comment),
    io:format("Comment has been saved for ~p~n", [NodeName]),
    {reply, ok, State};

handle_call({getDB, NodeName}, _From, State = #database_server_state{}) ->
    Comments = database_logic:getDB(NodeName),
    lists:foreach(fun(CM) ->
        io:format("Received: ~p~n", [CM])
    end, Comments),
    {reply, ok, State};

handle_call({getDBTwo, NodeName}, _From, State = #database_server_state{}) ->
    Comments = database_logic:getDBTwo(NodeName),
    lists:foreach(fun({CM,CO}) ->
        io:format("Received: ~p Created On: ~p~n", [CM,CO])
                  end, Comments),
    {reply, ok, State};

handle_call({delete, NodeName}, _From, State = #database_server_state{}) ->
    database_logic:deleteDB(NodeName),
    io:format("Data deleted for: ~p~n", [NodeName]),
    {reply, ok, State};

handle_call(_Request, _From, State = #database_server_state{}) ->
    {reply, ok, State}.

%% @private
%% @doc Handling cast messages
-spec(handle_cast(Request :: term(), State :: #database_server_state{}) ->
    {noreply, NewState :: #database_server_state{}} |
    {noreply, NewState :: #database_server_state{}, timeout() | hibernate} |
    {stop, Reason :: term(), NewState :: #database_server_state{}}).
handle_cast(_Request, State = #database_server_state{}) ->
    {noreply, State}.

%% @private
%% @doc Handling all non call/cast messages
-spec(handle_info(Info :: timeout() | term(), State :: #database_server_state{}) ->
    {noreply, NewState :: #database_server_state{}} |
    {noreply, NewState :: #database_server_state{}, timeout() | hibernate} |
    {stop, Reason :: term(), NewState :: #database_server_state{}}).
handle_info(_Info, State = #database_server_state{}) ->
    {noreply, State}.

%% @private
%% @doc This function is called by a gen_server when it is about to
%% terminate. It should be the opposite of Module:init/1 and do any
%% necessary cleaning up. When it returns, the gen_server terminates
%% with Reason. The return value is ignored.
-spec(terminate(Reason :: (normal | shutdown | {shutdown, term()} | term()),
        State :: #database_server_state{}) -> term()).
terminate(_Reason, _State = #database_server_state{}) ->
    ok.

%% @private
%% @doc Convert process state when code is changed
-spec(code_change(OldVsn :: term() | {down, term()}, State :: #database_server_state{},
        Extra :: term()) ->
    {ok, NewState :: #database_server_state{}} | {error, Reason :: term()}).
code_change(_OldVsn, State = #database_server_state{}, _Extra) ->
    {ok, State}.

%%%===================================================================
%%% Internal functions
%%%===================================================================

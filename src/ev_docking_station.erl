%%%-------------------------------------------------------------------
%%% @author Gustaf Nilstadius
%%% @copyright (C) 2016
%%% @doc
%%%
%%% @end
%%%-------------------------------------------------------------------
-module(ev_docking_station).
-behaviour(gen_server).
-author("Gustaf Nilstadius").

%% API
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-export([start_link/2]).

%%TODO Create genereic server with finite state machine



start_link(0, _) ->
  {error,invalid_total};
start_link(_, Occupied) when Occupied < 0 ->
  {error,invalid_occupied};
start_link(Total, Occupied) when Occupied > Total ->
  {error,invalid_occupied};
start_link(Total, Occupied) ->
  %%TODO genereate servername
  {ok, _} = gen_server:start_link({local, _}, ev_docking_station, [{Total, Occupied}], []),
  {ok, _}.


%%#########GEN_SERVER###################################################################

init([{Total, Total}]) ->
  {ok, {full, {Total, Total}}};
init([{Total, 0}]) ->
  {ok, {empty, {Total, 0}}};
init([{Total, Occupied}]) ->
  {ok, {idle, {Total, Occupied}}}.

handle_call(release, _, {empty, State}) ->
  {Reply, NewState} = docking:release(State),
  {reply, Reply, NewState};
handle_call(secure, _, State) ->
  {Reply, NewState} = docking:secure(State),
  {reply, Reply, NewState};
handle_call(get_info, _, State) ->
  Reply = docking:get_info(State),
  {reply, Reply, State}.


handle_cast(Request, State) ->
  erlang:error(not_implemented).

handle_info(Info, State) ->
  erlang:error(not_implemented).

terminate(Reason, State) ->
  erlang:error(not_implemented).

code_change(OldVsn, State, Extra) ->
  erlang:error(not_implemented).
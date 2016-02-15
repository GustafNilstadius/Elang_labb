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
-export([start_link/2, release_cycle/1, secure_cycle/1, get_info/1]).

%%TODO Create genereic server with finite state machine



start_link(0, _) ->
  {error,invalid_total};
start_link(_, Occupied) when Occupied < 0 ->
  {error,invalid_occupied};
start_link(Total, Occupied) when Occupied > Total ->
  {error,invalid_occupied};
start_link(Total, Occupied) ->
  %%TODO genereate servername
  {ok, _} = gen_server:start_link({local, kakor}, ev_docking_station, [{Total, Occupied}], []),
  {ok, kakor}.


release_cycle(Ref) ->
  gen_server:call(Ref, release).

secure_cycle(Ref) ->
  gen_server:call(Ref, secure).

get_info(Ref) ->
  gen_server:call(Ref, get_info).

%%#########GEN_SERVER###################################################################


init([{Total, Occupied}]) ->
  process_flag(trap_exit, true),
  docking:init({Total, Occupied}).

handle_call(release, _, State) ->
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
  %%Clean up here
  erlang:error(not_implemented).

code_change(OldVsn, State, Extra) ->
  erlang:error(not_implemented).
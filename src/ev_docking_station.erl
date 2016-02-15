%%%-------------------------------------------------------------------
%%% @author Gustaf Nilstadius
%%% @copyright (C) 2016
%%% @doc
%%%
%%% @end
%%%-------------------------------------------------------------------
-module(ev_docking_station).
-behaviour(gen_fsm).
-author("Gustaf Nilstadius").

%% API
-export([init/1, handle_event/3, handle_sync_event/4, handle_info/3, terminate/3, code_change/4]).
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
  gen_fsm:sync_send_all_state_event(Ref, get_info).

%%#########GEN_FSM###################################################################


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

idle(release, _, State) ->
  {Reply, {NewState, Data}} = docking:release({idle, State}),
  {reply, Reply, next_state, NewState, Data};
idle(secucure, _, State) -> 
  {Reply, {NewState, Data}} = docking:secure({idle, State}),
  {reply, Reply, next_state, NewState, Data}.

full(release, _, State) -> 
  {Reply, {NewState, Data}} = docking:release({full, State}),
  {reply, Reply, next_state, NewState, Data}.
full(secucure, _, State) ->
  {reply, {error, full}, next_state, full, State}.

empty(release, _, State) ->
  {reply, {error, empty}, next_state, empty, State}.
empty(secucure, _, State) ->
  {Reply, {NewState, Data}} = docking:secure({empty, State}),
  {reply, Reply, next_state, NewState, Data}.



handle_event(Event, StateName, StateData) ->
  erlang:error(not_implemented).

handle_sync_event(Event, From, StateName, StateData) ->
  Reply = docking:get_info({StateName, StateData}),
  {reply, Reply, next_state, StateName, StateData}.

handle_info(Info, StateName, StateData) ->
  erlang:error(not_implemented).

terminate(Reason, StateName, StateData) ->
  erlang:error(not_implemented).

code_change(OldVsn, StateName, StateData, Extra) ->
  erlang:error(not_implemented).
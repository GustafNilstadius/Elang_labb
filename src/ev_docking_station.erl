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
-export([init/1, handle_event/3, handle_sync_event/4, handle_info/3, terminate/3, code_change/4, full/3, full/3, empty/3, idle/3]).
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
  gen_fsm:start_link(?MODULE, [Total, Occupied], []).


release_cycle(Ref) ->
  gen_fsm:sync_send_event(Ref, release).

secure_cycle(Ref) ->
  gen_fsm:sync_send_event(Ref, secure).

get_info(Ref) ->
  gen_fsm:sync_send_all_state_event(Ref, get_info).

%%#########GEN_FSM###################################################################


init([Total, Occupied]) ->
  process_flag(trap_exit, true),
  {_, {NewState, Data}} = docking:init({Total, Occupied}),
  {ok, NewState, Data}.



idle(release, _, State) ->
  {Reply, {NewState, Data}} = docking:release({idle, State}),
  {reply, Reply, NewState, Data};
idle(secure, _, State) ->
  {Reply, {NewState, Data}} = docking:secure({idle, State}),
  {reply, Reply, NewState, Data}.

full(release, _, State) -> 
  {Reply, {NewState, Data}} = docking:release({full, State}),
  {reply, Reply, NewState, Data};
full(secure, _, State) ->
  {reply, {error, full}, full, State}.

empty(release, _, State) ->
  {reply, {error, empty}, empty, State};
empty(secure, _, State) ->
  {Reply, {NewState, Data}} = docking:secure({empty, State}),
  {reply, Reply, NewState, Data}.



handle_event(_Event, _StateName, _StateData) ->
  erlang:error(not_implemented).

handle_sync_event(_Event, _From, StateName, StateData) ->
  Reply = docking:get_info({StateName, StateData}),
  {reply, Reply, StateName, StateData}.

handle_info(_Info, _StateName, _StateData) ->
  erlang:error(not_implemented).

terminate(_Reason, _StateName, _StateData) ->
  ok.

code_change(_OldVsn, _StateName, _StateData, _Extra) ->
  erlang:error(not_implemented).
%%%-------------------------------------------------------------------
%%% @author Gustaf Nilstadius
%%% @copyright (C) 2016
%%% @doc
%%%
%%% @end
%%%-------------------------------------------------------------------
-module(ev_docking_station).
-author("Gustaf Nilstadius").

%% API
-export([]).

%%TODO Create genereic server with finite state machine

start_link(Total, Occupied) ->
  {ok, _} = gen_server:start_link({local, })
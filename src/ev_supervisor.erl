%%%-------------------------------------------------------------------
%%% @author Gustaf Nilstadius
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%%-------------------------------------------------------------------
-module(ev_supervisor).
-author("Gustaf Nisladius").
-behaviour(supervisor).

%% API
-export([init/1, start_link/0]).

start_link() ->
  supervisor:start_link({local, ?MODULE}, ?MODULE, []).

init(_) ->
  {ok, {{simple_one_for_one, 2, 3600},
    [{docking_station, {ev_docking_station, start_link, []},
      permanent, 2000, worker, [test]}]}}.
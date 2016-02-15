%%%-------------------------------------------------------------------
%%% @author Gustaf Nilstadius
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%%-------------------------------------------------------------------
-module(docking).
-author("Gustaf Nilstadius").

%% API
-export([release/1, secure/1, init/2, get_info/1]).

init(0, _) ->
  {error,invalid_total};
init(_, Occupied) when Occupied < 0 ->
  {error,invalid_occupied};
init(Total, Occupied) when Occupied > Total ->
  {error,invalid_occupied};
init(Total, Occupied) ->
  {ok, {Total, Occupied}}.

release({_, 0}) ->
  {error, empty};
release({Total, Occupied}) ->
  {ok, {Total, Occupied-1}}.

secure({Total, Total}) ->
  {error, full};
secure({Total, Occupied}) ->
  {ok, {Total, Occupied+1}}.

get_info({Total, Occupied}) ->
  {ok, [{total, Total}, {occupied, Occupied}, {free, Total-Occupied}]}.
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
-export([release/1, secure/1, get_info/1]).


release({Total, 0}) ->
  {{error, empty}, {empty, {Total, 0}}};
release({Total, 1}) ->
  {ok, {empty,{Total, 0}}};
release({Total, Occupied}) ->
  {ok, {idle, {Total, Occupied-1}}}.

secure({Total, Total}) ->
  {error, full};
secure({Total, Occupied}) ->
  {ok, {Total, Occupied+1}}.

get_info({Total, Occupied}) ->
  {ok, [{total, Total}, {occupied, Occupied}, {free, Total-Occupied}]}.
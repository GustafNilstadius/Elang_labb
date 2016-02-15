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


release({empty, {Total, 0}}) ->
  {{error, empty}, {empty, {Total, 0}}};
release({idle, {Total, 1}}) ->
  {ok, {empty,{Total, 0}}};
release({_ ,{Total, Occupied}}) ->
  {ok, {idle, {Total, Occupied-1}}}.

secure({_ ,{Total, Total}}) ->
  {{error, full}, {full, {Total, Total}}};
secure({_ ,{Total, Occupied}}) when Occupied+1 == Total ->
  {ok, {full, {Total, Occupied+1}}};
secure({_ ,{Total, Occupied}}) ->
  {ok, {idle, {Total, Occupied+1}}}.

get_info({_ ,{Total, Occupied}}) ->
  {ok, [{total, Total}, {occupied, Occupied}, {free, Total-Occupied}]}.
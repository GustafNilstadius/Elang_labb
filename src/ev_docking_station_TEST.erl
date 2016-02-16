%%%-------------------------------------------------------------------
%%% @author Gustaf Nilstadius
%%% @copyright (C) 2016
%%% @doc
%%% Tests for ev_docking_station.erl.
%%% Usage: ev_docking_station_TEST:all().
%%%   Tests all functions
%%% @end
%%% @deprecated Needs new tests
%%% TODO rewrite tests
%%%-------------------------------------------------------------------
-module(ev_docking_station_TEST).
-author("Gustaf Nilstadius").

%% API
-export([all/0, start_link_all/0, release_all/0, secure_all/0, get_info/0]).


all() ->
  io:format("Running ev_docking_station_TEST", []),
  {ok, Ref} = ev_docking_station:start_link(3, 1),
  ok = ev_docking_station:release_cycle(Ref),
  {error, empty} = ev_docking_station:release_cycle(Ref),
  ok = ev_docking_station:secure_cycle(Ref),
  ok = ev_docking_station:secure_cycle(Ref),
  ok = ev_docking_station:secure_cycle(Ref),
  {error, full} = ev_docking_station:secure_cycle(Ref),
  ev_docking_station:get_info(Ref),
  io:format(" - ok\n", []).



%% @deprecated
start_link_all() ->
  io:format("Running start_link_all", []),
  io:format(" 1", []),
  {ok, _} = ev_docking_station:start_link(3, 1),

  io:format(" 2", []),
  {ok, _} = ev_docking_station:start_link(50, 0),

  io:format(" 3", []),
  {error, invalid_occupied} = ev_docking_station:start_link(3, 4),

  io:format(" 3", []),
  {error, invalid_total} = ev_docking_station:start_link(0, 0),

  io:format(" - ok\n", []).

%% @deprecated
release_all() ->
  io:format("Running release_all", []),
  {ok, Ref} = ev_docking_station:start_link(3, 1),
  io:format(" 1", []),
  ok = ev_docking_station:release_cycle(Ref),
  io:format(" 2", []),
  {error, empty} = ev_docking_station:release_cycle(Ref),
  io:format(" - ok\n", []).

%% @deprecated
secure_all() ->
  io:format("Running secure_all", []),
  {ok, Ref} = ev_docking_station:start_link(3, 1),
  io:format(" 1", []),
  ok = ev_docking_station:secure_cycle(Ref),
  io:format(" 2", []),
  ok = ev_docking_station:secure_cycle(Ref),
  io:format(" 3", []),
  {error, full} = ev_docking_station:secure_cycle(Ref),
  io:format(" - ok\n", []).

%% @deprecated
get_info() ->
  io:format("Running get_info", []),
  {ok, Ref} = ev_docking_station:start_link(3, 1),
  {ok, [{total, _}, {occupied, _}, {free, _}]} = ev_docking_station:get_info(),
  io:format(" - ok\n", []).
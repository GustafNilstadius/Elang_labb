%%%-------------------------------------------------------------------
%%% @author Gustaf Nilstadius
%%% @copyright (C) 2016
%%% @doc
%%% Tests for ev_docking_station.erl.
%%% Usage: ev_docking_station_TEST:all().
%%%   Tests all functions
%%% @end
%%%-------------------------------------------------------------------
-module(ev_docking_station_TEST).
-author("Gustaf Nilstadius").

%% API
-export([all/0]).


all() ->
  start_link_all(),
  release_all(),
  secure_all(),
  get_info().



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

release_all() ->
  io:format("Running release_all", []),
  {ok, Ref} = ev_docking_station:start_link(3, 1),
  io:format(" 1", []),
  ok = ev_docking_station:release_cycle(Ref),
  io:format(" 2", []),
  {error, empty} = ev_docking_station:release_cycle(Ref),
  io:format(" - ok\n", []).

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

get_info() ->
  io:format("Running get_info", []),
  {ok, Ref} = ev_docking_station:start_link(3, 1),
  {ok, [{total, _}, {occupied, _}, {free, _}]} = ev_docking_station:get_info(),
  io:format(" - ok\n", []).
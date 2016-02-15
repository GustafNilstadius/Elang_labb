%%%-------------------------------------------------------------------
%%% @author Gustaf Nilstadius
%%% @author Robin Duda
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% @deprecated Not up to date du to changes in program architecture.
%%% Created : 15. Feb 2016 12:42
%%%-------------------------------------------------------------------
-module(docking_TEST).
-author("Gustaf Nilstadius").
-author("Robin Duda").

%% API
-export([all/0]).


all() ->
  init_all(),
  secure_all(),
  release_all(),
  info_all().


init_all() ->
  io:format("Running init_all", []),
  io:format(" 1", []),
  {ok, {3,1}} = docking:init(3,1),
  io:format(" 2", []),
  {ok, {50,50}} = docking:init(50,50),
  io:format(" 3", []),
  {error, invalid_occupied} = docking:init(50,51),
  io:format(" 4", []),
  {error, invalid_occupied} = docking:init(50,-1),
  io:format(" 5", []),
  {error, invalid_total} = docking:init(0, 3),
  io:format(" - ok\n", []).

secure_all() ->
  io:format("Running secure_all", []),
  {ok, DB} = {ok, {idle, {3, 1}}},
  io:format(" 1", []),
  {ok, DB1} = docking:secure(DB),
  io:format(" 2", []),
  {ok, DB2} = docking:secure(DB1),
  io:format(" 3", []),
  {{error, full}, _} = docking:secure(DB2),
  io:format(" - ok\n", []).

release_all() ->
  io:format("Running init_all", []),
  {ok, DB} = {ok, {idle, {3, 1}}},
  io:format(" 1", []),
  {ok, DB1} = docking:release(DB),
  io:format(" 2", []),
  {{error, empty}, _} = docking:release(DB1),
  io:format(" - ok\n", []).


info_all() ->
  io:format("Running info_all", []),
  {ok, [{total, 3}, {occupied, 2}, {free, 1}]} = docking:get_info({_, {3, 2}}),
  {ok, [{total, 3}, {occupied, 0}, {free, 3}]} = docking:get_info({_, {3, 0}}),
  {ok, [{total, 3}, {occupied, 3}, {free, 0}]} = docking:get_info({_, {3, 3}}),
  io:format(" - ok\n").

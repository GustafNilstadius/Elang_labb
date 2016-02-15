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
  {ok, {idle, {3, 1}}} = docking:init({3,1}),
  {ok, {full, {3, 3}}} = docking:init({3, 3}),
  {ok, {empty, {3, 0}}} = docking:init({3, 0}),
  io:format(" - ok\n", []).

secure_all() ->
  io:format("Running secure_all", []),
  {ok, DB} = docking:init({3, 1}),
  {ok, DB1} = docking:secure(DB),
  {ok, DB2} = docking:secure(DB1),
  {{error, full}, _} = docking:secure(DB2),
  io:format(" - ok\n", []).

release_all() ->
  io:format("Running init_all", []),
  {ok, DB} = docking:init({3, 1}),
  {ok, DB1} = docking:release(DB),
  {{error, empty}, _} = docking:release(DB1),
  io:format(" - ok\n", []).

info_all() ->
  io:format("Running info_all", []),
  {ok, Free} = docking:init({3, 2}),
  {ok, Empty} = docking:init({3, 0}),
  {ok, Full} = docking:init({3, 3}),
  {ok, [{total, 3}, {occupied, 2}, {free, 1}]} = docking:get_info(Free),
  {ok, [{total, 3}, {occupied, 0}, {free, 3}]} = docking:get_info(Empty),
  {ok, [{total, 3}, {occupied, 3}, {free, 0}]} = docking:get_info(Full),
  io:format(" - ok\n").

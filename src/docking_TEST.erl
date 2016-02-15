%%%-------------------------------------------------------------------
%%% @author hipernx
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 15. Feb 2016 12:42
%%%-------------------------------------------------------------------
-module(docking_TEST).
-author("hipernx").

%% API
-export([all/0]).


all() ->
  init_all(),
  release_all(),
  secure_all().

%%TODO create test for get_info()

secure_all() ->
  io:format("Running secure_all", []),
  {ok, DB} = docking:init(3,1),
  io:format(" 1", []),
  {ok, DB1} = docking:secure(DB),
  io:format(" 2", []),
  {ok, DB2} = docking:secure(DB1),
  io:format(" 3", []),
  {error, full} = docking:secure(DB2),
  io:format(" - ok\n", []).

release_all() ->
  io:format("Running init_all", []),
  {ok, DB} = docking:init(3,1),
  io:format(" 1", []),
  {ok, DB1} = docking:release(DB),
  io:format(" 2", []),
  {error, empty} = docking:release(DB1),
  io:format(" - ok\n", []).


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

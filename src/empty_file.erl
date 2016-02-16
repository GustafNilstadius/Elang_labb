%%%-------------------------------------------------------------------
%%% @author Gustaf Nilstadius
%%% @copyright (C) 2016
%%% @doc
%%%
%%% @end
%%%-------------------------------------------------------------------


%%  This is a notepad
%%TODO Read the instructions, Donne/G R0b1n?

{ok, Ref} = ev_docking_station:start_link(3, 1),
ok = ev_docking_station:release_cycle(Ref),
{error, empty} = ev_docking_station:release_cycle(Ref),
ok = ev_docking_station:secure_cycle(Ref),
ok = ev_docking_station:secure_cycle(Ref),
ok = ev_docking_station:secure_cycle(Ref),
{error, full} = ev_docking_station:secure_cycle(Ref),
ev_docking_station:get_info(Ref),
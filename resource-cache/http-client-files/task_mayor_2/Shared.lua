CONST_REWARD_EXP = 400

CONST_START_POINT = {
	{
		Vector3( 28.352, -1619.958 + 860, 20.413 );
		Vector3( 0, 0, 0 );
	};
	{
		Vector3( 2297.382, -1007.844 + 860, 60.478 );
		Vector3( 0, 0, 119 );
	};
}

CONST_ROUTE_CHECKPOINTS = {
	{
		Vector3( -55.097, -1344.413 + 860, 20.414 );
		Vector3( 540.123, -1654.97 + 860, 20.565 );
		Vector3( 243.846, -1954.434 + 860, 20.515 );
		Vector3( 338.601, -2102.67 + 860, 20.568 );
		Vector3( 398.363, -2425.386 + 860, 20.403 );
		Vector3( 241.171, -2214.976 + 860, 20.42 );
		Vector3( 306.29, -2824.067 + 860, 20.376 );
		Vector3( -100.961, -1988.932 + 860, 20.716 );
		Vector3( -329.725, -1690.761 + 860, 20.62 );
		Vector3( -808.026, -1190.758 + 860, 15.605 );
		Vector3( -1459.901, -1597.381 + 860, 20.845 );
	};
	{
		Vector3( 2250.347, -1132.675 + 860, 60.277 );
		Vector3( 2395, -814.176 + 860, 60.386 );
		Vector3( 2306.131, -571.405 + 860, 61.093 );
		Vector3( 1646.008, -322.05 + 860, 28.369 );
		Vector3( 1953.116, -250.807 + 860, 60.223 );
		Vector3( 1918.308, -512.648 + 860, 60.53 );
		Vector3( 1931.335, -746.28 + 860, 60.428 );
		Vector3( 2022.095, -777.654 + 860, 60.466 );
		Vector3( 2164.594, -885.288 + 860, 60.371 );
		Vector3( 2199.731, -1233.237 + 860, 60.48 );
	};
}

QUEST_DATA = {
	id = "task_mayor_2";

	title = "Агитация власти";
	description = "";

	CheckToStart = function( player )
		return player:IsInFaction()
	end;

	replay_timeout = 120;

	tasks = {
		[1] = {
			name = "Поговори с клерком";

			Setup = {
				client = function()
					CreateQuestPointToNPCWithDialog( FACTIONS_TASKS_PED_IDS[ localPlayer:GetFaction() ], {
						{
							text = [[— Здравствуйте, рейтинг власти в глазах народа
									стал резко снижаться. Необходимо провести
									агитационные акции в городе, во избежание
									эксцессов.]];
						};
						{
							text = [[На карте отмечены точки, по которым необходимо
									проехать на специализированном транспорте.]];
							info = true;
						};
					}, "task_mayor_2_end_step_1", _, true )
				end;
			};
		};
		[2] = {
			name = "Проследуй по маршруту";

			Setup = {
				client = function()
					local route_current_index = 0

					CEs.func_next_point = function()
						if CEs.marker and isElement( CEs.marker.colshape ) then	
							local vehicle = localPlayer:getData( "quest_vehicle" )						
							if not isElement( localPlayer.vehicle ) or localPlayer.vehicle ~= vehicle then
								triggerServerEvent( "PlayerFailStopQuest", localPlayer, { type = "quest_fail", fail_text = "Ты не в выданной машине" } )
								return
							end

							CEs.marker.destroy()

							triggerServerEvent( "onRequestStartPlayAgitationSpeech", resourceRoot, vehicle )
						end

						route_current_index = route_current_index + 1

						if CONST_ROUTE_CHECKPOINTS[ localPlayer:GetFactionDutyCity() ][ route_current_index ] then
							CreateQuestPoint( CONST_ROUTE_CHECKPOINTS[ localPlayer:GetFactionDutyCity() ][ route_current_index ], CEs.func_next_point, _, 10, 0, 0 )
							CEs.marker.slowdown_coefficient = nil
							CEs.marker.allow_passenger = true
						else
							localPlayer:ShowSuccess( "Возвращайтесь в мэрию" )
							triggerServerEvent( "task_mayor_2_end_step_2", localPlayer )
						end
					end

					CEs.func_on_vehicle_exit = function( vehicle, seat )
						local quest_vehicle = localPlayer:getData( "quest_vehicle" )	
						if quest_vehicle and vehicle == quest_vehicle then
							if isTimer( CEs.veh_fail_timer ) then killTimer( CEs.veh_fail_timer ) end

							localPlayer:ShowError( "Квест будет провален, если вы не вернётесь в выданный автомобиль" )
							
							CEs.veh_fail_timer = setTimer( function()
								triggerServerEvent( "PlayerFailStopQuest", localPlayer, "Ты покинул выданный автомобиль" )
							end, 60000, 1 )
						end
					end
					addEventHandler( "onClientPlayerVehicleExit", localPlayer, CEs.func_on_vehicle_exit)

					CEs.func_on_vehicle_enter = function( vehicle, seat )
						local quest_vehicle = localPlayer:getData( "quest_vehicle" )	
						if quest_vehicle then
							if vehicle == quest_vehicle then
								if isTimer( CEs.veh_fail_timer ) then killTimer( CEs.veh_fail_timer ) end
							else
								triggerServerEvent( "PlayerFailStopQuest", localPlayer, "Ты сменил автомобиль" )
							end
						end
					end
					addEventHandler( "onClientPlayerVehicleEnter", localPlayer, CEs.func_on_vehicle_enter )

					CEs.func_next_point()
				end;

				server = function( player )
					player.interior = 0
					player.dimension = 0

					local faction_id = player:GetFaction()
					local vehicle = CreateTemporaryQuestVehicle( player, vehicle_id_by_faction[ faction_id ] or 540, CONST_START_POINT[ player:GetFactionDutyCity() ][ 1 ], CONST_START_POINT[ player:GetFactionDutyCity() ][ 2 ] )
					vehicle:SetFuel( "full" )
					vehicle:SetWindowsColor( 0, 0, 0, 190 )
					vehicle:SetColor( 0, 0, 0, 0 )

					local number = math.random( 1, 10 ) % 10
					vehicle:SetNumberPlate( "1:а4".. number .. ( ( number + 5) % 10 ) .."мр97" )

					warpPedIntoVehicle( player, vehicle )

					addEventHandler( "onVehicleStartEnter", vehicle, function( enter_player, seat )
						if seat == 0 and enter_player ~= player then
							local faction = enter_player:GetFaction()

							if not FACTION_RIGHTS.ECONOMY[ faction ] or not enter_player:IsOnFactionDuty() then
								cancelEvent( )
							end
						end
					end )

					addEventHandler( "onVehicleDamage", vehicle, function( )
						if source.health < 800 then
							triggerEvent( "PlayerFailStopQuest", player, { type = "quest_fail", fail_text = "Ты разбил автомобиль" } )
						end
					end )
				end;
			};

			CleanUp = {
				client = function()
					CEs.func_next_point = nil

					removeEventHandler( "onClientPlayerVehicleExit", localPlayer, CEs.func_on_vehicle_exit )
					removeEventHandler( "onClientPlayerVehicleEnter", localPlayer, CEs.func_on_vehicle_enter )

					CEs.func_on_vehicle_exit = nil
					CEs.func_on_vehicle_enter = nil

					if isTimer( CEs.veh_fail_timer ) then killTimer( CEs.veh_fail_timer ) end
				end;
			};
		};
		[3] = {
			name = "Вернись в мэрию";

			Setup = {
				client = function()
					CreateQuestPoint( CONST_START_POINT[ localPlayer:GetFactionDutyCity() ][ 1 ], "task_mayor_2_end_step_3" )
				end;
			};

			CleanUp = {
				server = function( player )
					player:CompleteDailyQuest( "mayor_agitation" )
				end;
			};
		};
	};
	GiveReward = function( player )
		triggerEvent( "onServerCompleteShiftPlan", player, player, "complete_quest", "task_mayor_2", CONST_REWARD_EXP )
	end;
	rewards = {
		faction_exp = CONST_REWARD_EXP;
	};

	success_text = "Задача выполнена! Вы получили +".. CONST_REWARD_EXP .." очков ранга";
}
-- Точки начала маршрута
ROUTE_START_POINTS = {
	[ 0 ] = { 
		{ position = Vector3( -1258.666, -1809.229 + 860, 20.833 ) },
	},
}

-- Остановки
STOPS = {
	[ 0 ] = {
		[ 1 ] = {
			{ x = -1344.19, y = -1502.08 + 860, z = 19.85 },
			{ x = -1047.82, y = -1527.82 + 860, z = 19.79 },
			-- Дальше ХЗ
			{ x = -855.1, y = -1756.06 + 860, z = 19.78 },
			{ x = -901.22, y = -1836.48 + 860, z = 19.78 },
			{ x = 31.79, y = -2307.31 + 860, z = 19.6 },
			{ x = 210.46, y = -2541.48 + 860, z = 19.6 },
			{ x = 477.01, y = -2325.92 + 860, z = 19.58 },
			{ x = 308.71, y = -2246.44 + 860, z = 19.59 },
			{ x = 253.11, y = -1474.97 + 860, z = 19.73 },
			{ x = 420.3, y = -1225.01 + 860, z = 19.59 },
			{ x = 477.04, y = -1208.24 + 860, z = 19.6 },
			{ x = 98.29, y = -1227.34 + 860, z = 19.6 },
			{ x = -30.9, y = -1244.81 + 860, z = 19.6 },
			{ x = -227.15, y = -1227.96 + 860, z = 19.6 },
			{ x = -282.62, y = -1386.84 + 860, z = 19.6 },
			{ x = -300.39, y = -1560.47 + 860, z = 19.8 },
			{ x = -282.8, y = -1885.99 + 860, z = 19.81 },
			{ x = -300.32, y = -1836.42 + 860, z = 19.81 },
			{ x = -468.03, y = -1712.97 + 860, z = 19.75 },
			{ x = -449.84, y = -1702.09 + 860, z = 19.77 },
			{ x = -232.38, y = -1944.32, z = 19.81 },
			{ x = 106.43, y = -1936.58 + 860, z = 19.74 },
			{ x = 194.98, y = -1918.54 + 860, z = 19.77 },
			{ x = 633.04, y = -1936.59 + 860, z = 19.74 },
			{ x = 440.02, y = -1376.66 + 860, z = 19.63 },
			{ x = 456.68, y = -1346.92 + 860, z = 19.77 },
			{ x = 241.97, y = -1535.39 + 860, z = 19.7 },
			{ x = 202.46, y = -2439.64 + 860, z = 19.6 },
			{ x = 34.82, y = -2264.69 + 860, z = 19.6 },
			{ x = -478.78, y = -1960.56 + 860, z = 19.79 },
			{ x = -646.55, y = -1943.72 + 860, z = 19.78 },
			{ x = -751.49, y = -1961.58 + 860, z = 19.78 },
			{ x = -849.73, y = -1826.17 + 860, z = 19.78 },
			{ x = -1211.35, y = -1517.83 + 860, z = 19.85 },
			{ x = -1293.25, y = -1527.72 + 860, z = 19.85 },
			{ x = -1255.24, y = -1223.72 + 860, z = 19.85 },
			{ x = -1175.16, y = -1314.53 + 860, z = 19.85 },
			{ x = -470.5, y = -1780.72 + 860, z = 19.79 },
			{ x = -113.03, y = -1437.61 + 860, z = 19.6 },
		},
	},
}

-- Точки возврата к базе
RETURN_TARGETS = {
	-- НСК
	[ 0 ] = {
		{ position = Vector3( -1258.666, -1809.229 + 860, 20.833 ) },
	},
}

addEvent( "onDriverEarnMoney", true )

QUEST_DATA = {
	id = "task_driver_company";

	title = "Водитель автобуса";
	description = "";

	CheckToStart = function( player )
		return player:GetJobClass( ) == JOB_CLASS_DRIVER
	end;

	replay_timeout = 0;

	tasks = {
		[1] = {
			name = "Выедь из автобусного парка";

			Setup = {
				client = function()
					local city = localPlayer:GetShiftCity( )
					local start_points = ROUTE_START_POINTS[ city ]
					local start_point = start_points[ math.random( 1, #start_points ) ]

					CreateQuestPoint( start_point.position, 
						function()
							CEs.marker:destroy()
							triggerServerEvent( "PlayerAction_Task_Driver_1_step_1", localPlayer )
							if localPlayer.vehicle then localPlayer.vehicle:ping( ) end
						end
					, _, 10, 0, 0, CheckPlayerQuestVehicle, _, _, "cylinder", 0, 255, 0, 20 )
					CEs.marker.slowdown_coefficient = nil
				end;
			};
			event_end_name = "PlayerAction_Task_Driver_1_step_1";
			
		};

		[2] = {
			name = "Следуй по маршруту";

			Setup = {
				client = function()
					local city = localPlayer:GetShiftCity( )
					local stops = STOPS[ city ][ math.random( 1, #STOPS[ city ] ) ]
					createStops( stops )
					if localPlayer.vehicle then localPlayer.vehicle:ping( ) end
				end;
			};
			CleanUp = {
				client = function( )
					destroyStops( )
				end;
			};
			event_end_name = "PlayerAction_Task_Driver_1_step_2";
		},

		[3] = {
			name = "Вернись к депо";

			Setup = {
				client = function()
					local city = localPlayer:GetShiftCity( )
					local return_targets = RETURN_TARGETS[ city ]
					local return_point = return_targets[ math.random( 1, #return_targets ) ]

					CreateQuestPoint( return_point.position, 
						function()
							CEs.marker:destroy()
							triggerServerEvent( "PlayerAction_Task_Driver_1_step_3", localPlayer )
							if localPlayer.vehicle then localPlayer.vehicle:ping( ) end
						end
					, _, 10, 0, 0, false, _, _, "cylinder", 0, 255, 0, 20 )
					CEs.marker.slowdown_coefficient = nil
				end,
			};
			CleanUp = {
				server = function( player )
					local vehicle = player.vehicle
					if isElement( vehicle ) then
						player:GiveJobFineByVehicleHealth( vehicle.health )
						vehicle:fix()
					end
				end;
			};

			event_end_name = "PlayerAction_Task_Driver_1_step_3";
		};

	};

	GiveReward = function( player )
		StartAgain( player )
	end;

	no_show_rewards = true;
	no_show_success = true;
}

function StartAgain( player )
	setTimer( function()
		if not isElement( player ) then return end
		triggerEvent( "onJobRequestAnotherTask", player, player, false )
	end, 50, 1 )
end

function CheckPlayerQuestVehicle()
	if not isElement( localPlayer.vehicle ) or localPlayer.vehicle ~= localPlayer:getData( "job_vehicle" ) then
		localPlayer:ShowError( "Ты не в автомобиле Водителя" )
		return false
	end

	if localPlayer.vehicleSeat ~= 0 then
		localPlayer:ShowError( "Ты не водитель автомобиля Водителя" )
		return false
	end

	return true
end
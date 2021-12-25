QUEST_CONF = {
	dialogs = {
		main = {
			{ name = "Александр", voice_line = "Alexandr_1", text = "Здравствуй. Я слышал про твои проблемы.\nЛадно, не будем о грустном. У меня возможно есть новости, которые могут тебе помочь.\nНо прежде тебе нужно выполнить пару задач. Забери мой мопед с ремонта." },
		},
		finish = {
			{ name = "Александр", voice_line = "Alexandr_2", text = "Отлично. А ты ведь без колес сейчас? Пока можешь забрать мой мопед." },
		},
	},

	positions = {
		repair = Vector3( 1783.910, -702.957 + 860, 60.669 ),

		bike_spawn = Vector3( 1782.516, -698.466 + 860, 60.330 ),
		bike_spawn_rotation = Vector3( 0, 0, 322 ),

		player_spawn_near_bike = Vector3( 1783.961, -702.806 + 860, 60.669 ),
		player_spawn_near_bike_rotation = Vector3( 0, 0, 23 ),

		bike_direction = Vector3( 1811.900, -623.539 + 860, 60.668 ),
	}
}

QUEST_DATA = {
	id = "alexander_get_vehicle_bike",
	is_company_quest = true,

	title = "Получить транспорт",
	description = "Александр может владеть информацией, надо узнать кто мог такое провернуть.",

	-- TODO: Не забыть о блокировке старых игроков
	CheckToStart = function( player )
		return player.interior == 0 and player.dimension == 0
	end,

	restart_position = Vector3( 1774.9056, -637.4530 + 860, 60.8555 ),

	level_request = 1,

	OnAnyFinish = {
		server = function( player, reason, reason_data )
			player:InventoryRemoveTempItem( IN_TUTORIAL_CANISTER )
			DestroyAllTemporaryVehicles( player )
			ExitLocalDimension( player )
			iprint( reason )
		end,
	},

	tasks = {
		{
			name = "Поговорить с Александром",

			Setup = {
				client = function( )
					CreateMarkerToCutsceneNPC( {
						id = "alexander",
						dialog = QUEST_CONF.dialogs.main,
						radius = 1,
						callback = function( )
							CEs.marker.destroy( )
							EnterLocalDimension( )
							StartPedTalk( FindQuestNPC( "alexander" ).ped, nil, true )
							CEs.dialog:next( )

							setTimerDialog( function( )
								triggerServerEvent( "alexander_get_vehicle_bike_step_1", localPlayer )
							end, 13000, 1 )
						end
					} )
				end,
				server = function( player )
					if player:GotMotoBefore( ) then
						player:InfoWindow( "В данном квесте тебе будет предложено получить мопед. Так как ты его уже получал, в конце квеста у тебя останется весь имеющийся транспорт. Приятной игры!" )
					end
				end
			},

			CleanUp = {
				client = function( )
					FinishQuestCutscene( )
					StopPedTalk( FindQuestNPC( "alexander" ).ped )
				end,
			},

			event_end_name = "alexander_get_vehicle_bike_step_1",
		},

		{
			name = "Забрать мопед из ремонта",

			Setup = {
				client = function( )
					CreateQuestPoint( QUEST_CONF.positions.repair, function( self, player )
						CEs.marker.destroy( )

						triggerServerEvent( "alexander_get_vehicle_bike_step_3", localPlayer )
					end )
				end,
				server = function( player )
					player:InventoryRemoveItem( IN_TUTORIAL_CANISTER )	
					player:InventoryAddTempItem( IN_TUTORIAL_CANISTER )
				end,
			},

			event_end_name = "alexander_get_vehicle_bike_step_3",
		},

		{
			name = "Сесть на мопед",

			Setup = {
				client = function( )
					CEs.hint = CreateSutiationalHint( {
						text = "Нажми key=F или key=ENTER чтобы сесть на мопед",
						condition = function( )
							local vehicle = localPlayer:getData( "temp_vehicle" )
							return isElement( vehicle ) and ( localPlayer.position - vehicle.position ).length <= 4
						end
					} )

					fadeCamera( false, 0.0 )
					DisableGameHUD( true )

					localPlayer.position = QUEST_CONF.positions.player_spawn_near_bike
					localPlayer.rotation = QUEST_CONF.positions.player_spawn_near_bike_rotation

					local t = { }
					t.OnEnter = function( )
						removeEventHandler( "onClientPlayerVehicleEnter", localPlayer, t.OnEnter )
						triggerServerEvent( "alexander_get_vehicle_bike_step_4", localPlayer )
					end
					addEventHandler( "onClientPlayerVehicleEnter", localPlayer, t.OnEnter )

					setCameraTarget( localPlayer )
					setTimer( function( )
						DisableGameHUD( false )
						fadeCamera( true, 1.0 )
					end, 1000, 1 )
				end,
				server = function( player )
					local vehicle = CreateTemporaryVehicle( player, 468, QUEST_CONF.positions.bike_spawn, QUEST_CONF.positions.bike_spawn_rotation )
					player:SetPrivateData( "temp_vehicle", vehicle )
				end,
			},

			event_end_name = "alexander_get_vehicle_bike_step_4",
		},

		{
			name = "Припарковать мопед",

			Setup = {
				client = function( )
					table.insert( GEs, WatchElementCondition( localPlayer.vehicle, {
						condition = function( self, conf )
							if self.element.health <= 370 or self.element.inWater then
								FailCurrentQuest( "Мопед уничтожен!", "fail_destroy_vehicle" )
								return true
							elseif self.element:GetFuel( ) <= 0 then
								FailCurrentQuest( "Кончилось топливо!" )
								return true
							end
						end,
					} ) )

					CreateQuestPoint( QUEST_CONF.positions.bike_direction, function( self, player )
						CEs.marker.destroy( )

						triggerServerEvent( "alexander_get_vehicle_bike_step_5", localPlayer )
					end,
					_, _, _, _,
					function( )
						if not localPlayer.vehicle or localPlayer.vehicle.model ~= 468 then
							return false, "Александру нужен мопед, ало!"
						end
						return true
					end )
				end,
			},

			CleanUp = {
				server = function( player )
					local vehicle = GetTemporaryVehicle( player )
					if vehicle then
						vehicle:SetStatic( true )
						vehicle.engineState = false
					end
				end,
			},

			event_end_name = "alexander_get_vehicle_bike_step_5",
		},

		{
			name = "Поговорить с Александром",

			Setup = {
				client = function( )
					CreateMarkerToCutsceneNPC( {
						id = "alexander",
						dialog = QUEST_CONF.dialogs.finish,
						local_dimension = true,
						callback = function( )
							CEs.marker.destroy( )
							CEs.dialog:next( )
							StartPedTalk( FindQuestNPC( "alexander" ).ped, nil, true )

							setTimerDialog( function( )
								CreateEvacuationHintColshape()
								triggerServerEvent( "alexander_get_vehicle_bike_step_6", localPlayer )
							end, 5000, 1 )
						end
					} )
				end,
			},

			CleanUp = {
				client = function( )
					FinishQuestCutscene( )
					StopPedTalk( FindQuestNPC( "alexander" ).ped )
				end,
			},

			event_end_name = "alexander_get_vehicle_bike_step_6",
		},
	},

	GiveReward = function( player )
		if not player:GotMotoBefore( ) then
			local sOwnerPID = "p:" .. player:GetUserID()

			local pRow	= {
				model 		= 585;  -- Можно поставить( ID: 486( Мопед ) )
				variant		= 1;
				x			= 0;
				y			= 0;
				z			= 0;
				rx			= 0;
				ry			= 0;
				rz			= 0;
				owner_pid	= sOwnerPID;
				color		= { math.random( 0, 255 ), math.random( 0, 255 ), math.random( 0, 255 ) };
			}
		    
			player:GiveLicense( 1 ) -- Права
			exports.nrp_vehicle:AddVehicle( pRow, true, "OnQuestBikeAdded", { player = player, cost = VEHICLE_CONFIG[ pRow.model ].variants[ 1 ].cost } )
		end

		setTimer( function( )
			if not isElement( player ) then return end
			player:ShowInfo( "У тебя есть неиспользованная донат валюта! Используй F4 чтобы открыть Магазин" )
		end, 10000, 1 )

		setTimer( function( )
			if not isElement( player ) then return end
			player:ShowInfo( "Используй P чтобы открыть телефон" )
		end, 20000, 1 )

		triggerClientEvent( player, "ShowPlayerUIQuestCompleted", player, {
			rewards = {
				--donate = 50,
				money = 250000,
				exp = 2000,
			}
		} )
	end,

	rewards = {
		--donate = 50,
		money = 250000,
		exp = 2000,
	},

	no_show_rewards = true,
}

function Player:GotMotoBefore( )
	return self:GetLevel( ) >= 2 and self:GetPermanentData( "reg_date" ) < NEW_TUTORIAL_RELEASE_DATE
end
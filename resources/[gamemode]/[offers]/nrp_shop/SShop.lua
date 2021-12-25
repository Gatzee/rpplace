loadstring( exports.interfacer:extend( "Interfacer" ) )( )
Extend( "SPlayer" )
Extend( "SVehicle" )
Extend( "ShVehicleConfig" )
Extend( "SPlayerCommon" )
Extend( "ShTimelib" )
Extend( "ShAccessories" )
Extend( "ShSkin" )
Extend( "ShVinyls" )
Extend( "ShPhone" )

CONST_GET_DATA_URL = SERVER_NUMBER > 100 and "https://pyapi.devhost.nextrp.ru/v1.0/get_f4_data/" or "https://pyapi.gamecluster.nextrp.ru/v1.0/get_f4_data/"

function onPlayerRequestDonateMenu_handler( tab_num, open_from_info )
    local player = isElement( client ) and client or source

    local data = {
        tab              = tab_num,
        last_item        = player:GetOpenCaseItem( ),
        retention_tasks  = player:GetRetentionTasks( ) or { },
        car_slot_cost    = CalculateSlotCost( player, player:GetPermanentData( "car_slots" ) ),
        get_data_url     = CONST_GET_DATA_URL,
        bp_rewards_count = exports.nrp_battle_pass:GetPlayerAvailableRewardsCount( player ),
        premium_renewal  = player:IsPremiumRenewalEnabled( ),
        cases_info = { 
            ["bronze"] =
	        { 
                name = "Бронзовый кейс", id = "bronze", is_hit = 1, cost = 99,

                items = {
                    { id = "vehicle", rare = 5, params = {model = 438}, chance = 0.01  },
                    { id = "vehicle", rare = 5, params = {model = 540}, chance = 0.01  },
                    { id = "vehicle", rare = 5, params = {model = 566}, chance = 0.01  },
                    { id = "vehicle", rare = 5, params = {model = 467}, chance = 0.01  },
                    { id = "vehicle", rare = 4, params = {model = 426}, chance = 0.01  },
                    { id = "vehicle", rare = 4, params = {model = 516}, chance = 0.01  },  -- ВАЗ 21099(должен быть)
                    { id = "soft", rare = 4, params = {count = 150000}, chance = 0.1 },
                    { id = "skin", rare = 3, params = {model = 183}, chance = 0.1 },
                    { id = "premium", rare = 3, params = {days = 1}, chance = 0.1 },
                    { id = "wof_coin", rare = 3, params = {count = 5, type = "default"}, chance = 0.1 },
                    { id = "accessory", rare = 2, params = {model = 2420}, chance = 0.1 },
                    { id = "accessory", rare = 2, params = {model = 1775}, chance = 0.1 },
                    { id = "soft", rare = 2, params = {count = 60000}, chance = 0.1 },
                    { id = "skin", rare = 1, params = {model = 202}, chance = 0.1 },
                    -- { id = "box", rare = 1, params = {number = 1, items = { }, chance = 0.1 },
                    { id = "accessory", rare = 1, params = {model = 955}, chance = 0.1 },
                    { id = "dance", rare = 1, params = {id = 28}, chance = 0.1 },
                    { id = "phone_img", rare = 1, params = {id = "bmw"}, chance = 0.1 }
                },
	        },
        },
    }

    triggerClientEvent( player, "onPlayerShowDonate", resourceRoot, data )

    SendElasticGameEvent( player:GetClientID( ), "f4_window_open" )

	if open_from_info then
		if tab_num == "donate" then
			SendElasticGameEvent( player:GetClientID( ), "f4r_currency_deposit_button_click", { from = open_from_info } )
		else
			SendElasticGameEvent( player:GetClientID( ), "f4r_popup_click", { link = tostring( tab_num ), from = open_from_info } )
		end
	end
end
addEvent( "onPlayerRequestDonateMenu", true )
addEventHandler( "onPlayerRequestDonateMenu", root, onPlayerRequestDonateMenu_handler )

addEventHandler( "onPlayerReadyToPlay", root, function( )
    triggerClientEvent( source, "onPlayerLoadWebData", source, {
        get_data_url = CONST_GET_DATA_URL,
    } )
end )

function onDonateExchangeRequest_handler( amount )
    local amount = math.abs( math.floor( amount ) )
    if amount <= 0 or not isnumber( amount ) then
        client:ShowOverlay( OVERLAY_ERROR, { text = "Указана неверная сумма!" } )
        return
    end

    if client:GetDonate( ) < amount then
        client:ShowOverlay( OVERLAY_ERROR, { text = "Недостаточно средств для перевода валюты!" } )
        return
    end

    if client:TakeDonate( amount, "hard_conversion" ) then
        local money = amount * 1000

        client:GiveMoney( money, "hard_conversion" )
        client:ShowOverlay( OVERLAY_DONATE_CONVERT, { amount = money } )

        triggerEvent( "onPlayerDonateConvert", client, amount, money )
    end
end
addEvent( "onDonateExchangeRequest", true )
addEventHandler( "onDonateExchangeRequest", root, onDonateExchangeRequest_handler )

function Player.ShowOverlay( self, overlay_type, data )
    triggerClientEvent( self, "onOverlayNotificationRequest", resourceRoot, overlay_type, data )
end

function CalculateSlotCost( player, have_slots )
	local price = 50
	if have_slots >= 4 then
		price = 600
	elseif have_slots > 0 and have_slots < 3 then
		price = ( have_slots + 1 ) * 50
	elseif have_slots == 3 then
		price = 300
	end
	return price
end

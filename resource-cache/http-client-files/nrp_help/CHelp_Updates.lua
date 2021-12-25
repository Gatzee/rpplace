LAST_UPDATE = 1579122000

-- Костыль для открытия нужной вкладки
function SwitchToTabSimulated( tab, subtab, subsubtab )
    if not isElement( UI_elements.bg ) then return end

    local tab, subtab, subsubtab = tab or 1, subtab or 1, subsubtab or 1
    UI_elements[ "tab_" .. tab ]:ibTimer( 
        function( self, subtab, subsubtab ) 
            self:ibSimulateClick( "left", "up" )
            self:ibTimer( function( self, subtab, subsubtab ) 
                UI_elements[ "subtab_" .. subtab ]:ibSimulateClick( "left", "up" )
                self:ibTimer( function( ) 
                    if isElement( UI_elements[ "subsubtab_" .. subsubtab ] ) then
                        UI_elements[ "subsubtab_" .. subsubtab ]:ibSimulateClick( "left", "up" )
                    else
                        triggerEvent( "onDropdownMenuOpen", UI_elements.dropdown, subsubtab )
                    end
                end, 200, 1 )
            end, 100, 1, subtab, subsubtab )
        end
    , 50, 1, subtab, subsubtab )
end

function CreateMoreButton( px, py, parent, fn )
    return 
        ibCreateButton( px, py, 0, 0, parent,
            "img/btn_more.png", "img/btn_more.png", "img/btn_more.png",
            0xFFFFFFFF, 0xEEFFFFFF, 0xCCFFFFFF ):ibSetRealSize( )
        :ibOnClick( fn )
end

function CreatePointButton( px, py, parent, fn )
    return 
        ibCreateButton( px, py, 0, 0, parent,
            "img/btn_point.png", "img/btn_point.png", "img/btn_point.png",
            0xFFFFFFFF, 0xEEFFFFFF, 0xCCFFFFFF ):ibSetRealSize( )
        :ibOnClick( fn )
end

function CreateSegmentedBlock( px, py, parent, fn_check, fn_create )
    if not fn_check or fn_check( ) then
        return fn_create( px, py, parent )
    end
end

function IsOfferActiveForModel( ... )
    return exports.nrp_shop:IsOfferActiveForModel( ... )
end

function GetCurrentSegment( ... )
    return exports.nrp_shop:GetCurrentSegment( ... )
end

function BuildSegmentedUpdate( folder, segmented_blocks, parent )
    local debug = false
    
    local last_image
    for i, v in ipairs( segmented_blocks ) do
        local vals = { v( ) }
        local condition = vals[ 1 ]
        table.remove( vals, 1 )
        if condition or debug then
            local img = ibCreateImage( 0, ( last_image and last_image:ibGetAfterY( ) or 0 ), 0, 0, "img/items/updates/" .. folder .. "/" .. i .. ".png", parent ):ibSetRealSize( )
            if img then
                for n, k in pairs( vals ) do
                    k:setParent( img )
                end
            end
            last_image = img or last_image
        else
            for n, k in pairs( vals ) do
                destroyElement( k )
            end
        end
    end

    return last_image
end

-- Для сегментации окна обновления по спешлам или скидкам:
--[[
    IsOfferActiveForModel( "special", id ) -- Спешл
    IsOfferActiveForModel( "discounts", id ) -- Скидки на машины
    local current_segment = GetCurrentSegment( ) -- Текущий сегмент игрока
    CreateSegmentedBlock( 0, 200, parent,
        function( )
            return IsOfferActiveForModel( "special", 580 )  -- Если активна скидка на панамеру
        end,
        function( px, py, parent )
            return ibCreateImage( 0, 0, 0, 0, "img/items/updates/panamera_img.png", parent ):ibSetRealSize( )
        end
    )
]]

local sound = nil

UPDATES = {
	{   "Новый год к нам мчится!",
		start_time = getTimestampFromString( "26 декабря 2019 00:00" ),
        create_fn = function( parent )
            local segmented_blocks = {
				[ 1 ] = function( )
					return true,
					CreateMoreButton( 205, 504, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
                        triggerEvent( "ShowEventUIMainOffer", root )
					end )
				end,
                [ 2 ] = function( )
					return true,
					CreateMoreButton( 205, 415, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
                        triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "cases" )
                    end )
                end,
				[ 3 ] = function( )
					return IsOfferActiveForModel( "special", 6557 ),
					CreateMoreButton( 205, 360, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
                        triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
					end )
				end,
				[ 4 ] = function( )
					return IsOfferActiveForModel( "special", 550 ),
					CreateMoreButton( 205, 360, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
                        triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
					end )
				end,
                [ 5 ] = function( )
					return true,
					CreateMoreButton( 205, 416, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
                        triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
                    end )
                end,
                [ 6 ] = function( )
					return true,
					CreateMoreButton( 205, 340, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
                        triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
                    end )
                end,
                [ 7 ] = function( )
					return IsOfferActiveForModel( "special", "plate_hawk" ),
					CreateMoreButton( 205, 340, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
                        triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
                    end )
                end,
                [ 8 ] = function( )
					return IsOfferActiveForModel( "special", "plate_diamond" ),
					CreateMoreButton( 205, 340, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
                        triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
                    end )
                end,
                [ 9 ] = function( )
					return true,
                    CreatePointButton( 175, 340, parent, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
						triggerEvent( "ToggleGPS", localPlayer, { x = -1011.702, y = -615.423, z = 21.773 } )
                    end ),
                    CreatePointButton( 175, 744, parent, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
						triggerEvent( "ToggleGPS", localPlayer, {
							{ x = 2.541, y = -1061.981, z = 20.971 },
							{ x = 2315.453, y = 295.845, z = 62.415 },
							{ x = 1656.034, y = 1572.359, z = 16.160 },
						} )
                    end )
                end,
                [ 10 ] = function( ) return true end,
            }

            return BuildSegmentedUpdate( "new_year_19", segmented_blocks, parent ):ibGetAfterY( )
        end
    },
    {   "Уууу, скааазочка",
        create_fn = function( parent )
            local segmented_blocks = {
				[ 1 ] = function( )
					return IsOfferActiveForModel( "special", 6555 ),
					CreateMoreButton( 205, 360, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
                        triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
					end )
				end,
                [ 2 ] = function( )
					return true,
					CreateMoreButton( 205, 368, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
                        triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
                    end )
                end,
                [ 3 ] = function( )
					return IsOfferActiveForModel( "special", "plate_boar" ),
					CreateMoreButton( 205, 340, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
                        triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
                    end )
                end,
                [ 4 ] = function( )
					return IsOfferActiveForModel( "special", "plate_ataman" ),
					CreateMoreButton( 205, 340, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
                        triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
                    end )
                end,
                [ 5 ] = function( )
					return true,
                    CreatePointButton( 175, 340, parent, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
						triggerEvent( "ToggleGPS", localPlayer, { x = -1011.702, y = -615.423, z = 21.773 } )
                    end ),
                    CreatePointButton( 175, 744, parent, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
						triggerEvent( "ToggleGPS", localPlayer, {
							{ x = 2.541, y = -1061.981, z = 20.971 },
							{ x = 2315.453, y = 295.845, z = 62.415 },
							{ x = 1656.034, y = 1572.359, z = 16.160 },
						} )
                    end ),
                    CreatePointButton( 175, 1148, parent, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
						triggerEvent( "ToggleGPS", localPlayer, {
							{ x = 2.541, y = -1061.981, z = 20.971 },
							{ x = 2315.453, y = 295.845, z = 62.415 },
							{ x = 1656.034, y = 1572.359, z = 16.160 },
						} )
                    end )
                end,
                [ 6 ] = function( ) return true end,
            }

            return BuildSegmentedUpdate( "17_12_19", segmented_blocks, parent ):ibGetAfterY( )
        end
    },
    {   "Хэппи бьюздей",
        create_fn = function( parent )
            local segmented_blocks = {
				[ 1 ] = function( ) return true,
					CreateMoreButton( 205, 360, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
                        triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "offers" )
					end ),
					ibCreateArea( 30, 48, 500, 245 )
						:ibAttachTooltip( " O__o " )
						:ibOnHover( function( )
							if not isElement( sound ) then
								sound = playSound( "sfx/hhd.ogg", true )
								sound.volume = 0
							end
		
							if isElement( sound ) then
								source:ibInterpolate( function( self )
									sound.volume = self.easing_value * 0.05
								end, 500, "Linear" )
							end
						end )
						:ibOnLeave( function( )
							if isElement( sound ) then
								source:ibInterpolate( function( self )
									sound.volume = ( 1 - self.easing_value ) * 0.05
								end, 500, "Linear" )
							end
						end )
						:ibOnDestroy( function( )
							if isElement( sound ) then
								destroyElement( sound )
							end
						end )
				end,
                [ 2 ] = function( )
					return true,
					CreateMoreButton( 205, 415, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
                        triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "cases" )
                    end )
                end,
                [ 3 ] = function( )
					return IsOfferActiveForModel( "special", 555 ),
					CreateMoreButton( 205, 360, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
                        triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
                    end )
                end,
                [ 4 ] = function( )
					return true,
					CreateMoreButton( 205, 419, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
                        triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
                    end )
                end,
                [ 5 ] = function( )
					return IsOfferActiveForModel( "special", "plate_evil" ),
					CreateMoreButton( 205, 340, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
                        triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
                    end )
                end,
                [ 6 ] = function( )
					return IsOfferActiveForModel( "special", "plate_angel" ),
					CreateMoreButton( 205, 340, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
                        triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
                    end )
                end,
                [ 7 ] = function( )
					return true,
                    CreatePointButton( 175, 340, parent, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
						triggerEvent( "ToggleGPS", localPlayer, { x = -362.323, y = -881.648, z = 20.917 } )
                    end ),
                    CreatePointButton( 175, 744, parent, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
						triggerEvent( "ToggleGPS", localPlayer, {
							{ x = 2.541, y = -1061.981, z = 20.971 },
							{ x = 2315.453, y = 295.845, z = 62.415 },
							{ x = 1656.034, y = 1572.359, z = 16.160 },
						} )
                    end ),
                    CreatePointButton( 175, 1148, parent, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
						triggerEvent( "ToggleGPS", localPlayer, {
							{ x = 2.541, y = -1061.981, z = 20.971 },
							{ x = 2315.453, y = 295.845, z = 62.415 },
							{ x = 1656.034, y = 1572.359, z = 16.160 },
						} )
                    end )
                end,
                [ 8 ] = function( ) return true end,
            }

            return BuildSegmentedUpdate( "project_birthday", segmented_blocks, parent ):ibGetAfterY( )
        end
    },
    {   "Псс, мб немного снежка?",
        create_fn = function( parent )
            local segmented_blocks = {
				[ 1 ] = function( ) return true end,
                [ 2 ] = function( )
					return IsOfferActiveForModel( "special", 6554 ),
					CreateMoreButton( 205, 395, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
                        triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
                    end )
                end,
                [ 3 ] = function( )
					return true,
					CreateMoreButton( 205, 340, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
                        triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
                    end )
                end,
                [ 4 ] = function( )
					return IsOfferActiveForModel( "special", "plate_titan" ),
					CreateMoreButton( 205, 340, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
                        triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
                    end )
                end,
                [ 5 ] = function( )
					return IsOfferActiveForModel( "special", "plate_emblem" ),
					CreateMoreButton( 205, 340, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
                        triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
                    end )
                end,
                [ 6 ] = function( )
					return true,
                    CreatePointButton( 175, 340, parent, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
						triggerEvent( "ToggleGPS", localPlayer, { 
							{ x = -362.323, y = -881.648, z = 20.917 },
							{ x = 2047.004, y = 53.308, z = 62.649 },
						} )
                    end ),
                    CreatePointButton( 175, 744, parent, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
						triggerEvent( "ToggleGPS", localPlayer, {
							{ x = 2.541, y = -1061.981, z = 20.971 },
							{ x = 2315.453, y = 295.845, z = 62.415 },
							{ x = 1656.034, y = 1572.359, z = 16.160 },
						} )
                    end ),
                    CreatePointButton( 175, 1148, parent, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
						triggerEvent( "ToggleGPS", localPlayer, {
							{ x = 2.541, y = -1061.981, z = 20.971 },
							{ x = 2315.453, y = 295.845, z = 62.415 },
							{ x = 1656.034, y = 1572.359, z = 16.160 },
						} )
                    end )
                end,
                [ 7 ] = function( ) return true end,
            }

            return BuildSegmentedUpdate( "snow_19", segmented_blocks, parent ):ibGetAfterY( )
        end
    },
    {   "Переработка недвижимости",
        create_fn = function( parent )
            local segmented_blocks = {
				[ 1 ] = function( )
					return true,
                    CreateMoreButton( 205, 535, parent, function( key, state )
						if key ~= "left" or state ~= "up" then return end
						ibClick( )
                        SwitchToTabSimulated( 2, 11, 1 )
					end )
                end,
                [ 2 ] = function( )
					return IsOfferActiveForModel( "special", 6543 ),
					CreateMoreButton( 205, 394, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
                        triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
                    end )
                end,
                [ 3 ] = function( )
					return IsOfferActiveForModel( "special", 6545 ),
					CreateMoreButton( 205, 414, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
                        triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
                    end )
                end,
                [ 4 ] = function( )
					return true,
					CreateMoreButton( 205, 340, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
                        triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
                    end )
                end,
                [ 5 ] = function( )
					return IsOfferActiveForModel( "special", "plate_bandit" ),
					CreateMoreButton( 205, 340, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
                        triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
                    end )
                end,
                [ 6 ] = function( )
					return IsOfferActiveForModel( "special", "plate_jeweler" ),
					CreateMoreButton( 205, 340, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
                        triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
                    end )
                end,
                [ 7 ] = function( ) return true end,
            }

            return BuildSegmentedUpdate( "apartments", segmented_blocks, parent ):ibGetAfterY( )
        end
    },
    {   "Кооперативная работа",
        create_fn = function( parent )
            local segmented_blocks = {
                [ 1 ] = function( ) return true,
                    CreatePointButton( 175, 418, parent, function( key, state )
						if key ~= "left" or state ~= "up" then return end
						ibClick( )
						ShowInfoUI( false )
						triggerEvent( "ToggleGPS", localPlayer, { x = -1012.824, y = 101.708, z = 22.933 } )
					end )
                end,
                [ 2 ] = function( )
					return false,
					CreateMoreButton( 205, 394, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
                        triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
                    end )
                end,
                [ 3 ] = function( )
					return false,
					CreateMoreButton( 205, 414, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
                        triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
                    end )
                end,
                [ 4 ] = function( )
					return false,
					CreateMoreButton( 205, 340, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
                        triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
                    end )
                end,
                [ 5 ] = function( )
					return false,
					CreateMoreButton( 205, 340, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
                        triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
                    end )
                end,
                [ 6 ] = function( )
					return false,
					CreateMoreButton( 205, 340, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
                        triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
                    end )
                end,
                [ 7 ] = function( ) return true end,
            }

            return BuildSegmentedUpdate( "towtrucker_try_2", segmented_blocks, parent ):ibGetAfterY( )
        end
    },
    {   "Шлагбаумы, фиксы и контент",
        create_fn = function( parent )
            local segmented_blocks = {
                [ 1 ] = function( ) return true,
					CreateMoreButton( 205, 379, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
						ibClick( )
						ShowInfoUI( false )
                        triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "services" )
                    end ),
                    CreateMoreButton( 205, 1399, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
                        SwitchToTabSimulated( 2, 8, 1 )
                    end )
                end,
                [ 2 ] = function( )
					return IsOfferActiveForModel( "special", 6549 ),
					CreateMoreButton( 205, 413, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
                        triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
                    end )
                end,
                [ 3 ] = function( )
					return IsOfferActiveForModel( "special", 142 ),
					CreateMoreButton( 205, 340, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
                        triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
                    end )
                end,
                [ 4 ] = function( )
					return IsOfferActiveForModel( "special", "plate_hero" ),
					CreateMoreButton( 205, 340, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
                        triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
                    end )
                end,
                [ 5 ] = function( )
					return IsOfferActiveForModel( "special", "plate_terror" ),
					CreateMoreButton( 205, 340, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
                        triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
                    end )
                end,
                [ 6 ] = function( ) return true end,
            }

            return BuildSegmentedUpdate( "region_number", segmented_blocks, parent ):ibGetAfterY( )
        end
    },
    {   "Карманный плеер, кейс и акция",
        create_fn = function( parent )
            local segmented_blocks = {
                [ 1 ] = function( ) return
                    true,
					CreateMoreButton( 205, 785, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
                        triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "cases" )
                    end ),
					CreateMoreButton( 205, 1246, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
                        triggerServerEvent( "ShowPayoffer", localPlayer )
                    end )
                end,
            }

            return BuildSegmentedUpdate( "towtrucker", segmented_blocks, parent ):ibGetAfterY( )
        end
    },
    {   "Ты ТРЯСИ, ТРЯСИ смартфон!",
        create_fn = function( parent )
            local segmented_blocks = {
                [ 1 ] = function( ) return
                    true,
                    CreatePointButton( 176, 378, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
                        ShowInfoUI( false )
                        triggerEvent( "ToggleGPS", localPlayer, {
							{ x = 742.594, y = 700.5, z = 20.903 },
							{ x = 2027.349, y = 75.546, z = 60.641 },
							{ x = -100.885, y = -1125.183, z = 20.802 },
                        } )
                    end ),
                    CreatePointButton( 176, 861, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
                        ShowInfoUI( false )
                        triggerEvent( "ToggleGPS", localPlayer, {
							{ x = 35.424530029297,  y = -1395.6300048828, z = 20.823999404907 },
							{ x = 382.8244934082, 	y = -1160.3588867188, z = 20.979698181152 },
							{ x = 336.38983154297,  y = -1054.7312011719, z = 20.97608757019  },
							{ x = 112.01319122314,  y = -906.79888916016, z = 20.984712600708 },
							{ x = 40.266139984131,  y = -789.52655029297, z = 20.820650100708 },
							{ x = 239.34432983398,  y = -684.08776855469, z = 20.900699615479 },
							{ x = 46.018810272217,  y = -530.8857421875,  z = 20.807649612427 },
							{ x = -303.95001220703, y = -705.59161376953, z = 21.000272750854 },
							{ x = -170.32562255859, y = -947.42864990234, z = 21.018600463867 },
							{ x = -487.79162597656, y = -913.05340576172, z = 20.992853164673 },
							{ x = -653.33453369141, y = -1080.8101806641, z = 21.002540588379 },
							{ x = -1340.7576904297, y = -864.01599121094, z = 21.004560470581 },
							{ x = -1035.2707519531, y = -793.31146240234, z = 20.996049880981 },
							{ x = -1218.1373291016, y = -654.21893310547, z = 21.064565658569 },
							{ x = -1262.8510742188, y = -361.00146484375, z = 21.062145233154 },
							{ x = -879.91162109375, y = -654.70288085938, z = 20.995609283447 },
							{ x = -738.77398681641, y = -896.85272216797, z = 20.993774414063 },
							{ x = 417.4499206543, 	y = -343.67199707031, z = 20.804653167725 },
							{ x = 285.10861206055,  y = -798.30743408203, z = 21.003314971924 },
							{ x = 642.26599121094,  y = -1080.8426513672, z = 20.970874786377 },
							{ x = 430.25173950195,  y = -1482.2554931641, z = 20.817932128906 },
							{ x = 250.8572845459, 	y = -1374.8594970703, z = 20.83603477478  },
							{ x = -492.53771972656, y = 1533.8098144531,  z = 20.907375335693 },
							{ x = -335.51867675781, y = 1533.9166259766,  z = 20.907375335693 },
							{ x = -44.1018409729, 	y = 1534.0233154297,  z = 20.909950256348 },
							{ x = -153.12530517578, y = 1472.7897949219,  z = 20.90912437439  },
							{ x = -121.85342407227, y = 1379.3044433594,  z = 20.90912437439  },
							{ x = -316.51364135742, y = 1379.1293945313,  z = 20.908863067627 },
							{ x = -470.46362304688, y = 1240.2349853516,  z = 20.908863067627 },
							{ x = -327.42028808594, y = 1242.6452636719,  z = 20.908863067627 },
							{ x = 392.05212402344,  y = 720.62286376953,  z = 20.906700134277 },
							{ x = 2142.2006835938,  y = -259.6155090332,  z = 60.672527313232 },
							{ x = 1845.8122558594,  y = -18.258895874023, z = 60.628547668457 },
							{ x = 1931.9057617188,  y = 51.644218444824,  z = 60.628547668457 },
							{ x = 1756.0170898438,  y = 179.36483764648,  z = 60.612922668457 },
							{ x = 2192.8869628906,  y = -235.80860900879, z = 60.620346069336 },
							{ x = 2053.4372558594,  y = -93.068420410156, z = 60.680335998535 },
							{ x = 2167.4338378906,  y = -48.791381835938, z = 60.614608764648 },
							{ x = 363.57641601563,  y = -931.68347167969, z = 20.975212097168 },
							{ x = 393.87841796875,  y = -663.46960449219, z = 20.971012115467 },
							{ x = 341.70303344727,  y = -1259.1904296875, z = 20.847059249878 },
							{ x = 465.42675781252,  y = -1327.4320068359, z = 20.793287277222 },
							{ x = 214.94369506836,  y = -1672.6779785156, z = 20.826738357544 },
						}, true )
                    end )
                end,
                [ 2 ] = function( )
					return IsOfferActiveForModel( "special", 6540 ),
					CreateMoreButton( 205, 415, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
                        triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
                    end )
                end,
                [ 3 ] = function( )
					return IsOfferActiveForModel( "special", 6548 ),
					CreateMoreButton( 205, 413, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
                        triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
                    end )
                end,
                [ 4 ] = function( )
					return IsOfferActiveForModel( "special", 17 ),
					CreateMoreButton( 205, 359, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
                        triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
                    end )
                end,
                [ 5 ] = function( )
					return IsOfferActiveForModel( "special", 137 ),
					CreateMoreButton( 205, 359, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
                        triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
                    end )
                end,
                [ 6 ] = function( )
					return IsOfferActiveForModel( "special", "plate_graph" ),
					CreateMoreButton( 205, 340, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
                        triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
                    end )
                end,
                [ 7 ] = function( )
					return IsOfferActiveForModel( "special", "plate_crown" ),
					CreateMoreButton( 205, 340, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
                        triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
                    end )
                end,
                [ 8 ] = function( )
                    return true,
                    CreatePointButton( 176, 340, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
                        ShowInfoUI( false )
                        triggerEvent( "ToggleGPS", localPlayer, {
                            { x = 2.541, y = -1061.981, z = 20.971 },
                            { x = 2315.366, y = 295.722, z = 62.415 },
                            { x = 1656.487, y = 1572.523, z = 16.160 },
                        } )
                    end ),
                    CreatePointButton( 176, 744, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
                        ShowInfoUI( false )
                        triggerEvent( "ToggleGPS", localPlayer, {
							{ x = -362.323, y = -881.648, z = 20.917 };
							{ x = 2047.004, y = 53.308, z = 62.649 };
                        } )
                    end )
                end,
                [ 9 ] = function( ) return true end,
            }

            return BuildSegmentedUpdate( "phone", segmented_blocks, parent ):ibGetAfterY( )
        end
    },
    {   "Хеллоуин, крутые тачки!",
        create_fn = function( parent )
            local segmented_blocks = {
                [ 1 ] = function( ) return
                    true,
                    
                    CreateMoreButton( 205, 434, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
						ibClick( )
						ShowInfoUI( false )
                        triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "offers" )
                    end ),
                    CreateMoreButton( 205, 1374, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
                        SwitchToTabSimulated( 2, 8, 1 )
                    end )
                end,
                [ 2 ] = function( )
                    return true, CreateMoreButton( 205, 394, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
                        triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
                    end )
                end,
                [ 3 ] = function( )
                    return IsOfferActiveForModel( "special", "plate_god" ), CreateMoreButton( 205, 340, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
                        triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
                    end )
                end,
                [ 4 ] = function( )
                    return IsOfferActiveForModel( "special", "plate_actor" ), CreateMoreButton( 205, 340, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
                        triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
                    end )
                end,
                [ 5 ] = function( )
                    return IsOfferActiveForModel( "special", 6537 ), CreateMoreButton( 205, 360, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
                        triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
                    end )
                end,
                [ 6 ] = function( )
                    return IsOfferActiveForModel( "special", 6551 ), CreateMoreButton( 205, 417, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
                        triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
                    end )
                end,
                [ 7 ] = function( )
                    return IsOfferActiveForModel( "special", 7 ), CreateMoreButton( 205, 359, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
                        triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
                    end )
                end,
                [ 8 ] = function( )
                    return IsOfferActiveForModel( "special", 27 ), CreateMoreButton( 205, 359, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
						ShowInfoUI( false )
                        triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
                    end )
                end,
                [ 9 ] = function( ) return
                    true,

                    CreatePointButton( 176, 340, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
                        ShowInfoUI( false )
                        triggerEvent( "ToggleGPS", localPlayer, {
                            { x = 1792.201, y = 234.227, z = 60.704 },
                            { x = 2044.341, y = 56.338, z = 62.621 },
                        } )
                    end ),
                    
                    CreatePointButton( 176, 744, nil, function( key, state )
                        if key ~= "left" or state ~= "up" then return end
                        ibClick( )
                        ShowInfoUI( false )
                        triggerEvent( "ToggleGPS", localPlayer, {
                            { x = 2.541, y = -1061.981, z = 20.971 },
                            { x = 2315.366, y = 295.722, z = 62.415 },
                            { x = 1656.487, y = 1572.523, z = 16.160 },
                        } )
                    end )
                end,
                [ 10 ] = function( ) return true end,
            }

            return BuildSegmentedUpdate( "halloween", segmented_blocks, parent ):ibGetAfterY( )
        end
    },
    {   "Рублево, ФСИН, винилы...",
        create_fn = function( parent )
            local last_image = ibCreateImage( 0, 0, 0, 0, "img/items/updates/rublevo/1.png", parent ):ibSetRealSize( )
            CreateMoreButton( 205, 1215, last_image, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                ibClick( )
                SwitchToTabSimulated( 2, 18, 8 )
			end )

			last_image = ibCreateImage( 0, last_image:ibGetAfterY( ), 0, 0, "img/items/updates/rublevo/2.png", parent ):ibSetRealSize( )
			CreateMoreButton( 205, 773, last_image, function( key, state )
				if key ~= "left" or state ~= "up" then return end
				ibClick( )
				ShowInfoUI( false )
				triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
			end )

			last_image = CreateSegmentedBlock( 0, last_image:ibGetAfterY( ), parent,
				function( )
                    return IsOfferActiveForModel( "special", "plate_king" )
				end,

				function( px, py, parent )
					local parent = ibCreateImage( px, py, 0, 0, "img/items/updates/rublevo/3.png", parent ):ibSetRealSize( )

					CreateMoreButton( 205, 340, parent, function( key, state )
						if key ~= "left" or state ~= "up" then return end
						ibClick( )
						ShowInfoUI( false )
						triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
					end )

					return parent
				end
			) or last_image

			last_image = CreateSegmentedBlock( 0, last_image:ibGetAfterY( ), parent,
				function( )
					return IsOfferActiveForModel( "special", "plate_lawyer" )
				end,

				function( px, py, parent )
					local parent = ibCreateImage( px, py, 0, 0, "img/items/updates/rublevo/4.png", parent ):ibSetRealSize( )

					CreateMoreButton( 205, 340, parent, function( key, state )
						if key ~= "left" or state ~= "up" then return end
						ibClick( )
						ShowInfoUI( false )
						triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
					end )

					return parent
				end
			) or last_image

			last_image = CreateSegmentedBlock( 0, last_image:ibGetAfterY( ), parent,
				function( )
                    return IsOfferActiveForModel( "special", 6541 )
				end,

				function( px, py, parent )
					local parent = ibCreateImage( px, py, 0, 0, "img/items/updates/rublevo/5.png", parent ):ibSetRealSize( )

					CreateMoreButton( 205, 359, parent, function( key, state )
						if key ~= "left" or state ~= "up" then return end
						ibClick( )
						ShowInfoUI( false )
						triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
					end )

					return parent
				end
			) or last_image

			last_image = CreateSegmentedBlock( 0, last_image:ibGetAfterY( ), parent,
				function( )
					return IsOfferActiveForModel( "special", 6542 )
				end,

				function( px, py, parent )
					local parent = ibCreateImage( px, py, 0, 0, "img/items/updates/rublevo/6.png", parent ):ibSetRealSize( )

					CreateMoreButton( 205, 379, parent, function( key, state )
						if key ~= "left" or state ~= "up" then return end
						ibClick( )
						ShowInfoUI( false )
						triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
					end )

					return parent
				end
			) or last_image

			last_image = ibCreateImage( 0, last_image:ibGetAfterY( ), 0, 0, "img/items/updates/rublevo/7.png", parent ):ibSetRealSize( )
            CreatePointButton( 175, 340, last_image, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                ibClick( )
				ShowInfoUI( false )
				triggerEvent( "ToggleGPS", localPlayer, 
				{
					{ x = -1011.702, y = -615.423, z = 21.773 };
					{ x = 1782.086, y = 231.281, z = 60.852 };
				} )
            end )

			last_image = ibCreateImage( 0, last_image:ibGetAfterY( ), 0, 0, "img/items/updates/rublevo/8.png", parent ):ibSetRealSize( )

            return last_image:ibGetAfterY( )
        end
    },
    {   "Штрафы, кейс и скидки",
        create_fn = function( parent )
            local image = ibCreateImage( 0, 0, 0, 0, "img/items/updates/tab_dps_fines.png", parent ):ibSetRealSize( )

            -- Штрафы
            CreateMoreButton( 205, 425, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                ibClick( )
                SwitchToTabSimulated( 2, 20 )
			end )

            -- Кейс
            CreateMoreButton( 205, 905, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                ibClick( )
                ShowInfoUI( false )
                triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "cases" )
			end )

            -- Аксессуары
            CreateMoreButton( 205, 1309, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                ibClick( )
				ShowInfoUI( false )
                triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
            end )

            return image:ibData( "sy" )
        end
    },
    {   "Сотрудник ЖКХ и фиксы",
        create_fn = function( parent )
            local last_image = ibCreateImage( 0, 0, 0, 0, "img/items/updates/tab_hcs_1.png", parent ):ibSetRealSize( )

            CreateMoreButton( 205, 398, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                ibClick( )
                SwitchToTabSimulated( 2, 13, 12 )
			end )
					
			CreateMoreButton( 205, 822, parent, function( key, state )
				if key ~= "left" or state ~= "up" then return end
				ibClick( )
				ShowInfoUI( false )
				triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "offers" )
			end )

			last_image = CreateSegmentedBlock( 0, last_image:ibGetAfterY( ), parent,
				function( )
					return IsOfferActiveForModel( "special", 562 )
				end,

				function( px, py, parent )
					local parent = ibCreateImage( px, py, 0, 0, "img/items/updates/tab_hcs_2.png", parent ):ibSetRealSize( )
					
					CreateMoreButton( 205, 376, parent, function( key, state )
						if key ~= "left" or state ~= "up" then return end
						ibClick( )
						ShowInfoUI( false )
						triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
					end )

					return parent
				end
			) or last_image

			last_image = CreateSegmentedBlock( 0, last_image:ibGetAfterY( ), parent,
				function( )
					return IsOfferActiveForModel( "special", 534 )
				end,

				function( px, py, parent )
					local parent = ibCreateImage( px, py, 0, 0, "img/items/updates/tab_hcs_3.png", parent ):ibSetRealSize( )
					
					CreateMoreButton( 205, 340, parent, function( key, state )
						if key ~= "left" or state ~= "up" then return end
						ibClick( )
						ShowInfoUI( false )
						triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
					end )

					return parent
				end
			) or last_image

			last_image = ibCreateImage( 0, last_image:ibGetAfterY( ), 0, 0, "img/items/updates/tab_hcs_4.png", parent ):ibSetRealSize( )

            return last_image:ibGetAfterY( )
        end
    },
    {   "Сокровища и контент!",
        create_fn = function( parent )
            local image = ibCreateImage( 0, 0, 0, 0, "img/items/updates/tab_hobby_digging.png", parent ):ibSetRealSize( )

            -- Хобби
            CreateMoreButton( 205, 398, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                ibClick( )
                SwitchToTabSimulated( 2, 19, 4 )
			end )

            -- Акция КБ
            CreateMoreButton( 205, 898, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                ibClick( )
                ShowInfoUI( false )
                triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "offers" )
			end )

            -- Новый кейс
            CreateMoreButton( 205, 1358, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                ibClick( )
                ShowInfoUI( false )
                triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "cases" )
            end )

            -- Новые скины спешал
            CreateMoreButton( 205, 1762, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                ibClick( )
                ShowInfoUI( false )
                triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
            end )

            -- Новая тачка спешал
            CreateMoreButton( 205, 2167, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                ibClick( )
                ShowInfoUI( false )
                triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
			end )

            return image:ibData( "sy" )
        end
    },
    {   "Чат 2.0 и мотосалон",
        create_fn = function( parent )
            local image = ibCreateImage( 0, 0, 0, 0, "img/items/updates/tab_moto.png", parent ):ibSetRealSize( )

            -- Мотосалон
            CreatePointButton( 175, 900, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                ibClick( )
				ShowInfoUI( false )
				triggerEvent( "ToggleGPS", localPlayer, 
				{ x = -256.490, y = -1041.199, z = 20.802 } )
            end )

            -- Снова мотосалон
            CreatePointButton( 175, 1415, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                ibClick( )
				ShowInfoUI( false )
				triggerEvent( "ToggleGPS", localPlayer, 
				{ x = -256.490, y = -1041.199, z = 20.802 } )
            end )

            -- Кейсы
            CreateMoreButton( 205, 1857, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                ibClick( )
                ShowInfoUI( false )
                triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "cases" )
			end )

            -- Новая тачка спешал
            CreateMoreButton( 205, 2300, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                ibClick( )
                ShowInfoUI( false )
                triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
            end )

            -- Новые скины спешал
            CreateMoreButton( 205, 2704, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                ibClick( )
                ShowInfoUI( false )
                triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
            end )

            return image:ibData( "sy" )
        end
    },
    {   ".:: FAST & FURIOUS NEXTRP ::.",
        create_fn = function( parent )
            local image = ibCreateImage( 0, 0, 0, 0, "img/items/updates/tab_fast_and_furious.png", parent ):ibSetRealSize( )

            -- Номера в тюнинге (F1)
            CreateMoreButton( 205, 377, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                SwitchToTabSimulated( 2, 16 )
            end )

            -- Тематическое обновление (спешал)
            CreateMoreButton( 205, 1247, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                ibClick( )
                ShowInfoUI( false )
                triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
            end )

            -- Новые скины (спешал)
            CreateMoreButton( 205, 1651, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                ibClick( )
                ShowInfoUI( false )
                triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
			end )

            -- Новая тачка в автосалоне
            CreateMoreButton( 205, 2055, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                ibClick( )
                ShowInfoUI( false )
                triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
            end )

            return image:ibData( "sy" )
        end
    },
    {   "Аксессуары и 1-е сентября",
        create_fn = function( parent )
            local image = ibCreateImage( 0, 0, 0, 0, "img/items/updates/tab_gde_obnova_suka.png", parent ):ibSetRealSize( )

            -- Аксессуары и новый магазин одежды
            CreatePointButton( 176, 728, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                ibClick( )
				ShowInfoUI( false )
				triggerEvent( "ToggleGPS", localPlayer, {
					{ x = 2.541, y = -1061.981, z = 20.971 },
					{ x = 2315.366, y = 295.722, z = 62.415 },
					{ x = 1656.487, y = 1572.523, z = 16.160 },
				} )
            end )

            -- Уникальная машина (спешил)
            CreateMoreButton( 205, 1168, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                ibClick( )
                ShowInfoUI( false )
                triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
            end )

            -- Новая тачка в автосалоне
            CreatePointButton( 176, 1592, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                ibClick( )
				ShowInfoUI( false )
				triggerEvent( "ToggleGPS", localPlayer, 
				{ x = 2044.341, y = 56.338, z = 62.621 } )
            end )

            -- Новые скины (спешал)
            CreateMoreButton( 205, 2015, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                ibClick( )
                ShowInfoUI( false )
                triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
            end )

            return image:ibData( "sy" )
        end
    },
    {   "Автомобили любят все",
        create_fn = function( parent )
            local image = ibCreateImage( 0, 0, 0, 0, "img/items/updates/tab_diamond_case.png", parent ):ibSetRealSize( )

            -- Бриллиантовый кейс
            CreateMoreButton( 205, 359, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                ibClick( )
                ShowInfoUI( false )
                triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "cases" )
            end )

            -- Уникальная машина (спешил)
            CreateMoreButton( 205, 763, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                ibClick( )
                ShowInfoUI( false )
                triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
            end )

            -- Новая тачка в автосалоне
            CreatePointButton( 175, 1187, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                ibClick( )
				ShowInfoUI( false )
				triggerEvent( "ToggleGPS", localPlayer, 
				{ x = 1792.201, y = 234.227, z = 60.704 } )
            end )

            -- Новые скины (спешал)
            CreateMoreButton( 205, 1610, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                ibClick( )
                ShowInfoUI( false )
                triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
            end )
            
            return image:ibData( "sy" )
        end
    },
    {   "Оптимизация и контент!",
        create_fn = function( parent )
            local image = ibCreateImage( 0, 0, 0, 0, "img/items/updates/tab_daily_quests.png", parent ):ibSetRealSize( )

            -- Ежедневные задачи
            CreateMoreButton( 205, 356, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                ibClick( )
                ShowInfoUI( false )
                triggerEvent( "ShowUIQuestsList", localPlayer )
            end )

            -- Новый журнал квестов F2
            CreateMoreButton( 205, 782, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                ibClick( )
                ShowInfoUI( false )
				triggerEvent( "ShowUIQuestsList", localPlayer )
            end )

            -- Кадилак в F4
            CreateMoreButton( 205, 1651, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                ibClick( )
                ShowInfoUI( false )
                triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
            end )

            -- Новые бизнесы
            CreateMoreButton( 205, 2093, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                ibClick( )
                SwitchToTabSimulated( 2, 7, 1 )
            end )

            -- Скины в магазине одежды
            CreatePointButton( 175, 2532, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                ibClick( )
				ShowInfoUI( false )
				triggerEvent( "ToggleGPS", localPlayer, {
					{ x = 2.541, y = -1061.981, z = 20.971 },
					{ x = 2315.366, y = 295.722, z = 62.415 },
					{ x = 1656.487, y = 1572.523, z = 16.160 },
				} )
            end )

            -- Новые автомобили в автосалонах
            CreatePointButton( 175, 2971, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                ibClick( )
				ShowInfoUI( false )
				triggerEvent( "ToggleGPS", localPlayer, {
					{ x = 1792.201, y = 234.227, z = 60.704 },
					{ x = 2044.341, y = 56.338, z = 62.621 },
				} )
            end )
            
            return image:ibData( "sy" )
        end
    },
    {   "Новые режимы банд",
        create_fn = function( parent )
            local image = ibCreateImage( 0, 0, 0, 0, "img/items/updates/tab_gang_wars.png", parent ):ibSetRealSize( )

            -- Банды
            CreateMoreButton( 205, 401, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                SwitchToTabSimulated( 2, 6, 1 )
            end )

            -- Срочка
            CreateMoreButton( 205, 865, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                ibClick( )
                SwitchToTabSimulated( 2, 18, 2 )
            end )

            -- Дальнобойщик
            CreateMoreButton( 205, 1307, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                SwitchToTabSimulated( 2, 13, 6 )
            end )

            -- Кейс мотор
            CreateMoreButton( 205, 1767, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                ibClick( )
                ShowInfoUI( false )
                triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "cases" )
            end )

            -- Уники F4
            CreateMoreButton( 205, 2209, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                ibClick( )
                ShowInfoUI( false )
                triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
            end )

            -- Скины в магазине одежды
            CreatePointButton( 175, 2667, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                ibClick( )
				ShowInfoUI( false )
				triggerEvent( "ToggleGPS", localPlayer, {
					{ x = 2.541, y = -1061.981, z = 20.971 },
					{ x = 2315.366, y = 295.722, z = 62.415 },
					{ x = 1656.487, y = 1572.523, z = 16.160 },
				} )
            end )
            
            return image:ibData( "sy" )
        end
    },
    {   "Лодки, Дровосек",
        create_fn = function( parent )
            local image = ibCreateImage( 0, 0, 0, 0, "img/items/updates/tab_boats.png", parent ):ibSetRealSize( )

            -- Дровосек
            CreateMoreButton( 205, 475, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                SwitchToTabSimulated( 2, 13, 11 )
            end )

            -- Кейсы
            CreateMoreButton( 205, 900, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                ibClick( )
                triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "cases" )
            end )

            -- Лодки
            CreateMoreButton( 205, 1363, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                SwitchToTabSimulated( 2, 15, 3 )
            end )

            -- Бумер
            CreateMoreButton( 205, 1806, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                ibClick( )
                ShowInfoUI( false )
                triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
            end )

            -- Скины
            CreateMoreButton( 205, 2230, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                ibClick( )
                ShowInfoUI( false )
                triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
            end )
            
            return image:ibData( "sy" )
        end
    },
    {   "Олимпийский Парк",
        create_fn = function( parent )
            local image = ibCreateImage( 0, 0, 0, 0, "img/items/updates/tab_newmap.png", parent ):ibSetRealSize( )

            -- Новый премиум
            CreateMoreButton( 205, 787, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                ibClick( )
                ShowInfoUI( false )
                triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "premium" )
            end )

            -- Новые работы
            CreateMoreButton( 205, 1268, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                SwitchToTabSimulated( 2, 13, 9 )
            end )

            -- Спешл с Ф4
            CreateMoreButton( 205, 1692, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                ibClick( )
                ShowInfoUI( false )
                triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "special" )
            end )
            
            return image:ibData( "sy" )
        end
    },
    {   "Мэрия 2.0, Акции и Скидки!",
        create_fn = function( parent )
            local image = ibCreateImage( 0, 0, 0, 0, "img/items/updates/tab_gallardo.png", parent ):ibSetRealSize( )

            -- Скидон кейсы
            CreateMoreButton( 205, 360, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                ShowInfoUI( false )
                triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "cases" )
            end )

            -- Новый кейс
            CreateMoreButton( 205, 784, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                ShowInfoUI( false )
                triggerServerEvent( "onPlayerRequestDonateMenu", localPlayer, "cases" )
            end )

            -- Gallardo
            CreateMoreButton( 205, 1207, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                ShowInfoUI( false )
                triggerEvent( "ShowUI_BRPromo", localPlayer, true, true )
            end )
            
            return image:ibData( "sy" )
        end
    },
    {   "Мэрия и новый Магазин!",
        create_fn = function( parent )
            local image = ibCreateImage( 0, 0, 0, 0, "img/items/updates/tab_mayoralty.png", parent ):ibSetRealSize( )

            -- Мэрия
            CreateMoreButton( 205, 379, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                SwitchToTabSimulated( 2, 17, 7 )
            end )
            
            return image:ibData( "sy" )
        end
    },
    {   "Лётчик, Обучение и Акция!",
        create_fn = function( parent )
            local image = ibCreateImage( 0, 0, 0, 0, "img/items/updates/tab_pilot.png", parent ):ibSetRealSize( )

            -- Рулетка
            CreateMoreButton( 205, 398, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                SwitchToTabSimulated( 2, 13, 8 )
            end )
            
            -- Кейс
            CreateMoreButton( 205, 822, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                ibClick( )
                ShowInfoUI( false )
                triggerServerEvent( "ShowPayoffer", localPlayer )
            end )

            return image:ibData( "sy" )
        end
    },
    {   "\"Южный\", Рулетка, Скидки!",
        create_fn = function( parent )
            local image = ibCreateImage( 0, 0, 0, 0, "img/items/updates/tab_roulette.png", parent ):ibSetRealSize( )

            -- Рулетка
            CreateMoreButton( 205, 399, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                SwitchToTabSimulated( 2, 14, 4 )
            end )
            
            -- Кейс
            CreateMoreButton( 205, 843, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                ibClick( )
                ShowInfoUI( false )
                triggerServerEvent( "PlayerRequestRegisteredCases", localPlayer )
            end )

            return image:ibData( "sy" )
        end
    },
    {   "Кости и Безумный Кейс",
        create_fn = function( parent )
            local image = ibCreateImage( 0, 0, 0, 0, "img/items/updates/tab_dices.png", parent ):ibSetRealSize( )

            -- Кейс
            CreateMoreButton( 205, 456, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                ibClick( )
                ShowInfoUI( false )
                triggerServerEvent( "PlayerRequestRegisteredCases", localPlayer )
            end )

            -- Кости
            CreateMoreButton( 205, 918, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                SwitchToTabSimulated( 2, 14, 4 )
            end )

            return image:ibData( "sy" )
        end
    },
    {   "Кинотеатр и улучшения",
        create_fn = function( parent )
            local image = ibCreateImage( 0, 0, 0, 0, "img/items/updates/tab_cinema.png", parent ):ibSetRealSize( )

            -- Кинотеатр
            CreateMoreButton( 205, 418, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                SwitchToTabSimulated( 2, 14, 2 )
            end )

            -- F2
            CreateMoreButton( 205, 860, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                ibClick( )
                ShowInfoUI( false )
                triggerEvent( "ShowUIQuestsList", localPlayer )
            end )

            -- Авиаремонт
            CreateMoreButton( 205, 1302, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                SwitchToTabSimulated( 2, 3, 3 )
            end )

            return image:ibData( "sy" )
        end
    },
    {   "Авиасалон и Кейс",
        create_fn = function( parent )
            local image = ibCreateImage( 0, 0, 0, 0, "img/items/updates/tab_aero.png", parent ):ibSetRealSize( )

            -- Инфо по авиашколе
            CreateMoreButton( 205, 398, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                SwitchToTabSimulated( 2, 4, 3 )
            end )

            -- Инфо по салону
            CreateMoreButton( 205, 1122, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                SwitchToTabSimulated( 2, 2, 6 )
            end )

            -- Кейс Данилыча
            CreateMoreButton( 205, 1564, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                ShowInfoUI( false )
                triggerServerEvent( "PlayerRequestRegisteredCases", localPlayer )
            end )

            return image:ibData( "sy" )
        end
    },
    {   "Охота и Автомобили",
        create_fn = function( parent )
            local image = ibCreateImage( 0, 0, 0, 0, "img/items/updates/tab_hunting.png", parent ):ibSetRealSize( )

            -- Инфо по охоте
            CreateMoreButton( 205, 398, parent, function( key, state )
                if key ~= "left" or state ~= "up" then return end
                SwitchToTabSimulated( 2, 18, 3 )
            end )

            return image:ibData( "sy" )
        end
    },
    { "Такси и Уровни", "tab_taxi" },
    { "Рыбалка, Бизнесы, Квест", "tab_fisher" },
    { "Коттеджи, Акция, Фиксы", "tab_countryhouse" },
    { "Бизнесы, Кейсы, Квартиры", "tab_businesses" },
    { "Новая карта и Фермер", "tab_map" },
}

UPDATES_LIST = { }
for i, v in pairs( UPDATES ) do
	if not v.start_time or v.start_time < getRealTimestamp( ) then
		table.insert(
			UPDATES_LIST,
			{
				name = v[ 1 ],
				create_fn = v.create_fn or function( parent )
					local image = ibCreateImage( 0, 0, 0, 0, "img/items/updates/" .. v[ 2 ] .. ".png", parent ):ibSetRealSize( )
					return image:ibData( "sy" )
				end,
			}
		)
	end

	if v.start_time and v.start_time < getRealTimestamp( ) then
		LAST_UPDATE = math.max( LAST_UPDATE, v.start_time )
	end
end
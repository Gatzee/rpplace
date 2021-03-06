loadstring(exports.interfacer:extend("Interfacer"))()
Extend("CQuest")
Extend("CUI")

IGNORE_GPS_ROUTE = true

PROXY_TREES = {}
RESTORE_TREES = {}

CENTER_WOOD_POINT = Vector3( 1866.3865, 333.7227, 16.3713 )
CURRENT_BUNCH_ID = nil
CURRENT_WOOD_ID = nil
BUNCH_TREES = 
{
	{
		name = "stock_1_bunch_1", 
		position = Vector3( 1743.5664, 100.0573, 12.6145 ),
		woods =
		{
			Vector3( 1755.1003, 86.3726, 13.6672 ),
			Vector3( 1768.0964, 94.1979, 14.7893 ),
			Vector3( 1770.5532, 105.6065, 15.9023 ),
			Vector3( 1758.0111, 110.4114, 15.8158 ),
			Vector3( 1747.8386, 120.0488, 16.1888 ),
			Vector3( 1734.7028, 115.4709, 15.4038 ),
			Vector3( 1721.9938, 119.1502, 15.278 ),
			Vector3( 1725.4782, 105.4263, 14.3593 ),
			Vector3( 1722.0231, 92.4369, 13.2764 ),
			Vector3( 1728.0988, 80.7227, 12.5903 ),
			Vector3( 1739.376, 76.0934, 12.5466 ),
			Vector3( 1742.9559, 86.8181, 13.373 ),
			Vector3( 1756.2908, 98.0166, 14.6993 ),
			Vector3( 1758.7498, 122.0474, 16.4049 ),
			Vector3( 1731.5755, 129.5303, 15.9156 ),
			Vector3( 1716.453, 81.8012, 12.8111 ),
			Vector3( 1723.6456, 67.6819, 11.6376 ),
			Vector3( 1742.3892, 61.9711, 11.4963 ),
			Vector3( 1767.7775, 71.8134, 12.862 ),
			Vector3( 1775.994, 85.6798, 14.3977 ),
		} ,
	},

	{
		name = "stock_1_bunch_1", 
		position = Vector3( 2012.0762, 324.2255, 15.9221 ),
		woods = 
		{
			Vector3( 1996.7683, 309.1562, 16.9592 ),
			Vector3( 2001.1335, 289.4417, 16.9592 ),
			Vector3( 2016.7974, 293.0513, 16.9592 ),
			Vector3( 2034.5106, 296.4492, 16.7101 ),
			Vector3( 2045.5539, 308.6851, 16.3901 ),
			Vector3( 2048.5437, 328.9761, 16.3901 ),
			Vector3( 2043.2768, 345.8758, 17.0355 ),
			Vector3( 2030.6313, 356.4364, 17.3264 ),
			Vector3( 2015.3533, 364.4385, 17.0769 ),
			Vector3( 1995.4063, 359.1573, 17.8223 ),
			Vector3( 1987.481, 340.1367, 19.2136 ),
			Vector3( 1992.225, 321.5463, 17.8099 ),
			Vector3( 1987.8912, 291.6505, 16.9592 ),
			Vector3( 2006.3603, 303.0621, 16.9592 ),
			Vector3( 2028.2487, 309.222, 16.5683 ),
			Vector3( 2034.1544, 333.0102, 16.3889 ),
			Vector3( 2016.8281, 341.8902, 17.4877 ),
			Vector3( 2010.94, 274.4743, 16.9592 ),
			Vector3( 2028.238, 276.7686, 16.9592 ),
			Vector3( 2036.9775, 319.2812, 16.3901 ),
		},
	},

	{
		name = "stock_1_bunch_1",
		position = Vector3( 1772.9842, 548.7584, 15.5850 ),
		woods =
		{
			Vector3( 1783.8325, 567.0002, 17.054 ),
			Vector3( 1792.2659, 557.3088, 17.2625 ),
			Vector3( 1796.3873, 548.0125, 17.486 ),
			Vector3( 1794.84, 537.8461, 17.7023 ),
			Vector3( 1784.9866, 534.2829, 16.6113 ),
			Vector3( 1777.2911, 528.7188, 15.9046 ),
			Vector3( 1768.8387, 533.3276, 15.8614 ),
			Vector3( 1758.3405, 540.6573, 15.8614 ),
			Vector3( 1754.0612, 548.9749, 15.8823 ),
			Vector3( 1761.3908, 553.7812, 16.2726 ),
			Vector3( 1759.6334, 566.3308, 16.8742 ),
			Vector3( 1770.0725, 575.1262, 17.5109 ),
			Vector3( 1784.408, 564.441, 17.0716 ),
			Vector3( 1787.215, 546.9569, 17.4666 ),
			Vector3( 1773.3371, 523.7449, 15.8614 ),
			Vector3( 1762.9656, 528.0136, 15.8614 ),
			Vector3( 1747.3482, 536.9733, 15.8614 ),
			Vector3( 1755.3741, 556.6042, 16.2488 ),
			Vector3( 1768.1789, 562.4482, 16.8247 ),
			Vector3( 1784.0476, 577.1678, 17.2538 ),
		} 
	},

	{
		name = "stock_1_bunch_1", 
		position = Vector3( 1671.9334, 425.7666, 19.0243 ),
		woods =
		{
			Vector3( 1664.971, 410.9726, 18.95 ),
			Vector3( 1672.2012, 400.4027, 18.7899 ),
			Vector3( 1684.5257, 399.3643, 19.277 ),
			Vector3( 1686.5051, 400.3509, 19.4069 ),
			Vector3( 1685.9287, 412.9388, 19.8847 ),
			Vector3( 1695.598, 420.2949, 20.0392 ),
			Vector3( 1693.0076, 429.158, 20.2543 ),
			Vector3( 1701.8935, 434.2578, 19.7338 ),
			Vector3( 1695.9097, 442.1226, 19.0236 ),
			Vector3( 1680.6456, 439.8341, 18.997 ),
			Vector3( 1678.5032, 450.8023, 18.4004 ),
			Vector3( 1694.3193, 451.2072, 18.4004 ),
			Vector3( 1686.5191, 422.3986, 20.0834 ),
			Vector3( 1661.7689, 452.5458, 18.2804 ),
			Vector3( 1645.7503, 446.4561, 17.5181 ),
			Vector3( 1676.4383, 409.5039, 19.3807 ),
			Vector3( 1709.4687, 416.216, 19.0896 ),
			Vector3( 1716.3015, 429.4521, 19.1203 ),
			Vector3( 1710.3187, 448.2718, 18.7302 ),
			Vector3( 1705.6489, 460.0726, 18.4004 ),
		},
	},
}

STOCKS =
{
    --???????????? 1 ????????????????, ???????????????? 2
	[ "stock_1_bunch_1" ] = 0,
	
}

local CONTROLS = { "next_weapon ", "previous_weapon", "fire", "aim_weapon" }
function SetControlState( state )
	for k, v in pairs( CONTROLS ) do
		toggleControl( v, state )
	end
end

function RestorePrevTrees()
	for k, v in pairs( RESTORE_TREES ) do
		v:setAlpha( 255 )
		v:setRotation( 0, 0, math.random(0, 360) )
		v:setCollisionsEnabled( true )
		local position = v:getPosition()
		v:setPosition( position.x, position.y, position.z )
	end
end

--???????????? ??????????????, ???????????????????????? ?????????????? ???????????? ???????????????????????? ????????????
function StartCheckPosition( target )
	CHECK_POS_TIMER = Timer( function( )
		if getDistanceBetweenPoints3D( target.x, target.y, target.z, getElementPosition( localPlayer ) ) > 350 then
			triggerServerEvent( "onJobEndShiftRequest", resourceRoot )
			resetWoodcutterSetting( )
		end
	end, 5000, 0 )
end

function onFailQuestEnterInVehicle( player )
	local vehicle_model = source:getModel()
	if player == localPlayer and vehicle_model ~= 400  then
		triggerServerEvent( "onJobEndShiftRequest", localPlayer )
	end
end

addEventHandler( "onClientResourceStart", resourceRoot, function()
	CQuest( QUEST_DATA )
	
	for k, v in pairs( BUNCH_TREES ) do
		for key_tree, value_tree in pairs( v.woods ) do
			PROXY_TREES[ k .. key_tree ] = Object( 781, value_tree.x, value_tree.y, value_tree.z - 1 )
			PROXY_TREES[ k .. key_tree ]:setRotation( 0, 0, math.random(0, 360))
		end
	end

end )

--???????? ???????????? ?????????? ?????????????????????? ???? ?????????? ?????????????? ?????????? ???????????????????? ????????????
function resetWoodcutterSetting()
	localPlayer:setFrozen( false )
	localPlayer:setAnimation()
	GAME_STEP = nil
	CURRENT_GAME = nil
	if CURRENT_UI_ELEMENT then
		CURRENT_UI_ELEMENT:destroy()
		CURRENT_UI_ELEMENT = nil
	end
	if isTimer( CHECK_POS_TIMER ) then
		killTimer( CHECK_POS_TIMER )
		CHECK_POS_TIMER = nil
	end
	removeEventHandler( "onClientVehicleEnter", root, onFailQuestEnterInVehicle )
	RestorePrevTrees()
	SetControlState( true )
	SetCarryingState( false )
end
addEventHandler( "onClientResourceStop", resourceRoot, resetWoodcutterSetting )

addEvent("onWoodcutterCompany_1_EndShiftRequestReset", true)
addEventHandler( "onWoodcutterCompany_1_EndShiftRequestReset", root, resetWoodcutterSetting )



function onWoodcutterRefreshStockValue_handler( stock, value )
	if type( stock ) == "table" then
		for k, v in pairs( stock ) do
			if STOCKS[ k ] then
				STOCKS[ k ] = v
			end
		end
	else
		if STOCKS[ stock ] then
			STOCKS[ stock ] = value
		end
	end
end
addEvent( "onWoodcutterRefreshStockValue", true )
addEventHandler( "onWoodcutterRefreshStockValue", root, onWoodcutterRefreshStockValue_handler )


local carrying_controls = { "jump", "sprint", "crouch", "enter_exit", }
function SetCarryingState( value )
	for k, v in pairs( carrying_controls ) do
		toggleControl( v, not value )
	end
end
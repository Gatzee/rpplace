if localPlayer then
    BANK_NPC_POSITION = Vector3( 295.370, -898.076, 21.876 )

    local ped = createPed(160, BANK_NPC_POSITION)
    ped.rotation = Vector3( 0, 0, 180)
    setTimer(setElementFrozen, 250, 1, ped, true)
    addEventHandler("onClientPedDamage", ped, cancelEvent)
end

CONST_LOAD_VEHICLE_TIME = 6 * 60
CONST_FAIL_SHIFT_EMPTY_VEHICLE = 5 * 60

MAX_DISTANCE_BETWEEN_VEHICLE = 300
MAX_DISTANCE_BETWEEN_VEHICLE_FAIL_TIME = 30

BANK_LOAD_POINT = {
    {
        collect = Vector3( 215.13, -349.18, 19.88 ),
        parking = Vector3( 172.38, -312.18, 19.7 ),
    },
    {
        collect = Vector3( 749.21, -363.24, 19.7 ),
        parking = Vector3( 759.33, -388.68, 19.7 ),
    },
    {
        collect = Vector3( 721.54, -204.78, 26.63 ),
        parking = Vector3( 704.01, -162.28, 19.7 ),
    },
    {
        collect = Vector3( 488.94, -161.25, 19.7 ),
        parking = Vector3( 449.67, -166.06, 19.7 ),
    },
    {
        collect = Vector3( -94.31, -745.54, 1.15 ),
        parking = Vector3( -3.11, -701.31, 17.27 ),
    },
    {
        collect = Vector3( 388.01, -137.9, 19.89 ),
        parking = Vector3( 354.35, -146.18, 19.7 ),
    },
    {
        collect = Vector3( 1596.18, -551.72, 35.68 ),
        parking = Vector3( 1577.75, -573.05, 35.63 ),
    },
    {
        collect = Vector3( 1558.92, -428.33, 35.77 ),
        parking = Vector3( 1564.64, -470.84, 36.08 ),
    },
    {
        collect = Vector3( 1662.43, -248.78, 26.2 ),
        parking = Vector3( 1637.83, -305.96, 26.53 ),
    },
    {
        collect = Vector3( 1640.21, -241.98, 26.29 ),
        parking = Vector3( 1619.09, -244.68, 26.34 ),
    },
    {
        collect = Vector3( 1955.47, 293.41, 15.64 ),
        parking = Vector3( 1921.52, 372.02, 15.72 ),
    },
    {
        collect = Vector3( 2106.63, 927.96, 15.39 ),
        parking = Vector3( 2084.26, 964.46, 15.39 ),
    },
    {
        collect = Vector3( 1684.77, 686.76, 15.14 ),
        parking = Vector3( 1659.71, 624.47, 15.14 ),
    },
    {
        collect = Vector3( 1519.1, 653.78, 19.27 ),
        parking = Vector3( 1612.39, 668.47, 15.17 ),
    },
    {
        collect = Vector3( 1671.63, 1006.95, 15.17 ),
        parking = Vector3( 1620.14, 1000.88, 15.17 ),
    },
    {
        collect = Vector3( 2194.68, 1568.58, 15.18 ),
        parking = Vector3( 2154.68, 1644.42, 15.17 ),
    },
    {
        collect = Vector3( 2119.39, 1575.63, 15 ),
        parking = Vector3( 2163.33, 1633.33, 15.17 ),
    },
    {
        collect = Vector3( 2038.26, 1487.03, 15.17 ),
        parking = Vector3( 2098.15, 1542.64, 15.18 ),
    },
    {
        collect = Vector3( 1590.45, 753.14, 15.14 ),
        parking = Vector3( 1633.02, 731.09, 15.14 ),
    },
    {
        collect = Vector3( 349.07, 997.69, 20.78 ),
        parking = Vector3( 333.57, 973.78, 20.78 ),
    },
    {
        collect = Vector3( 740.26, -427.68, 19.89 ),
        parking = Vector3( 720.26, -480.52, 19.7 ),
    },
    {
        collect = Vector3( 1359.34, 2579.22, 9.09 ),
        parking = Vector3( 1323.81, 2491.77, 9.09 ),
    },
    {
        collect = Vector3( 1298.45, 2692.57, 9.89 ),
        parking = Vector3( 1221.19, 2652.59, 8.86 ),
    },
    {
        collect = Vector3( 933.28, 2454.57, 14.19 ),
        parking = Vector3( 942.6, 2523.31, 7.45 ),
    },
    {
        collect = Vector3( 886.53, 2285.94, 11.48 ),
        parking = Vector3( 830.09, 2289.26, 12.12 ),
    },
    {
        collect = Vector3( 850.72, 2382.19, 10.64 ),
        parking = Vector3( 900.64, 2332.08, 11.47 ),
    },
    {
        collect = Vector3( 731.09, 2365.35, 13.59 ),
        parking = Vector3( 698.53, 2300.47, 13.62 ),
    },
    {
        collect = Vector3( 1277.6, 2376.35, 10.64 ),
        parking = Vector3( 1245.03, 2353.05, 9.03 ),
    },
    {
        collect = Vector3( 1347.81, 2302.56, 8.53 ),
        parking = Vector3( 1385.04, 2280.29, 7.81 ),
    },
    {
        collect = Vector3( 1438.81, 2301.12, 8.22 ),
        parking = Vector3( 1471.05, 2268.43, 8.3 ),
    },
    {
        collect = Vector3( 1440.1, 2214.65, 8.26 ),
        parking = Vector3( 1420.88, 2166.79, 8.1 ),
    },
    {
        collect = Vector3( 1440.38, 2268.4, 8.26 ),
        parking = Vector3( 1414.02, 2258.36, 8.07 ),
    },
    {
        collect = Vector3( 1177.21, 2245.57, 8.27 ),
        parking = Vector3( 1197.15, 2285.91, 8.07 ),
    },
    {
        collect = Vector3( 1021.71, 2208.85, 7.98 ),
        parking = Vector3( 1093.65, 2226.68, 7.76 ),
    },
    {
        collect = Vector3( 658.65, 2244.18, 13.77 ),
        parking = Vector3( 730.21, 2206.78, 13.56 ),
    },
    {
        collect = Vector3( 1314.8, 2252.91, 8.27 ),
        parking = Vector3( 1326.43, 2308.22, 8.34 ),
    },
    {
        collect = Vector3( 1295.41, 2226.81, 8.02 ),
        parking = Vector3( 1266.94, 2191.28, 7.84 ),
    },
    {
        collect = Vector3( 457.26, 2590.97, 16.2 ),
        parking = Vector3( 476.5, 2640.22, 14.52 ),
    },
    {
        collect = Vector3( 325.57, 2716.43, 20.09 ),
        parking = Vector3( 364.35, 2663.08, 20.09 ),
    },
    {
        collect = Vector3( 270.63, 2775.01, 20.1 ),
        parking = Vector3( 214.36, 2755.1, 16.9 ),
    },
    {
        collect = Vector3( 347.1, 2555.22, 20.34 ),
        parking = Vector3( 391.48, 2512.62, 20.47 ),
    },
    {
        collect = Vector3( -85.82, 2510.87, 20.6 ),
        parking = Vector3( -48, 2461.13, 20.6 ),
    },
    {
        collect = Vector3( -444.52, 2484.53, 15.56 ),
        parking = Vector3( -434.09, 2519.14, 15.89 ),
    },
    {
        collect = Vector3( -385.74, 2413.15, 14.14 ),
        parking = Vector3( -360.99, 2459.12, 14.19 ),
    },
    {
        collect = Vector3( -543.91, 2206.22, 14.84 ),
        parking = Vector3( -524, 2200.71, 14.62 ),
    },
    {
        collect = Vector3( -589.91, 2399.14, 20.37 ),
        parking = Vector3( -522.8, 2437.64, 14.93 ),
    },
    {
        collect = Vector3( -592.17, 2502.51, 16.39 ),
        parking = Vector3( -619.09, 2467.17, 16.47 ),
    },
    {
        collect = Vector3( -676.61, 2632.4, 17.94 ),
        parking = Vector3( -663.92, 2599.36, 16.71 ),
    },
    {
        collect = Vector3( -714.84, 2401.17, 17.79 ),
        parking = Vector3( -723.85, 2350.19, 18.01 ),
    },
    {
        collect = Vector3( -781.85, 2335.44, 17.95 ),
        parking = Vector3( -816.6, 2298.67, 17.83 ),
    },
    {
        collect = Vector3( -870.66, 2443.38, 18.64 ),
        parking = Vector3( -856.47, 2492.95, 17.54 ),
    },
    {
        collect = Vector3( -686.41, 1818.07, 10.44 ),
        parking = Vector3( -675.11, 1851.83, 10.23 ),
    },
    {
        collect = Vector3( -995.68, 2260.26, 15.1 ),
        parking = Vector3( -1036.73, 2228.6, 15.24 ),
    },
    {
        collect = Vector3( -1610.53, 2472.44, 9.5 ),
        parking = Vector3( -1632.57, 2468.1, 9.5 ),
    },
    {
        collect = Vector3( -1410.69, 2766.94, 14.13 ),
        parking = Vector3( -1440.15, 2765.63, 14.13 ),
    },
    {
        collect = Vector3( -1267.81, 2649.26, 16.88 ),
        parking = Vector3( -1347.04, 2681.13, 14.31 ),
    },
    {
        collect = Vector3( -1398.44, 2354.39, 10.02 ),
        parking = Vector3( -1432.98, 2358.95, 9.5 ),
    },
    {
        collect = Vector3( -1335.48, 2441.46, 12.18 ),
        parking = Vector3( -1345.09, 2399.18, 10.55 ),
    },
    {
        collect = Vector3( -1374.75, 2703.22, 14.47 ),
        parking = Vector3( -1365.18, 2739, 14.3 ),
    },
    {
        collect = Vector3( -962.6, 2382.07, 16.95 ),
        parking = Vector3( -945.11, 2391.54, 16.95 ),
    },
    {
        collect = Vector3( -851.55, 2598.37, 16.93 ),
        parking = Vector3( -854.84, 2561.9, 16.62 ),
    },
    {
        collect = Vector3( -759.34, 2793.95, 14.6 ),
        parking = Vector3( -731.29, 2753.39, 14.3 ),
    },
    {
        collect = Vector3( -358.06, 2738.15, 13.92 ),
        parking = Vector3( -322.65, 2743.05, 13.93 ),
    },
    {
        collect = Vector3( 82.91, 2436.75, 21.89 ),
        parking = Vector3( 65.83, 2419.2, 20.61 ),
    },
    {
        collect = Vector3( 579.22, 2020.81, 13.01 ),
        parking = Vector3( 562.2, 1967.31, 7.28 ),
    },
    {
        collect = Vector3( 892.52, 2085.17, 7.48 ),
        parking = Vector3( 912.65, 2129.87, 7.67 ),
    },
    {
        collect = Vector3( 1238.76, 2526.65, 10.05 ),
        parking = Vector3( 1252.93, 2505.43, 10.02 ),
    },
    {
        collect = Vector3( 1112.28, 2647.13, 8.27 ),
        parking = Vector3( 1149.26, 2638.28, 8.39 ),
    },
    {
        collect = Vector3( 1062, 2613.66, 9.3 ),
        parking = Vector3( 1035.52, 2630.9, 9.3 ),
    },
    {
        collect = Vector3( 1105.92, 2696.26, 6.25 ),
        parking = Vector3( 1082.04, 2733.78, 5.92 ),
    },
    {
        collect = Vector3( 820.71, 2764.43, 7.46 ),
        parking = Vector3( 860.07, 2778.12, 6.96 ),
    },
    {
        collect = Vector3( 587.27, 2770.91, 10.52 ),
        parking = Vector3( 611.33, 2778.46, 9.84 ),
    },
    {
        collect = Vector3( 512.25, 2642.22, 14.27 ),
        parking = Vector3( 534.5, 2675.2, 14.27 ),
    },
    {
        collect = Vector3( 586.03, 2431.19, 13.46 ),
        parking = Vector3( 587.77, 2410.53, 13.56 ),
    },
    {
        collect = Vector3( 500.1, 2361.58, 20.51 ),
        parking = Vector3( 486.82, 2395, 20.38 ),
    },
    {
        collect = Vector3( 470.07, 2570.35, 16.2 ),
        parking = Vector3( 451.41, 2546.62, 16.42 ),
    },
    {
        collect = Vector3( 89.33, 2791.58, 15.27 ),
        parking = Vector3( 43.18, 2785.59, 14.43 ),
    },
    {
        collect = Vector3( -265.86, 2860.85, 14.14 ),
        parking = Vector3( -250.34, 2874.87, 14.14 ),
    },
    {
        collect = Vector3( -581.16, 1773.5, 7.61 ),
        parking = Vector3( -533.72, 1791.18, 7.28 ),
    },
    {
        collect = Vector3( -529.48, 2233.72, 14.85 ),
        parking = Vector3( -527.68, 2211.26, 14.63 ),
    },
    {
        collect = Vector3( -490.02, 2436.46, 15.14 ),
        parking = Vector3( -541.12, 2443.44, 15.22 ),
    },
    {
        collect = Vector3( -1225.48, 2086.76, 9.92 ),
        parking = Vector3( -1161.41, 2038.45, 7.3 ),
    },
    {
        collect = Vector3( -808.85, 1803.05, 9.81 ),
        parking = Vector3( -837.3, 1789.59, 8.34 ),
    },
    {
        collect = Vector3( 1121.68, 2252.85, 8.27 ),
        parking = Vector3( 1156.93, 2256.55, 8.06 ),
    },
    {
        collect = Vector3( 974.6, 2279.79, 10.93 ),
        parking = Vector3( 960.03, 2299.76, 11 ),
    },
}

--if localPlayer then
--	for k, v in pairs( BANK_LOAD_POINT ) do
--		createBlip( v.parking, 0, 2, 255, 0, 0 )
--		createBlip( v.collect, 0, 2, 0, 0, 255 )
--
--		createMarker( v.parking, "cylinder", 4, 255, 0, 0 )
--		createMarker( v.collect, "cylinder", 4, 0, 0, 255 )
--	end
--end

BANK_UNLOAD_POINTS_VEHICLE = {
    Vector3( { x = 330.086, y = -857.326, z = 20.737 } ),
}

BANK_UNLOAD_POINT_PED = Vector3( 287.865, -855.744, 20.749 )

INCASATOR_WEAPONS_DATA = 
{
	[ JOB_ROLE_GUARD ] =
	{
		{ 22, 68 },
		{ 3 },
	},
} 

BANK_LOAD_POINT_MIN_DISTANCE = 1000
BANK_LOAD_POINT_MAX_DISTANCE = 3500

QUEST_BAGS_COUNT = 10
MAX_TAKE_BAGS_ON_POINT = 2

CONST_DAMAGE_ARMOR = 2000

BAG_MODEL_ID = 629
BAG_MAX_TIME = 180
BAG_MONEY_VALUE = 15000

PPS_FACTIONS = {
    [F_POLICE_PPS_NSK] = true,
    [F_POLICE_PPS_GORKI] = true,
}

PPS_CALL_KEY = "l"
PPS_CALL_DISTANCE = 1500
PPS_CALL_TIMEOUT = 180
PPS_MAX_COUNT_ACCEPT = 4
PPS_TIME_OFF_MARKERS = 120

CASH_OUT_POINTS = {
    EAST_POINT = Vector3( 1964.91, -1372.98 - 860, 29.85 ),
    WEST_POINT = Vector3( -1970.58, 1535.54 - 860, 17.7 ),
}

function GetIncasatorBagMoneyValue()
    return BAG_MONEY_VALUE
end
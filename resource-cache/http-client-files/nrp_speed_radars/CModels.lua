function ReplaceModel()
	local txd = engineLoadTXD( "files/models/radar.txd" )
	local dff = engineLoadDFF( "files/models/radar.dff", 1224 )
	local col = engineLoadCOL( "files/models/radar.col" )
	engineImportTXD( txd, 1224 )
	engineReplaceModel( dff, 1224 )
	engineReplaceCOL( col, 1224 )

	engineSetModelLODDistance( 1224, 300 )
end

local RADAR_OBJECT_POSITIONS = { 
	{ rz = 75, x = 237.41383, y = -388.08893, z = 20.559025 },
	{ rz = 158, x = -279.63965, y = -851.13904, z = 20.777336 },
	{ rz = 344, x = -303.85535, y = -832.4303, z = 20.761166 },
	{ rz = 523, x = 239.7467, y = -1408.0884, z = 20.563074 },
	{ rz = 1080, x = 446.78085, y = -1079.3712, z = 20.720875 },
    { rz = 1339, x = -852.41272, y = -863.94464, z = 20.746805 },
    { rz = 1352, x = -1357.5903, y = -800.46765, z = 20.752161 },
    { rz = 1483, x = -522.15521, y = -1104.2922, z = 20.74995 },
    { rz = 1483, x = 1832.8518, y = -173.86206, z = 60.495274 },
    { rz = 1649, x = 1819.1864, y = -131.57898, z = 60.498737 },
    { rz = 1499, x = 2088.8203, y = 587.88977, z = 60.496223 },
    { rz = 1676, x = 2080.907, y = 607.98706, z = 60.496223 },
    { rz = 1594, x = 1849.3809, y = 210.60205, z = 60.390099 },
    { rz = 1973, x = 2066.2231, y = 179.67856, z = 60.388615 },
    { rz = 1995, x = 1573.8129, y = 1212.5026, z = 26.152912 },
    { rz = 2196, x = 1464.03, y = 1379.4991, z = 26.150875 },
    { rz = 2466, x = 1618.8212, y = 1365.4559, z = 26.153513 },
    { rz = 2466, x = 2033.3304, y = 1653.2708, z = 15.919176 },
    { rz = 196, x = 2073.9175, y = 1640.3383, z = 15.919732 },
    { rz = 310, x = 2092.1252, y = 1695.2913, z = 15.913511 },
    { rz = 543, x = 1543.8058, y = 2530.7908, z = 15.919547 },
    { rz = 613, x = 1578.3855, y = 2554.8306, z = 15.920686 },
    { rz = 724, x = 1540.4838, y = 2602.0859, z = 15.916813 },
    { rz = 698, x = 2147.607, y = -273.960, z = 60.496223 },
}

function CreateRadarObjects()
	for k,v in pairs(RADAR_OBJECT_POSITIONS) do
		createObject( 1224, v.x, v.y, v.z, 0, 0, v.rz )
	end
end
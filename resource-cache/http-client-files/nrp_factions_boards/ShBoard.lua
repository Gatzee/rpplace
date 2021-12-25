loadstring( exports.interfacer:extend( "Interfacer" ) )()
Extend( "Globals" )

BOARDS_LIST = 
{
	-- ППС НСК
	{
		title = "Доска объявлений",
		faction = F_POLICE_PPS_NSK,

		x = -359.475, 
		y = -791.291, 
		z = 1061.424,
		interior = 1,
		dimension = 1,
	},

	-- ППС Горки
	{

		title = "Доска объявлений",
		faction = F_POLICE_PPS_GORKI,

		x = 1958.373, 
		y = 130.000, 
		z = 631.42,
		interior = 1,
		dimension = 1,
	},

	-- ДПС НСК
	{

		title = "Доска объявлений",
		faction = F_POLICE_DPS_NSK,
		
		x = 331.971, 
		y = -1186.104, 
		z = 1021.59,
		interior = 1,
		dimension = 1,
	},

	-- ДПС Горки
	{

		title = "Доска объявлений",
		faction = F_POLICE_DPS_GORKI,
		
		x = 2188.850, 
		y = 214.966, 
		z = 601,
		interior = 1,
		dimension = 1,
	},

	-- Больница НСК
	{

		title = "Доска объявлений",
		faction = F_MEDIC,
		
		x = 437.728, 
		y = -1600.287, 
		z = 1020.968,
		interior = 1,
		dimension = 1,
	},

	-- Больница Горки
	{

		title = "Доска объявлений",
		faction = F_MEDIC,
		
		x = 1932.039, 
		y = 310.220, 
		z = 660.966,
		interior = 1,
		dimension = 1,
	},

	-- Армия КПП
	{

		title = "Доска объявлений",
		faction = F_ARMY,
		
		x = -2293.694, 
		y = 0.516 + 860, 
		z = 20.098,
	},

	-- Мэрия НСК
	{

		title = "Доска объявлений",
		faction = F_GOVERNMENT_NSK,

		x = -53.677,
		y = -867.104,
		z = 1047.537,

		interior = 1,
		dimension = 1,
	},

	-- Мэрия Горки
	{

		title = "Доска объявлений",
		faction = F_GOVERNMENT_GORKI,

		x = 2294.371,
		y = -78.334,
		z = 671.513,

		interior = 1,
		dimension = 1,
	},

	--ФСИН
	{

		title = "Доска объявлений",
		faction = F_FSIN,

		x = -2675.1633,
		y = 2833.7587,
		z = 1540.4593,

		interior = 1,
		dimension = 1,
	},
}

for k,v in pairs(BOARDS_LIST) do
	v.board_id = k
end
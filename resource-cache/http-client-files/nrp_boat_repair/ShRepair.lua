REPAIR_COST_MUL = 0.01 -- Полная стоимость ремонта ТС из полностью сломанного состояния( относительно полной стоимости ТС )
FUEL_COST = 57 -- Стоимость литра топлива

WORKSHOPS_LIST = {
	{ x = 1139.255, y = -634.467 + 860, z = 1, },
	{ x = 1459.051, y = -2540.756 + 860, z = 1, },
	{ x = -379.582, y = -1167.729 + 860, z = 1, },
	{ x = -825.879, y = -2105.24 + 860, z = 1, },
	{ x = -1753.574, y = 853.18 + 860, z = 1, },
	{ x = -2938.290, y = -2077.59 + 860, z = 1, },

	-- Подмосковье
	{ x = -131.568, y = -335.479 + 860, z = 1, },
	{ x = -114.526, y = -755.82 + 860, z = 1, },
	{ x = 575.013, y = -840.99 + 860, z = 1, },
	{ x = 917.403, y = -323.544 + 860, z = 1, },
	{ x = -424.795, y = 106.223 + 860, z = 1, },
	{ x = 211.291, y = 542.472 + 860, z = 1, },
}

PARTS_LIST = {
	boat = { "Трюм", "Мотор", "Поворотный механизм", "Борт", "Палуба" },
}

function GetLocations( )
    return WORKSHOPS_LIST
end
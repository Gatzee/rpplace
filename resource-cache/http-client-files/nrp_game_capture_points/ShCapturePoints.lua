POINT_STATE_NEUTRAL = 1
POINT_STATE_CAPTURING = 2
POINT_STATE_CAPTURED = 3
POINT_STATE_CONFLICT = 4

POINTS_PER_SECOND = 0.45
CAPTURE_DURATION = 30
CAPTURE_SPEED_PER_PLAYER = 0.1
CAPTURE_ZONE_RADIUS = 10
ZONE_STATUS_UPDATE_INTERVAL = 3

SPAWN_POSITIONS = 
{
	purple = Vector3( 492.92, -3726.807, 20.595 ),
	green = Vector3( -1267.833, -1258.938, 21.5 ),
}

POINT_POSITIONS = 
{
	{ x = -766.049, y = -2106.378, z = 15.785, name = "A" },
	{ x = -8.241, y = -1694.879, z = 20.813, name = "B" },
	{ x = 491.452, y = -2362.762, z = 20.58, name = "C" },
}

VEHICLE_POSITIONS = 
{
	-- Лепта ( Восточная ОПГ )
	{ model = 540, x = 523.027, y = -2852.899, z = 20.412, rz = 0 },
	{ model = 540, x = 531.768, y = -2852.943, z = 20.411, rz = 0 },
	{ model = 540, x = 540.506, y = -2853.198, z = 20.413, rz = 0 },
	{ model = 540, x = 510.067, y = -2853.681, z = 20.412, rz = 0 },
	{ model = 540, x = 518.295, y = -2853.083, z = 20.412, rz = 0 },

	{ model = 540, x = 513.883, y = -2825.411, z = 20.413, rz = 0 },
	{ model = 540, x = 522.725, y = -2826.019, z = 20.41, rz = 0 },
	{ model = 540, x = 531.714, y = -2825.69, z = 20.411, rz = 0 },
	{ model = 540, x = 540.303, y = -2825.687, z = 20.411, rz = 0 },
	{ model = 540, x = 527.447, y = -2852.58, z = 20.409, rz = 0 },

	-- Военкомат ( Западная ОПГ )
	{ model = 540, x = -1299.043, y = -1274.139, z = 21.323, rz = 270 },
	{ model = 540, x = -1298.855, y = -1268.459, z = 21.325, rz = 270 },
	{ model = 540, x = -1299.058, y = -1262.674, z = 21.326, rz = 270 },
	{ model = 540, x = -1298.971, y = -1256.894, z = 21.325, rz = 270 },
	{ model = 540, x = -1298.795, y = -1251.048, z = 21.324, rz = 270 },

	{ model = 540, x = -1282.026, y = -1246.56, z = 21.326, rz = 180 },
	{ model = 540, x = -1273.341, y = -1246.131, z = 21.324, rz = 180 },
	{ model = 540, x = -1264.52, y = -1246.883, z = 21.323, rz = 180 },
	{ model = 540, x = -1256.091, y = -1246.957, z = 21.323, rz = 180 },
	{ model = 540, x = -1247.502, y = -1246.659, z = 21.323, rz = 180 },

	-- Точка A
	{ model = 540, x = -854.67, y = -1352.032, z = 15.609, rz = 270 },
	{ model = 540, x = -854.495, y = -1357.505, z = 15.607, rz = 270 },
	{ model = 540, x = -854.808, y = -1345.131, z = 15.61, rz = 270 },

	-- Точка B
	{ model = 540, x = 1.617, y = -1637.314, z = 20.41, rz = 0 },
	{ model = 540, x = -7.132, y = -1637.309, z = 20.414, rz = 0 },
	{ model = 540, x = 9.568, y = -1637.176, z = 20.41, rz = 0 },

	-- Точка C
	{ model = 540, x = 462.071, y = -2338.002, z = 20.398, rz = 90 },
	{ model = 540, x = 462.244, y = -2341.672, z = 20.396, rz = 90 },
	{ model = 540, x = 462.513, y = -2349.194, z = 20.395, rz = 90 },
}

RETURN_LOCATIONS = 
{
	purple =
	{
		x = 1939.572, y = -2244.303, z = 30.291
	},

	green = 
	{
		x = -2736.034, y = -1801.862, z = 22.234
	}
}
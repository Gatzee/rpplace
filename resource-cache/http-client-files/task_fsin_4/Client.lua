loadstring( exports.interfacer:extend( "Interfacer" ) )( )
Extend( "CQuest" )

POINTS = {
	{ x = -2910.62, y = 1807.27 + 860, z = 14.09 },
	{ x = -2914.11, y = 1763.05 + 860, z = 14.08 },
	{ x = -2882.14, y = 1762.72 + 860, z = 14.08 },
	{ x = -2913.77, y = 1838.77 + 860, z = 14.08 },
	{ x = -2927.43, y = 1862.19 + 860, z = 14.08 },
	{ x = -2929.33, y = 1830.8 + 860, z = 14.08 },
	{ x = -2929.4, y = 1748.01 + 860, z = 14.08 },
	{ x = -2711.55, y = 1949.33 + 860, z = 13.92 },
	{ x = -2623.39, y = 1958.86 + 860, z = 14.1 },
	{ x = -2709.77, y = 1980.86 + 860, z = 14.13 },
	{ x = -2819.4, y = 1965.79 + 860, z = 14.12 },
	{ x = -2878.81, y = 1924.52 + 860, z = 14.06 },
	{ x = -2852.8, y = 1910.79 + 860, z = 13.22 },
	{ x = -2439.94, y = 1833.45 + 860, z = 14.08 },
	{ x = -2442.46, y = 1887.02 + 860, z = 14.08 },
	{ x = -2426.07, y = 1850.42 + 860, z = 14.08 },
	{ x = -2334.01, y = 1712.46 + 860, z = 14.2 },
	{ x = -2345.37, y = 1678.98 + 860, z = 14.09 },
	{ x = -2366.2, y = 1676.59 + 860, z = 14.2 },
	{ x = -2505.67, y = 1594.2 + 860, z = 14.2 },
	{ x = -2533.34, y = 1659.62 + 860, z = 14.09 },
	{ x = -2511.92, y = 1673.87 + 860, z = 14.09 },
	{ x = -2490.99, y = 1675.74 + 860, z = 14.09 },
	{ x = -2481.26, y = 1651.45 + 860, z = 14.2 },
	{ x = -2604.49, y = 1926.3 + 860, z = 14.08 },
	{ x = -2606.81, y = 1945.41 + 860, z = 14.08 },
	{ x = -2657.93, y = 1942.53 + 860, z = 14.08 },
	{ x = -2832.03, y = 1924.71 + 860, z = 14.08 },
	{ x = -2796.02, y = 1955.21 + 860, z = 14.1 },
	{ x = -2729.5, y = 1808.94 + 860, z = 14.09 },
	{ x = -2694.99, y = 1782.31 + 860, z = 14.08 },
}

addEventHandler( "onClientResourceStart", resourceRoot, function ( )
	CQuest( QUEST_DATA )
end )
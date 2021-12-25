loadstring( exports.interfacer:extend( "Interfacer" ) )( )
Extend( "CQuest" )

VEHICLES = {
	[ F_POLICE_PPS_GORKI ] = { model = 400, x = 1922.789, y = -721.559 + 860, z = 60.811, rz = 62.721, tuning = { TUNING_SIREN, 2 }, paintjob = 1, },
	[ F_POLICE_PPS_NSK ] = { model = 400, x = -396.580, y = -1659.537 + 860, z = 20.639, rz = 93, tuning = { TUNING_SIREN, 2 }, paintjob = 1, },
}

	addEventHandler( "onClientResourceStart", resourceRoot, function ( )
		CQuest( QUEST_DATA )
	
		for i, v in pairs( VEHICLES ) do
			local vehicle = Vehicle( v.model, v.x, v.y, v.z )
			vehicle.rotation = Vector3( 0, 0, v.rz )
			vehicle.frozen = true
			vehicle:SetColor( 255, 255, 255 )
			vehicle:SetNumberPlate( "6:а".. math.random( 0, 9 ) .. math.random( 0, 9 ) .. math.random( 0, 9 ) .. math.random( 1, 9 ) .. "99" )
	
			if v.tuning then
				vehicle:SetExternalTuningValue( v.tuning[ 1 ], v.tuning[ 2 ] )
			end
	
			if v.paintjob then
				vehicle.paintjob = v.paintjob
			end
	
			v.element = vehicle
		end
	end )
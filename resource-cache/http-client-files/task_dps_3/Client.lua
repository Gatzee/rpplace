loadstring( exports.interfacer:extend( "Interfacer" ) )( )
Extend( "CQuest" )

VEHICLES = {
	[ F_POLICE_DPS_GORKI ] = { model = 540, x = 2201.922, y = -658.772 + 860, z = 60.512, rz = 1.894, tuning = { TUNING_SIREN, 2 }, paintjob = 0, },
	[ F_POLICE_DPS_NSK ] = { model = 540, x = 354.85, y = -2082.3 + 860, z = 20.5, rz = 0, tuning = { TUNING_SIREN, 2 }, paintjob = 0, },
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
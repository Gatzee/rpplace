
JOB_DATA[ JOB_CLASS_INKASSATOR ] =
{
    task_resource = "task_incasator_coop",
	onStartWork = "onServerIncasatorStartWork",
	onEndWork = "onServerIncasatorEndWork",

    markers_positions = 
    {
        {
    		city = 0,
    		name = "Работа инкассатором",
			x = 287.968, y = -896.578, z = 21.876,
			blip_size = 1.8,
    	},
    },
    blip_id = 72,

	company_name = JOB_ID[ JOB_CLASS_INKASSATOR ],
    conf = 
    {
    	{
			level = 18,
    	},
    	{
    		level = 21,
    	},
    	{
    		level = 25,
		},
	},
	
	job_join_condition = function( lobby, player, is_start, show_player )
		if player:GetSocialRating() < 0 then
			return false, (show_player and "У тебя" or "У игрока") .. " низкий социальный рейтинг"
		end
		return true
	end,

    vehicle_data = {
    	[ 2 ] = {
			vehicle_model = 459,
			positions = {
				{ position = Vector3( { x = 303.046, y = -893.655, z = 20.737 } ), rotation = Vector3( { x = 0.000, y = 0.000, z = 270 } ), },
			},
			idle_time = 15,
            apply_fn = function( vehicle )
				setVehiclePaintjob( vehicle, 0 )
				setVehicleColor( vehicle, 250, 240, 185 )
			end,
    	},
    }
}

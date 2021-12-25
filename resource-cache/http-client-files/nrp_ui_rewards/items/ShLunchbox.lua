REGISTERED_ITEMS.lunchbox = {
	Give = function( player, params )
		player:InventoryAddItem( IN_FOOD_LUNCHBOX, params.count )
	end;

	uiCreateRewardItem = function( id, params, bg, fonts )
		ibCreateContentImage( 0, 110, 120, 120, "other", id, bg ):center_x( )

		ibCreateLabel( 0, 238, 0, 0, "x" .. params.count, bg )
			:ibBatchData( { font = ibFonts.bold_34, align_x = "center", align_y = "top" })
			:center_x( )
	end;
	
	uiGetDescriptionData = function( id, params )
		return {
			title = "Ланч";
		}
	end;
}
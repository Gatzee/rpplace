REGISTERED_CASE_ITEMS.jailkeys = {
	rewardPlayer_func = function( player, params )
		player:InventoryAddItem( IN_JAILKEYS, nil, params.count )
	end;

	uiCreateItem_func = function( id, params, bg, fonts )
		local img = ibCreateContentImage( 0, 0, 90, 90, "other", id, bg ):center( )
		ibCreateLabel( 45, 72, 0, 0, "X".. params.count, img )
			:ibBatchData( { font = ibFonts.bold_16, align_x = "center", align_y = "center" } )
	end;

	uiCreateRewardItem_func = function( id, params, bg, fonts )
		ibCreateContentImage( 0, 110, 120, 120, "other", id, bg ):center_x( )

		ibCreateLabel( 0, 238, 0, 0, "x" .. params.count, bg )
			:ibBatchData( { font = ibFonts.bold_34, align_x = "center", align_y = "top" })
			:center_x( )
	end;
	
	uiGetDescriptionData_func = function( id, params )
		return {
			title = "Карточка свободы";
			description = "Карточка, которая\nпозволяет выйти\nиз тюрьмы один раз"
		}
	end;

	uiGetContentTextureRolling = function( id, params )
        return "other", id, 120, 120
	end;

	uiDrawItemInRolling = function( pos_x, pos_y, texture, size_x, size_y, alpha, id, params )
		size_x, size_y = size_x * 0.8, size_y * 0.8
		dxDrawImage( pos_x - math.floor( size_x / 2 ), pos_y + 5 - math.floor( size_y / 2 ), size_x, size_y, texture, 0, 0, 0, tocolor( 255, 255, 255, alpha ), true )
	end;
}
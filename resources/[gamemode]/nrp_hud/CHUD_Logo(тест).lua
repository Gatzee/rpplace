HUD_CONFIGS.logo = {
    elements = { },
    independent = true, -- Не управлять позицией худа
    create = function( self )
        ibUseRealFonts( true )

        local bg = ibCreateImage( 20, 20, 138, 60, _, _, 0xd72a323c )  -- Черный цвет tocolor( 0, 0, 0 )
        self.elements.bg = bg

        local server_name = ( localPlayer:getData( "_srv" ) or { 1, "" } )[ 2 ]
        self.elements.lbl_server = ibCreateLabel( 15, 0, 136, 60, server_name, bg, ibApplyAlpha( COLOR_WHITE, 100 ), _, _, "left", "center", ibFonts.bold_24 )

        ibUseRealFonts( false )
        return bg
    end,

    destroy = function( self )
        DestroyTableElements( self.elements )
        
        self.elements = { }
    end,
}

function LOGO_onElementDataChange( key )
    if key == "_srv" then
        local id = "logo"
        local self = HUD_CONFIGS[ id ]

        local server_name = ( localPlayer:getData( "_srv" ) or { 1, "" } )[ 2 ]
        if self.elements.lbl_server then
            self.elements.lbl_server:ibData( "text", server_name )
        end
    end
end
addEventHandler( "onClientElementDataChange", localPlayer, LOGO_onElementDataChange )

function LOGO_onStart( )
    if localPlayer:IsInGame( ) then
        AddHUDBlock( "logo" )
    end
end
addEventHandler( "onClientResourceStart", resourceRoot, LOGO_onStart )

function LOGO_onClientPlayerNRPSpawn_handler( spawn_mode )
    if spawn_mode == 3 then return end
    LOGO_onStart( )
end
addEvent( "onClientPlayerNRPSpawn", true )
addEventHandler( "onClientPlayerNRPSpawn", root, LOGO_onClientPlayerNRPSpawn_handler )
Extend( "CInterior" )

local NPC = {
    { x = 448.21, y = -1608.15, z = 1020.96, rotation = 45, interior = 1, dimension = 1, text = "ALT Взаимодействие" },
    { x = 1942.44, y = 302.95, z = 660.97, rotation = 45, interior = 1, dimension = 1, text = "ALT Взаимодействие" },
    { x = 164.81, y = -814.83, z = 1140.54, rotation = -90, interior = 1, dimension = 1, text = "ALT Взаимодействие" },
    { x = 2274.9, y = -87.89, z = 670.99, rotation = 0, interior = 1, dimension = 1, text = "ALT Взаимодействие" },
    { x = -46.95, y = -860.26, z = 1047.53, rotation = -120, interior = 1, dimension = 1, text = "ALT Взаимодействие" },
}

function createNPC( config )
    config.radius = 2.5
    config.keypress = "lalt"

    local npc = TeleportPoint( config )
    npc.elements = { }
    npc.marker:setColor( 255, 255, 255, 0 )
    npc.PostJoin = onNPCAction
    npc.PostLeave = onNPCLeave
    npc.ped = createPed( 298, config.x, config.y, config.z )
    addEventHandler( "onClientPedDamage", npc.ped, cancelEvent )

    npc.ped.frozen = true
    npc.ped.dimension = config.dimension
    npc.ped.interior = config.interior
    npc.ped.rotation = Vector3( 0, 0, config.rotation )
end

function onNPCAction( )
    components.windowDonation( true )
end

function onNPCLeave( )
    components.windowDonation( false )
end

for _, config in pairs( NPC ) do
    createNPC( config )
end

function CreateBottombar( )
    ANIM_MUL = 1

    wBottom = { }

    local font = exports.nrp_fonts:DXFont("OpenSans/OpenSans-SemiBold.ttf", 14, false, "default")

    local sx, sy = 719, 70
    local scale = 1
    scale = scale > 1 and 1 or scale

    wBottom.scale = scale
    wBottom.sx, wBottom.sy = sx * scale, sy * scale

    wBottom.px = x - wBottom.sx
    wBottom.py = y - wBottom.sy - 20

    UIElements.bg_bottom = ibCreateImage( wBottom.px, wBottom.py, wBottom.sx, wBottom.sy, "img/bg_stats.png" )

    UIElements.lbl_speed           = ibCreateLabel( 150 + 53, 10, 0, 0, "0", UIElements.bg_bottom ):ibBatchData( { font = font, color = 0xffd0d6db } )
    UIElements.lbl_acceleration    = ibCreateLabel( 320 + 53, 10, 0, 0, "0", UIElements.bg_bottom ):ibBatchData( { font = font, color = 0xffd0d6db } )
    UIElements.lbl_handling        = ibCreateLabel( 480 + 53, 10, 0, 0, "0", UIElements.bg_bottom ):ibBatchData( { font = font, color = 0xffd0d6db } )
end

function ExpandBottombar( instant )
    if instant then
        UIElements.bg_bottom:ibBatchData(
            {
                px = wBottom.px, py = wBottom.py - 90
            }
        )

    else
        UIElements.bg_bottom:ibMoveTo( wBottom.px, wBottom.py - 90, 150 * ANIM_MUL, "OutQuad" )

    end
end

function ShowBottombar( instant )
    if instant then
        UIElements.bg_bottom:ibBatchData(
            {
                px = wBottom.px, py = wBottom.py
            }
        )

    else
        UIElements.bg_bottom:ibMoveTo( wBottom.px, wBottom.py, 150 * ANIM_MUL, "OutQuad" )

    end
end

function HideBottombar( instant )
    if instant then
        UIElements.bg_bottom:ibBatchData(
            {
                px = wBottom.px, py = y
            }
        )

    else
        UIElements.bg_bottom:ibMoveTo( wBottom.px, y, 150 * ANIM_MUL, "OutQuad" )

    end
end

function RefreshBottomBar( )
    if not isElement( VEHICLE ) then return end
    local default_stats = { VEHICLE:GetStats( ) }

    local now_stats = { VEHICLE:GetStats( ) }

    iprint( default_stats, now_stats )

    -- Стата машины по входу в тюнинг
    local speed, acceleration, handling = unpack( now_stats )
    UIElements.lbl_speed:ibData( "text", speed )
    UIElements.lbl_acceleration:ibData( "text", acceleration )
    UIElements.lbl_handling:ibData( "text", handling )

    local speed_new, acceleration_new, handling_new = unpack( now_stats )

    -- Радиус значений для шкал
    local bars_range = { 0, 350 }

    -- Подсчет шкал
    local bars_amount = 14
    local bars_positions = {
        { 114 + 53, 44 },
        { 281 + 53, 44 },
        { 449 + 53, 44 },
    }
    local icon_sizes = {
        normal = { 6, 16 },
        green = { 24, 32 },
        red = { 42, 50 },
    }
    local icon_normal_sx, icon_normal_sy = unpack( icon_sizes.normal )
    local icon_offset = 4

    for bar_n, bar_conf in pairs( bars_positions ) do

        local now_value = now_stats[ bar_n ]

        -- Сами шкалы
        for icon_n = 1, bars_amount do

            local icon_key = "bars_" .. bar_n .. "_" .. icon_n
            if isElement( UIElements[ icon_key ] ) then destroyElement( UIElements[ icon_key ] ) end

            local bar_weight = ( bars_range[ 2 ] - bars_range[ 1 ] ) / bars_amount
            local icon_min_value = math.ceil( bars_range[ 1 ] + icon_n * bar_weight )

            if icon_min_value <= now_value then
                local tbl = icon_sizes.normal
                local icon_sx, icon_sy = unpack( tbl )

                local icon_texture = ":nrp_tuning_shop/img/icon_default.png"

                local icon_px = bar_conf[ 1 ] + ( icon_n - 1 ) * ( icon_normal_sx + icon_offset ) + icon_normal_sx / 2 - icon_sx / 2
                local icon_py = bar_conf[ 2 ] + icon_normal_sy / 2 - icon_sy / 2
                UIElements[ icon_key ] = ibCreateImage( icon_px, icon_py, icon_sx, icon_sy, icon_texture, UIElements.bg_bottom )
            end

        end

    end

end

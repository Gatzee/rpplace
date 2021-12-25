
local PRISON_POINTS =
{
    -2668.0739, 1540.6018 + 860,
    -2786.2692, 1537.5063 + 860,
    -2819.3554, 1543.6765 + 860,
    -2853.1428, 1563.2917 + 860,
    -2879.29, 1580.5322 + 860,
    -2931.8093, 1619.4924 + 860,
    -2936.1643, 1637.5224 + 860,
    -2935.048, 1669.7597 + 860,
    -2937.8056, 1709.2722 + 860,
    -2952.4018, 1789.1467 + 860,
    -2960.4887, 1829.3212 + 860,
    -2966.4409, 1868.1455 + 860,
    -2960.0646, 1885.0932 + 860,
    -2900.978, 1923.8056 + 860,
    -2793.0847, 1995.2812 + 860,
    -2769.9948, 1996.832 + 860,
    -2686.1552, 1984.0788 + 860,
    -2561.0415, 1967.6123 + 860,
    -2540.0493, 1961.904 + 860,
    -2472.1611, 1930.0966 + 860,
    -2372.0512, 1882.7033 + 860,
    -2356.7006, 1866.2883 + 860,
    -2331.0473, 1793.2802 + 860,
    -2285.0383, 1666.2565 + 860,
    -2291.1015, 1650.0576 + 860,
    -2501.3369, 1548.393 + 860,
    -2517.4541, 1544.4028 + 860,
    -2534.4479, 1540.7399 + 860,
    -2615.9345, 1540.8374 + 860,
    -2656.8703, 1540.7019 + 860,
    -2668.0739, 1540.6018 + 860,
};

PRISON_AREA = nil

LEAVE_END_TICKS = nil
LEAVE_TIME = 15 * 60 * 1000
LEAVE_TIMER = nil

--Игрок вернулся в зону тюрьмы во время заключения
function onEnterPrisonArea( element )

    if element ~= localPlayer then return end

    if isTimer( LEAVE_TIMER ) then

        killTimer( LEAVE_TIMER )
        LEAVE_TIMER = nil

        UI_Elements.bg:destroy()
        UI_Elements.bg = nil

        localPlayer:setData( "prison_break", nil, false )
        
        triggerServerEvent( "prison:OnPlayerResetLeavePrisonArea", localPlayer )
    end

end

PRE_CHECK_TIMER = nil
-- Игрок покинул тюрьму во время заключения
function onLeavePrisonArea( element )

    if element ~= localPlayer then return end

    local timehour = getRealTime().hour + TIME_DIFF
    --Если игрок покинул территрию с 18:00 - 12:00 и он находится не в интерьере, то объявляем побег
    if timehour >= 9 and timehour <= 18 and localPlayer:getDimension() == 0 and localPlayer:getInterior() == 0 then

        if isTimer( PRE_CHECK_TIMER ) then
            killTimer( PRE_CHECK_TIMER )
        end

        PRE_CHECK_TIMER = Timer( function( targetElement )
            if localPlayer:getDimension() ~= 0 or localPlayer:getInterior() ~= 0 then return end

            if not isElementWithinColShape( localPlayer, PRISON_AREA ) and not isTimer( LEAVE_TIMER ) and localPlayer:getData("jailed") then

                if isTimer( PRE_CHECK_TIMER ) then
                    killTimer( PRE_CHECK_TIMER )
                end

                --Уничтожаем маркеры работы
                DestroyJobsMarkers()
                triggerServerEvent( "prison:OnPlayerStartLeavePrisonArea", localPlayer )

                LEAVE_END_TICKS = getTickCount() + LEAVE_TIME
                LEAVE_TIMER = Timer( function()
                    OnPlayerReleased()
                    triggerServerEvent( "prison:OnPlayerLeavePrisonArea", localPlayer )
                end, LEAVE_TIME, 1 )

                CreateDescriptionLeavePrsion()

            end
        end, 10000, 1, element )
        
    elseif not isElementWithinColShape( localPlayer, PRISON_AREA ) and localPlayer:getDimension() == 0 and localPlayer:getInterior() == 0 then
        if isTimer( PRE_CHECK_TIMER ) then
            killTimer( PRE_CHECK_TIMER )
        end
        PRE_CHECK_TIMER = Timer( function( targetElement )
            if localPlayer:getDimension() ~= 0 or localPlayer:getInterior() ~= 0 then return end

            triggerServerEvent( "prison:OnPlayerStartLeavePrisonAreaNight", localPlayer )
            localPlayer:ShowInfo("Сотрудники ФСИН ночью более бдительны! Вас поймали!")
        end, 10000, 1, element )
    end

end

-- Игрок умер во время побега
function OnPrisonPlayerWasted()

    if isTimer( PRE_CHECK_TIMER ) then
        killTimer( PRE_CHECK_TIMER )
    end
    if isTimer( LEAVE_TIMER ) then

        killTimer( LEAVE_TIMER )
        LEAVE_TIMER = nil

        UI_Elements.bg:destroy()
        UI_Elements.bg = nil

        triggerServerEvent( "prison:OnPlayerResetLeavePrisonArea", localPlayer )
    end
end
addEventHandler( "onClientPlayerWasted", localPlayer, OnPrisonPlayerWasted )


function onStart()
    PRISON_AREA = createColPolygon( unpack( PRISON_POINTS ) )
end
addEventHandler( "onClientResourceStart", resourceRoot, onStart )
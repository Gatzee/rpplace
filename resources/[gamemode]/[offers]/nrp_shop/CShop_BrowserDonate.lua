local payment_window

function ShowPaymentForPrice( sum )
    payment_window = ibPayment( )
    payment_window.data = { sum = sum }
    payment_window.init( )
end

function HidePaymentWindow( )
    if payment_window then
        payment_window.destroy( )
        payment_window = nil
    end
end

function FindPremiumPackByDays( days )
    local is_discount = GetPremiumDiscountsForDays( days ) and HasPremiumDiscounts()
    for i, v in pairs(is_discount and PREMIUM_SETTINGS.discount_pack_ids or PREMIUM_SETTINGS.pack_ids) do
        if i == days then
            return v
        end
    end
end

function ShowPaymentForPremium( days )
    local pack_id = FindPremiumPackByDays( days )

    if pack_id then
        payment_window = ibPayment( )
        payment_window.data = { pack_id = pack_id }
        payment_window.init( )
    else
        localPlayer:ErrorWindow( "Данные значения премиума не найдены" )
    end
end

function onDonatePaymentSuccess_handler( )
    HidePaymentWindow( )
    ibBuyDonateSound()
end
addEvent( "onDonatePaymentSuccess", true )
addEventHandler( "onDonatePaymentSuccess", root, onDonatePaymentSuccess_handler )
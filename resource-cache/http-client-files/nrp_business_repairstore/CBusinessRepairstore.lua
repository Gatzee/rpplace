local UIElements = {}

local x,y = guiGetScreenSize()
local REPAIRSTORE_CONFIG = {
	sx = 640,
	sy = 480,
}
REPAIRSTORE_CONFIG.px = x/2-REPAIRSTORE_CONFIG.sx/2
REPAIRSTORE_CONFIG.py = y/2-REPAIRSTORE_CONFIG.sy/2


function InitRepairStore( )
	if not _INIT then
		loadstring(exports.interfacer:extend("Interfacer"))()
		Extend("CVehicle")
		Extend("ShVehicleConfig")
		Extend("Globals")
		Extend("CPlayer")
		Extend("ShUtils")
		Extend("CUI")
		Extend("ShBusiness")
		Extend("CInterior")
		Extend("ib")

		_INIT = true
	end
end

addEvent("Repairstore_ShowUI",true)
function Repairstore_ShowUI(state,data)
	InitRepairStore( )

	if state then

		Repairstore_ShowUI( false )

		local vehicle = data.vehicle
		local variant = data.variant

		setElementData( vehicle, "condition", data.condition, false )

		if VEHICLE_TYPE_BIKE[vehicle.model] or VEHICLE_TYPE_QUAD[data.vehicle] then 
			localPlayer:ShowInfo("Данный вид транспорта не требует ремонта")
			return 
		end

		-- Делаем проверку.
		local broken_parts = {}
		for i=0, 6 do
			local state = vehicle:getPanelState(i)
			if state > 0 then
				local conf = {
					name = vehicle:GetPanelName(i),
					component = vehicle:GetPanelComponentName(i),
					state = state,
					price = vehicle:GetPanelPrice(i),
					type = "Panel",
					ID = i,
				}
				if vehicle:GetPartCondition( "panels", i ) == 4 then
					conf.replace = true
				end
				table.insert(broken_parts, conf)
			end
		end


		-- Колеса.
		local pWheels = {}
		local pWheels = {vehicle:getWheelStates()}

		for i=1, 4 do
			local state = pWheels[i]
			if state > 0 then
				local conf = {
					name = vehicle:GetWheelName(i),
					component = vehicle:GetWheelComponentName(i),
					state = state,
					price = vehicle:GetWheelPrice(i),
					type = "Wheel",
					ID = i,
					replace = true,
				}
				table.insert(broken_parts, conf)
			end
		end

		-- Двери.
		for i=0, 5 do
			local state = vehicle:getDoorState(i)
			if state > 1 then
				local conf = {
					name = vehicle:GetDoorName(i),
					component = vehicle:GetDoorComponentName(i),
					state = state,
					price = vehicle:GetDoorPrice(i),
					type = "Door",
					ID = i,
				}
				if vehicle:GetPartCondition( "doors", i ) == 4 then
					conf.replace = true
				end
				table.insert(broken_parts, conf)
			end
		end

		-- Фары
		for i=0, 3 do
			local state = vehicle:getLightState(i)
			if state > 0 then
				local conf = {
					name = vehicle:GetLightName(i),
					component = vehicle:GetLightComponentName(i),
					state = state,
					price = vehicle:GetLightPrice(i),
					type = "Light",
					ID = i,
				}
				if vehicle:GetPartCondition( "lights", i ) == 4 then
					conf.replace = true
				end
				table.insert(broken_parts, conf)
			end
		end

		-- Двигатель.
		if vehicle.health < 1000.0 then
			local pRow = {};
			local conf = {
				name = "Двигатель",
				component = "engine",
				state = 0,
				price = vehicle:GetEngineRepairCost(),
				type = "Custom",
				ID = 1,
			}
			table.insert(broken_parts, conf)
		end

		-- Множитель стоимости ремонта для транспорта
		local multiplier = vehicle:GetRepairCostMultiplier( localPlayer )
		for i, v in pairs( broken_parts ) do
			if v.price then v.price = math.floor( v.price * multiplier ) end
		end

		BROKEN_PARTS = broken_parts

		showCursor(true)

		if next(broken_parts) == nil and vehicle:GetMileage( ) < 850 then
			-- Всё збс
			localPlayer:ShowInfo("Ваш транспорт не имеет повреждений")
			return Repairstore_ShowUI(false)	
		end

		local textures = {
			"bg_gradient.png",
			"money_icon.png",
			"unchecked.png",
			"checked.png",
			"scroll_bg.png",
			"engine_icon.png",
			"button_buy_idle.png",
			"button_buy_hover.png",
			"button_buy_click.png",
			"button_hbuy_idle.png",
			"button_hbuy_hover.png",
			--"button_hbuy_click.png",	
			"button_selectall.png",
		}
		UIElements.Textures = {}

		for i,file_name in pairs( textures ) do
			local id = file_name:match( "(.+)%..+" )
			UIElements.Textures[ id ] = dxCreateTexture( "img/" .. file_name )
		end

		local balance = localPlayer:GetMoney() or 0
		UIElements.HelpPopup_money = ibCreateLabel( x - 60, 20, 0, 30, balance, UIElements.bg_gradient, 0xFFFFFFFF, 1, 1, "right", "center", ibFonts.bold_16 )
		UIElements.HelpPopup_money_icon = ibCreateImage( x - 50, 20, 30, 30, UIElements.Textures.money_icon )

		UIElements.HelpPopup_left = ibCreateLabel( x - 110, 80, 0, 0, "- обратно", UIElements.bg_gradient, 0xFFFFFFFF, 1, 1, "left", "center", ibFonts.regular_14 )
		UIElements.HelpPopup_left_key = ibCreateLabel( x - 175, 80, 0, 0, "Shift", UIElements.bg_gradient, 0xFFFFFFFF, 1, 1, "left", "center", ibFonts.bold_16 )

		UIElements.HelpPopup_right = ibCreateLabel( x - 110, 110, 0, 0, "- выбрать", UIElements.bg_gradient, 0xFFFFFFFF, 1, 1, "left", "center", ibFonts.regular_14 )
		UIElements.HelpPopup_right_key = ibCreateLabel( x - 175, 110, 0, 0, "Enter", UIElements.bg_gradient, 0xFFFFFFFF, 1, 1, "left", "center", ibFonts.bold_16 )

		UIElements.bg_gradient = ibCreateImage( 0, (y - 1080) / 2, 800, 1080, UIElements.Textures.bg_gradient )

		UIElements.title = ibCreateLabel( 80, 280, 0, 0, "АВТОСЕРВИС", UIElements.bg_gradient, 0xFFFFFFFF, 1, 1, "left", "center", ibFonts.bold_21 )
		UIElements.titlemark = ibCreateLabel( 80, 340, 0, 0, "СПИСОК ДЕТАЛЕЙ:", UIElements.bg_gradient, 0x66FFFFFF, 1, 1, "left", "center", ibFonts.bold_13 )

		TICKERS = {}

		local function refreshCurrentPrice()
			local function inner_refresh()
				local total_price = 0
				for i,v in pairs(TICKERS) do
					local img = v:ibData( "texture" )
					if img == UIElements.Textures.checked then
						total_price = total_price + BROKEN_PARTS[ i ].price
					end
				end
				total_price = math.min( total_price, math.floor( vehicle:GetTotalPrice() ) )
				UIElements.price:ibData( "text", total_price == 0 and "0" or format_price( total_price ) )
				UIElements.price:ibData( "color", localPlayer:GetMoney() < total_price and 0xffff0000 or 0xffffffff )

				local color = 0xFFFFFFFF
				if localPlayer:GetMoney() < total_price then
					color = 0xffaaaaaa
				end
				UIElements.ButtonPay:ibData( "color", color )

			end
			setTimer(inner_refresh,50,1)
		end

		UIElements.Scrollpane, UIElements.ScrollBar = ibCreateScrollpane( 80, 370, 600, 200, UIElements.bg_gradient )

		local epx, epy = 1, 13
		local count_items = 0
		for i, data in pairs(broken_parts) do
			
			local part_name = ibCreateLabel( epx, epy, 0, 0, data.name, UIElements.Scrollpane, 0x66FFFFFF, 1, 1, "left", "center", ibFonts.regular_13 )

			local typefix = ibCreateLabel( epx + 230, epy, 0, 0, data.replace and "Замена" or "Восстановление", UIElements.Scrollpane, 0x66FFFFFF, 1, 1, "left", "center", ibFonts.regular_13 )
			
			local price_img = ibCreateImage( epx + 390, epy - 14, 28, 28, UIElements.Textures.money_icon, UIElements.Scrollpane )

			local price = ibCreateLabel( epx + 425, epy, 0, 0, format_price(data.price), UIElements.Scrollpane, 0x66FFFFFF, 1, 1, "left", "center", ibFonts.regular_13 )

			local ticker = ibCreateImage( epx + 535, epy - 13, 26, 26,  UIElements.Textures.unchecked, UIElements.Scrollpane )
			:ibOnClick( function( button, state )
				if button ~= "left" or state ~= "up" then return end

				refreshCurrentPrice()
				
				local texture = source:ibData( "texture" )
				if texture == UIElements.Textures.unchecked then
					source:ibData( "texture", UIElements.Textures.checked )
				else
					source:ibData( "texture", UIElements.Textures.unchecked )
				end
			end )
			table.insert( TICKERS, ticker )

			epy = epy + 40
			count_items = count_items + 1
		end

		UIElements.Scrollpane:AdaptHeightToContents()
		UIElements.ScrollBar:UpdateScrollbarVisibility( UIElements.Scrollpane )

		local py = 580
		UIElements.selectall = ibCreateButton( 540, py, 100, 30,  UIElements.bg_gradient, UIElements.Textures.button_selectall, UIElements.Textures.button_selectall, UIElements.Textures.button_selectall, 0xFFFFFFFF, 0xF0FFFFFF, 0xA0FFFFFF  )
		:ibOnClick( function(button,state)
			if button ~= "left" or state ~= "up" then return end

			for i,v in pairs(TICKERS) do
				v:ibData( "texture", UIElements.Textures.checked )
			end

			refreshCurrentPrice()
		end )

		py = py + 50

		UIElements.titlecost = ibCreateLabel( 80, py + 10, 0, 0, "Стоимость ремонта:", UIElements.bg_gradient, 0x66FFFFFF, 1, 1, "left", "center", ibFonts.bold_13 )
		UIElements.price_img = ibCreateImage( 80, py + 30, 28, 28, UIElements.Textures.money_icon, UIElements.bg_gradient )
		UIElements.price = ibCreateLabel( 120, py + 42, 0, 0, "0", UIElements.bg_gradient, 0x66FFFFFF, 1, 1, "left", "center", ibFonts.bold_16 )

		UIElements.ButtonPay = ibCreateButton( 486, py + 5, 186, 50,  UIElements.bg_gradient, UIElements.Textures.button_buy_hover, UIElements.Textures.button_buy_hover, UIElements.Textures.button_buy_hover, 0xFFFFFFFF, 0xF0FFFFFF, 0xA0FFFFFF  )
		:ibOnClick( function(button,state)
			if button ~= "left" or state ~= "up" then return end
			BuyRepair( _, _, vehicle )
		end )

		DisableGameHUD(true)

		bindKey("lshift", "up", LShiftHideUI)
		bindKey("enter", "up", BuyRepair, vehicle)
	else
		for i, element in pairs(UIElements) do
			if isElement(element) then
				destroyElement(element)
			end
		end
		DisableGameHUD(false)
		unbindKey("lshift", "up", LShiftHideUI)
		unbindKey("enter", "up", BuyRepair)
		showCursor(false)
		CleanResourceTextures( )
	end

end
addEventHandler("Repairstore_ShowUI",root,Repairstore_ShowUI)

function BuyRepair(_, _, vehicle)
	local total_price = 0
	for i,v in pairs(TICKERS) do
		local img = v:ibData( "texture" )
		if img == UIElements.Textures.checked then
			total_price = total_price + BROKEN_PARTS[i].price
		end
	end
	total_price = math.min( total_price, math.floor( vehicle:GetTotalPrice() ) )

	if total_price > localPlayer:GetMoney() then
		localPlayer:ShowError( "Недостаточно средств!" )
		return
	end

	selected = {}
		
	for i,v in pairs(TICKERS) do
		local img = v:ibData( "texture" )
		if img == UIElements.Textures.checked then
			table.insert(selected, BROKEN_PARTS[i])
		end
	end

	for i, v in pairs( selected ) do
		v.name = nil
	end

	Repairstore_ShowUI(false)
	triggerServerEvent("onPlayerRequestRepairstorePayment", localPlayer, vehicle, selected)
end

function LShiftHideUI()
	Repairstore_ShowUI(false)
end

addEventHandler("onClientPlayerWasted", localPlayer, function()
	if isElement(UIElements.bg_gradient) then
		Repairstore_ShowUI(false)
	end
end)

function ForceUpdateLightStates( vehicle, data )
	if isElement(vehicle) then
		for k,v in pairs(data) do
			setVehicleLightState(vehicle, k, v)
		end
	end
end
addEvent("ForceUpdateLightStates", true)
addEventHandler("ForceUpdateLightStates", root, ForceUpdateLightStates)

REPLACE_MUL = 3

Vehicle.GetPanelName = function(self, iPanel)
	local pPanelsData = {
		[ 0 ] = "Переднее левое крыло",
		[ 1 ] = "Переднее правое крыло",
		[ 2 ] = "Заднее левое крыло",
		[ 3 ] = "Заднее правое крыло",
		[ 4 ] = "Лобовое стекло",
		[ 5 ] = "Передний бампер",
		[ 6 ] = "Задний бампер",
	}
	return pPanelsData[iPanel]
end

Vehicle.GetPanelComponentName = function(self, iPanel)
	local pPanelsData = {
		[ 0 ] = "front_left_fender",
		[ 1 ] = "front_right_fender",
		[ 2 ] = "rear_left_fender",
		[ 3 ] = "rear_right_fender",
		[ 4 ] = "windshield_dummy",
		[ 5 ] = "bump_front_dummy",
		[ 6 ] = "bump_rear_dummy",
	}
	return pPanelsData[iPanel]
end

Vehicle.GetPanelPrice = function(self, iPanel, clear)
	if self:IsInFaction() then return 0 end
	local iPrice = self:GetRepairPrice() * VEHICLE_REPAIR_PARTS.panels / 7

	if self:GetPartCondition( "panels", iPanel ) == 4 then
		iPrice = iPrice * REPLACE_MUL
	end

	return math.floor(iPrice)
end

Vehicle.GetWheelName = function(self, iWheel, clear)
	local pWheelsData = {
		[ 1 ] = "Переднее левое колесо",
		[ 2 ] = "Заднее левое колесо",
		[ 3 ] = "Переднее правое колесо",
		[ 4 ] = "Заднее правое колесо",
	}
	return pWheelsData[iWheel]
end

Vehicle.GetWheelComponentName = function(self, iWheel)
	local pWheelsData = {
		[ 1 ] = "wheel_lf_dummy",
		[ 2 ] = "wheel_lb_dummy",
		[ 3 ] = "wheel_rf_dummy",
		[ 4 ] = "wheel_rb_dummy",
	}
	return pWheelsData[iWheel]
end

Vehicle.GetWheelPrice = function(self, iWheel)
	if self:IsInFaction() then return 0 end
	return math.floor( self:GetRepairPrice() * VEHICLE_REPAIR_PARTS.wheels / 4 ) -- or pWheelsData[iWheel]
end

Vehicle.GetDoorName = function(self, iDoor)
	local pDoorsData =
	{
		[ 0 ] = "Капот",
		[ 1 ] = "Багажник",
		[ 2 ] = "Передняя левая дверь",
		[ 3 ] = "Передняя правая дверь",
		[ 4 ] = "Задняя левая дверь",
		[ 5 ] = "Задняя правая дверь",
	}
	return pDoorsData[iDoor]
end

Vehicle.GetDoorComponentName = function(self, iDoor)
	local pDoorsData = {
		[ 0 ] = "bonnet_dummy",
		[ 1 ] = "boot_dummy",
		[ 2 ] = "door_lf_dummy",
		[ 3 ] = "door_rf_dummy",
		[ 4 ] = "door_lr_dummy",
		[ 5 ] = "door_rr_dummy",
	}
	return pDoorsData[iDoor]
end

Vehicle.GetDoorPrice = function(self, iDoor)
	if self:IsInFaction() then return 0 end
	local pDoorsData =
	{
		[ 0 ] = 0.015,
		[ 1 ] = 0.02,
		[ 2 ] = 0.025,
		[ 3 ] = 0.025,
		[ 4 ] = 0.01,
		[ 5 ] = 0.01,
	}
	local iPrice = self:GetRepairPrice() * VEHICLE_REPAIR_PARTS.doors / 6

	if self:GetPartCondition( "doors", iDoor ) == 4 then
		iPrice = iPrice * REPLACE_MUL
	end

	return math.floor(iPrice)
end

Vehicle.GetLightName = function(self, iLight)
	local pLightsData = {
		[ 0 ] = "Передняя левая фара",
		[ 1 ] = "Передняя правая фара",
		[ 2 ] = "Задняя правая фара",
		[ 3 ] = "Задняя левая фара",
	}
	return pLightsData[iLight];
end

Vehicle.GetLightComponentName = function(self, iLight)
	local pLightsData = {
		[ 0 ] = "light_lf_dummy",
		[ 1 ] = "light_rf_dummy",
		[ 2 ] = "light_lr_dummy",
		[ 3 ] = "light_rr_dummy",
	}
	return pLightsData[iLight]
end

Vehicle.GetLightPrice = function(self)
	if self:IsInFaction() then return 0 end
	local iPrice = self:GetRepairPrice() * VEHICLE_REPAIR_PARTS.lights / 4

	if self:GetPartCondition( "lights", iLight ) == 4 then
		iPrice = iPrice * REPLACE_MUL
	end

	return math.floor(iPrice)
end

Vehicle.GetEngineRepairCost = function(self)
	if self:IsInFaction() then return 0 end
	local vehicle_type = self.vehicleType
	local full_price_types = {
		Bike = true,
		Quad = true,
		Boat = true,
		Helicopter = true,
		Plane = true,
	}
	local iPrice = self:GetRepairPrice() * ( full_price_types[ vehicle_type ] and 1 or VEHICLE_REPAIR_PARTS.engine )

	iPrice = (1 - self.health / 1000) * iPrice

	return math.floor(iPrice)
end

Vehicle.GetResetMileageCost = function(self, variant)
	if self:IsInFaction() then return 0 end
	local vehicle_type = self.vehicleType
	local full_price_types = {
		Bike = true,
		Quad = true,
		Boat = true,
	}

	local variant = variant or self:GetVariant() or 1
	local variant_data = VEHICLE_CONFIG[self.model].variants[variant] or VEHICLE_CONFIG[self.model].variants[1]
	local current_price = variant_data.cost or 0
	local iPrice = current_price * 0.2

	return math.floor(iPrice)
end

Vehicle.GetRepairPrice = function( self, variant )
	if self:IsInFaction() then return 0 end

	local variant = variant or self:GetVariant() or 1
	local variant_data = VEHICLE_CONFIG[self.model].variants[variant] or VEHICLE_CONFIG[self.model].variants[1]
	local current_price = variant_data.repair_cost or variant_data.cost or 0
	local repair_coeff = self:GetRepairCoefficient()
	local repair_price = current_price * repair_coeff

	return repair_price
end

Vehicle.GetRepairCoefficient = function( self )
	local vehicle_price = self:GetPrice()
	for i = 1, #VEHICLE_REPAIR_COEFF do
		local threshold = VEHICLE_REPAIR_RANGE[ i ]
		if vehicle_price < threshold then
			return VEHICLE_REPAIR_COEFF[ i ] / 100
		end
	end
end

Vehicle.GetPartCondition = function( self, sPart, iIndex )
	local pCondition = self:GetCondition()
	local sIndex = tostring(iIndex)
	if sPart == "engine" then
		return pCondition.engine or 0
	else
		if pCondition[sPart] then
			return pCondition[sPart][sIndex] or 5
		else
			return 0
		end
	end
end


addEventHandler( "onClientResourceStart", resourceRoot, function( )
	InitRepairStore()
	for i, data in pairs( BUSINESS_ELEMENTS ) do
		if data.business_id == 2 then
			local config = { }
			config.x, config.y, config.z = data.x, data.y+860, data.z

			local is_create_blip = true
			for k,v in pairs( getElementsByType("blip") ) do
				if getBlipIcon(v) == 27 then
					if (v.position - Vector3(config.x, config.y, config.z)).length <= 50 then
						is_create_blip = false
						break
					end
				end
			end

			if is_create_blip then
				config.elements = { }
				config.elements.blip = createBlip( config.x, config.y, config.z, 27, 2, 255, 0, 0, 255, 0, 300 )
			end

			config.radius = 3
			config.marker_text = ""
			config.keypress = "lalt";
			config.text = "ALT Взаимодействие"
			config.accepted_elements = { vehicle = true }

			tpoint = TeleportPoint( config )
			tpoint.marker:setColor( 0, 100, 200, 10 )

			tpoint:SetImage( { "img/icon.png", 255, 255, 255, 255, 3 } )
			tpoint:SetDropImage( { ":nrp_shared/img/dropimage.png", 0, 100, 200, 255, 2.2 } )

			tpoint.PreJoin = function( seld, player )
				if player.vehicle == nil then return false end
				local special_type = player.vehicle:GetSpecialType( )
				if special_type and special_type ~= "moto" then return false end

				return true
			end

			tpoint.PostJoin = function( self, player )
				if isElement( UI_bg ) then return end

				triggerServerEvent( "RequestRepairData", resourceRoot )
			end

			tpoint.PostLeave = function( self, player )
			--	DestroyUI( )
			end
		end
	end
end )





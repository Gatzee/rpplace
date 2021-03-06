loadstring( exports.interfacer:extend( "Interfacer" ) )()
Extend( "SPlayer" )
Extend( "SInterior" )
Extend( "SClans" )

MATCHES_LIST = { }
MATCHES_BY_LOBBY_ID = { }

addEvent( "CEV:OnPlayerRequestRespawn", true )

function CreateMatch( data )
    local self = data

    self.config = table.copy( HOLDAREA_CONFIG[ 1 ] )

	self.scores = { }

    self.team_id_by_clan_id = { }
	self.clan_id_by_team_id = { }

    self.elements = { }

    self.OnPlayerRequestJoin = function( player )
		local clan_id = player:GetClanID( )
		local clan_players = self.clans_players[ clan_id ]
		if not clan_players then
			clan_players = { }
			self.clans_players[ clan_id ] = clan_players
			table.insert( self.teams, {
				clan_id = clan_id,
				players = clan_players,
            } )
            local team_id = #self.teams
            self.team_id_by_clan_id[ clan_id ] = team_id
            self.clan_id_by_team_id[ team_id ] = clan_id
		end
		table.insert( clan_players, player )
		
		table.insert( self.participants, player )

		self.participants_data[ player ] = {
			team_players = clan_players,
			clan_id = clan_id,
			uid = player:GetID( ),
			name = player:GetNickName( ),
			hp = player.health,
			armor = player.armor,
			position = player.position,
			dimension = player.dimension,
			interior = player.interior,
        }
        
        self.OnPlayerJoin( player )
    end

    self.OnPlayerJoin = function( player )
        self.OnPlayerRequestSpawn( player, true )

        addEventHandler( "onPlayerPreWasted", player, self.OnPlayerPreWasted )
        addEventHandler( "CEV:OnPlayerRequestRespawn", player, self.OnPlayerRequestSpawn )

        player:CompleteDailyQuest( "band_participate_raider_capture" )
    end

	self.OnPlayerRequestLeave = function(  )
        local player = source
        triggerEvent( player, "CEV:OnPlayerRequestEventLeave", player )
    end

    self.OnPlayerLeave = function( player )
        self.ClearPlayerData( player )

        removeEventHandler( "onPlayerPreWasted", player, self.OnPlayerPreWasted )
        removeEventHandler( "CEV:OnPlayerRequestRespawn", player, self.OnPlayerRequestSpawn )
    end

	self.ClearPlayerData = function( player )
		local data = self.participants_data[ player ]
		if not data then return end

		self.participants_data[ player ] = nil

		for k,v in pairs( self.participants ) do
			if v == player then
				table.remove( self.participants, k )
				break
			end
		end

		local team_players = data.team_players
		for k, v in pairs( team_players ) do
			if v == player then
				table.remove( team_players, k )
				break
			end
		end

		-- if #team_players == 0 then
		-- 	self.OnFinish( true )
		-- end
	end

    self.OnPlayerPreWasted = function( )
        cancelEvent()
    end

    self.OnPlayerWasted = function( )
        --
    end

    self.OnPlayerRequestSpawn = function( player, on_join )
        local player = isElement( player) and player or source
        local clan_id = player:GetClanID( )
        local team_id = self.team_id_by_clan_id[ clan_id ]
        local spawns = self.config.spawns[ team_id ]
        local random_position = Vector3( spawns[ math.random( #spawns ) ] ):AddRandomRange( 4 )
        if player:isDead( ) then
            player:spawn( random_position, player.rotation, player.model, player.interior, self.dimension )
        else
            player:Teleport( random_position, self.dimension, 0 )
            player.health = 100
        end
        -- if not on_join then
        --     player.health = 30
        -- end
    end

    self.OnPlayerSpawn = function( )
        --
    end



	self.OnCreated = function( )
        for team_id, team in pairs( self.teams ) do
            self.scores[ team.clan_id ] = 0
            self.team_id_by_clan_id[ team.clan_id ] = team_id
            self.clan_id_by_team_id[ team_id ] = team.clan_id
        end
        for i, player in pairs( self.participants ) do
            self.OnPlayerJoin( player )
        end
	end

    self.OnStart = function( )
		if self.started then return end
		self.started = true

        self.elements.holdarea = CreateHoldArea( self.config, self )
        self.holdarea = self.elements.holdarea

        for k, player in pairs( self.participants ) do
            self.OnPlayerRequestSpawn( player, true )
        end
        
        local clans_tags = { }
        for team_id, team in pairs( self.teams ) do
            self.scores[ team.clan_id ] = 0
            clans_tags[ team.clan_id ] = GetClanData( team.clan_id, "tag" )
        end
		
		local pDataToSend =
		{
			teams = self.team_id_by_clan_id,
			clans_tags = clans_tags,
			duration = self.conf.game_duration,
			need_score = self.holdarea.need_score,
		}

		triggerClientEvent( self.participants, "CEV:OnClientGameStarted", resourceRoot, pDataToSend )
    end

    self.OnFinish = function( is_forced )
		if self.finished then return end
        
        local clan_1 = self.clan_id_by_team_id[ 1 ]
        local clan_2 = self.clan_id_by_team_id[ 2 ]

        if  
            self.scores[ clan_1 ] == self.scores[ clan_2 ] and 
            #self.clans_players[ clan_1 ] > 0 and #self.clans_players[ clan_2 ] > 0 
        then
            self.holdarea.need_score = ( self.scores[ clan_1 ] or 0 ) + 1
            triggerClientEvent( self.participants, "CEV:UpdateGameUI", resourceRoot, _, self.holdarea.need_score )
            return
        end

        local winner_clan_id = ( self.scores[ clan_1 ] or 0 ) > ( self.scores[ clan_2 ] or 0 ) and clan_1 or clan_2
        local loser_clan_id = ( self.scores[ clan_1 ] or 0 ) > ( self.scores[ clan_2 ] or 0 ) and clan_2 or clan_1

        -- ???????? ???????????????????? ?????????????? ??????????????, ???? ?????????????????????? ???? ????????????????
        if #self.clans_players[ winner_clan_id ] == 0 then
            winner_clan_id, loser_clan_id = loser_clan_id, winner_clan_id
        end

        if self.holdarea and self.holdarea.destroy then
            self.holdarea:destroy( )
        else
            Debug( "no self.holdarea, self.started " .. tostring( self.started ) .. ", scores " .. inspect( self.scores ), 1 )
            Debug( "teams " .. inspect( self.teams ), 1 )
        end

        self.finished = true

        triggerEvent( "CEV:OnGameFinished", root, self.id, {
            winner_clan_id = winner_clan_id,
            loser_clan_id = loser_clan_id,
            scores = self.scores,
        } )
    end

    self.destroy = function( )
		-- ???? ???????????????????? ?????? ?????????????????? ???????????????? ??????????????, ?????????? ?????
		DestroyTableElements( self.elements )
        
        MATCHES_BY_LOBBY_ID[ self.id ] = nil
    end

    table.insert( MATCHES_LIST, self )
    MATCHES_BY_LOBBY_ID[ self.id ] = self

    self.OnCreated( )
end
addEvent( "CEV:OnLobbyCreated", true )
addEventHandler( "CEV:OnLobbyCreated", resourceRoot, CreateMatch )

function OnPlayerLobbyJoin( lobby_id, player )
    local match = MATCHES_BY_LOBBY_ID[ lobby_id ]

    if match then
        match.OnPlayerRequestJoin( player )
    end
end
addEvent( "CEV:OnPlayerLobbyJoin", true )
addEventHandler( "CEV:OnPlayerLobbyJoin", resourceRoot, OnPlayerLobbyJoin )

function OnPlayerLobbyLeave( lobby_id, player )
    local match = MATCHES_BY_LOBBY_ID[ lobby_id ]

    if match then
        match.OnPlayerLeave( player )
    end
end
addEvent( "CEV:OnPlayerLobbyLeave", true )
addEventHandler( "CEV:OnPlayerLobbyLeave", resourceRoot, OnPlayerLobbyLeave )

function OnGameLobbyStarted( lobby_id, state )
    local match = MATCHES_BY_LOBBY_ID[ lobby_id ]

    if match then
        if state == 4 then
            match.OnStart( )
        else
            match.OnFinish( )
        end
    end
end
addEvent( "CEV:OnLobbyStateChanged", true )
addEventHandler( "CEV:OnLobbyStateChanged", resourceRoot, OnGameLobbyStarted )

function OnGameLobbyDestroyed( lobby_id )
    local match = MATCHES_BY_LOBBY_ID[ lobby_id ]

    if match then
        match.destroy( )
    end
end
addEvent( "CEV:OnLobbyDestroyed", true )
addEventHandler( "CEV:OnLobbyDestroyed", resourceRoot, OnGameLobbyDestroyed )
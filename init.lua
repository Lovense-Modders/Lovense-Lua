lovense = {}
lovense.toys = {}

local json = require( "lovense.json" )
local http = require( "socket.http" )

require( "lovense.toys.Ambi" )
require( "lovense.toys.Diamo" )
require( "lovense.toys.Domi" )
require( "lovense.toys.Edge" )
require( "lovense.toys.Ferri" )
require( "lovense.toys.Hush" )
require( "lovense.toys.Lush" )
require( "lovense.toys.Max" )
require( "lovense.toys.Mission" )
require( "lovense.toys.Nora" )
require( "lovense.toys.Osci" )
require( "lovense.toys.Quake" )

function lovense.Request( url, parameters )
    if not lovense.domain then error( "Please call lovense.GetToys first" ) return end

    local params = "?"

    for k, v in pairs( parameters or {} ) do
        params = params .. k .. "=" .. v .. "&"
    end

    return http.request( lovense.domain .. url .. params )
end

function lovense.Connect()
    local body, code = http.request( lovense.domain or "http://127-0-0-1.lovense.club:20010/" )

    if code == "connection refused" then
        body, code = http.request( "http://127-0-0-1.lovense.club:20011/" )
        if code == "connection refused" then
            return false
        else
            lovense.domain = "http://127-0-0-1.lovense.club:20011/"
        end
    else
        lovense.domain = "http://127-0-0-1.lovense.club:20010/"
    end

    return true
end

function lovense.GetToys()
    local found = lovense.Connect()
    if not found then return end

    local body = http.request( lovense.domain .. "GetToys" )

    local result = json.decode( body )
    local toys = {}

    for _, v in pairs( result.data ) do
        toys[#toys + 1] = lovense.newToy( v )
    end

    return toys
end

function lovense.newToy( data )
    local meta = lovense.toys[data.name]

    if not meta then return end

    return meta.new( data )
end
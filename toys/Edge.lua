local meta = {}
meta.__index = meta

function meta:__tostring()
    return "[" .. self.name .. "#" .. self.id .. "]"
end

function meta.new( data )
    return setmetatable( data, meta )
end

function meta:Request( action, parameters )
	if self.status == 0 then return end
	
	parameters = parameters or {}
	parameters.t = self.id

	lovense.Request( action, parameters )
end

function meta:Vibrate( v ) -- v = Speed between 0 and 20
	self:Request( "Vibrate", {
		v = v
	} )
end

function meta:Vibrate1( v, sec ) -- v = Speed between 0 and 20
	lovense.Request( "Vibrate1", {
		v = v
	} )
end

function meta:Vibrate2( v, sec ) -- v = Speed between 0 and 20
	lovense.Request( "Vibrate2", {
		v = v
	} )
end

function meta:Preset( v ) -- v = Pattern between 0 and 3
	lovense.Request( "Preset", {
		v = v
	} )
end

function meta:Battery()
	return self:Request( "Battery" )
end

function meta:AVibrate( v, sec ) --  v = Speed between 0 and 20; sec = time in seconds
	lovense.Request( "AVibrate", {
		v = v,
		sec = sec
	} )
end

function meta:AVibrate1( v, sec ) --  v = Speed between 0 and 20; sec = time in seconds
	lovense.Request( "AVibrate1", {
		v = v,
		sec = sec
	} )
end

function meta:AVibrate2( v, sec ) --  v = Speed between 0 and 20; sec = time in seconds
	lovense.Request( "AVibrate2", {
		v = v,
		sec = sec
	} )
end

lovense.toys["Edge"] = meta
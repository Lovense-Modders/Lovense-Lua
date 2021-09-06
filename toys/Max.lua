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

function meta:AirAuto( v ) -- v = Speed between 0 and 3
	lovense.Request( "AirAuto", {
		v = v
	} )
end

function meta:AirIn()
	lovense.Request( "AirIn" )
end

function meta:AirOut()
	lovense.Request( "AirOut" )
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

function meta:AAirLevel( a, sec ) -- a = Speed between 0 and 3; sec = time in seconds
	lovense.Request( "AAirLevel", {
		a = a,
		sec = sec
	} )
end

function meta:AVibAir( v, a, sec ) -- v = Vibration speed between 0 and 20; a = Contraction speed between 0 and 3; sec = time in seconds
	lovense.Request( "AVibAir", {
		v = v,
		a = a,
		sec = sec
	} )
end

lovense.toys["Max"] = meta
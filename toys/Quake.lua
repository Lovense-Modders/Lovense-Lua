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

function meta:Battery()
	return self:Request( "Battery" )
end

function meta:AVibrate( v, sec ) --  v = Speed between 0 and 20; sec = time in seconds
	lovense.Request( "AVibrate", {
		v = v,
		sec = sec
	} )
end

lovense.toys["Quake"] = meta
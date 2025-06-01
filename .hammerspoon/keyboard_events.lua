-- keyboard_events.lua - Keyboard event logging and HTTP integration module

local M = {}

-- Function to send HTTP event to OSX automation system
local function sendHTTPEvent(event_type, params)
	local port = os.getenv("OSX_EVTS_PORT") or "10888"
	local url = string.format("http://127.0.0.1:%s/evt/%s", port, event_type)
	local paramStr = ""
	for key, value in pairs(params) do
		if paramStr ~= "" then paramStr = paramStr .. "&" end
		paramStr = paramStr .. key .. "=" .. hs.http.encodeForQuery(tostring(value))
	end
	if paramStr ~= "" then url = url .. "?" .. paramStr end
	
	hs.http.get(url, nil, function(status, body, headers)
		-- Optional: handle response
		if status ~= 200 then
			print("Failed to send keyboard event: " .. tostring(status))
		end
	end)
end

-- Key event logger
local keyLogger = hs.eventtap.new({ hs.eventtap.event.types.keyDown }, function(evt)
	local keyCode = evt:getKeyCode()
	local flags = evt:getFlags()
	local char = hs.keycodes.map[keyCode]
	
	-- Print to console (existing behavior)
	print(string.format("%s key - keyCode: %d, modifiers: %s", char or "nil", keyCode, hs.inspect(flags)))
	
	-- Convert flags table to comma-separated string
	local modifiersList = {}
	for modifier, enabled in pairs(flags) do
		if enabled then
			table.insert(modifiersList, modifier)
		end
	end
	local modifiersString = table.concat(modifiersList, ",")
	
	-- Send to OSX automation system
	sendHTTPEvent("keyboard_event", {
		key_code = keyCode,
		key_char = char or "unknown",
		modifiers = modifiersString
	})
	
	return false
end)

-- Setup function to initialize keyboard event logging
function M.setup(bindFunction, notifyFunction)
	-- Store references to the main config functions
	local Bind = bindFunction
	local Notify = notifyFunction
	
	-- Toggle key logger with Cmd+Ctrl+K
	Bind({ "cmd", "ctrl" }, "k", function()
		if keyLogger:isEnabled() then
			keyLogger:stop()
			-- Send event that logging stopped
			sendHTTPEvent("keyboard_event", {
				key_code = 0,
				key_char = "logger_stopped",
				modifiers = "system"
			})
			Notify("Key logger stopped")
		else
			keyLogger:start()
			-- Send event that logging started
			sendHTTPEvent("keyboard_event", {
				key_code = 0,
				key_char = "logger_started", 
				modifiers = "system"
			})
			Notify("Key logger started - sending events to OSX automation")
		end
	end)
end

-- Function to check if logger is currently enabled
function M.isEnabled()
	return keyLogger:isEnabled()
end

-- Function to manually start/stop logger
function M.start()
	keyLogger:start()
end

function M.stop()
	keyLogger:stop()
end

-- Function to send custom keyboard events
function M.sendEvent(key_code, key_char, modifiers)
	sendHTTPEvent("keyboard_event", {
		key_code = key_code or 0,
		key_char = key_char or "custom",
		modifiers = modifiers or ""
	})
end

return M

HS = hs

-- Hotkey registration system
local hotkeyRegistry = {}

-- Enhanced Bind function with registration and description
-- Usage: Bind(mods, key, description, fn)
function Bind(mods, key, description, fn)
	-- Register the hotkey with description
	table.insert(hotkeyRegistry, {
		mods = mods,
		key = key,
		description = description or "No description",
		fn = fn,
	})

	-- Call the original bind function
	return HS.hotkey.bind(mods, key, fn)
end

-- Function to write keybinds to markdown file
function writeKeymapsToFile()
	local filePath = HS.configdir .. "/keymaps.md"
	local content = { "# Hammerspoon Keybinds\n" }

	table.insert(content, "| Modifiers | Key | Description |")
	table.insert(content, "|-----------|-----|-------------|")

	for _, entry in ipairs(hotkeyRegistry) do
		local mods = table.concat(entry.mods, "+")
		local key = string.lower(entry.key) -- Ensure lowercase for consistency
		local row = string.format("| %s | %s | %s |", mods, key, entry.description)
		table.insert(content, row)
	end

	table.insert(content, string.format("\n**Total: %d hotkeys registered**", #hotkeyRegistry))

	local file = io.open(filePath, "w")
	if file then
		file:write(table.concat(content, "\n"))
		file:close()
		print("Keymaps written to " .. filePath)
	else
		print("Failed to write keymaps file")
	end
end

function Notify(message)
	local time = os.date("%H:%M:%S")
	HS.execute(
		'/opt/homebrew/bin/terminal-notifier -title "hammerspoon ' .. time .. '" -message "' .. message .. '"',
		false
	)
end

Bind({ "cmd", "ctrl" }, "r", "Reload Hammerspoon configuration", function()
	Notify("Reloading Hammerspoon")
	HS.reload()
end)

local eventtap = HS.eventtap
local event = HS.eventtap.event

-- Watch for scroll events
local scrollWatcher = eventtap.new({ event.types.scrollWheel }, function(e)
	local mods = e:getFlags()
	local scroll = e:getProperty(event.properties.scrollWheelEventDeltaAxis1)
	-- Check if Cmd is held down and throttle keystrokes
	if mods.cmd then
		if scroll > 0 then
			HS.eventtap.keyStroke({ "cmd" }, "=")
		elseif scroll < 0 then
			HS.eventtap.keyStroke({ "cmd" }, "-")
		end
		return true
	end
end)
scrollWatcher:start()
-- Refresh the eventtap periodically to prevent it from being disabled
local refreshTimer = HS.timer.doEvery(10, function()
	print("Scheduled restart of scrollwatcher")
	scrollWatcher:stop()
	scrollWatcher:start()
end)

YABAI = "/opt/homebrew/bin/yabai"
HYPER = { "cmd", "alt", "ctrl" }
HYPRS = { "cmd", "alt", "ctrl", "shift" }
CMD = { "cmd" }
CMDSHF = { "cmd", "shift" }
CMDALT = { "cmd", "alt" }
CMDCTRL = { "cmd", "ctrl" }
CMDALTS = { "cmd", "alt", "shift" }
ALTS = { "shift", "alt" }
HOTKEY = os.getenv("HOME") .. "/bin/hotkey"

function YWIN(action, args)
	local cmd = string.format("%s -m window --%s %s", YABAI, action, args)
	print(cmd)
	local _, status, exitCode = HS.execute(cmd)
	if status == true then
		return true
	else
		print(string.format("Command failed: %s (exit code: %s)", command, status))
		return false
	end
end

function WIN(action, args, onError)
	return function()
		if not YWIN(action, args) and onError then
			onError()
		end
	end
end

function EXEC(cmd)
	return function()
		HS.execute(cmd, false)
	end
end

function ClickAtCurrentPosition()
	local currentPosition = HS.mouse.absolutePosition()
	HS.eventtap.event.newMouseEvent(HS.eventtap.event.types.leftMouseDown, currentPosition):post()
	HS.eventtap.event.newMouseEvent(HS.eventtap.event.types.leftMouseUp, currentPosition):post()
end

-- Text insertion shortcuts
Bind(CMDCTRL, "L", "Type localhost IP address", function()
	HS.eventtap.keyStrokes("127.0.0.1")
end)

Bind(CMDCTRL, "V", "Type Discord channel URL", function()
	HS.eventtap.keyStrokes("https://discord.com/channels/1210288790858375219/1330835593445245050 ")
end)

-- System and terminal shortcuts

Bind(CMDSHF, "t", "Open new Ghostty terminal", EXEC("open -na Ghostty"))
Bind(CMDSHF, "C", "Copy color at cursor position", EXEC(HOTKEY .. " copycolor"))

-- Window management - resize
Bind(CMDSHF, "H", "Resize window left (shrink width)", WIN("resize", "right:-50:0", WIN("resize", "left:-50:0")))
Bind(CMDSHF, "L", "Resize window right (expand width)", WIN("resize", "left:50:0", WIN("resize", "right:50:0")))
Bind(CMDALT, "J", "Resize window down (shrink height)", WIN("resize", "top:0:-50", WIN("resize", "bottom:0:-50")))
Bind(CMDALT, "K", "Resize window up (expand height)", WIN("resize", "bottom:0:50", WIN("resize", "top:0:50")))

-- Window management - focus
Bind(CMDSHF, "J", "Focus previous window", WIN("focus", "prev", WIN("focus", "last")))
Bind(CMDSHF, "K", "Focus next window", WIN("focus", "next", WIN("focus", "first")))

-- Window management - actions
Bind(CMDSHF, "space", "Swap window with next", WIN("swap", "next", WIN("swap", "first")))
Bind(CMDSHF, "return", "Toggle fullscreen zoom", WIN("toggle", "zoom-fullscreen"))
Bind(CMDSHF, "d", "Move window to recent display", WIN("display", "recent"))
Bind(CMDSHF, "b", "Balance space layout", EXEC(YABAI .. " -m space --balance"))
Bind(CMDSHF, "i", "Toggle window sticky mode", WIN("toggle", "sticky"))
Bind(CMDSHF, "u", "Toggle window floating mode", WIN("toggle", "float"))
Bind(CMDSHF, "o", "Toggle window split orientation", WIN("toggle", "split"))

-- Space switching with number keys
local allKeys = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "0" }
for i, key in ipairs(allKeys) do
	Bind(CMDSHF, key, "Move window to space " .. i, function()
		YWIN("space", tostring(i))
	end)
end

local allKeys = { "1", "2", "3" }
for i, key in ipairs(allKeys) do
	Bind(CMDALTS, key, "Move window to space " .. i, function()
		YWIN("space", tostring(i + 10))
	end)
end

-- Import keyboard events module
local KeyboardEvents = require("keyboard_events")
-- Setup keyboard event logging (pass Bind and Notify functions)
KeyboardEvents.setup(Bind, Notify)

-- Screenshot shortcuts
--Bind({ "ctrl" }, "f5", "Take screenshot", EXEC(HOTKEY .. " screenshot"))
--Bind({ "ctrl", "cmd" }, "f5", "Take interactive screenshot", EXEC(HOTKEY .. " screenshot interactive"))

-- Force quit current application
Bind({ "cmd" }, "f1", "Force quit current application", function()
	local frontmostApp = HS.application.frontmostApplication()
	if frontmostApp then
		local appName = frontmostApp:name()
		HS.execute('killall -9 "' .. appName .. '"', true)
		HS.alert.show("SIGKILL sent to " .. appName)
	end
end)

-- Write keymaps to file after all bindings are registered
HS.timer.doAfter(1, writeKeymapsToFile)

-- Commented out sections from original file for reference:

-- Application shortcuts (commented out)
-- Bind(CMDALTS, "1", "Open Mail app", EXEC("open -a Mail"))
-- Bind(CMDALTS, "2", "Open Calendar app", EXEC("open -a Calendar"))
-- Bind(CMDALTS, "3", "Open Discord app", EXEC("open -a Discord"))
-- Bind(CMDALTS, "4", "Open Zen browser", EXEC("open -a Zen"))
-- Bind(CMDALTS, "5", "Open WezTerm", EXEC("open -a wezterm"))
-- Bind(CMDALTS, "6", "Open Google Chrome", EXEC("open -a 'Google Chrome'"))

-- Advanced space management (commented out)
-- local keyMapping = { "x", "c", "v", "s", "d", "f", "w", "e", "r", "1", "2", "3", "4" }
-- for i = 1, 13 do
-- 	Bind(HYPER, keyMapping[i], "Focus space " .. i, function()
-- 		YSPCE("focus", tostring(i))
-- 	end)
-- 	Bind(HYPRS, keyMapping[i], "Move window to space " .. i, WIN("space", tostring(i)))
-- 	Bind(ALTS, keyMapping[i], "Move window and focus space " .. i, function()
-- 		YWIN("space", tostring(i))
-- 		YSPCE("focus", tostring(i))
-- 	end)
-- end

-- Menu bar functionality (commented out - extensive yabai desktop tracking code)
-- This section contained complex desktop monitoring and menu bar updates

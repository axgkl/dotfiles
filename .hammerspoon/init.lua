HS = hs
Bind = HS.hotkey.bind
function Notify(message)
	local time = os.date("%H:%M:%S")
	HS.execute(
		'/opt/homebrew/bin/terminal-notifier -title "hammerspoon ' .. time .. '" -message "' .. message .. '"',
		false
	)
end
Bind({ "cmd", "ctrl" }, "r", function()
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
-- function YSPCE(action, args)
-- 	local cmd = string.format("%s -m space --%s %s", YABAI, action, args)
-- 	HS.execute(cmd, false)
-- end

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
		--ClickAtCurrentPosition()
	end
end
--TERMOPEN = [[open -na Ghostty && sleep 1.0 && yabai -m window --focus $(yabai -m query --windows | jq 'map(select(.app == "Ghostty")) | sort_by(.id) | last | .id') ]]

function ClickAtCurrentPosition()
	local currentPosition = HS.mouse.absolutePosition()
	HS.eventtap.event.newMouseEvent(HS.eventtap.event.types.leftMouseDown, currentPosition):post()
	HS.eventtap.event.newMouseEvent(HS.eventtap.event.types.leftMouseUp, currentPosition):post()
end

Bind(CMDCTRL, "L", function()
	HS.eventtap.keyStrokes("127.0.0.1")
end)
Bind(CMDCTRL, "V", function()
	HS.eventtap.keyStrokes("https://discord.com/channels/1210288790858375219/1330835593445245050 ")
end)

TERMOPEN = "/Applications/WezTerm.app/Contents/MacOS/wezterm-gui start --always-new-process"
Bind({ "ctrl" }, "F9", EXEC("pmset sleepnow"))
--Bind(HYPER, "t", EXEC("open -na wezterm"))
Bind(CMDSHF, "t", EXEC("open -na Ghostty"))
Bind(CMDALT, "8", EXEC("open -na Wezterm --args start --always-new-process")) -- no gui

-- HS.hotkey.bind(CMDALT, "8", function()
-- 	HS.task
-- 		.new("/usr/bin/open", nil, function()
-- 			return true
-- 		end, { "-na", "WezTerm", "--args", "start", "--always-new-process" })
-- 		:start()
-- end)
--Bind(CMDALT, "8", EXEC("open -na Wezterm"))
-- Open new WezTerm instance with Cmd+Alt+Return
-- Bind(CMDALT, "8", function()
-- 	HS.task
-- 		.new("/opt/homebrew/bin/wezterm", nil, function()
-- 			return true
-- 		end, { "start", "--always-new-process" })
-- 		:start()
-- end)
Bind(CMDSHF, "C", EXEC(HOTKEY .. " copycolor"))

Bind(CMDSHF, "H", WIN("resize", "right:-50:0", WIN("resize", "left:-50:0")))
Bind(CMDSHF, "L", WIN("resize", "left:50:0", WIN("resize", "right:50:0")))
Bind(CMDALT, "J", WIN("resize", "top:0:-50", WIN("resize", "bottom:0:-50")))
Bind(CMDALT, "K", WIN("resize", "bottom:0:50", WIN("resize", "top:0:50")))
Bind(CMDSHF, "J", WIN("focus", "prev", WIN("focus", "last")))
Bind(CMDSHF, "K", WIN("focus", "next", WIN("focus", "first")))

Bind(CMDSHF, "space", WIN("swap", "next", WIN("swap", "first")))
Bind(CMDSHF, "return", WIN("toggle", "zoom-fullscreen"))
Bind({ "ctrl", "shift" }, "return", WIN("display", "recent"))
Bind({ "ctrl", "shift" }, "space", EXEC(YABAI .. " -m space --balance"))
Bind(CMDSHF, "i", WIN("toggle", "sticky"))
Bind(CMDSHF, "u", WIN("toggle", "float"))
Bind(CMDSHF, "o", WIN("toggle", "split"))

-- sip on did not work fuck, so with have sa loaded and can do space:
local allKeys = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", ".", "," }
for i, key in ipairs(allKeys) do
	Bind(CMDSHF, key, function()
		YWIN("space", tostring(i))
	end)
end
-- Import keyboard events module
local KeyboardEvents = require('keyboard_events')

-- Setup keyboard event logging (pass Bind and Notify functions)
KeyboardEvents.setup(Bind, Notify)

Bind({ "ctrl" }, "f5", EXEC(HOTKEY .. " screenshot"))
Bind({ "ctrl", "cmd" }, "f5", EXEC(HOTKEY .. " screenshot interactive"))
Bind({ "cmd" }, "f1", function()
	local frontmostApp = HS.application.frontmostApplication()
	if frontmostApp then
		local appName = frontmostApp:name()
		HS.execute('killall -9 "' .. appName .. '"', true)
		HS.alert.show("SIGKILL sent to " .. appName)
	end
end)
--
-- -- win to space with sip on: switch to space here, then call yabai
-- function MissCtrlId(spcnr)
-- 	local handle = io.popen(YABAI .. " -m query --spaces | jq '.[] | select(.index == " .. spcnr .. ") | .id'")
-- 	local result = handle:read("*a")
-- 	handle:close()
-- 	return tonumber(result:match("^%s*(.-)%s*$"))
-- end
-- function Win2spc(nr)
-- 	return function()
-- 		local mid = MissCtrlId(nr)
-- 		local win = hs.window.focusedWindow()
-- 		HS.spaces.gotoSpace(mid)
-- 		--HS.timer.usleep(1000000)
-- 		--HS.spaces.moveWindowToSpace(win, mid)
-- 		HS.execute(HOTKEY .. " win2spc " .. win:id() .. " " .. nr, false)
-- 	end
-- end

-- Bind(CMDALTS, "1", EXEC("open -a Mail"))
-- Bind(CMDALTS, "2", EXEC("open -a Calendar"))
-- Bind(CMDALTS, "3", EXEC("open -a Discord"))
-- Bind(CMDALTS, "4", EXEC("open -a Zen"))
-- Bind(CMDALTS, "5", EXEC("open -a wezterm"))
-- Bind(CMDALTS, "6", EXEC("open -a 'Google Chrome'"))
-- local keyMapping = { "x", "c", "v", "s", "d", "f", "w", "e", "r", "1", "2", "3", "4" }
-- for i = 1, 13 do
-- 	Bind(HYPER, keyMapping[i], function()
-- 		YSPCE("focus", tostring(i))
-- 	end)
-- 	Bind(HYPRS, keyMapping[i], WIN("space", tostring(i)))
-- 	Bind(ALTS, keyMapping[i], function()
-- 		YWIN("space", tostring(i))
-- 		YSPCE("focus", tostring(i))
-- 	end)
-- end

-- hs.hotkey.bind({ "ctrl" }, "f5", function()
-- 	print(hs.execute(YABAI .. " -m query --spaces --space | jq -r '.index'"))
-- end)

----local yabai_menu = hs.menubar.new()
--
---- Function to check if a desktop (space) has windows
--local function getDesktopsWithWindows()
--	local command = YABAI .. " -m query --windows"
--	local startTime = hs.timer.secondsSinceEpoch()
--
--	local output, status = hs.execute(command)
--	local endTime = hs.timer.secondsSinceEpoch()
--	print(string.format("Elapsed Time: %.2f seconds", endTime - startTime))
--
--	local has_windws = {}
--	if status then
--		local windows = hs.json.decode(output)
--		--print("windows" .. hs.inspect(windows))
--		for _, window in ipairs(windows) do
--			has_windws[window.space] = true -- Mark the desktop as having windows
--		end
--	end
--	return has_windws
--end
--
--local function generateDesktopString(activeDesktop, desktopsWithWindows)
--	-- local nrs = { "①", "②", "③", "④", "⑤", "⑥", "⑦", "⑧", "⑨", "⓪", "①", "②", "③" }
--	local n = { "𝟷", "𝟸", "𝟹", "𝟺", "𝟻", "𝟼", "𝟽", "𝟾", "𝟿", "𝟶", "𝟷", "𝟸", "𝟹" }
--	--local anr = { "➊", "➋", "➌", "➍", "➎", "➏", "➐", "➑", "➒", "●", "➊", "➋", "➌" }
--	local anr = { "1̲", "2̲", "3̲", "4̲", "5̲", "6̲", "7̲", "8̲", "9̲", "0̲", "1̲", "2̲", "3̲" }
--
--	for i = 1, #n do
--		if not desktopsWithWindows[i] then
--			n[i] = "▪"
--		end
--	end
--
--	if activeDesktop and activeDesktop >= 1 and activeDesktop <= 13 then
--		n[activeDesktop] = anr[activeDesktop]
--	end
--
--	return table.concat(n)
--end
--
---- Update the menu bar widget with the active desktop
--local function update_yabai_menu(activeDesktop)
--	local desktopsWithWindows = getDesktopsWithWindows()
--	yabai_menu:setTitle(generateDesktopString(activeDesktop, desktopsWithWindows))
--end
--
---- local wf = hs.window.filter.default
---- wf:subscribe(hs.window.filter.windowFocused, function(window)
---- 	if window then
---- 		local output, status = hs.execute(YABAI .. " -m query --spaces --space | jq -r '.index'")
---- 		if status then
---- 			local desktopNumber = tonumber(output:match("%d+"))
---- 			if desktopNumber then
---- 				update_yabai_menu(desktopNumber)
---- 			end
---- 		end
---- 	end
---- end)
----
---- update_yabai_menu(nil)
----
---- local function handleYabaiEvent(event)
---- 	print("Space changed!")
---- end
----
---- local yabaiTask = hs.task.new("/usr/bin/env", function(exitCode, stdOut, stdErr)
---- 	if exitCode == 0 then
---- 		handleYabaiEvent(stdOut)
---- 	else
---- 		hs.alert.show("Error: " .. stdErr)
---- 	end
---- end, function(task, stdOut, stdErr)
---- 	handleYabaiEvent(stdOut)
---- 	return true -- Continue reading output
---- end, { "yabai", "-m", "signal", "--add", "event=space_changed", "action=echo space_changed" })
----
---- yabaiTask:start()
----
---- local function getBundleID(appName)
---- 	local app = hs.application.find(appName)
---- 	if app then
---- 		return app:bundleID()
---- 	else
---- 		return nil
---- 	end
---- end
----
---- local function getAppImage(appName)
---- 	local bundleID = getBundleID(appName)
---- 	if bundleID then
---- 		return hs.image.imageFromAppBundle(bundleID)
---- 	else
---- 		return nil
---- 	end
---- end
----
---- local function createCombinedImage(apps)
---- 	local canvas = hs.canvas.new({ x = 0, y = 0, w = #apps * 32, h = 32 })
---- 	for i, appName in ipairs(apps) do
---- 		local img = getAppImage(appName)
---- 		if img then
---- 			canvas[i] = {
---- 				type = "image",
---- 				image = img,
---- 				frame = { x = (i - 1) * 32, y = 0, w = 32, h = 32 },
---- 			}
---- 		end
---- 	end
---- 	return canvas:imageFromCanvas()
---- end
----
---- local function generateMenu()
---- 	local wins = hs.execute(YABAI .. " -m query --windows", true)
---- 	print(wins)
---- 	local yabaiOutput = hs.json.decode(wins)
---- 	local spaces = {}
----
---- 	-- Group apps by space
---- 	for _, window in ipairs(yabaiOutput) do
---- 		if not spaces[window.space] then
---- 			spaces[window.space] = {}
---- 		end
---- 		table.insert(spaces[window.space], window.app)
---- 	end
----
---- 	local sortedSpaces = {}
---- 	for space in pairs(spaces) do
---- 		table.insert(sortedSpaces, space)
---- 	end
---- 	table.sort(sortedSpaces)
---- 	-- Create menu entries
---- 	local menuEntries = {}
---- 	for _, space in ipairs(sortedSpaces) do
---- 		local apps = spaces[space]
---- 		local combinedImage = createCombinedImage(apps)
---- 		table.insert(menuEntries, {
---- 			title = "Space " .. space,
---- 			image = combinedImage,
---- 			fn = function()
---- 				hs.alert.show("Apps on Space " .. space .. ": " .. table.concat(apps, ", "))
---- 			end,
---- 		})
---- 	end
---- 	return menuEntries
---- end
---- --yabai_menu:setMenu(generateMenu)
>>>>>>> 21ec991 (add on)

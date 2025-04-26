local usKeyboard = "U.S."
local intlKeyboard = "U.S. International – PC"

local appWatcher = nil

local function setLayoutIfNeeded(targetLayout)
	local currentLayout = hs.keycodes.currentLayout()
	if currentLayout ~= targetLayout then
		hs.keycodes.setLayout(targetLayout)
	end
end

local function applicationWatcher(appName, eventType, appObject)
	if eventType == hs.application.watcher.activated then
		if appName == "WezTerm" or appName == "Firefox" then
			setLayoutIfNeeded(usKeyboard)
		elseif appName == "Slack" then
			setLayoutIfNeeded(intlKeyboard)
		end
	end
end

appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()

local function launchIfNotRunning(appName)
	local app = hs.application.find(appName)
	if not app then
		hs.application.launchOrFocus(appName)
	end
end

hs.timer.doAfter(2, function()
	launchIfNotRunning("Firefox")
end)

hs.timer.doAfter(6, function()
	launchIfNotRunning("WezTerm")
end)

hs.timer.doAfter(8, function()
	launchIfNotRunning("Slack")
end)

local dotfileWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", hs.reload):start()

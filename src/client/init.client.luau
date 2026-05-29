local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local React = require("@packages/react")
local ReactRoblox = require("@packages/react-roblox")
local Vide = require("@packages/vide")

local ReactColorMap = require("@react-components/color-map")
local VideColorMap = require("@vide-components/color-map")

local mount = Vide.mount
local create = Vide.create
local source = Vide.source

local e = React.createElement

local useState = React.useState
local useEffect = React.useEffect

local function ReactApp()
	local colors, setColors = useState({})

	useEffect(function()
		local connection = RunService.RenderStepped:Connect(function(delta: number)
			local map = table.create(5000, nil) :: any
			for steps = 1, 5000 do
				map[steps] = Color3.new(math.random(), math.random(), math.random())
			end

			setColors(map)
		end)

		return function()
			connection:Disconnect()
		end
	end)

	return e("ScreenGui", {
		IgnoreGuiInset = true,
		ResetOnSpawn = false,
	}, {
		e(ReactColorMap, {
			Colors = colors,
		}),
	})
end

local function VideApp()
	local colors = source({})

	RunService.RenderStepped:Connect(function(deltaTime: number)
		local map = table.create(20000, nil) :: any
		for steps = 1, 20000 do
			map[steps] = Color3.new(math.random(), math.random(), math.random())
		end

		colors(map)
	end)

	return create("ScreenGui", {
		IgnoreGuiInset = true,
		ResetOnSpawn = false,

		VideColorMap({
			Colors = colors,
		}),
	})
end

local root = ReactRoblox.createRoot(Instance.new("Folder"))
root:render(ReactRoblox.createPortal(e(ReactApp), Players.LocalPlayer:WaitForChild("PlayerGui")))

--mount(function()
--	return VideApp()
--end, Players.LocalPlayer:WaitForChild("PlayerGui"))

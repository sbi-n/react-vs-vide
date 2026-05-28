local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local React = require(game:GetService("ReplicatedStorage"):WaitForChild("packages"):WaitForChild("react"))
local ReactRoblox = require(game:GetService("ReplicatedStorage"):WaitForChild("packages"):WaitForChild("react-roblox"))
local Vide = require(game:GetService("ReplicatedStorage"):WaitForChild("packages"):WaitForChild("vide"))

local ReactColorMap = require(game:GetService("StarterPlayer"):WaitForChild("StarterPlayerScripts"):WaitForChild("client"):WaitForChild("react-components"):WaitForChild("color-map"))
local VideColorMap = require(game:GetService("StarterPlayer"):WaitForChild("StarterPlayerScripts"):WaitForChild("client"):WaitForChild("vide-components"):WaitForChild("color-map"))

local mount = Vide.mount
local create = Vide.create
local source = Vide.source

local e = React.createElement

local useState = React.useState
local useEffect = React.useEffect

local function ReactApp()
	local colors, setColors = useState({})

	useEffect(function()
		RunService.RenderStepped:Connect(function(deltaTime: number)
			local map = table.create(500, nil) :: any
			for steps = 1, 500 do
				map[steps] = Color3.new(math.random(), math.random(), math.random())
			end

			setColors(map)
		end)
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
		local map = table.create(1000, nil) :: any
		for steps = 1, 1000 do
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
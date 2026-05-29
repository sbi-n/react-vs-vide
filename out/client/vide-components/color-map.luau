local Vide = require(game:GetService("ReplicatedStorage"):WaitForChild("packages"):WaitForChild("vide"))

local create = Vide.create
local derive = Vide.derive
local indexes = Vide.indexes

local function ColorMap(props: {
	Colors: Vide.Source<{ Color3 }>,
})
	return create("Frame")({
		AnchorPoint = Vector2.new(0.5, 0),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = derive(function()
			return UDim2.new(0, #props.Colors(), 0, 100)
		end),

		indexes(props.Colors, function(value, index)
			return create("Frame")({
				Position = UDim2.fromOffset(index - 1, 0),
				Size = UDim2.new(0, 1, 1, 0),
				BackgroundColor3 = value,
			})
		end),
	})
end

return ColorMap

local React = require(game:GetService("ReplicatedStorage"):WaitForChild("packages"):WaitForChild("react"))

local e = React.createElement

local function ColorMap(props: { 
    Colors: { Color3 }
})
    local children = table.create(#props.Colors, nil) :: any

    for index, color in props.Colors do
        children[index] = e("Frame", {
            BorderSizePixel = 0,
            Position = UDim2.fromOffset(index - 1, 0),
            Size = UDim2.new(0, 1, 1, 0),
            BackgroundColor3 = color
        })
    end

    return e("Frame", {
        AnchorPoint = Vector2.new(0.5, 1),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.new(0, #props.Colors, 0, 100)
    }, children)
end

return ColorMap
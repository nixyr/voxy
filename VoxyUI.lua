do
    local v = game:GetService("CoreGui"):FindFirstChild("VoxyUI")
    if v then
        v:Destroy()
    end
end

local Voxy = {}

function Voxy:Window(Title)
    local VoxyLibrary = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local TopBar = Instance.new("Frame")
    local SectionFrame = Instance.new("Frame")
    local PageListHolder = Instance.new("Frame")
    local PageFrame = Instance.new("ScrollingFrame")
    local MainFrameCorner = Instance.new("UICorner")
    local TopBarCorner = Instance.new("UICorner")
    local SectionCorner = Instance.new("UICorner")
    local PageCorner = Instance.new("UICorner")
    local UIListLayout = Instance.new("UIListLayout")
    local PageFolder = Instance.new("Folder")
    local Close = Instance.new("TextButton")
    local Minimize = Instance.new("TextButton")
    local WindowTitle = Instance.new("TextLabel")
    local CloseIcon = Instance.new("ImageLabel")
    local MinimizeIcon = Instance.new("ImageLabel")

    --[Locals]--
    local UserInputService = game:GetService("UserInputService")
    local Camera = workspace:WaitForChild("Camera")
    local minimized = false
    local ItemBGColor = Color3.fromRGB(20, 20, 20)
    local FindV = game:GetService("CoreGui")
    local DragMousePosition
    local FramePosition
    local Draggable = false

    --[Drag Script]--
    TopBar.InputBegan:Connect(
        function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                Draggable = true
                DragMousePosition = Vector2.new(input.Position.X, input.Position.Y)
                FramePosition = Vector2.new(MainFrame.Position.X.Scale, MainFrame.Position.Y.Scale)
            end
        end
    )
    UserInputService.InputChanged:Connect(
        function(input)
            if Draggable == true then
                local NewPosition =
                    FramePosition +
                    ((Vector2.new(input.Position.X, input.Position.Y) - DragMousePosition) / Camera.ViewportSize)
                MainFrame.Position = UDim2.new(NewPosition.X, 0, NewPosition.Y, 0)
            end
        end
    )

    UserInputService.InputEnded:Connect(
        function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                Draggable = false
            end
        end
    )

    PageFolder.Name = "TabFolder"
    PageFolder.Parent = SectionFrame

    Title = Title or ""

    VoxyLibrary.Name = "VoxyUI"
    VoxyLibrary.Parent = game.CoreGui
    VoxyLibrary.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    MainFrame.Name = Title .. " Holder" or "MainFrame"
    MainFrame.Parent = VoxyLibrary
    MainFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
    MainFrame.Position = UDim2.new(0.048, 0, 0.075, 0)
    MainFrame.Size = UDim2.new(0, 420, 0, 280)

    MainFrameCorner.Name = "Corner"
    MainFrameCorner.Parent = MainFrame
    MainFrameCorner.CornerRadius = UDim.new(0, 5)

    TopBar.Name = "TopBar"
    TopBar.Parent = MainFrame
    TopBar.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    TopBar.Position = UDim2.new(0, 0, 0, 0)
    TopBar.Size = UDim2.new(0, 420, 0, 30)

    TopBarCorner.Name = "Corner"
    TopBarCorner.Parent = TopBar
    TopBarCorner.CornerRadius = UDim.new(0, 5)

    WindowTitle.Name = Title
    WindowTitle.Parent = TopBar
    WindowTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    WindowTitle.BackgroundTransparency = 1
    WindowTitle.Position = UDim2.new(0, 10, 0, 7)
    WindowTitle.TextXAlignment = Enum.TextXAlignment.Left
    WindowTitle.Size = UDim2.new(0, 15, 0, 15)
    WindowTitle.TextColor3 = Color3.fromRGB(90, 90, 90)
    WindowTitle.Font = Enum.Font.GothamBold
    WindowTitle.Text = Title
    WindowTitle.ZIndex = 2
    WindowTitle.TextSize = 15.000

    SectionFrame.Name = "SectionFrame"
    SectionFrame.Parent = MainFrame
    SectionFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    SectionFrame.Visible = true
    SectionFrame.Position = UDim2.new(0, 10, 0, 40)
    SectionFrame.Size = UDim2.new(0, 290, 0, 230)

    SectionCorner.Name = "Corner"
    SectionCorner.Parent = SectionFrame
    SectionCorner.CornerRadius = UDim.new(0, 5)

    Close.Name = "Close"
    Close.Parent = TopBar
    Close.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    Close.BackgroundTransparency = 1.000
    Close.Position = UDim2.new(0, 395, 0, 5)
    Close.Size = UDim2.new(0, 15, 0, 15)
    Close.Text = ""
    Close.TextColor3 = Color3.fromRGB(190, 190, 190)
    Close.Visible = true
    Close.AutoButtonColor = false
    Close.MouseButton1Click:Connect(
        function()
            VoxyLibrary:Destroy()
        end
    )

    CloseIcon.Name = "CloseIcon"
    CloseIcon.Parent = Close
    CloseIcon.Position = UDim2.new(0.2, 0, 0.128935531, 0)
    CloseIcon.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    CloseIcon.BackgroundTransparency = 1.000
    CloseIcon.Size = UDim2.new(0, 15, 0, 15)
    CloseIcon.Image = "http://www.roblox.com/asset/?id=5969992570"
    CloseIcon.ImageColor3 = Color3.fromRGB(190, 190, 190)
    CloseIcon.Visible = true

    Minimize.Name = "Minimize"
    Minimize.Parent = TopBar
    Minimize.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    Minimize.BackgroundTransparency = 1.000
    Minimize.Position = UDim2.new(0, 370, 0, 6)
    Minimize.Size = UDim2.new(0, 15, 0, 15)
    Minimize.Text = ""
    Minimize.TextColor3 = Color3.fromRGB(190, 190, 190)
    Minimize.Visible = true
    Minimize.AutoButtonColor = false
    Minimize.MouseButton1Click:Connect(
        function()
            if minimized == false then
                MainFrame:TweenSize(
                    UDim2.new(0, 420, 0, 30),
                    Enum.EasingDirection.Out,
                    Enum.EasingStyle.Quint,
                    .5,
                    true
                )
                SectionFrame.Visible = false
                PageListHolder.Visible = false
                PageFrame.Visible = false
                minimized = true
            else
                MainFrame:TweenSize(
                    UDim2.new(0, 420, 0, 280),
                    Enum.EasingDirection.Out,
                    Enum.EasingStyle.Quart,
                    .5,
                    true
                )
                wait(.128935531)
                SectionFrame.Visible = true
                PageListHolder.Visible = true
                PageFrame.Visible = true
                minimized = false
            end
        end
    )

    MinimizeIcon.Name = "MinimizeIcon"
    MinimizeIcon.Parent = Minimize
    MinimizeIcon.Position = UDim2.new(0.2, 0, 0.128935531, 0)
    MinimizeIcon.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    MinimizeIcon.BackgroundTransparency = 1.000
    MinimizeIcon.Size = UDim2.new(0, 15, 0, 15)
    MinimizeIcon.Image = "http://www.roblox.com/asset/?id=6035067836"
    MinimizeIcon.ImageColor3 = Color3.fromRGB(190, 190, 190)
    MinimizeIcon.Visible = true

    PageListHolder.Name = "PageListHolder"
    PageListHolder.Parent = MainFrame
    PageListHolder.Size = UDim2.new(0, 110, 0, 230)
    PageListHolder.Position = UDim2.new(0, 305, 0, 40)
    PageListHolder.BackgroundColor3 = Color3.fromRGB(15, 15, 15)

    PageFrame.Name = "PageList"
    PageFrame.Active = true
    PageFrame.Parent = PageListHolder
    PageFrame.BorderSizePixel = 0
    PageFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    PageFrame.BackgroundTransparency = 1.000
    PageFrame.Position = UDim2.new(0, 0, 0, 10)
    PageFrame.Size = UDim2.new(1, 0, 1, 0)
    PageFrame.ZIndex = 2
    PageFrame.ScrollingDirection = Enum.ScrollingDirection.Y
    PageFrame.ScrollBarThickness = 0

    PageCorner.Name = "Corner"
    PageCorner.Parent = PageListHolder
    PageCorner.CornerRadius = UDim.new(0, 5)

    UIListLayout.Parent = PageFrame
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 5)

    local TabHandler = {}

function TabHandler:CreateTab(TabText)
    local TabMainFrame = Instance.new("Frame")
    local TabButton = Instance.new("TextButton")

    TabText = TabText or ""

    TabMainFrame.Name = "TabMainFrame"
    TabMainFrame.Parent = PageFrame
    TabMainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabMainFrame.BackgroundTransparency = 1.000
    TabMainFrame.Size = UDim2.new(0, 110, 0, 20)
    TabMainFrame.ZIndex = 2

    TabButton.Name = "TabButton"
    TabButton.Parent = TabMainFrame
    TabButton.BackgroundColor3 = Color3.fromRGB(166, 248, 255)
    TabButton.BackgroundTransparency = 1.000
    TabButton.Position = UDim2.new(0, 8, 0, 0)
    TabButton.Size = UDim2.new(0, 101, 0, 20)
    TabButton.ZIndex = 2
    TabButton.Font = Enum.Font.GothamBold
    TabButton.Text = TabText
    TabButton.TextColor3 = Color3.fromRGB(56, 56, 56)
    TabButton.TextSize = 11.000
    TabButton.TextXAlignment = Enum.TextXAlignment.Left

    local NewTab = Instance.new("ScrollingFrame")
    local PageList = Instance.new("UIListLayout")

    NewTab.Name = TabText
    NewTab.Parent = PageFolder
    NewTab.Active = true
    NewTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    NewTab.Position = UDim2.new(0, 0, 0, 10)
    NewTab.BackgroundTransparency = 1.000
    NewTab.BorderSizePixel = 0
    NewTab.Size = UDim2.new(1, 0, 1, 0)
    NewTab.ZIndex = 2
    NewTab.ScrollBarThickness = 0
    NewTab.Visible = false
    NewTab.ScrollingDirection = Enum.ScrollingDirection.Y

    PageList.Name = "PageList"
    PageList.Parent = NewTab
    PageList.SortOrder = Enum.SortOrder.LayoutOrder
    PageList.Padding = UDim.new(0, 5)

    function UpdateSize()
        local cS = PageList.AbsoluteContentSize

        game.TweenService:Create(
            NewTab,
            TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
            {
                CanvasSize = UDim2.new(0, cS.X, 0, cS.Y)
            }
        ):Play()
    end
    UpdateSize()
    NewTab.ChildAdded:Connect(UpdateSize)
    NewTab.ChildRemoved:Connect(UpdateSize)

    TabButton.MouseButton1Click:Connect(
        function()
            UpdateSize()
            for i, v in next, PageFolder:GetChildren() do
                UpdateSize()
                v.Visible = false
            end
            NewTab.Visible = true
            for i, v in next, PageFrame:GetChildren() do
                if v:IsA("Frame") then
                    for i, v in next, v:GetChildren() do
                        if v:IsA("TextButton") then
                            game.TweenService:Create(
                                v,
                                TweenInfo.new(0.18, Enum.EasingStyle.Quint, Enum.EasingDirection.In),
                                {
                                    TextColor3 = Color3.fromRGB(56, 56, 56)
                                }
                            ):Play()
                        end
                    end
                end
            end
            game.TweenService:Create(
                TabButton,
                TweenInfo.new(0.18, Enum.EasingStyle.Quint, Enum.EasingDirection.In),
                {
                    TextColor3 = Color3.fromRGB(255, 255, 255)
                }
            ):Play()
        end
    )

    local SectionHandler = {}
function SectionHandler:CreateSection(SectionName)
    local SectionHandlerFrame = Instance.new("ScrollingFrame")
    local SectionCorner = Instance.new("UICorner")
    local SectionList = Instance.new("UIListLayout")

    SectionList.Name = "SectionList"
    SectionList.Parent = SectionHandlerFrame
    SectionList.HorizontalAlignment = Enum.HorizontalAlignment.Center
    SectionList.SortOrder = Enum.SortOrder.LayoutOrder
    SectionList.Padding = UDim.new(0, 3)

    SectionName = SectionName or ""

    SectionHandlerFrame.Name = TabText .. " Tab"
    SectionHandlerFrame.Parent = NewTab
    SectionHandlerFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    SectionHandlerFrame.BackgroundTransparency = 1.000
    SectionHandlerFrame.BorderSizePixel = 0
    SectionHandlerFrame.Position = UDim2.new(0, 0, 7.08064434e-08, 0)
    SectionHandlerFrame.Size = UDim2.new(1, 0, 1, 0)
    SectionHandlerFrame.ZIndex = 2
    SectionHandlerFrame.ClipsDescendants = true
    SectionHandlerFrame.ScrollingDirection = Enum.ScrollingDirection.Y
    SectionHandlerFrame.ScrollBarThickness = 0

    SectionCorner.CornerRadius = UDim.new(0, 5)
    SectionCorner.Name = "Corner"
    SectionCorner.Parent = SectionHandlerFrame

    local ItemHandler = {}
    
function ItemHandler:CreateLabel(LabelText)
    local LabelFrame = Instance.new("Frame")
    local LabelInfo = Instance.new("TextLabel")

    LabelText = LabelText or ""

    LabelFrame.Name = LabelText .. "Holder"
    LabelFrame.Parent = SectionHandlerFrame
    LabelFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    LabelFrame.BackgroundTransparency = 1
    LabelFrame.Size = UDim2.new(0, 280, 0, 20)

    LabelInfo.Name = "LabelText"
    LabelInfo.Parent = LabelFrame
    LabelInfo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    LabelInfo.BackgroundTransparency = 1
    LabelInfo.Size = UDim2.new(0, 15, 0, 10)
    LabelInfo.TextColor3 = Color3.fromRGB(100, 100, 100)
    LabelInfo.TextSize = 10
    LabelInfo.Font = Enum.Font.GothamSemibold
    LabelInfo.Text = LabelText
    LabelInfo.TextXAlignment = Enum.TextXAlignment.Left
    LabelInfo.Position = UDim2.new(0, 0, 0.2, 0)
end

function ItemHandler:CreateButton(ButtonText, callback)
    local Button = Instance.new("TextButton")
    local ButtonCorner = Instance.new("UICorner")
    local UIItemList = Instance.new("UIListLayout")
    local ButtonInfo = Instance.new("TextLabel")
    local ButtonImage = Instance.new("ImageLabel")
    local Debounce = false
    local debounce1 = false
    local isHovering = false

    ButtonText = ButtonText or ""
    callback = callback or function()
        end

    Button.Name = ButtonText .. "Holder"
    Button.Parent = SectionHandlerFrame
    Button.BackgroundColor3 = ItemBGColor
    Button.Size = UDim2.new(0, 280, 0, 40)
    Button.AutoButtonColor = false
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.ZIndex = 2
    Button.Text = ""
    Button.Font = Enum.Font.GothamBold
    Button.TextSize = 10
    Button.MouseButton1Click:Connect(
        function()
            callback()
        end
    )
    Button.MouseButton1Up:Connect(
        function()
            Button:TweenSize(UDim2.new(0, 280, 0, 40), "InOut", "Quint", 0.18, true)
            game.TweenService:Create(
                Button,
                TweenInfo.new(0.18, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
                {
                    BackgroundColor3 = ItemBGColor,
                    TextColor3 = Color3.fromRGB(255, 255, 255)
                }
            ):Play()
        end
    )

    Button.MouseButton1Down:Connect(
        function()
            Button:TweenSize(UDim2.new(0, 278, 0, 40), "InOut", "Bounce", 0.18, true)
            game.TweenService:Create(
                Button,
                TweenInfo.new(0.18, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
                {
                    BackgroundColor3 = ItemBGColor,
                    TextColor3 = Color3.fromRGB(190, 190, 190)
                }
            ):Play()
            wait(.7)
        end
    )

    ButtonInfo.Name = ButtonText
    ButtonInfo.Parent = Button
    ButtonInfo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ButtonInfo.BackgroundTransparency = 1
    ButtonInfo.BorderSizePixel = 0
    ButtonInfo.Text = ButtonText
    ButtonInfo.TextColor3 = Color3.fromRGB(255, 255, 255)
    ButtonInfo.Font = Enum.Font.GothamBold
    ButtonInfo.Position = UDim2.new(0, 10, 0, 2)
    ButtonInfo.TextXAlignment = Enum.TextXAlignment.Left
    ButtonInfo.TextSize = 10
    ButtonInfo.Size = UDim2.new(0, 250, 0, 40)

    ButtonImage.Name = "ClickImage"
    ButtonImage.Parent = Button
    ButtonImage.Size = UDim2.new(0, 20, 0, 20)
    ButtonImage.Position = UDim2.new(0, 250, 0, 10)
    ButtonImage.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    ButtonImage.BackgroundTransparency = 1
    ButtonImage.ImageColor3 = Color3.fromRGB(255, 255, 255)
    ButtonImage.Image = "rbxassetid://7839505809"
    ButtonImage.Visible = true

    ButtonCorner.Name = "Corner"
    ButtonCorner.Parent = Button
    ButtonCorner.CornerRadius = UDim.new(0, 3)
end

function ItemHandler:CreateToggle(ToggleText, callback)
    local ToggleAction = {}
    local ToggleButton = Instance.new("TextButton")
    local ToggleCorner = Instance.new("UICorner")
    local Switch1 = Instance.new("ImageLabel")
    local Switch2 = Instance.new("ImageLabel")
    local ToggleInfo = Instance.new("TextLabel")

    local debounce = false
    ToggleText = ToggleText or ""
    callback = callback or function()
        end

    ToggleButton.Name = ToggleText .. "Holder"
    ToggleButton.Parent = SectionHandlerFrame
    ToggleButton.BackgroundColor3 = ItemBGColor
    ToggleButton.Size = UDim2.new(0, 280, 0, 40)
    ToggleButton.AutoButtonColor = false
    ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleButton.ZIndex = 2
    ToggleButton.Text = ""
    ToggleButton.Font = Enum.Font.GothamBold

    Switch1.Name = "Frame"
    Switch1.Parent = ToggleButton
    Switch1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Switch1.BackgroundTransparency = 1.000
    Switch1.Position = UDim2.new(0, 245, 0, 15)
    Switch1.Size = UDim2.new(0, 27, 0, 13)
    Switch1.Image = "rbxassetid://3570695787"
    Switch1.ImageColor3 = Color3.fromRGB(190, 190, 190)
    Switch1.ScaleType = Enum.ScaleType.Slice
    Switch1.SliceCenter = Rect.new(100, 100, 100, 100)
    Switch1.SliceScale = 0.250

    Switch2.Name = "Frame_2"
    Switch2.Parent = Switch1
    Switch2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Switch2.BackgroundTransparency = 1.000
    Switch2.Position = UDim2.new(0, 3, 0.150000006, 0)
    Switch2.Size = UDim2.new(0, 9, 0, 9)
    Switch2.Image = "rbxassetid://3570695787"
    Switch2.ScaleType = Enum.ScaleType.Slice
    Switch2.SliceCenter = Rect.new(100, 100, 100, 100)
    Switch2.SliceScale = 0.250

    ToggleCorner.Name = "Corner"
    ToggleCorner.Parent = ToggleButton
    ToggleCorner.CornerRadius = UDim.new(0, 3)

    ToggleInfo.Name = ToggleText
    ToggleInfo.Parent = ToggleButton
    ToggleInfo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ToggleInfo.BackgroundTransparency = 1
    ToggleInfo.BorderSizePixel = 0
    ToggleInfo.Text = ToggleText
    ToggleInfo.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleInfo.Font = Enum.Font.GothamBold
    ToggleInfo.Position = UDim2.new(0, 10, 0, 2)
    ToggleInfo.TextXAlignment = Enum.TextXAlignment.Left
    ToggleInfo.TextSize = 10
    ToggleInfo.Size = UDim2.new(0, 250, 0, 40)

    local togstate = false
    local toolight = true

    function trigger()
        togstate = not togstate
        callback(togstate)
        if togstate then
            Switch1.ImageColor3 = Color3.fromRGB(255, 255, 255)
            if toolight then
                Switch2.ImageColor3 = Color3.fromRGB(26, 26, 26)
            end
            Switch2.Position = UDim2.new(0.59, 0, 0.150000006, 0)
        else
            Switch1.ImageColor3 = Color3.fromRGB(26, 26, 26)
            if toolight then
                Switch2.ImageColor3 = Color3.fromRGB(255, 255, 255)
            end
            Switch2.Position = UDim2.new(0, 3, 0.150000006, 0)
        end
    end

    ToggleButton.MouseButton1Click:Connect(trigger)

    function ToggleAction:Set(state)
        togstate = state
        if togstate then
            Switch1.ImageColor3 = Color3.fromRGB(176, 148, 255)
            if toolight then
                Switch2.ImageColor3 = Color3.fromRGB(26, 26, 26)
            end
            Switch2.Position = UDim2.new(0.59, 0, 0.150000006, 0)
        else
            Switch1.ImageColor3 = Color3.fromRGB(26, 26, 26)
            if toolight then
                Switch2.ImageColor3 = Color3.fromRGB(176, 148, 255)
            end
            Switch2.Position = UDim2.new(0, 3, 0.150000006, 0)
        end
        callback(togstate)
    end
    return ToggleAction
end

function ItemHandler:CreateDropdown(DropdownText, List, callback)
    local DropdownFrame = Instance.new("TextButton")
    local dropdownFrame = Instance.new("Frame")
    local DropdownCorner = Instance.new("UICorner")
    local DropdownItemFrame = Instance.new("Frame")
    local DropdownMCorner = Instance.new("UICorner")
    local Expand = Instance.new("ImageButton")
    local ExpandImage = Instance.new("ImageLabel")
    local DropdownItem1 = Instance.new("TextLabel")
    local UIListLayout = Instance.new("UIListLayout")
    local UIListLayout_2 = Instance.new("UIListLayout")
    local UIListLayout_3 = Instance.new("UIListLayout")
    local DropdownStoke = Instance.new("UIStroke")

    callback = callback or function() end
    List = List or {}
    DropdownText = DropdownText or ""
    local DropYSize = 40
    local isDropped1 = false

    DropdownFrame.Name = DropdownText .. "Holder"
    DropdownFrame.Parent = SectionHandlerFrame
    DropdownFrame.BackgroundColor3 = ItemBGColor
    DropdownFrame.TextColor3 = Color3.fromRGB(255, 255, 255)
    DropdownFrame.Text = ""
    DropdownFrame.BackgroundTransparency = 1.000
    DropdownFrame.Position = UDim2.new(0, 0, 0, 0)
    DropdownFrame.Size = UDim2.new(0, 280, 0, 40)
    DropdownFrame.ClipsDescendants = true
    DropdownFrame.MouseButton1Click:Connect(
        function()
            if isDropped1 then
                isDropped1 = false
                DropdownFrame:TweenSize(UDim2.new(0, 280, 0, 40), "In", "Quint", 0.10)
                game.TweenService:Create(
                    Expand,
                    TweenInfo.new(0.10, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
                    {
                        Rotation = 0
                    }
                ):Play()
                wait(0.10)
                SectionHandlerFrame:TweenSize(
                    UDim2.new(1, 0, 0, SectionList.AbsoluteContentSize.Y + 5),
                    "In",
                    "Quint",
                    0.10
                )
                wait(0.10)
                UpdateSize()
            else
                isDropped1 = true
                DropdownFrame:TweenSize(UDim2.new(0, 280, 0, DropYSize), "In", "Quint", 0.10)
                game.TweenService:Create(
                    Expand,
                    TweenInfo.new(0.10, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
                    {
                        Rotation = 180
                    }
                ):Play()
                wait(0.10)
                SectionHandlerFrame:TweenSize(
                    UDim2.new(1, 0, 0, SectionList.AbsoluteContentSize.Y + 5),
                    "In",
                    "Quint",
                    0.10
                )
                wait(0.10)
                UpdateSize()
            end
        end
    )

    dropdownFrame.Name = "DropdownMainFrame"
    dropdownFrame.Parent = DropdownFrame
    dropdownFrame.BackgroundColor3 = ItemBGColor
    dropdownFrame.Size = UDim2.new(0, 280, 1, 0)
    dropdownFrame.ZIndex = 2

    DropdownStoke.Name = "Outline"
    DropdownStoke.Parent = DropdownFrame
    DropdownStoke.Thickness = 2
    DropdownStoke.LineJoinMode = Enum.LineJoinMode.Round
    DropdownStoke.Transparency = 0
    DropdownStoke.Color = Color3.fromRGB(0, 0, 0)

    DropdownCorner.Name = "Corner"
    DropdownCorner.CornerRadius = UDim.new(0, 3)
    DropdownCorner.Parent = dropdownFrame

    DropdownItemFrame.Name = "MainDropdownFrame"
    DropdownItemFrame.Parent = dropdownFrame
    DropdownItemFrame.BackgroundColor3 = ItemBGColor
    DropdownItemFrame.Size = UDim2.new(0, 280, 0, 20)
    DropdownItemFrame.ZIndex = 2

    DropdownMCorner.Name = "Corner"
    DropdownMCorner.CornerRadius = UDim.new(0, 3)
    DropdownMCorner.Parent = DropdownItemFrame

    Expand.Name = "Expand"
    Expand.Parent = DropdownItemFrame
    Expand.BackgroundTransparency = 1.000
    Expand.Position = UDim2.new(0, 250, 0, 10)
    Expand.Size = UDim2.new(0, 20, 0, 20)
    Expand.ZIndex = 2
    Expand.Image = ""
    Expand.ImageColor3 = Color3.fromRGB(255, 255, 255)
    Expand.ImageRectOffset = Vector2.new(564, 284)
    Expand.ImageRectSize = Vector2.new(36, 36)
    Expand.MouseButton1Click:Connect(
        function()
            if isDropped1 then
                isDropped1 = false
                DropdownFrame:TweenSize(UDim2.new(0, 280, 0, 40), "In", "Quint", 0.10)
                game.TweenService:Create(
                    Expand,
                    TweenInfo.new(0.10, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
                    {
                        Rotation = 0
                    }
                ):Play()
                wait(0.10)
                SectionHandlerFrame:TweenSize(
                    UDim2.new(1, 0, 0, SectionList.AbsoluteContentSize.Y + 5),
                    "In",
                    "Quint",
                    0.10
                )
                wait(0.10)
                UpdateSize()
            else
                isDropped1 = true
                DropdownFrame:TweenSize(UDim2.new(0, 280, 0, DropYSize), "In", "Quint", 0.10)
                game.TweenService:Create(
                    Expand,
                    TweenInfo.new(0.10, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
                    {
                        Rotation = 180
                    }
                ):Play()
                wait(0.10)
                SectionHandlerFrame:TweenSize(
                    UDim2.new(1, 0, 0, SectionList.AbsoluteContentSize.Y + 5),
                    "In",
                    "Quint",
                    0.10
                )
                wait(0.10)
                UpdateSize()
            end
        end
    )

    ExpandImage.Name = "ExpandImage"
    ExpandImage.Parent = Expand
    ExpandImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ExpandImage.BackgroundTransparency = 1
    ExpandImage.Image = "rbxassetid://6031090990"
    ExpandImage.ImageColor3 = Color3.fromRGB(255, 255, 255)
    ExpandImage.Position = UDim2.new(0, 0, 0, 0)
    ExpandImage.Size = UDim2.new(0, 20, 0, 20)
    ExpandImage.Rotation = 180

    DropdownItem1.Name = "Item1"
    DropdownItem1.Parent = DropdownItemFrame
    DropdownItem1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    DropdownItem1.BackgroundTransparency = 1.000
    DropdownItem1.Position = UDim2.new(0, 10, 0, 0)
    DropdownItem1.Size = UDim2.new(0, 250, 0, 40)
    DropdownItem1.ZIndex = 2
    DropdownItem1.Font = Enum.Font.GothamBold
    DropdownItem1.Text = DropdownText .. " : "
    DropdownItem1.TextColor3 = Color3.fromRGB(100, 100, 100)
    DropdownItem1.TextSize = 10
    DropdownItem1.TextXAlignment = Enum.TextXAlignment.Left

    UIListLayout.Parent = dropdownFrame
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 7)

    UIListLayout_2.Parent = ItemButtonHolder
    UIListLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout_2.VerticalAlignment = Enum.VerticalAlignment.Center

    UIListLayout_3.Parent = DropdownFrame
    UIListLayout_3.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout_3.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout_3.VerticalAlignment = Enum.VerticalAlignment.Center

for i, v in next, List do
    local ItemButtonHolder = Instance.new("Frame")
    local ItemButton = Instance.new("TextButton")
    local UICorner_3 = Instance.new("UICorner")

    ItemButtonHolder.Name = "ItemButtonHolder"
    ItemButtonHolder.Parent = dropdownFrame
    ItemButtonHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ItemButtonHolder.BackgroundTransparency = 1
    ItemButtonHolder.BorderSizePixel = 0
    ItemButtonHolder.Size = UDim2.new(1, 0, 0, 40)

    ItemButton.Name = "ItemButton"
    ItemButton.Parent = ItemButtonHolder
    ItemButton.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
    ItemButton.BackgroundTransparency = 1
    ItemButton.Size = UDim2.new(0, 290, 0, 40)
    ItemButton.ZIndex = 2
    ItemButton.AutoButtonColor = false
    ItemButton.Font = Enum.Font.GothamSemibold
    ItemButton.Text = "  " .. v
    ItemButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ItemButton.TextSize = 10
    ItemButton.TextXAlignment = Enum.TextXAlignment.Center

    UICorner_3.CornerRadius = UDim.new(0, 3)
    UICorner_3.Parent = ItemButton

    DropYSize = DropYSize + 40
    ItemButton.MouseButton1Click:Connect(
        function()
            callback(v)
            DropdownItem1.Text = DropdownText .. " : " .. v
            DropdownItem1.TextColor3 = Color3.fromRGB(255, 255, 255)
            DropdownFrame:TweenSize(UDim2.new(0, 280, 0, 40), "In", "Quint", 0.10)
            wait()
            isDropped = false
            wait(0.10)
            SectionHandlerFrame:TweenSize(UDim2.new(1, 0, 1, 0), "In", "Quint", 0.10)
            wait(0.10)
            DropdownItem1.TextColor3 = Color3.fromRGB(255, 255, 255)
            UpdateSize()
            game.TweenService:Create(
                Expand,
                TweenInfo.new(0.10, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
                {
                    Rotation = 0
                }
            ):Play()
        end
    )
end

    local DropdownHandler = {}
function DropdownHandler:ClearItems()
    DropdownItem1.Text = tostring(dropInfo)
    game.TweenService:Create(
      DropdownFrame,
      TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
      {
          Size = UDim2.new(0, 280, 0, 40)
      }
  ):Play()
  isDropped = false
  for i, v in next, DropdownFrame:GetChildren() do
      if v:IsA("TextButton") then
          v:Destroy()
      end
  end
end

function DropdownHandler:AddItem(NewItem)
    local ItemButtonHolder = Instance.new("Frame")
    local ItemButton = Instance.new("TextButton")
    local UICorner_3 = Instance.new("UICorner")
    local DropdownStoke = Instance.new("UIStroke")

    ItemButtonHolder.Name = "ItemButtonHolder"
    ItemButtonHolder.Parent = dropdownFrame
    ItemButtonHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ItemButtonHolder.BackgroundTransparency = 1
    ItemButtonHolder.BorderSizePixel = 0
    ItemButtonHolder.Size = UDim2.new(1, 0, 0, 40)

    ItemButton.Name = "ItemButton"
    ItemButton.Parent = ItemButtonHolder
    ItemButton.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
    ItemButton.BackgroundTransparency = 1
    ItemButton.Size = UDim2.new(0, 290, 0, 40)
    ItemButton.ZIndex = 2
    ItemButton.AutoButtonColor = false
    ItemButton.Font = Enum.Font.GothamSemibold
    ItemButton.Text = "  " .. v
    ItemButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ItemButton.TextSize = 10
    ItemButton.TextXAlignment = Enum.TextXAlignment.Center

    UICorner_3.CornerRadius = UDim.new(0, 3)
    UICorner_3.Parent = ItemButton

    DropYSize = DropYSize + 40
    ItemButton.MouseButton1Click:Connect(
        function()
            callback(v)
            DropdownItem1.Text = DropdownText .. " : " .. v
            DropdownItem1.TextColor3 = Color3.fromRGB(255, 255, 255)
            DropdownFrame:TweenSize(UDim2.new(0, 280, 0, 40), "In", "Quint", 0.10)
            wait()
            isDropped = false
            wait(0.10)
            SectionHandlerFrame:TweenSize(UDim2.new(1, 0, 1, 0), "In", "Quint", 0.10)
            wait(0.10)
            DropdownItem1.TextColor3 = Color3.fromRGB(255, 255, 255)
            UpdateSize()
            game.TweenService:Create(
                Expand,
                TweenInfo.new(0.10, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
                {
                    Rotation = 0
                }
            ):Play()
        end
    )
end
end

function ItemHandler:CreateSlider(SliderText, minvalue, maxvalue, callback)
  local SliderHolder = Instance.new("Frame")
  local SliderCorner = Instance.new("UICorner")
  local SliderInfo = Instance.new("TextLabel")
  local SliderButton = Instance.new("ImageButton")
  local SliderButtonCorner = Instance.new("UICorner")
  local SliderIn = Instance.new("ImageLabel")
  local SliderInCorner = Instance.new("UICorner")
  local SliderValue = Instance.new("TextLabel")
  local SliderStoke = Instance.new("UIStroke")
  
  minvalue = minvalue or 0
  maxvalue = maxvalue or 200
  callback = callback or function() end
  
  SliderHolder.Name = "SliderHolder"
  SliderHolder.Parent = SectionHandlerFrame
  SliderHolder.BackgroundColor3 = ItemBGColor
  SliderHolder.BorderSizePixel = 0
  SliderHolder.Size = UDim2.new(0,280, 0, 40)
  
  SliderCorner.Name = "Corner"
  SliderCorner.Parent = SliderHolder
  SliderCorner.CornerRadius = UDim.new(0, 3)
  
  SliderInfo.Name = SliderText
  SliderInfo.Parent = SliderHolder
  SliderInfo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
  SliderInfo.BackgroundTransparency = 1
  SliderInfo.BorderSizePixel = 0
  SliderInfo.Text = SliderText
  SliderInfo.TextColor3 = Color3.fromRGB(255, 255, 255)
  SliderInfo.Font = Enum.Font.GothamBold
  SliderInfo.Position = UDim2.new(0, 10, 0, 2)
  SliderInfo.TextXAlignment = Enum.TextXAlignment.Left
  SliderInfo.TextSize = 10
  SliderInfo.Size = UDim2.new(0, 250, 0, 30)
  
  SliderButton.Name = "SliderButton"
  SliderButton.Parent = SliderHolder
  SliderButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
  SliderButton.Position = UDim2.new(0, 10,0, 25)
  SliderButton.Size = UDim2.new(0, 255, 0, 7)
  SliderButton.AutoButtonColor = false
  SliderButton.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
  SliderButton.ImageTransparency = 1
  
  SliderButtonCorner.Name = "Corner"
  SliderButtonCorner.Parent = SliderButton
  SliderButtonCorner.CornerRadius = UDim.new(0, 1000)
  
  SliderIn.Name = "SliderIn"
  SliderIn.Parent = SliderButton
  SliderIn.BackgroundColor3 = Color3.fromRGB(190, 190, 190)
  SliderIn.Size = UDim2.new(0, 0, 0, 5)
  SliderIn.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
  SliderIn.ImageTransparency = 1
  SliderIn.ImageColor3 = Color3.fromRGB(190, 190, 190)
  
  SliderInCorner.Name = "Corner"
  SliderInCorner.Parent = SliderIn
  SliderInCorner.CornerRadius = UDim.new(0, 1000)
  
  SliderValue.Name = "Value"
  SliderValue.Parent = SliderHolder
  SliderValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
  SliderValue.BackgroundTransparency = 1
  SliderValue.BorderSizePixel = 0
  SliderValue.Position = UDim2.new(0, 0, 0, 0)
  SliderValue.TextXAlignment = Enum.TextXAlignment.Right
  SliderValue.Size = UDim2.new(0, 250, 0, 30)
  SliderValue.TextSize = 10
  SliderValue.Font = Enum.Font.GothamBold
  SliderValue.TextColor3 = Color3.fromRGB(255,255,255)
  SliderValue.Text = minvalue or "0"
  
  local mouse = game.Players.LocalPlayer:GetMouse()
  local uis = game:GetService("UserInputService")
  local val;
  
  SliderButton.MouseButton1Down:Connect(function()
    val = math.floor((((tonumber(maxvalue) - tonumber(minvalue)) / 300) * SliderIn.AbsoluteSize.X) + tonumber(minvalue)) or 0 
    pcall(function()
      callback(val)
    end)
    SliderIn.Size = UDim2.new(0, math.clamp(mouse.X - SliderIn.AbsolutePosition.X, 0, 300), 0, 7)
    moveconnection = mouse.Move:Connect(function()
      SliderValue.Text = val
      val = math.floor((((tonumber(maxvalue) - tonumber(minvalue)) / 300) * SliderIn.AbsoluteSize.X) + tonumber(minvalue))
      pcall(function()
        callback(val)
    end)
    SliderIn.Size = UDim2.new(0, math.clamp(mouse.X - SliderIn.AbsolutePosition.X, 0, 300), 0, 7)
    end)
    releaseconnection = uis.InputEnded:Connect(function(Mouse)
        if Mouse.UserInputType == Enum.UserInputType.MouseButton1 then
          val = math.floor((((tonumber(maxvalue) - tonumber(minvalue)) / 300) * SliderIn.AbsoluteSize.X) + tonumber(minvalue))
          pcall(function()
            callback(val)
          end)
          SliderIn.Size = UDim2.new(0, math.clamp(mouse.X - SliderIn.AbsolutePosition.X, 0, 300), 0, 7)
          moveconnection:Disconnect()
          releaseconnection:Disconnect()
          end
      end)
end)
  
  
end

function ItemHandler:CreateTextBox(TextBoxText, PlaceHolder, del, callback)
  TextBoxText  = TextBoxText or "TextBox"
  PlaceHolder = PlaceHolder or "PlaceHolder"
  del = del or false
  callback = callback or function() end
  
  local TextBoxHolder = Instance.new("Frame")
  local textboxFrame = Instance.new("Frame")
  local TextBoxCorner = Instance.new("UICorner")
  local TextBox = Instance.new("TextBox")
  local TextBoxInfo = Instance.new("TextLabel")
  local TextBoxCorner2  = Instance.new("UICorner")
  local TextBoxInList = Instance.new("UIListLayout")
  local TextBoxPadding = Instance.new("UIPadding")
  local UIListo = Instance.new("UIListLayout")
  
  TextBoxHolder.Name = "TextBoxHolder"
  TextBoxHolder.Parent = SectionHandlerFrame
  TextBoxHolder.BackgroundColor3 = ItemBGColor
  TextBoxHolder.BackgroundTransparency = 1
  TextBoxHolder.Size = UDim2.new(0, 280,  0, 40)
  
  textboxFrame.Name = "TextBoxFrame"
  textboxFrame.Parent = TextBoxHolder
  textboxFrame.BackgroundColor3 = ItemBGColor
  textboxFrame.Size = UDim2.new(0, 280, 0, 40)
  textboxFrame.ZIndex = 2
  
  TextBoxCorner.Name = "Corner"
  TextBoxCorner.Parent = textboxFrame
  TextBoxCorner.CornerRadius = UDim.new(0, 3)
  
  TextBoxInfo.Name = TextBoxText
  TextBoxInfo.Parent = textboxFrame
  TextBoxInfo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
  TextBoxInfo.BackgroundTransparency = 1
  TextBoxInfo.BorderSizePixel = 0
  TextBoxInfo.Text = TextBoxText
  TextBoxInfo.TextColor3 = Color3.fromRGB(255, 255, 255)
  TextBoxInfo.Font = Enum.Font.GothamBold
  TextBoxInfo.Position = UDim2.new(0, 50, 0, 2)
  TextBoxInfo.TextXAlignment = Enum.TextXAlignment.Left
  TextBoxInfo.TextSize = 10
  TextBoxInfo.Size = UDim2.new(0, 160, 0, 45)
  
  TextBox.Parent = textboxFrame
  TextBox.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
  TextBox.ClipsDescendants = true
  TextBox.Position = UDim2.new(0, 0, 0, 0)
  TextBox.Size = UDim2.new(0, 100, 0, 22)
  TextBox.ZIndex = 2
  TextBox.ClearTextOnFocus = false
  TextBox.Font = Enum.Font.GothamSemibold
  TextBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
  TextBox.Text = ""
  TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
  TextBox.TextSize = 10.000
  TextBox.PlaceholderText = PlaceHolder
  
  TextBoxCorner2.Name = "Corner"
  TextBoxCorner2.Parent = TextBox
  TextBoxCorner2.CornerRadius = UDim.new(0, 5)
  
  TextBoxInList.Name = "textboxinlist"
  TextBoxInList.Parent = textboxFrame
  TextBoxInList.FillDirection = Enum.FillDirection.Horizontal
  TextBoxInList.VerticalAlignment = Enum.VerticalAlignment.Center

  TextBoxPadding.Name = "Padding"
  TextBoxPadding.Parent = textboxFrame
  TextBoxPadding.PaddingLeft = UDim.new(0, 10)
  
  UIListo.Parent = TextBoxHolder
  UIListo.HorizontalAlignment = Enum.HorizontalAlignment.Center
  UIListo.SortOrder = Enum.SortOrder.LayoutOrder
  UIListo.VerticalAlignment = Enum.VerticalAlignment.Center
  
  function anim(property)
    if property == "Text" then 
      textboxFrame:TweenSize(UDim2.new(0, 279, 0, 34),  "InOut", "Quint", 0.18, true)
      wait(0.18)
      textboxFrame:TweenSize(UDim2.new(0, 280, 0, 40),  "InOut", "Quint", 0.18, true)
    end
  end
  TextBox.Changed:Connect(anim)
  
  TextBox.FocusLost:Connect(function(EnterPressed)
    if not EnterPressed then
      callback(TextBox.Text)
    else 
      if del then
      callback(TextBox.Text)
      else 
        callback(TextBox.Text)
        TextBox.Text = ""
      end
    end
  end)
end

return ItemHandler
end
return SectionHandler
end
return TabHandler
end

local win = Voxy:Window("Voxy Library")
local tab = win:CreateTab("Tab #1")
local sec = tab:CreateSection("Sec #1")

sec:CreateButton("Button", function()
  print(game.Players.LocalPlayer.Name)
end)
sec:CreateToggle("Toggle", function(s)
    print(s)
end)
sec:CreateDropdown("Dropdown", {"Shim", "Bol","k"}, function(l)
    print(l)
end)
sec:CreateSlider("Slider", 0, 100, function(vals)
  print(vals)
end)
sec:CreateTextBox("TextBox", "PlaceHolder", false, function(txt)
  print(txt)
end)
return Voxy

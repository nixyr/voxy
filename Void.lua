local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local VirtualU = game:GetService('VirtualUser')
local TwenS = game:GetService('TweenService')
local Camera = game:GetService('Workspace').CurrentCamera
local Mouse = Players.LocalPlayer:GetMouse()
local identify = identifyexecutor or nil

---Library
local VoidHUB = loadstring(game:HttpGet("https://github.com/nixyr/voxy-/raw/main/VoxyUI.lua"))()

local Void = VoidHUB:Window("VoidHUB "..'['..identify()..']')

---Tabs & Section
local Main = Void:CreateTab("Main")
local MainSec = Main:CreateSection("MainSec")
local Teleport = Void:CreateTab("Telelort")
local TeleportSec = Teleport:CreateSection("TP")
local Eggs = Void:CreateTab("Eggs")
local EggsSec = Eggs:CreateSection("Eggsec")
local Misc = Void:CreateTab("Others")
local MiscSec = Misc:CreateSection("MiscSec")
local Credits = Void:CreateTab("Credits")
local CreditsSec = Credits:CreateSection("CreditsSec")

--GenGenv
getgenv().autoClick = false
getgenv().autoRebirth = false
getgenv().autoEgg = false

--Function
function doClick()
spawn(function()
  local event = game:GetService("ReplicatedStorage").Events:WaitForChild("Click3")
  end)
end

--Main
MainSec:CreateLabel("Farm")

MainSec:CreateToggle("Auto Click", function(click)
  getgenv().autoClick = click
  print("Auto Click Is : "..click)
  if click then
  doClick()
  end
  end)

local selectedGamePass;

MainSec:CreateDropdown("Unlock Gamepass", {"AutoClicker", "AutoRebirth"}, function(gp)
  for sname,sbool in next, gp do
  for _,v in pairs(lp.Passes.GetChildren()) do
  if sname == v.Name then
  if sbool == true then
  v.Value = true
  else
    v.Value = false
  end
  end
  end
  end
  end)

MainSec:CreateLabel("Areas")
MainSec:CreateButton("Unlock All Island", function()
  if workspace:FindFirstChild("Scripts") and workspace.Scripts:FindFirstChild("Portals") then
  local pfolder = workspace.Scripts.Portals
  for _,z in pairs(pfolder:GetChildren()) do
  if z:IsA("Model") or z.ClassName == "Model" and z:FindFirstChildOfClass("BoolValue") == false and z:FindFirstChild("LabelUI") then
  z:FindFirstChildOfClass("BoolValue").Value = true
  if z:FindFirstChild("LabelUI") then
  z:FindFirstChild("LabelUI"):Destroy()
  end
  end
  end
  local area = workspace.Scripts.Portals.Areas

  if area:FindFirstChild("Volcano") and area.Volcano:FindFirstChildOfClass("BoolValue") and area.Volcano["Unlocked"].Value == false then
  if area.Volcano:FindFirstChildOfClass("SurfaceGui") then
  area.Volcano:FindFirstChildOfClass("SurfaceGui"):Destroy()
  end
  if area.Volcano:FindFirstChildOfClass("BoolValue") then
  area.Volcano:FindFirstChildOfClass("BoolValue").Value = true;
  end
  area.Volcano.Transparency = 1;
  area.Volcano.CanCollide = false;
  end
  end
  end)

local xil = {"Spawn","Forest","Beach","Atlantis","Desert","Winter","Volcano","Moon","Cyber","Magic","Heaven","Nuclear","Void","Spooky","Cave","Steampunk","Hell"}
local shop = {"Potions","Upgrades","Shop","Auras","Index","PetMachine"}

TeleportSec:CreateLabel("Teleports")

local selectedArea;

TeleportSec:CreateDropdown("Select Island", xil, function(xIsland)
  getgenv().xIsland = xIsland
  end)

TeleportSec:CreateButton("Teleport To Island", function()
  if selectedArea then
  if lp.Character ~= nil and workspace:FindFirstChild("Scripts") and workspace.Scripts:FindFirstChild("TeleportTo") then
  local ttfolder = workspace.Scripts.TeleportTo
  local old_pos;
  local new_pos;
  for _,z in pairs(ttfolder:GetChildren()) do
  if lp.Character ~= nil and z.Name == tostring(getgenv().xIsland) and z:IsA("Part") then
-- This part copy form they module script lol path: game:GetService("Players").lp.PlayerScripts.Library.Portals
  old_pos = z.CFrame
  new_pos = old_pos * CFrame.new(0,2,0)
  lp.Character.PrimaryPart.CFrame = new_pos
  game:GetService("ReplicatedStorage").Events.WorldBoost:FireServer(z.Name)
  end
  end
  end
  end
  end)

local selectedShop;

TeleportSec:CreateDropdown("Select  Shop", shop, function(tpshop)
  getgenv().TPToShop = tpshop
  end)

TeleportSec:CreateButton("Teleport To Shop", function()
  if selectedShop then
  if lp.Character ~= nil and workspace:FindFirstChild("Scripts") and workspace.Scripts:FindFirstChild("Spawn") then
  local old_pos;
  local new_pos;
  local sFolder = workspace.Scripts.Spawn
  for _,v in pairs(sFolder:GetChildren()) do
  if lp.Character ~= nil and v:IsA("Model") and v.Name == tostring(getgenv().TPToShop) and v:FindFirstChild("Spin") ~= nil then
  old_pos = v["Spin"].CFrame
  new_pos = old_pos * CFrame.new(0,2,0)
  lp.Character.PrimaryPart.CFrame = new_pos
  end
  end
  end
  end
  end)

MiscSec:CreateLabel("Others")

MiscSec:CreateButton("Claim All Chest", function()
  local remote = game:GetService("ReplicatedStorage").Events.Chest
  local ffolder = lp.Chests
  if remote and ffolder then
  for _,z in pairs(ffolder:GetChildren()) do
  if z:IsA("NumberValue") and z.Value == 0 then
  remote:FireServer(z.Name)
  end
  end
  end
  end)

MiscSec:CreateTextBox("Pet Storage", "Value : Number/s", false, function(xPet)
  local maxstorage = lp.Data.MaxStorage;
  local petstorage = lp.Upgrades.PetStorage;
  local num = xPet
  if maxstorage and petstorage then
  maxstorage.Value = tonumber(num); petstorage.Value = tonumber(num);
  end
  end)

MiscSec:CreateTextBox("Pet Equip", "Value : Number/s", false, function(xEquip)
  local maxEq = lp.Data.MaxEquip;
  local petEq = lp.Upgrades.PetEquip;
  local num = xEquip
  if maxEq and petEq then
  maxEq.Value = tonumber(num); petEq.Value = tonumber(num);
  end
  end)

local eggs = {"Atlantis", "Basic", "Beach", "Cave", "Cyber", "Desert", "Forest", "Heaven", "Hell", "Magic", "Magma", "Moon", "Mythic", "Nuclear", "Spooky", "Steampunk", "Void", "Volcano", "Winter"}

local selectedEggs;
EggsSec:CreateDropdown("Select Egg", eggs, function(eggo)
  getgenv().eggs = eggo
  end)

local selectedMkde;
EggsSec:CreateDropdown("Select Mode", {
  "Single", "Triple"
}, function(mode)
  getgenv().selecmode = mode
  end)

local Remote = game:GetService("ReplicatedStorage").Functions.Unbox

EggsSec:CreateButton("Open Once", function()
  if selectedMkde and selectedEggs then
  if Remote then
  local Egg = getgenv().eggs
  local Type = getgenv().selecmode
  Remote:InvokeServer(Egg, Type)
  end
  end
  end)

EggsSec:CreateToggle("Auto Hatch", function(auto)
  getgenv().autoeg = auto
  if selectedMkde and selectedEggs and auto then
  local Egg = getgenv().eggs
  local Type = getgenv().selecmode
  Remote:InvokeServer(Egg, Type)
  end
end)

if lp.Data:FindFirstChild("Banned") then
    lp.Data:FindFirstChild("Banned"):Destroy()
end
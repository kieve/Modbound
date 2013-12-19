function init()
  data.mode = "none"
  data.color = "green"
  data.timer = 0
  if not math.targetPosition then
    math.targetPosition = {}
  end
end

function uninit()
  tech.setParentAppearance("normal")
end

function input(args)
  if args.moves["special"] == 1 and args.moves["down"] then
    if data.color == "green" then
      data.color = "orange"
    else
      data.color = "green"
    end
    return "switch_tele"
  elseif args.moves["special"] == 1 then
    return "tele"
  elseif args.moves["special"] == 2 then
    return "set_tele"
  end

  return nil
end

function update(args)
  local energyUsage = tech.parameter("energyUsage")
  local teleOutTime = tech.parameter("teleOutTime")
  local teleInTime = tech.parameter("teleInTime")
  local teleSwitchTime = tech.parameter("teleSwitchTime")

  if args.actions["tele"] and data.mode == "none" and args.availableEnergy > energyUsage then
    if math.targetPosition[data.color] then
      data.mode = "start"
    end
  end

  if args.actions["set_tele"] and data.mode == "none" then
    math.targetPosition[data.color] = tech.position()
    data.mode = "set"
    data.timer = 0
  end

  if args.actions["switch_tele"] and data.mode == "none" then
    data.mode = "switch"
    data.timer = 0
  end

  if data.mode == "start" then
    tech.setVelocity({0, 0})
    data.mode = "out"
    data.timer = 0

    return energyUsage
  elseif data.mode == "out" then
    tech.setParentAppearance("hidden")
    tech.setAnimationState("teleing", "out")
    tech.setVelocity({0, 0})
    data.timer = data.timer + args.dt

    if data.timer > teleOutTime then
      tech.setPosition(math.targetPosition[data.color])
      data.mode = "in"
      data.timer = 0
    end

    return 0
  elseif data.mode == "in" then
    tech.setParentAppearance("normal")
    tech.setAnimationState("teleing", "in")
    tech.setVelocity({0, 0})
    data.timer = data.timer + args.dt

    if data.timer > teleInTime then
      data.mode = "none"
    end

    return 0
  elseif data.mode == "switch" then
    local animState = nil
    if data.color == "green" then
      animState = "switch_green"
    else
      animState = "switch_orange"
    end
    tech.setAnimationState("teleing", animState)
    data.timer = data.timer + args.dt

    if data.timer > teleSwitchTime then
      data.mode = "none"
    end

    return 0
  elseif data.mode == "set" then
    local animState = nil
    if data.color == "green" then
      animState = "set_green"
    else
      animState = "set_orange"
    end
    tech.setAnimationState("teleing", animState)
    data.timer = data.timer + args.dt

    if data.timer > teleSwitchTime then
      data.mode = "none"
    end

    return 0
  end
end

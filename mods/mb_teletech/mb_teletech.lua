function init()
  data.mode = "none"
  data.timer = 0
end

function uninit()
  tech.setParentAppearance("normal")
end

function input(args)
  if args.moves["special"] == 1 then
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

  if args.actions["tele"] and data.mode == "none" and args.availableEnergy > energyUsage then
    if math.targetPosition then
      data.mode = "start"
    end
  end

  if args.actions["set_tele"] and data.mode == "none" then
    math.targetPosition = tech.position()
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
      tech.setPosition(math.targetPosition)
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
  end
end

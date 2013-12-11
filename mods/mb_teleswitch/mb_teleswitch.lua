function init(args)
  object.setInteractive(true)
  object.setAllOutboundNodes(object.animationState("switchState") == "on")
end

function onInteraction(args)
  if object.animationState("switchState") == "off" then
    object.setAnimationState("switchState", "on")
    object.playSound("onSounds");
    world.spawnProjectile("teslabolt", object.toAbsolutePosition({ 0.0, 1.0 }))
    object.setAllOutboundNodes(true)
  else
    object.setAnimationState("switchState", "off")
    object.playSound("offSounds")
    object.setAllOutboundNodes(false)
  end
end

function hasCapability(capability)
  if capability == 'mb_tele' then
    return true
  end
  return false
end
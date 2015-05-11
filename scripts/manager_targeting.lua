-- 
-- Please see the readme.txt file included with this distribution for 
-- attribution and copyright information.
--

function getTargets(rActor, rEffect)
	if PremiumTargetingManager then
		return PremiumTargetingManager.getTargets(rActor, rEffect);
	end
	
	return "targetct", {};
end

function toggleTarget(sTargetType, sSourceNode, sTargetNode)
	if PremiumTargetingManager then
		return PremiumTargetingManager.toggleTarget(sTargetType, sSourceNode, sTargetNode);
	end
end

function addTarget(sTargetType, sSourceNode, sTargetNode)
	if PremiumTargetingManager then
		return PremiumTargetingManager.addTarget(sTargetType, sSourceNode, sTargetNode);
	end
end

function addFactionTargets(sTargetType, nodeSource, sFaction, bNegated)
	if PremiumTargetingManager then
		return PremiumTargetingManager.addFactionTargets(sTargetType, nodeSource, sFaction, bNegated);
	end
end

function removeTarget(sTargetType, nodeSource, sTargetNode)
	if PremiumTargetingManager then
		return PremiumTargetingManager.removeTarget(sTargetType, nodeSource, sTargetNode);
	end
end

function removeClientTarget(msguser, sSourceName, sTargetNode)
	if PremiumTargetingManager then
		return PremiumTargetingManager.removeClientTarget(msguser, sSourceName, sTargetNode);
	end
end

function removeTargetFromAllEntries(sTargetType, sTargetNode)
	if PremiumTargetingManager then
		return PremiumTargetingManager.removeTargetFromAllEntries(sTargetType, sTargetNode);
	end
end

function clearTargets(sTargetType, nodeSource)
	if PremiumTargetingManager then
		return PremiumTargetingManager.clearTargets(sTargetType, nodeSource);
	end
end

function onSortCompare(w1, w2)
						if w1.name.getValue() == "" then
							return true;
						elseif w2.name.getValue() == "" then
							return false;
						end
					
						return w1.name.getValue() >  w2.name.getValue();
end
		
function total()
						weight = 0;
						pa = 0;
						ma = 0;
						ip = 0;
						templist = source.getChildren();
						for i in pairs(templist) do
							if templist[i].getChild("weight") then
								weight = weight + templist[i].getChild("weight").getValue();
							end
							if templist[i].getChild("physical") then
								pa = pa + templist[i].getChild("physical").getValue();
							end
							if templist[i].getChild("mystic") then
								ma = ma + templist[i].getChild("mystic").getValue();
							end
							if templist[i].getChild("init_penalty") then
								ip = ip + templist[i].getChild("init_penalty").getValue();
							end
						end
						window.getDatabaseNode().getChild("weight.armor").setValue(weight);
						window.getDatabaseNode().getChild("armortotal.totalpa").setValue(pa);
						window.getDatabaseNode().getChild("armortotal.totalma").setValue(ma);
						window.getDatabaseNode().getChild("armortotal.totalip").setValue(ip);
end
					
function onInit()
						source = getDatabaseNode();
						source.onChildUpdate = total;
						total();
end
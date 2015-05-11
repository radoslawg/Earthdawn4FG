function getDef(value)
	if value == 0 then
		return 0;
	elseif value == 1 then
		return 2;
	elseif value >= 2 and value <= 3 then
		return 3;
	elseif value >= 4 and value <= 6 then
		return 4;
	elseif value >= 7 and value <= 8 then
		return 5;
	elseif value >= 9 and value <= 10 then
		return 6;	
	elseif value >= 11 and value <= 13 then
		return 7;
	elseif value >= 14 and value <= 15 then
		return 8;
	elseif value >= 16 and value <= 17 then
		return 9;
	elseif value >= 18 and value <= 20 then
		return 10;
	elseif value >= 21 and value <= 22 then
		return 11;
	elseif value >= 23 and value <= 24 then
		return 12;
	elseif value >= 25 and value <= 27 then
		return 13;
	elseif value >= 28 and value <= 29 then
		return 14;
	elseif value == 30 then
		return 15;
	else
		return 0;
	end
end

function getMA(value)
	if value <= 0 then
		return 0;
	elseif value >= 11 and value <= 13 then
		return 1;
	elseif value >= 14 and value <= 16 then
		return 2;
	elseif value >= 17 and value <= 19 then
		return 3;
	elseif value >= 20 and value <= 22 then
		return 4;
	elseif value >= 23 and value <= 25 then
		return 5;
	elseif value >= 26 and value <= 28 then
		return 6;
	elseif value >= 29 and value <= 30 then
		return 7;
	else
		return 0;
	end
end

function getHealth(value)
	if value == 0 then
		return 0,0,0,0;
	elseif value == 1 then
		return 19,10,3,0.5;
	elseif value == 2 then
		return 20,11,4,0.5;
	elseif value == 3 then
		return 22,13,4,1;
	elseif value == 4 then
		return 23,14,5,1;
	elseif value == 5 then
		return 24,15,5,1;
	elseif value == 6 then
		return 26,17,6,1;
	elseif value == 7 then
		return 27,18,6,1;
	elseif value == 8 then
		return 28,19,7,2;
	elseif value == 9 then
		return 30,21,7,2;
	elseif value == 10 then
		return 31,22,8,2;
	elseif value == 11 then
		return 32,24,8,2;
	elseif value == 12 then
		return 34,26,9,2;
	elseif value == 13 then
		return 35,27,9,2;
	elseif value == 14 then
		return 36,28,10,3;
	elseif value == 15 then
		return 38,30,10,3;
	elseif value == 16 then
		return 39,31,11,3;
	elseif value == 17 then
		return 40,32,11,3;
	elseif value == 18 then
		return 42,34,12,3;
	elseif value == 19 then
		return 43,35,12,3;
	elseif value == 20 then
		return 44,36,13,4;
	elseif value == 21 then
		return 46,39,13,4;
	elseif value == 22 then
		return 47,40,13,4;
	elseif value == 23 then
		return 48,41,14,4;
	elseif value == 24 then
		return 50,43,14,4;
	elseif value == 25 then
		return 51,44,15,4;
	elseif value == 26 then
		return 52,45,15,5;
	elseif value == 27 then
		return 54,47,15,5;
	elseif value == 28 then
		return 55,48,16,5;
	elseif value == 29 then
		return 56,49,16,5;
	elseif value == 30 then
		return 58,51,17,5;
	else
		return 0,0,0,0;
	end
end
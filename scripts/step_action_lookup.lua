function getStep(attribute)
	if attribute <= 0 then
		return 1;
	elseif attribute >= 1 and attribute <= 3 then
		return 2;
	elseif attribute >= 4 and attribute <= 6 then
		return 3;
	elseif attribute >= 7 and attribute <= 9 then
		return 4;
	elseif attribute >= 10 and attribute <= 12 then
		return 5;
	elseif attribute >= 13 and attribute <= 15 then
		return 6;
	elseif attribute >= 16 and attribute <= 18 then
		return 7;
	elseif attribute >= 19 and attribute <= 21 then
		return 8;
	elseif attribute >= 22 and attribute <= 24 then
		return 9;
	elseif attribute >= 25 and attribute <= 27 then
		return 10;
	elseif attribute >= 28 and attribute <= 30 then
		return 11;
	elseif attribute >= 31 and attribute <= 33 then
		return 12;
	elseif attribute >= 34 and attribute <= 36 then
		return 13;
	elseif attribute >= 37 and attribute <= 39 then
		return 14;
	elseif attribute >= 40 and attribute <= 42 then
		return 15;
	elseif attribute >= 43 and attribute <= 45 then
		return 16;
	elseif attribute >= 46 and attribute <= 48 then
		return 17;
	elseif attribute >= 49 and attribute <= 51 then
		return 18;
	elseif attribute >= 52 and attribute <= 54 then
		return 19;
	elseif attribute >= 55 and attribute <= 57 then
		return 20;
	elseif attribute >= 58 and attribute <= 60 then
		return 21;
	elseif attribute >= 61 and attribute <= 63 then
		return 22;
	elseif attribute >= 64 and attribute <= 66 then
		return 23;
	elseif attribute >= 67 and attribute <= 69 then
		return 24;
	elseif attribute >= 70 and attribute <= 72 then
		return 25;
	elseif attribute >= 73 and attribute <= 75 then
		return 26;
	elseif attribute >= 76 and attribute <= 78 then
		return 27;
	elseif attribute >= 79 and attribute <= 81 then
		return 28;
	elseif attribute >= 82 and attribute <= 84 then
		return 29;
	elseif attribute >= 85 and attribute <= 87 then
		return 30;
	elseif attribute >= 88 and attribute <= 90 then
		return 31;
	elseif attribute >= 91 and attribute <= 93 then
		return 32;
	elseif attribute >= 94 and attribute <= 96 then
		return 33;
	elseif attribute >= 97 and attribute <= 99 then
		return 34;
	elseif attribute >= 100 and attribute <= 102 then
		return 35;
	elseif attribute >= 103 and attribute <= 105 then
		return 36;
	elseif attribute >= 106 and attribute <= 108 then
		return 37;
	elseif attribute >= 109 and attribute <= 111 then
		return 38;
	elseif attribute >= 112 and attribute <= 114 then
		return 39;
	elseif attribute >= 115 and attribute <= 117 then
		return 40;
	elseif attribute >= 118 then
		return 40;
	end
end

function getStepDice(stepnum)
	if stepnum < 0 then
		stepnum = 0;
	end
	if stepnum > 100 then
		stepnum = 100;
	end
	if stepnum == 0 then
		return {"0"},0
	elseif stepnum == 1 then
		return {"d4"}, -2;
	elseif stepnum == 2 then
		return {"d4"}, -1;
	elseif stepnum == 3 then
		return {"d4"}, 0;
	elseif stepnum == 4 then
		return {"d6"}, 0;
	elseif stepnum == 5 then
		return {"d8"}, 0;
	elseif stepnum == 6 then
		return {"d10"}, 0;
	elseif stepnum == 7 then 
		return {"d12"}, 0;
	elseif stepnum == 8 then 
		return {"d6","d6"}, 0;
	elseif stepnum == 9 then 
		return {"d8","d6"}, 0;

	elseif stepnum == 10 then 
		return {"d8","d8"}, 0;
	elseif stepnum == 11 then 
		return {"d10","d8"}, 0;
	elseif stepnum == 12 then 
		return {"d10","d10"}, 0;
	elseif stepnum == 13 then 
		return {"d12","d10"}, 0;
	elseif stepnum == 14 then 
		return {"d12","d12"}, 0;
	elseif stepnum == 15 then 
		return {"d12","d6","d6"}, 0;
	elseif stepnum == 16 then 
		return {"d12","d8","d6"}, 0;
	elseif stepnum == 17 then 
		return {"d12","d8","d8"}, 0;
	elseif stepnum == 18 then 
		return {"d12","d10","d8"}, 0;
	elseif stepnum == 19 then 
		return {"d20","d6","d6"}, 0;

	elseif stepnum == 20 then 
		return {"d20","d8","d6"}, 0;
	elseif stepnum == 21 then 
		return {"d20","d8","d8"}, 0;
	elseif stepnum == 22 then 
		return {"d20","d10","d8"}, 0;
	elseif stepnum == 23 then 
		return {"d20","d10","d10"}, 0;
	elseif stepnum == 24 then 
		return {"d20","d12","d10"}, 0;
	elseif stepnum == 25 then 
		return {"d20","d12","d12"}, 0;
	elseif stepnum == 26 then 
		return {"d20","d12","d6","d6"}, 0;
	elseif stepnum == 27 then 
		return {"d20","d12","d8","d6"}, 0;
	elseif stepnum == 28 then 
		return {"d20","d12","d8","d8"}, 0;
	elseif stepnum == 29 then 
		return {"d20","d12","d10","d8"}, 0;

	elseif stepnum == 30 then 
		return {"d20","d20","d6","d6"}, 0;
	elseif stepnum == 31 then 
		return {"d20","d20","d8","d6"}, 0;
	elseif stepnum == 32 then 
		return {"d20","d20","d8","d8"}, 0;
	elseif stepnum == 33 then 
		return {"d20","d20","d10","d8"}, 0;
	elseif stepnum == 34 then 
		return {"d20","d20","d10","d10"}, 0;
	elseif stepnum == 35 then 
		return {"d20","d20","d12","d10"}, 0;
	elseif stepnum == 36 then 
		return {"d20","d20","d12","d12"}, 0;
	elseif stepnum == 37 then 
		return {"d20","d20","d12","d6","d6"}, 0;
	elseif stepnum == 38 then 
		return {"d20","d20","d12","d8","d6"}, 0;
	elseif stepnum == 39 then 
		return {"d20","d20","d12","d8","d8"}, 0;

	elseif stepnum == 40 then 
		return {"d20","d20","d12","d10","d8"}, 0;
	elseif stepnum == 41 then 
		return {"d20","d20","d20","d6","d6"}, 0;
	elseif stepnum == 42 then 
		return {"d20","d20","d20","d8","d6"}, 0;
	elseif stepnum == 43 then 
		return {"d20","d20","d20","d8","d8"}, 0;
	elseif stepnum == 44 then 
		return {"d20","d20","d20","d10","d8"}, 0;
	elseif stepnum == 45 then 
		return {"d20","d20","d20","d10","d10"}, 0;
	elseif stepnum == 46 then 
		return {"d20","d20","d20","d12","d10"}, 0;
	elseif stepnum == 47 then 
		return {"d20","d20","d20","d12","d12"}, 0;
	elseif stepnum == 48 then 
		return {"d20","d20","d20","d12","d6", "d6"}, 0;
	elseif stepnum == 49 then 
		return {"d20","d20","d20","d12","d8", "d6"}, 0;

	elseif stepnum == 50 then 
		return {"d20","d20","d20","d12","d8", "d8"}, 0;
	elseif stepnum == 51 then 
		return {"d20","d20","d20","d12","d10", "d8"}, 0;
	elseif stepnum == 52 then 
		return {"d20","d20","d20","d20","d6", "d6"}, 0;
	elseif stepnum == 53 then 
		return {"d20","d20","d20","d20","d8", "d6"}, 0;
	elseif stepnum == 54 then 
		return {"d20","d20","d20","d20","d8", "d8"}, 0;
	elseif stepnum == 55 then 
		return {"d20","d20","d20","d20","d10", "d8"}, 0;
	elseif stepnum == 56 then 
		return {"d20","d20","d20","d20","d10", "d10"}, 0;
	elseif stepnum == 57 then 
		return {"d20","d20","d20","d20","d12", "d10"}, 0;
	elseif stepnum == 58 then 
		return {"d20","d20","d20","d20","d12", "d12"}, 0;
	elseif stepnum == 59 then 
		return {"d20","d20","d20","d20","d12", "d6", "d6"}, 0;

	elseif stepnum == 60 then 
		return {"d20","d20","d20","d20","d12", "d8", "d6"}, 0;
	elseif stepnum == 61 then 
		return {"d20","d20","d20","d20","d12", "d8", "d8"}, 0;
	elseif stepnum == 62 then 
		return {"d20","d20","d20","d20","d12", "d10", "d8"}, 0;
	elseif stepnum == 63 then 
		return {"d20","d20","d20","d20","d20", "d6", "d6"}, 0;
	elseif stepnum == 64 then 
		return {"d20","d20","d20","d20","d20", "d8", "d6"}, 0;
	elseif stepnum == 65 then 
		return {"d20","d20","d20","d20","d20", "d8", "d8"}, 0;
	elseif stepnum == 66 then 
		return {"d20","d20","d20","d20","d20", "d10", "d8"}, 0;
	elseif stepnum == 67 then 
		return {"d20","d20","d20","d20","d20", "d10", "d10"}, 0;
	elseif stepnum == 68 then 
		return {"d20","d20","d20","d20","d20", "d12", "d10"}, 0;
	elseif stepnum == 69 then 
		return {"d20","d20","d20","d20","d20", "d12", "d12"}, 0;

	elseif stepnum == 70 then 
		return {"d20","d20","d20","d20","d20", "d12", "d6", "d6"}, 0;
	elseif stepnum == 71 then 
		return {"d20","d20","d20","d20","d20", "d12", "d8", "d6"}, 0;
	elseif stepnum == 72 then 
		return {"d20","d20","d20","d20","d20", "d12", "d8", "d8"}, 0;
	elseif stepnum == 73 then 
		return {"d20","d20","d20","d20","d20", "d12", "d10", "d8"}, 0;
	elseif stepnum == 74 then 
		return {"d20","d20","d20","d20","d20", "d20", "d6", "d6"}, 0;
	elseif stepnum == 75 then 
		return {"d20","d20","d20","d20","d20", "d20", "d8", "d6"}, 0;
	elseif stepnum == 76 then 
		return {"d20","d20","d20","d20","d20", "d20", "d8", "d8"}, 0;
	elseif stepnum == 77 then 
		return {"d20","d20","d20","d20","d20", "d20", "d10", "d8"}, 0;
	elseif stepnum == 78 then 
		return {"d20","d20","d20","d20","d20", "d20", "d10", "d10"}, 0;
	elseif stepnum == 79 then 
		return {"d20","d20","d20","d20","d20", "d20", "d12", "d10"}, 0;

	elseif stepnum == 80 then 
		return {"d20","d20","d20","d20","d20", "d20", "d12", "d12"}, 0;
	elseif stepnum == 81 then 
		return {"d20","d20","d20","d20","d20", "d20", "d12", "d6", "d6"}, 0;
	elseif stepnum == 82 then 
		return {"d20","d20","d20","d20","d20", "d20", "d12", "d8", "d6"}, 0;
	elseif stepnum == 83 then 
		return {"d20","d20","d20","d20","d20", "d20", "d12", "d8", "d8"}, 0;
	elseif stepnum == 84 then 
		return {"d20","d20","d20","d20","d20", "d20", "d12", "d10", "d8"}, 0;
	elseif stepnum == 85 then 
		return {"d20","d20","d20","d20","d20", "d20", "d20", "d6", "d6"}, 0;
	elseif stepnum == 86 then 
		return {"d20","d20","d20","d20","d20", "d20", "d20", "d8", "d6"}, 0;
	elseif stepnum == 87 then 
		return {"d20","d20","d20","d20","d20", "d20", "d20", "d8", "d8"}, 0;
	elseif stepnum == 88 then 
		return {"d20","d20","d20","d20","d20", "d20", "d20", "d10", "d8"}, 0;
	elseif stepnum == 89 then 
		return {"d20","d20","d20","d20","d20", "d20", "d20", "d10", "d10"}, 0;

	elseif stepnum == 90 then 
		return {"d20","d20","d20","d20","d20", "d20", "d20", "d12", "d10"}, 0;
	elseif stepnum == 91 then 
		return {"d20","d20","d20","d20","d20", "d20", "d20", "d12", "d12"}, 0;
	elseif stepnum == 92 then 
		return {"d20","d20","d20","d20","d20", "d20", "d20", "d12", "d6", "d6"}, 0;
	elseif stepnum == 93 then 
		return {"d20","d20","d20","d20","d20", "d20", "d20", "d12", "d8", "d6"}, 0;
	elseif stepnum == 94 then 
		return {"d20","d20","d20","d20","d20", "d20", "d20", "d12", "d8", "d8"}, 0;
	elseif stepnum == 95 then 
		return {"d20","d20","d20","d20","d20", "d20", "d20", "d12", "d10", "d8"}, 0;
	elseif stepnum == 96 then 
		return {"d20","d20","d20","d20","d20", "d20", "d20", "d20", "d6", "d6"}, 0;
	elseif stepnum == 97 then 
		return {"d20","d20","d20","d20","d20", "d20", "d20", "d20", "d8", "d6"}, 0;
	elseif stepnum == 98 then 
		return {"d20","d20","d20","d20","d20", "d20", "d20", "d20", "d8", "d8"}, 0;
	elseif stepnum == 99 then 
		return {"d20","d20","d20","d20","d20", "d20", "d20", "d20", "d10", "d8"}, 0;

	elseif stepnum == 100 then 
		return {"d20","d20","d20","d20","d20", "d20", "d20", "d20", "d10", "d10"}, 0;
	end
end

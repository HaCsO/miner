-- mining before fuel was gone
must_pass = 0; -- 0 if unlimited
backcount = 800; -- 1 <= x <= 1024
black_list = {1, 13};

allow = true;
passed = 0;

function table.contains(table, element)
	for _, value in pairs(table) do
		if value == element then
			return true;
		end
	end
	return false;
end

function checkInventory( ... )
	count = 0;
	for i=1, 16 do
		id = turtle.getItemDetail(i).id;
		if table.contains(black_list, id) then
			turtle.select(i);
			turtle.drop();
		else
			count += turtle.getItemCount(i);
		end
	end
	if count >= backcount then
		allow = false;
	end
end

function digCycle( ... )
	turtle.dig();
	turtle.digUp();
	turtle.digDown();
	turtle.forward();
	turtle.refuel();
end

if must_pass == 0 then

	while turtle.getFuelLevel() > passed and allow do 
		digCycle();
		checkInventory();
		passed += 1;
	end

else

	for i=1, must_pass and allow do
		digCycle();
		checkInventory();
		passed += 1;
	end

end

turtle.turnLeft();
turtle.turnLeft();

for i=1, passed do
	turtle.forward();
end
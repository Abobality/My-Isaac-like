global.map_width = 9;
global.map_heigth = 9;

randomise();

global.map = ds_grid_create(global.map_width,global.map_heigth);
ds_grid_set_region(global.map,0,0,global.map_width - 1,global.map_heigth-1,-1);

ds_grid_set_region(global.map,1,1,global.map_width - 2,global.map_heigth-2,0);

spawnedRoom = 1;
maxRoom = 6;
spawnerPosX = 4;
spawnerPosY = 4;
directions = [[0,-1],[0,1],[1,0],[-1,0]];

ds_grid_set(global.map,spawnerPosX,spawnerPosY,1);


targetX = spawnerPosX;
targetY = spawnerPosY;

room_generate = function()
{
	while spawnedRoom < maxRoom
	{
		var dir = directions[irandom_range(0,3)];
	
		targetX += dir[0];
		targetY += dir[1];
	
		if checker()
		{
			ds_grid_set(global.map,targetX,targetY,2);
			spawnedRoom++
			show_debug_message($"{targetX} {targetY}")
		}else{
			targetX += -dir[0];
			targetY += -dir[1];
		}
	}
	
}

checker = function()
{
	if (targetX < 0 || targetX >= global.map_width || 
        targetY < 0 || targetY >= global.map_heigth) 
    {
        return false;
    }
	if ds_grid_get(global.map,targetX,targetY) == -1 return false;
	if ds_grid_get(global.map,targetX,targetY) == 1 return false;
	if ds_grid_get(global.map,targetX,targetY) == 2 return false;
	
	return true
}
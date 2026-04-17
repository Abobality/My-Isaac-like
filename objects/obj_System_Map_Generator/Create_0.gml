randomise();

global.map_width = 13;
global.map_heigth = 9;
global.map = ds_grid_create(global.map_width,global.map_heigth);

spawnedRoom = 1;
maxRoom = 20;
spawnerPosX = round(global.map_width / 2);
spawnerPosY = round(global.map_heigth / 2);
directions = [[0,-1],[1,0],[0,1],[-1,0]];

ds_grid_set_region(global.map,0,0,global.map_width - 1,global.map_heigth-1,-1);
ds_grid_set_region(global.map,1,1,global.map_width - 2,global.map_heigth-2,0);


ds_grid_set(global.map,spawnerPosX,spawnerPosY,1);

targetX = spawnerPosX;
targetY = spawnerPosY;

room_generate = function()
{
	var attemps = 0;
	var max_attemps = 200;
	
	var rooms_list = [];
    array_push(rooms_list, [spawnerPosX, spawnerPosY]);
	
	
	while spawnedRoom < maxRoom && attemps < max_attemps
	{
		var r_idx = irandom(array_length(rooms_list) - 1);
	    var base_room = rooms_list[r_idx];
        
	    var bx = base_room[0];
	    var by = base_room[1];
		
		var index = irandom_range(0,3)
		var dir = directions[index];
		
		attemps++;
	
		targetX = bx + dir[0];
		targetY = by + dir[1];
	
		if checker(index)
		{
			ds_grid_set(global.map,targetX,targetY,2);
			spawnedRoom++
			array_push(rooms_list, [targetX, targetY]);
			show_debug_message($"{targetX} {targetY}")
			attemps = 0;
		}
		
		if attemps = max_attemps
		{
			show_debug_message("spawn limited!");
		}
	}
	
}

checker = function(ind)
{
	var ind2 = ind - 1;
	var ind3 = ind + 1;
	
	if (targetX < 0 || targetX >= global.map_width || 
        targetY < 0 || targetY >= global.map_heigth) 
    {
        return false;
    }
	
	if ind2 < 0
	{
		ind2 = 3;
	}
	
	if ind3 > 3
	{
		ind3 = 0;
	}
	
	if irandom(1) = 1 return false;
	
	if ds_grid_get(global.map,targetX,targetY) == -1 return false;
	if ds_grid_get(global.map,targetX,targetY) == 1 return false;
	if ds_grid_get(global.map,targetX,targetY) == 2 return false;
	
	if ds_grid_get(global.map,targetX + directions[ind2][0],targetY + directions[ind2][1]) == 1 return false;
	if ds_grid_get(global.map,targetX + directions[ind2][0],targetY + directions[ind2][1]) == 2 return false;
	
	if ds_grid_get(global.map,targetX + directions[ind3][0],targetY + directions[ind3][1]) == 1 return false;
	if ds_grid_get(global.map,targetX + directions[ind3][0],targetY + directions[ind3][1]) == 2 return false;
	
	return true
}

roomsSetter = function()
{
	var bfsMap = ds_grid_create(global.map_width,global.map_heigth);

	ds_grid_set_region(bfsMap,0,0,global.map_width - 1,global.map_heigth-1,-1);
	
	var queue = ds_queue_create();
	ds_queue_enqueue(queue, [spawnerPosX, spawnerPosY]);
	bfsMap[# spawnerPosX, spawnerPosY] = 0;
	
	while (!ds_queue_empty(queue)) {
	    var pos = ds_queue_dequeue(queue);
	    var cx = pos[0]; var cy = pos[1];
    
	    for (var i = 0; i < 4; i++) {
	        var nx = cx + directions[i][0];
	        var ny = cy + directions[i][1];
        
	        if (global.map[# nx, ny] > 0 && bfsMap[# nx, ny] == -1) {
	            bfsMap[# nx, ny] = bfsMap[# cx, cy] + 1;
	            ds_queue_enqueue(queue, [nx, ny]);
	        }
	    }
	}

	var max_d = -1;
	var boss_x = 4; var boss_y = 4;

	for (var yy = 0; yy < 9; yy++) {
	    for (var xx = 0; xx < 9; xx++) {
	        var d = bfsMap[# xx, yy];
	        if (d > max_d) {
	            max_d = d;
	            boss_x = xx;
	            boss_y = yy;
	        }
	    }
	}

	global.map[# boss_x, boss_y] = 3;

	ds_queue_destroy(queue);
	ds_grid_destroy(bfsMap);
}
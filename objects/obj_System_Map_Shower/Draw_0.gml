draw_set_colour(c_white);

for(var i = 0;i<global.map_width;i++)
{
	for(var j = 0;j<global.map_heigth;j++)
	{
		draw_rectangle(x+32 * i,y+32 * j,x+32 * i + 16,y+32 * j+16,true);
		
		switch ds_grid_get(global.map,i,j)
		{
			case -1:
				draw_rectangle_colour(x+32 * i,y+32 * j,x+32 * i + 16,y+32 * j+16,c_gray,c_gray,c_gray,c_gray,false);
				break;
			
			case 1:
				draw_rectangle_colour(x+32 * i,y+32 * j,x+32 * i + 16,y+32 * j+16,c_red,c_red,c_red,c_red,false);
				break;
				
			case 2:
				draw_rectangle_colour(x+32 * i,y+32 * j,x+32 * i + 16,y+32 * j+16,c_white,c_white,c_white,c_white,false);
				break;
		}
	}
}
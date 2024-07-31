// https://github.com/Sembiance/openscad-modules
module dome_old(d=5, h=2, hollow=false, wallWidth=0.5, $fn=128)
{
	sphereRadius = (pow(h, 2) + pow((d/2), 2) ) / (2*h);

	translate([0, 0, (sphereRadius-h)*-1])
	{
		difference()
		{
			sphere(sphereRadius);
			translate([0, 0, -h])
			{
				cube([2*sphereRadius, 2*sphereRadius, 2*sphereRadius], center=true);
			}

			if(hollow)
				sphere(sphereRadius-wallWidth);
			
		}
	}
}

module dome(d=5, h=2, hollow=false, wallWidth=0.5, $fn=$fn)
{
    sphereRadius = (pow(h, 2) + pow((d/2), 2) ) / (2*h);
    
    start_x = acos(d / 2 / sphereRadius);
    start_y = asin((sphereRadius - h) / sphereRadius);
    end = 90;
    
    difference() {
        rotate_extrude() {
            polygon([
                [0,0],
                for( i = [0 : $fn - 1]) 
                [sphereRadius * cos(start_x + i / ($fn - 1) * (end - start_x)), sphereRadius * sin(start_y + i / ($fn - 1) * (end - start_y)) - sphereRadius * sin(start_y)]]);
        }
        if(hollow) { // Could also be done in 2d but this is easier
            dome(d-2*wallWidth, h-wallWidth, false);
        }
    }
}


/*
d = 5;
h = 1;
fn = 128;
   
dome(d, h, $fn = fn, hollow=true);

translate([d, 0, 0])
dome_old(d, h, $fn = fn, hollow=true);
*/
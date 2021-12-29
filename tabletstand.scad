// Small stand to rest a tablet on for charging/etc

// I never actually tried full-size as the test one worked as a kick-stand
//width = 70;
//height = 70;

// Cut-down version for testing
width = 40;
height = 40;

difference(){
    union(){
        translate([0, 0, 5])
            rotate([-30, 0, 0])
            union() {
                translate([0, 10, 0])
                    cube([width, 5, height]);
                translate([0, 0, 10])
                    cube([width, 10, 5]);
            };
        translate([0, 15, 0])
            cube([width, 10, 10]);
    }
    translate([0, 0, -4])
        cube([width, width, 5]);
}

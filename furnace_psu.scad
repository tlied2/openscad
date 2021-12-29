// Box for 5v USB output buck converter with display
// and carrier board with ptc/rectifier/etc
// In this case taking AC from my HVAC

module box() {
    difference(){
        cube([100, 24, 24]);
        // Hollow It Out
        translate([2, 1, 2])
            cube([96, 22, 24]);
        // Screw Hole
        translate([50, 12, 0])
            cylinder(h=4, d=4);
        // USB Port
        translate([0, 4.5, 15])
            cube([2, 15, 10]);
        // Wire Slot
        translate([98, 10, 10])
            cube([2, 4, 15]);
    }
    translate([13, 0, 2])
        cube([27, 24 ,2]);
    translate([13, 0, 2])
        cube([4, 24 ,6]);
}

module lid() {
    difference(){
        cube([100, 24, 2]);
        // Hollow It Out
        translate([20, 2, 0])
            cube([60, 20, 2]);

    }
}

// Print box module
box();
// Lift the lid up a bit for a better view
translate([0, 0, 38])
// Print the lid module for the box
lid();

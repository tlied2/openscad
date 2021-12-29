// Holder/stand for my Casio fx-300
// was designed to be wedged between two workstations
// works as a desktop stand as well

width = 2;

difference(){
    // Main cube total size
    union(){
        cube([
            85 + 2*width,
            50 + width,
            18,
        ]);
        translate([0, 20 + width, 18])
            cube([
                85 + 2*width,
                width,
                10
            ]);
    }
    // Box in front for calc
    translate([width, width, width])
        cube([
            85,
            20,
            18,
        ]);
    // Cut up back to minimize
    translate([width, 20 + 2*width, 0])
        cube([
            85,
            30,
            18,
        ]);
    // Notch out a bit more
    translate([20 + width, width, width])
        cube([
            85 - (40 + 2*width),
            30,
            40,
        ]);
}

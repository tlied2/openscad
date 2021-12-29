// Box for an arcade button
// and an esp-01 (+carrier/psu board)

include <BOSL/transforms.scad>
use <MCAD/boxes.scad>

wall = 1.5;

total_width = 74;
total_depth = 50;
total_height = 35;

width = total_width - 2 * wall;
depth = total_depth - 2 * wall;

button = 30;

module slot(d=3, h=20) {
    hull(){
        sphere(d=d, $fn=20);
        up(10)
            sphere(d=d, $fn=20);
    }
}

module lidslots() {
    xspread(l=10, n=3)
        slot();
}

difference() {
    // Base Box
    roundedBox([
        total_width,
        total_depth,
        total_height],
        4, true);
    // Make Hollow
    up(wall)
        roundedBox([
            width,
            depth,
            total_height],
            4, true);
    // Make Button Hole
    down(total_height / 2)
    left((total_width / 4) - 2)
        cylinder(2 * wall, d=button, true);
    // Make Power Hole
    down((total_height / 2) - (8 + 5))
    right((total_width / 2) - (11 + 5))
    forward(depth / 2)
        cube([22, 6, 16], true);
        //cube(14, true);
    // Front Slots
    down((total_height / 2) - 15)
    left(20)
    forward((total_depth / 2) - 1)
        lidslots();
    // Back Top Slots
    down((total_height / 2) - 15)
    left(20)
    back((total_depth / 2) - 0.5)
        lidslots();
    // Back Bottom Slots
    down((total_height / 2) - 15)
    right(20)
    back((total_depth / 2) - 0.5)
        lidslots();
}

// Ledge
up((total_height / 2) - (wall + 9))
right((total_width / 2) - 5)
    cube([8, depth / 2, 1], true);

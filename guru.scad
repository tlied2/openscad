// Guru Plug Box
// Swapped PSU for DC jack and external 5VDC

include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <MCAD/boxes.scad>


wall = 1;
depth = 92;
width = 60;
height = 30;

total_width = width + 2 * wall;
total_depth = depth + 2 * wall;
total_height = height + wall;

module post() {
    cylinder(h=12, d=7);
    up(11) cylinder(h=6, d=3.9);
}

module posts() {
    w_dist = 51;
    d_dist = 83;
    w_inset = (total_width - w_dist) / 2;
    d_inset = (total_depth - d_dist) / 2;

    back(d_inset) {
        right(w_inset) post();
        right(w_inset + w_dist) post();
    }
    back(d_inset + d_dist) {
        right(w_inset) post();
        right(w_inset + w_dist) post();
    }
}

module slot(d=2, h=20) {
    hull(){
        sphere(d=d, $fn=20);
        translate([0, 0, h])
            sphere(d=d, $fn=20);
    }
}

module lidslots() {
    yspread(l=60, n=3)
        xrot(90)
            yspread(l=4, n=2)
                slot();
}

// USB / Ethernet Ports
module usbports() {
    translate([
        0,
        -(total_depth / 2),
        10
    ])
        cube([45, 4 * wall, 28], true);
}

module base() {
    difference() {
        roundedBox([total_width, total_depth, total_height], 2, true);
        up(wall)
            roundedBox([width, depth, height], 2, true);
        // SD card slot
            translate([
                width / 2 - wall,
                -(total_depth / 2) + 22.5,
                -(total_height / 2) + 2 * wall
            ])
                cube([3 * wall, 20, 10]);
        usbports();
        // JTAG / UART Ports
            translate([
                -(width / 2) - 2 * wall,
                -(total_depth / 2) + 37,
                -(total_height / 2) + 10
            ])
                cube([3 * wall, 35, 10]);
        // GPIO header
            translate([
                width / 2 - wall,
                -(total_depth / 2) + 54,
                -(total_height / 2) + 13
            ])
                cube([3 * wall, 25, 5]);
        // Rear Vents
            back(total_depth / 2 - (wall / 2))
            down(height / 2 - 5)
                xspread(l=40, n=8)
                    slot();
    }
}

module lid() {
    difference() {
        roundedBox([total_width, total_depth, 10 + wall], 2, true);
        up(wall)
            roundedBox([width, depth, 10], 2, true);
        // power jack opening
        back((total_depth - 15) / 2 - 20)
            cube([11 + 2 * wall, 16 + 2 * wall, 11], true);
        usbports();
        // Lid Slots
        translate([
            total_width / 2 - wall / 2,
            10,
            0,
        ])
            lidslots();
        translate([
            -(total_width / 2 - wall / 2),
            10,
            0,
        ])
            lidslots();
    }
    // tab
    up(7)
        difference() {
            roundedBox([width, depth, 7], 2, true);
            roundedBox([
                width - 2 * wall,
                depth - 2 * wall,
                7], 2, true);
            usbports();
       }
    // reinforcing
    up(2.5)
    forward(18)
        cube([width, wall, 16], true); 
}

module power() {
    difference() {
        cube([10 + 2 * wall, 15 + 2 * wall, 11 + 2 * wall], true);
        up(wall)
        forward(wall)
            cube([10, 15 + wall, 11 + wall], true);
    }
    // front lip
    forward(8)
    up(5)
        cube([10 + 2 * wall, wall, 3 * wall], true);
    // bottom lip
    forward(7.5)
    up(7)
        cube([10 + 2 * wall, 2, wall], true);
    // back tab
    back(9)
    up(7)
        cube([10 + 2 * wall, 2 + wall, wall], true);
}


// Move to positive quadrant
translate([
    total_width / 2,
    total_depth / 2,
    total_height / 2,
])  
    base();
posts();


translate([100, 50, 0])
    lid();

translate([150, 10, 0])
    power();

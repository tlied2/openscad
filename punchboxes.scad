// A few joined boxes for drink or sugar/etc packets

include <BOSL/transforms.scad>
include <MCAD/boxes.scad>

count = 4;

wall = 1;
depth = 50;
width = 28;
height = 50;

total_width = width + 2 * wall;
total_depth = depth + 2 * wall;
total_height = height + wall;

module base() {
    right(total_width / 2)
    back(total_depth / 2)
    up(total_height / 2)
    difference() {
        roundedBox([width + 2 * wall, depth + 2 * wall, height], 2.5, true);
        up(wall)
        roundedBox([width, depth, height], 2.5, true);
    }
}

for ( idx = [0: count - 1]) {
    right( idx * (total_width - wall) )
        base();
}

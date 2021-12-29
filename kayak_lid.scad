// Box to fit some controls into an odd space in a kayak (lid)

LidWidth = 210;
LidDepth = 95;
LidHeight = 2;
CornerRad = 5;
CornerHoleOffset = 6;
MountHole = 5 / 2;

//rotate(a=[0,180,0])
difference(){
    // Rounded corners
    minkowski(){
        cube([
            LidWidth - CornerRad,
            LidDepth - CornerRad,
            LidHeight]);
        cylinder(
            r=CornerRad,
            h=LidHeight,
            center=true);
    };
    
    // Big Hole
    translate([52, 45, -1])
        cylinder(r=14.5, h=LidHeight + 2);
    
    // 3 Smaller Holes
    translate([96, 38, -1])
        cylinder(r=8.5, h=LidHeight + 2);
    translate([133, 38, -1])
        cylinder(r=8.5, h=LidHeight + 2);
    translate([170, 38, -1])
        cylinder(r=8.5, h=LidHeight + 2);
    
    // Mounting Holes
    translate([1, 1, -1])
        cylinder(r=MountHole, h=LidHeight + 2);
    translate([LidWidth - 6, 1, -1])
        cylinder(r=MountHole, h=LidHeight + 2);
    translate([1, LidDepth - 6, -1])
        cylinder(r=MountHole, h=LidHeight + 2);
    translate([LidWidth - 6, LidDepth - 6, -1])
        cylinder(r=MountHole, h=LidHeight + 2);    
}

// Flange
translate([13.5, LidDepth - 82.5, -20]){
    difference(){
        cube([177, 80, 20]);
        translate([2, 8, 0])
            cube([173, 70, 20]);
        translate([0, -21, 18])
            rotate([-70, 0, 0])
                cube([179, 40, 20]);
    }
}

// Box to fit some controls into an odd space in a kayak

mmIn = 25.4;

boxHeight = 3.5 * mmIn;
boxBottomWidth = 6.625 * mmIn;
boxTopWidth = 7.25 * mmIn;
boxBottomDepth = 2.2 * mmIn;
BoxTopDepth = 3.375 * mmIn;

boxBottomOffset = (boxTopWidth - boxBottomWidth) / 2;

boxPoints = [
    [boxBottomOffset, 0, 0],
    [boxBottomOffset + boxBottomWidth, 0, 0],
    [boxBottomOffset + boxBottomWidth, boxBottomDepth, 0],
    [boxBottomOffset, boxBottomDepth, 0],
    [0, 0, boxHeight],
    [boxTopWidth, 0, boxHeight],
    [boxTopWidth, BoxTopDepth, boxHeight],
    [0, BoxTopDepth, boxHeight],
  ];

boxFaces = [
    [0, 1, 2, 3], // Bottom
    [4, 5, 1, 0], // Front
    [7, 6, 5, 4], // Top
    [5, 6, 2, 1], // Right
    [6, 7, 3, 2], // Back
    [7, 4, 0, 3], // Left
  ];

difference() {
    // Join box and flange
    union(){
        polyhedron(
            points = boxPoints,
            faces = boxFaces);
        lid();
    }
    // Hollow out box
    translate([2, 2, 2])
        scale([0.98, 0.96, 1])
            polyhedron(points = boxPoints, faces = boxFaces);
    // Wiring Hole
    translate([
        boxTopWidth/2 + 0.5*mmIn,
        boxBottomDepth/2,
        0])
        cylinder(
            r=0.5*mmIn,
            h=5,
            center=true);
}


LidWidth = 210;
LidDepth = 95;
LidHeight = 1;
CornerRad = 5;
CornerHoleOffset = 6;
MountHole = 5 / 2;

module lid() {
    translate([-10, 5, boxHeight - LidHeight]){
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
            
            // Mounting Holes
            translate([1, 1, -1])
                cylinder(
                    r=MountHole,
                    h=LidHeight + 2);
            translate([LidWidth - 6, 1, -1])
                cylinder(
                    r=MountHole,
                    h=LidHeight + 2);
            translate([1, LidDepth - 6, -1])
                cylinder(
                    r=MountHole,
                    h=LidHeight + 2);
            translate([
                LidWidth - 6,
                LidDepth - 6,
                -1])
                cylinder(
                    r=MountHole,
                    h=LidHeight + 2);    
        }
    }
}

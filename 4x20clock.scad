// Box for 4-row 20-column 7-segment display

// Wall Thickness
width = 2;

// width, height of board itself
//board = [98.25, 60];
//board = [98.4, 60];
board = [100, 62];

// width, height of display itself
display = [98, 40];
// Added 1 to balance it better/clear the wall
disp_inset = 11;

// Height of workpiece
front_depth = 30;
//front_depth = 20;
//front_depth = 10;
//front_depth = 5;

// Standoff diameter
standoff = 3.6;

// Tab width, height, thickness
tab = [20, 15, 1];


module front(){
    difference(){
        
        // Starter Box
        cube([
            board[0] + 2*width,
            board[1] + 2*width,
            front_depth + width
        ]);
        
        // Hollow it out
        translate([width, width, width])
            cube([
                board[0],
                board[1],
                front_depth
            ]);
        
        //
        // Hole for display
        //
        translate([
            ((board[0] - display[0]) / 2) + width,
            disp_inset + width,
            0
        ])
            cube([
                display[0],
                display[1],
                width
            ]);
          
        //  
        // Holes for standoffs
        //
        translate([
            width + standoff,
            disp_inset - 5,
            0
        ])
            cylinder(width, d=standoff);

        translate([
            width + standoff,
            width + disp_inset + display[1] + standoff/2 + 5,
            0
        ])
            cylinder(width, d=standoff);

        translate([
            board[0] + width - standoff,
            disp_inset - 5,
            0
        ])
            cylinder(width, d=standoff);
                        
        translate([
            board[0] + width - standoff,
            width + disp_inset + display[1] + standoff/2 + 5,
            0
        ])
            cylinder(width, d=standoff);
     
        //
        // Hole for USB
        //
        translate([
            -1,
            10,
            10
        ])
            cube([10, 15, 10]);
    }
    
    //
    // Tilt Tabs
    //
    translate([0, -tab[1], 0,]) cube([tab[0], tab[1] + 5, tab[2]]);
    translate([board[0] + 2*width - tab[0], -tab[1], 0,]) cube([tab[0], tab[1] + 5, tab[2]]);

}

module cover(){
    cube([
        board[0] + 2*width,
        board[1] + 2*width,
//        width,
        1.5,
    ]);
}


front();

translate([110, 0, 0])
    cover();

/* UNCOMMENT EACH MODEL TO RENDER THEM SEPARATELY */
//midScreen();
//endScreen();
hinge();

/* BEGIN CODE */

/************/
// This is the adjust the hole size you will put the filament through
// change this to adjust the tolerance
// 2.1 worked for me for 1.75mm filament
filamentD=2.1;
/************/

$fn=100;
width=148;
height=210;
thickness=5;
hingeGapHeight=20;
hingeHeight=19.6; // is a multiple of 0.4 for the stand nozzle size
filamentLength=hingeGapHeight+thickness*4;


module filament() {
    rotate([-90,0,0])
    translate([thickness*0.5,-thickness*0.5,0])
    cylinder(d=filamentD, h=filamentLength);
}

module screen() {
    difference() {
        cube([width,height,thickness]);
        
        translate([thickness,thickness,thickness/2])
        cube([width-thickness*2,height-thickness*2,thickness]);
    }
}

module hinge() {
    difference() {
        rotate([-90,0,0])
        translate([0,-thickness,0])
        hull() {
            translate([thickness/2,thickness/2,0])
                cylinder(h=hingeHeight, d=thickness);
            
            
            translate([thickness*1.5,thickness/2,0])
                cylinder(h=hingeHeight, d=thickness);
        }
        
        filament();
        
        translate([thickness,0,0])
        filament();
    }
}

module hingeGap() {
    cube([thickness*2, hingeGapHeight, thickness]);
}

module doubleHingeGap() {
    translate([-thickness,thickness*2,0])
    hingeGap();

    translate([-thickness,height-thickness*2-hingeGapHeight,0])
    hingeGap();
}

module doubleFilamentGap() {
    filament();
    
    translate([0,height-filamentLength,0])
    filament();
}

module endScreen() {
    difference() {
        screen();
        
        doubleHingeGap();
        
        doubleFilamentGap();
    }
}

module midScreen() {
    difference() {
        screen();
 
        doubleHingeGap();
        
        translate([width,0,0])
        doubleHingeGap();

        doubleFilamentGap();
        
        translate([width-thickness,0,0])
        doubleFilamentGap();
    }
}

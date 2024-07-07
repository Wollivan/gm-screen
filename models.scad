midScreen();
//endScreen();
//hinge();

/* BEGIN CODE */


width=148;
height=210;
thickness=6;
hingeHeight=20;
filamentLength=hingeHeight+thickness*4;
filamentD=1.9;

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
    cube([thickness*2, hingeHeight, thickness]);
}

module doubleHingeGap() {
    translate([-thickness,thickness*2,0])
    hingeGap();

    translate([-thickness,height-thickness*2-hingeHeight,0])
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








//////////////////////////////////////////////////////////////////
// Parametric Gridfinity Ultra Light Bins by HuMa_Meng          //
//                                                              //
// Author: https://makerworld.com/en/@huma_meng                 //
//                                                              //
// License: CC BY-NC-SA 4.0                                     //
//          https://creativecommons.org/licenses/by-nc-sa/4.0/  //
//                                                              //
// Copyright (c) 2024 HuMa_Meng                                 //
// Version 1.0                                                  //
//                                                              //
// Copyright (c) 2026 Skyler Curtis                             //
// Version 2.0                                                  //
//                                                              //
//                                                              //
//////////////////////////////////////////////////////////////////

// Parameters /////////////////////////////////////////////////////
/* [General Settings] */
// Grids in X direction (Min: 0.5, Max: 15, 1 u = 42 mm)
Grids_X = 1.0;          // [0.5:0.5:15]

// Grids in Y direction (Min: 0.5, Max: 15, 1 u = 42 mm)
Grids_Y = 1.0;          // [0.5:0.5:15]

// Grids in Z direction (Min: 0 (adapter), Max: 25, 1 u = 7 mm)
Grids_Z = 5.0;          // [0:1:25]

/* [Half Grid Settings] */
// Normally, the half grid in X direction is on the right side. Disable it to put it on the left side.
Half_Grid_Right = true;

// Normally, the half grid in Y direction is on the top side. Disable it to put it on the bottom side.
Half_Grid_Top = true;

// Use half-sized grids for the base
Half_Grid_Base = false;

/* [Ultra Light Settings] */
// Wall thickness (Recommended: 1.00 mm, Min: 0.3 mm, Max: 1.35 mm)
Wall_Thickness = 1.00;  // [0.30:0.01:1.35]

// Make the base thinner, so less material is used
Ultra_Light_Base = false;

// Use rips instead of a whole chamfer for the label taps
Ultra_Light_Labels = true;

/* [Magnets] */
// Holes on the bottom to glue in magnets
Magnets = true;

// Diameter of the magnets. Add your needed tolerance to the measured magnet diameter. (Min: 3.0 mm, Max: 8.0 mm)
Magnet_Diameter = 6.15;  // [3.0:0.01:8.0]

// Depth of the magnets. Add your needed tolerance to the measured magnet depth. (Min: 1.0 mm, Max: 5.0 mm)
Magnet_Depth = 2.2;  // [1.0:0.01:5.0]

/* [Dividers] */
// Dividers to separate the bin into sections
Dividers = false;

// Number of dividers in X direction (0 = no dividers, Min: 0, Max: 15)
Dividers_X = 2;         

// Number of dividers in Y direction (0 = no dividers, Min: 0, Max: 15)
Dividers_Y = 0;        

/* [Labels] */
// Labels on top of the bins
Labels = false;

// Label for each bin section or just one label
Label_For_Each_Section = true;

// Position of the label
Label_Position = "Full";    // [Full, Left, Center, Right]

// Label width (if it is not "Full") (Recommended: 30.0 mm, Min: 10.0 mm, Max: 100.0 mm)
Label_Width = 30.0;         // [10.0:0.1:100.0]

// Label depth (Recommended: 13.0 mm, Min: 5.0 mm, Max: 25.0 mm)
Label_Depth = 13.0;         // [5.0:0.1:25.0]

/* [Scoop] */
// Scoop on the front of the bin
Scoops = false;

// Radius of the scoop (0.0 = no scoop, Recommended: 15.0 mm, Min.: 0.0 mm, Max.: 42.0 mm)
Scoop_Radius = 15.0;   // [0.0:0.1:42.0]

/* [Solid] */

// Solid Base for making cuts
Solid = false;

/* [Cuts] */
// Cut a Cylinder
Cut_Cylinder = false;
// Diameter of cylinder to cut
Cut_Cylinder_d = 10; // [0:1:100]
// Depth to cut to
Cut_Cylinder_depth = 5;
//Cut all the way down (1mm floor wall)
Cut_To_Floor = true;

/* [Cuts - Advanced] */
// POLYNOTE: the edge of a square (4 sided-cylinder) is not
// the diameter, like you might expect.
// each point is placed on the circles edge, but the edges that connect points are shorter by a multiple.
// 
//For Cutting Polygons (C-f POLYNOTE)
Cylinder_Sides = 360; // [0:360]

//POLYDIAGRAM (ascii art is janky, but you get the idea (hopefully)
//      ****
//    *______* <- The edges dont pass through the center, and are thus 
//  * |      |*   Shorter than d by a multiplier
// *  |      | *
//*   |      |  *
//*   |      |   * 
// *  |      |  *
//  * |______| *
//   *        *
//    *     *
//      ***

// Cylinder Draft
Cylinder_Draft = 0;

// For rotating Polygons
Polygon_Rotate = 0; // [0:360]
// Cut Cylinder d on bottom
Cut_d_bottom = false;
// Cut Cylinder d at bottom of hole
Cut_d_in_hole = false;

/* [Hidden] */
// Setup Parameter
$fa = 8;
$fs = 0.25;

// Basic units
Offset_XY            = 0.25;
Grids_X_             = Half_Grid_Base ? 2.0 * Grids_X : Grids_X;
Grids_Y_             = Half_Grid_Base ? 2.0 * Grids_Y : Grids_Y;
Grids_Z_             = Grids_Z;
Basic_Unit_XY        = Half_Grid_Base ? 0.5 * 42.0 : 42.0;
Basic_Unit_Z         = 7.0;
Basic_Radius_1       = 4.0;
Basic_Radius_2       = 8.0;
Top_Clearance_Offset = 0.6;
Stacking_Lip_Width   = 2.6;
Magnet_Radius        = 0.5 * Magnet_Diameter;
Label_Height         = 1.0;

height_0 = 4.75;
height_1 = 7.0 - height_0;
height_2 = (Grids_Z - 1) * Basic_Unit_Z;
top_layer = height_1 + height_2 - 1;


// Code Start ////////////////////////////////////////////////////
// Generate the basic bin
difference() {
translate([-(Grids_X_ * Basic_Unit_XY) / 2.0, -(Grids_Y_ * Basic_Unit_XY) / 2.0, -5.75])
difference() {
    union() {
        if (Half_Grid_Right && Half_Grid_Top) {
            makeBinBase();
        }
        else if (!Half_Grid_Right && Half_Grid_Top) {
            translate([Grids_X_ * Basic_Unit_XY , 0.0, 0.0]) mirror([1, 0, 0]) makeBinBase();
        }
        else if (Half_Grid_Right && !Half_Grid_Top) {
            translate([0.0, Grids_Y_ * Basic_Unit_XY , 0.0]) mirror([0, 1, 0]) makeBinBase();
        }
        else if (!Half_Grid_Right && !Half_Grid_Top) {
            translate([Grids_X_ * Basic_Unit_XY, Grids_Y_ * Basic_Unit_XY , 0.0]) mirror([1, 0, 0]) mirror([0, 1, 0]) makeBinBase();
        }
        
        makeBinBody();
        makeBinStacklip();
        
        if (Dividers == true && (Dividers_X > 0 || Dividers_Y > 0)) {
            makeBinDividers();
        }
        
        if (Labels == true) {
            makeBinLabels();  
        }
        
        if (Scoops == true) {
            makeBinScoops();  
        }
    }
    
    // Clean bin
    if (Half_Grid_Right && Half_Grid_Top) {
        makeBinClean();
    }
    else if (!Half_Grid_Right && Half_Grid_Top) {
        translate([Grids_X_ * Basic_Unit_XY , 0.0, 0.0]) mirror([1, 0, 0]) makeBinClean();
    }
    else if (Half_Grid_Right && !Half_Grid_Top) {
        translate([0.0, Grids_Y_ * Basic_Unit_XY , 0.0]) mirror([0, 1, 0]) makeBinClean();
    }
    else if (!Half_Grid_Right && !Half_Grid_Top) {
        translate([Grids_X_ * Basic_Unit_XY, Grids_Y_ * Basic_Unit_XY , 0.0]) mirror([1, 0, 0]) mirror([0, 1, 0]) makeBinClean();
    }
}
if (Cut_Cylinder) {
    if (!Cut_To_Floor)
        translate([0,0, top_layer])
        mirror([0,0,1])
        rotate([0,0,Polygon_Rotate])
        cylinder(
            d1=Cut_Cylinder_d,
            d2=Cut_Cylinder_d-Cylinder_Draft,
            h=Cut_Cylinder_depth,
            $fn=Cylinder_Sides
        );
    else
        rotate([0,0,Polygon_Rotate])
        cylinder(
            d1=Cut_Cylinder_d,
            d2=Cut_Cylinder_d-Cylinder_Draft,
            h=top_layer+100,
            $fn=Cylinder_Sides
        );

    if (Cut_d_bottom) {    
        #translate([(Grids_X-1)*42/2, (Grids_Y-1)*42/2,-5.75])
        mirror([1,0,0])
        linear_extrude(0.6)
        text(str(Cut_Cylinder_d), halign="center", valign="center");
    }
    
    if (Cut_d_in_hole) {
        translate([0,0, -0.6])
        linear_extrude(0.6)
        text(str(Cut_Cylinder_d), halign="center", valign="center");
        
    }
        
//translate([0,0,-100]) cube(200); //debug slice
}
}


// Modules ///////////////////////////////////////////////////////
module makeBinBase() {
    // Generate all base shapes
    difference() {
        union() {
            // Create full-sized base units
            for (g_x = [0:1:Grids_X_ - 1]) {
                for (g_y = [0:1:Grids_Y_ - 1]) {
                    makeBinBaseSingle(g_x * Basic_Unit_XY, g_y * Basic_Unit_XY, 1.0, 1.0);
                }
            }
            // Create half-sized base units
            if (Grids_X_ % 1 > 0) {
                for (g_y = [0:1:Grids_Y_ - 1]) {
                    makeBinBaseSingle(floor(Grids_X_) * Basic_Unit_XY, g_y * Basic_Unit_XY, 0.5, 1.0);
                }
            }
            if (Grids_Y_ % 1 > 0) {
                for (g_x = [0:1:Grids_X_ - 1]) {
                    makeBinBaseSingle(g_x * Basic_Unit_XY, floor(Grids_Y_) * Basic_Unit_XY, 1.0, 0.5);
                }
            }
            // Create a quarter-sized base unit
            if (Grids_X_ % 1 > 0 && Grids_Y_ % 1 > 0) {
                makeBinBaseSingle(floor(Grids_X_) * Basic_Unit_XY, floor(Grids_Y_) * Basic_Unit_XY, 0.5, 0.5);
            }
        }
    }
}


module makeBinBaseSingle(start_x = 0.0, start_y = 0.0, width_x = 1.0, width_y = 1.0) {
    // Define parameters
    radius_0 = 1.05 - Offset_XY;
    radius_1 = 1.85 - Offset_XY;
    radius_2 = Basic_Radius_1 - Offset_XY;
    height_0 = 0.80;
    height_1 = 1.80;
    height_2 = 2.15;
    
    // Calculate corners
    corner_0 = [start_x + Basic_Radius_1, start_y + Basic_Radius_1];
    corner_1 = [start_x + width_x * Basic_Unit_XY - Basic_Radius_1, start_y + Basic_Radius_1];
    corner_2 = [start_x + Basic_Radius_1, start_y + width_y * Basic_Unit_XY - Basic_Radius_1];
    corner_3 = [start_x + width_x * Basic_Unit_XY - Basic_Radius_1, start_y + width_y * Basic_Unit_XY - Basic_Radius_1];

    // Create the base shape
    difference() {
        translate([start_x, start_y, 0.0]) cube([(width_x * Basic_Unit_XY), (width_y * Basic_Unit_XY), height_0 + height_1 + height_2 + Wall_Thickness]);
        /// Inner hollows
        union() {
            if (Ultra_Light_Base) {
                hull() {
                    translate([corner_0[0], corner_0[1], Wall_Thickness]) cylinder(height_0 - 0.5858 * Wall_Thickness, radius_0 - 0.4142 * Wall_Thickness, radius_1 - Wall_Thickness);
                    translate([corner_1[0], corner_1[1], Wall_Thickness]) cylinder(height_0 - 0.5858 * Wall_Thickness, radius_0 - 0.4142 * Wall_Thickness, radius_1 - Wall_Thickness);
                    translate([corner_2[0], corner_2[1], Wall_Thickness]) cylinder(height_0 - 0.5858 * Wall_Thickness, radius_0 - 0.4142 * Wall_Thickness, radius_1 - Wall_Thickness);
                    translate([corner_3[0], corner_3[1], Wall_Thickness]) cylinder(height_0 - 0.5858 * Wall_Thickness, radius_0 - 0.4142 * Wall_Thickness, radius_1 - Wall_Thickness);
                }
                hull() {
                    translate([corner_0[0], corner_0[1], height_0 + 0.4142 * Wall_Thickness]) cylinder(height_1, radius_1 - Wall_Thickness, radius_1 - Wall_Thickness);
                    translate([corner_1[0], corner_1[1], height_0 + 0.4142 * Wall_Thickness]) cylinder(height_1, radius_1 - Wall_Thickness, radius_1 - Wall_Thickness);
                    translate([corner_2[0], corner_2[1], height_0 + 0.4142 * Wall_Thickness]) cylinder(height_1, radius_1 - Wall_Thickness, radius_1 - Wall_Thickness);
                    translate([corner_3[0], corner_3[1], height_0 + 0.4142 * Wall_Thickness]) cylinder(height_1, radius_1 - Wall_Thickness, radius_1 - Wall_Thickness);
                }
                hull() {
                    translate([corner_0[0], corner_0[1], height_0 + height_1 + 0.4142 * Wall_Thickness]) cylinder(height_2, radius_1 - Wall_Thickness, radius_2 - Wall_Thickness);
                    translate([corner_1[0], corner_1[1], height_0 + height_1 + 0.4142 * Wall_Thickness]) cylinder(height_2, radius_1 - Wall_Thickness, radius_2 - Wall_Thickness);
                    translate([corner_2[0], corner_2[1], height_0 + height_1 + 0.4142 * Wall_Thickness]) cylinder(height_2, radius_1 - Wall_Thickness, radius_2 - Wall_Thickness);
                    translate([corner_3[0], corner_3[1], height_0 + height_1 + 0.4142 * Wall_Thickness]) cylinder(height_2, radius_1 - Wall_Thickness, radius_2 - Wall_Thickness);
                }
                hull() {
                    translate([corner_0[0], corner_0[1], height_0 + height_1 + height_2]) cylinder(0.4142 * Wall_Thickness, radius_2 - 1.4142 * Wall_Thickness, radius_2 - Wall_Thickness);
                    translate([corner_1[0], corner_1[1], height_0 + height_1 + height_2]) cylinder(0.4142 * Wall_Thickness, radius_2 - 1.4142 * Wall_Thickness, radius_2 - Wall_Thickness);
                    translate([corner_2[0], corner_2[1], height_0 + height_1 + height_2]) cylinder(0.4142 * Wall_Thickness, radius_2 - 1.4142 * Wall_Thickness, radius_2 - Wall_Thickness);
                    translate([corner_3[0], corner_3[1], height_0 + height_1 + height_2]) cylinder(0.4142 * Wall_Thickness, radius_2 - 1.4142 * Wall_Thickness, radius_2 - Wall_Thickness);
                }
                hull() {
                    translate([corner_0[0], corner_0[1], height_0 + height_1 + height_2]) cylinder(1.4142 * Wall_Thickness, radius_2 - 1.4142 * Wall_Thickness, radius_2);
                    translate([corner_1[0], corner_1[1], height_0 + height_1 + height_2]) cylinder(1.4142 * Wall_Thickness, radius_2 - 1.4142 * Wall_Thickness, radius_2);
                    translate([corner_2[0], corner_2[1], height_0 + height_1 + height_2]) cylinder(1.4142 * Wall_Thickness, radius_2 - 1.4142 * Wall_Thickness, radius_2);
                    translate([corner_3[0], corner_3[1], height_0 + height_1 + height_2]) cylinder(1.4142 * Wall_Thickness, radius_2 - 1.4142 * Wall_Thickness, radius_2);
                }
            }
            // Magnets
            if (!Half_Grid_Base && Magnets && width_x == 1.0 && width_y == 1.0) {
                makeMagnetHoles(start_x, start_y);
            }
        }
    }

    // Create magnet holes if necessary
    if (!Half_Grid_Base && Magnets && width_x == 1.0 && width_y == 1.0) {
        difference() {
            union() {
                translate([corner_0[0] + (Basic_Radius_2 - Basic_Radius_1), corner_0[1] + (Basic_Radius_2 - Basic_Radius_1), 0.0]) cylinder(Magnet_Depth + Wall_Thickness, Magnet_Radius + Wall_Thickness, Magnet_Radius + Wall_Thickness);
                translate([corner_1[0] - (Basic_Radius_2 - Basic_Radius_1), corner_1[1] + (Basic_Radius_2 - Basic_Radius_1), 0.0]) cylinder(Magnet_Depth + Wall_Thickness, Magnet_Radius + Wall_Thickness, Magnet_Radius + Wall_Thickness);
                translate([corner_2[0] + (Basic_Radius_2 - Basic_Radius_1), corner_2[1] - (Basic_Radius_2 - Basic_Radius_1), 0.0]) cylinder(Magnet_Depth + Wall_Thickness, Magnet_Radius + Wall_Thickness, Magnet_Radius + Wall_Thickness);
                translate([corner_3[0] - (Basic_Radius_2 - Basic_Radius_1), corner_3[1] - (Basic_Radius_2 - Basic_Radius_1), 0.0]) cylinder(Magnet_Depth + Wall_Thickness, Magnet_Radius + Wall_Thickness, Magnet_Radius + Wall_Thickness);
            }
            makeMagnetHoles(start_x, start_y);
        }
    }
}


module makeMagnetHoles(start_x = 0.0, start_y = 0.0) {
    // Create shapes for the magnet holes
    union() {
        translate([start_x + Basic_Radius_2, start_y + Basic_Radius_2, 0.0]) cylinder(Magnet_Depth, Magnet_Radius, Magnet_Radius);
        translate([start_x + Basic_Unit_XY - Basic_Radius_2, start_y + Basic_Radius_2, 0.0]) cylinder(Magnet_Depth, Magnet_Radius, Magnet_Radius);
        translate([start_x + Basic_Radius_2, start_y + Basic_Unit_XY - Basic_Radius_2, 0.0]) cylinder(Magnet_Depth, Magnet_Radius, Magnet_Radius);
        translate([start_x + Basic_Unit_XY - Basic_Radius_2, start_y + Basic_Unit_XY - Basic_Radius_2, 0.0]) cylinder(Magnet_Depth, Magnet_Radius, Magnet_Radius);
    }    
}


module makeBinBody() {
    // Define parameters
    radius_0 = Basic_Radius_1 - Offset_XY;
    height_0 = 4.75;
    height_1 = 7.0 - height_0;
    height_2 = (Grids_Z - 1) * Basic_Unit_Z;
    
    // Calculate corners
    corner_0 = [Basic_Radius_1, Basic_Radius_1];
    corner_1 = [(Grids_X_ * Basic_Unit_XY) - Basic_Radius_1, Basic_Radius_1];
    corner_2 = [Basic_Radius_1, (Grids_Y_ * Basic_Unit_XY) - Basic_Radius_1];
    corner_3 = [(Grids_X_ * Basic_Unit_XY) - Basic_Radius_1, (Grids_Y_ * Basic_Unit_XY) - Basic_Radius_1];
    
    // Create the outer bin hull
    difference() {
        hull() {
            translate([corner_0[0], corner_0[1], height_0]) cylinder(height_1 + height_2, radius_0, radius_0);
            translate([corner_1[0], corner_1[1], height_0]) cylinder(height_1 + height_2, radius_0, radius_0);
            translate([corner_2[0], corner_2[1], height_0]) cylinder(height_1 + height_2, radius_0, radius_0);
            translate([corner_3[0], corner_3[1], height_0]) cylinder(height_1 + height_2, radius_0, radius_0);
        }
        if (!Solid) {
            union() {
            hull() {
                translate([corner_0[0], corner_0[1], height_0]) cylinder(height_1 + height_2, radius_0 - Wall_Thickness, radius_0 - Wall_Thickness);
                translate([corner_1[0], corner_1[1], height_0]) cylinder(height_1 + height_2, radius_0 - Wall_Thickness, radius_0 - Wall_Thickness);
                translate([corner_2[0], corner_2[1], height_0]) cylinder(height_1 + height_2, radius_0 - Wall_Thickness, radius_0 - Wall_Thickness);
                translate([corner_3[0], corner_3[1], height_0]) cylinder(height_1 + height_2, radius_0 - Wall_Thickness, radius_0 - Wall_Thickness);
            }
        }
    }
    }
}


module makeBinStacklip() {
    // Define parameters
    radius_0 = 1.15;
    radius_1 = 1.85;
    radius_2 = Basic_Radius_1 - Offset_XY;
    height_0 = Stacking_Lip_Width - Wall_Thickness;
    height_1 = 0.60;
    height_2 = 0.70;
    height_3 = 1.80;
    height_4 = 1.90;
    height_5 = 0.75;
    height_start = (Grids_Z * Basic_Unit_Z) - (height_0 + height_1);
    
    // Calculate corners
    corner_0 = [Basic_Radius_1, Basic_Radius_1];
    corner_1 = [(Grids_X_ * Basic_Unit_XY) - Basic_Radius_1, Basic_Radius_1];
    corner_2 = [Basic_Radius_1, (Grids_Y_ * Basic_Unit_XY) - Basic_Radius_1];
    corner_3 = [(Grids_X_ * Basic_Unit_XY) - Basic_Radius_1, (Grids_Y_ * Basic_Unit_XY) - Basic_Radius_1];
    
    // Create stacklip on top of the bin
    difference() {    
        union() {
            hull() {     
                translate([corner_0[0], corner_0[1], height_start]) cylinder(height_0 + height_1 + height_2 + height_3 + height_4, radius_2, radius_2);
                translate([corner_1[0], corner_1[1], height_start]) cylinder(height_0 + height_1 + height_2 + height_3 + height_4, radius_2, radius_2);
                translate([corner_2[0], corner_2[1], height_start]) cylinder(height_0 + height_1 + height_2 + height_3 + height_4, radius_2, radius_2);
                translate([corner_3[0], corner_3[1], height_start]) cylinder(height_0 + height_1 + height_2 + height_3 + height_4, radius_2, radius_2);
            }
        }
        union() {
            hull() {
                translate([corner_0[0], corner_0[1], height_start]) cylinder(height_0, radius_2 - Wall_Thickness, radius_0);
                translate([corner_1[0], corner_1[1], height_start]) cylinder(height_0, radius_2 - Wall_Thickness, radius_0);
                translate([corner_2[0], corner_2[1], height_start]) cylinder(height_0, radius_2 - Wall_Thickness, radius_0);
                translate([corner_3[0], corner_3[1], height_start]) cylinder(height_0, radius_2 - Wall_Thickness, radius_0);
            }
            hull() {
                translate([corner_0[0], corner_0[1], height_start + height_0]) cylinder(height_1, radius_0, radius_0);
                translate([corner_1[0], corner_1[1], height_start + height_0]) cylinder(height_1, radius_0, radius_0);
                translate([corner_2[0], corner_2[1], height_start + height_0]) cylinder(height_1, radius_0, radius_0);
                translate([corner_3[0], corner_3[1], height_start + height_0]) cylinder(height_1, radius_0, radius_0);
            }
            hull() {
                translate([corner_0[0], corner_0[1], height_start + height_0 + height_1]) cylinder(height_2, radius_0, radius_1);
                translate([corner_1[0], corner_1[1], height_start + height_0 + height_1]) cylinder(height_2, radius_0, radius_1);
                translate([corner_2[0], corner_2[1], height_start + height_0 + height_1]) cylinder(height_2, radius_0, radius_1);
                translate([corner_3[0], corner_3[1], height_start + height_0 + height_1]) cylinder(height_2, radius_0, radius_1);
            }
            hull() {
                translate([corner_0[0], corner_0[1], height_start + height_0 + height_1 + height_2]) cylinder(height_3, radius_1, radius_1);
                translate([corner_1[0], corner_1[1], height_start + height_0 + height_1 + height_2]) cylinder(height_3, radius_1, radius_1);
                translate([corner_2[0], corner_2[1], height_start + height_0 + height_1 + height_2]) cylinder(height_3, radius_1, radius_1);
                translate([corner_3[0], corner_3[1], height_start + height_0 + height_1 + height_2]) cylinder(height_3, radius_1, radius_1);
            }
            hull() {
                translate([corner_0[0], corner_0[1], height_start + height_0 + height_1 + height_2 + height_3]) cylinder(height_4, radius_1, radius_2);
                translate([corner_1[0], corner_1[1], height_start + height_0 + height_1 + height_2 + height_3]) cylinder(height_4, radius_1, radius_2);
                translate([corner_2[0], corner_2[1], height_start + height_0 + height_1 + height_2 + height_3]) cylinder(height_4, radius_1, radius_2);
                translate([corner_3[0], corner_3[1], height_start + height_0 + height_1 + height_2 + height_3]) cylinder(height_4, radius_1, radius_2);
            }
            hull() {
                translate([corner_0[0], corner_0[1], height_start + height_0 + height_1 + height_2 + height_3 + height_4 - height_5]) cylinder(height_5, radius_2, radius_2);
                translate([corner_1[0], corner_1[1], height_start + height_0 + height_1 + height_2 + height_3 + height_4 - height_5]) cylinder(height_5, radius_2, radius_2);
                translate([corner_2[0], corner_2[1], height_start + height_0 + height_1 + height_2 + height_3 + height_4 - height_5]) cylinder(height_5, radius_2, radius_2);
                translate([corner_3[0], corner_3[1], height_start + height_0 + height_1 + height_2 + height_3 + height_4 - height_5]) cylinder(height_5, radius_2, radius_2);
            }
        }
    }
}


module makeBinDividers() {
    // Define parameters
    radius_0 = 1.10;
    radius_spaceing_x = ((Grids_X_ * Basic_Unit_XY) - (2.0 * Offset_XY) - (2.0 * Wall_Thickness) - (2.0 * radius_0) - (Dividers_X * (Wall_Thickness + (2.0 * radius_0)))) / (Dividers_X + 1);
    radius_spaceing_y = ((Grids_Y_ * Basic_Unit_XY) - (2.0 * Offset_XY) - (2.0 * Wall_Thickness) - (2.0 * radius_0) - (Dividers_Y * (Wall_Thickness + (2.0 * radius_0)))) / (Dividers_Y + 1);
    start_xy = Offset_XY + Wall_Thickness + radius_0;
    
    // Calculate corners
    corner_0 = [start_xy, start_xy];
    corner_1 = [start_xy + radius_spaceing_x, start_xy];
    corner_2 = [start_xy, start_xy + radius_spaceing_y];
    corner_3 = [start_xy + radius_spaceing_x, start_xy + radius_spaceing_y];
    
    // Create divider shapes
    difference() {
        hull() {
            translate([Basic_Radius_1, Basic_Radius_1, Wall_Thickness]) cylinder((Grids_Z * Basic_Unit_Z) - Top_Clearance_Offset - Wall_Thickness, Basic_Radius_1 - Offset_XY, Basic_Radius_1 - Offset_XY);
            translate([(Grids_X_ * Basic_Unit_XY) - Basic_Radius_1, Basic_Radius_1, Wall_Thickness]) cylinder((Grids_Z * Basic_Unit_Z) - Top_Clearance_Offset - Wall_Thickness, Basic_Radius_1 - Offset_XY, Basic_Radius_1 - Offset_XY);
            translate([Basic_Radius_1, (Grids_Y_ * Basic_Unit_XY) - Basic_Radius_1, Wall_Thickness]) cylinder((Grids_Z * Basic_Unit_Z) - Top_Clearance_Offset - Wall_Thickness, Basic_Radius_1 - Offset_XY, Basic_Radius_1 - Offset_XY);
            translate([(Grids_X_ * Basic_Unit_XY) - Basic_Radius_1, (Grids_Y_ * Basic_Unit_XY) - Basic_Radius_1, Wall_Thickness]) cylinder((Grids_Z * Basic_Unit_Z) - Top_Clearance_Offset - Wall_Thickness, Basic_Radius_1 - Offset_XY, Basic_Radius_1 - Offset_XY);
        }
        
        union() {
            for (d_x = [0 : 1 : Dividers_X]) {
                for (d_y = [0 : 1 : Dividers_Y]) {
                    hull() {
                        translate([corner_0[0] + d_x * (radius_spaceing_x + 2.0 * radius_0 + Wall_Thickness), corner_0[1] + d_y * (radius_spaceing_y + 2.0 * radius_0 + Wall_Thickness), 0.0]) cylinder((Grids_Z * Basic_Unit_Z), radius_0, radius_0);
                        translate([corner_1[0] + d_x * (radius_spaceing_x + 2.0 * radius_0 + Wall_Thickness), corner_1[1] + d_y * (radius_spaceing_y + 2.0 * radius_0 + Wall_Thickness), 0.0]) cylinder((Grids_Z * Basic_Unit_Z), radius_0, radius_0);
                        translate([corner_2[0] + d_x * (radius_spaceing_x + 2.0 * radius_0 + Wall_Thickness), corner_2[1] + d_y * (radius_spaceing_y + 2.0 * radius_0 + Wall_Thickness), 0.0]) cylinder((Grids_Z * Basic_Unit_Z), radius_0, radius_0);
                        translate([corner_3[0] + d_x * (radius_spaceing_x + 2.0 * radius_0 + Wall_Thickness), corner_3[1] + d_y * (radius_spaceing_y + 2.0 * radius_0 + Wall_Thickness), 0.0]) cylinder((Grids_Z * Basic_Unit_Z), radius_0, radius_0);
                    }
                }
            }
        }
    }
}


module makeBinLabels() {
    // Difine parameters
    dividers_x = (Dividers && Label_For_Each_Section) ? Dividers_X : 0;
    dividers_y = (Dividers && Label_For_Each_Section) ? Dividers_Y : 0;
    
    // Label Mode FULL
    if (Label_Position == "Full") {
        for (d_y = [0 : 1 : dividers_y]) {
            label_width = (Grids_X_ * Basic_Unit_XY) - (2.0 * Offset_XY);
            label_depth = (d_y == 0) ? (Label_Depth + Stacking_Lip_Width) : Label_Depth;
            makeBinLabel(
                Offset_XY,       
                ((Grids_Y_ * Basic_Unit_XY) * (dividers_y + 1 - d_y) - Offset_XY * (dividers_y + 1 - 2.0* d_y) + Wall_Thickness * d_y) / (dividers_y + 1),
                label_width, label_depth
            );
        }
    }
        
    // Label Mode LEFT
    else if (Label_Position == "Left") {
        for (d_x = [0 : 1 : dividers_x]) {
            for (d_y = [0 : 1 : dividers_y]) {
                label_width = (d_x == 0) ? (Label_Width + Stacking_Lip_Width) : Label_Width;
                label_depth = (d_y == 0) ? (Label_Depth + Stacking_Lip_Width) : Label_Depth;
                makeBinLabel(
                    Offset_XY + (((Grids_X_ * Basic_Unit_XY) - (2 * Offset_XY) - Wall_Thickness) / (dividers_x + 1)) * d_x,
                    ((Grids_Y_ * Basic_Unit_XY) - Offset_XY) - (((Grids_Y_ * Basic_Unit_XY) - (2 * Offset_XY) - Wall_Thickness) / (dividers_y + 1)) * d_y,
                    label_width, label_depth
                );
            }
        }   
    }
    
    // Label Mode CENTER
    else if (Label_Position == "Center") {
        for (d_x = [0 : 1 : dividers_x]) {
            for (d_y = [0 : 1 : dividers_y]) {
                
                label_width = Label_Width;
                label_depth = (d_y == 0) ? (Label_Depth + Stacking_Lip_Width) : Label_Depth;
                
                makeBinLabel(
                    Offset_XY + (((Grids_X_ * Basic_Unit_XY) - (2 * Offset_XY) - Wall_Thickness) / (dividers_x + 1)) * d_x + ( (((Grids_X_ * Basic_Unit_XY) - (2 * Offset_XY) - Wall_Thickness) / (dividers_x + 1)) / 2.0 ) - (label_width / 2.0),
                    ((Grids_Y_ * Basic_Unit_XY) - Offset_XY) - (((Grids_Y_ * Basic_Unit_XY) - (2 * Offset_XY) - Wall_Thickness) / (dividers_y + 1)) * d_y,
                    label_width, label_depth
                );
            }
        }
    }

    // Label Mode RIGHT
    else if (Label_Position == "Right") {
        for (d_x = [0 : 1 : dividers_x]) {
            for (d_y = [0 : 1 : dividers_y]) {
                label_width = (d_x == dividers_x) ? (Label_Width + Stacking_Lip_Width) : Label_Width;
                label_depth = (d_y == 0) ? (Label_Depth + Stacking_Lip_Width) : Label_Depth;
                makeBinLabel(
                    Offset_XY + (((Grids_X_ * Basic_Unit_XY) - (2 * Offset_XY) - Wall_Thickness) / (dividers_x + 1)) * d_x + ((((Grids_X_ * Basic_Unit_XY) - (2 * Offset_XY) - Wall_Thickness) / (dividers_x + 1)) + Wall_Thickness) - label_width,
                    ((Grids_Y_ * Basic_Unit_XY) - Offset_XY) - (((Grids_Y_ * Basic_Unit_XY) - (2 * Offset_XY) - Wall_Thickness) / (dividers_y + 1)) * d_y,
                    label_width, label_depth
                );
            }
        }
    }
}


module makeBinLabel(start_x = 0.0, start_y = 0.0, width = 10.0, depth = 10.0) {
    // Difine parameters
    dividers_x = Dividers ? Dividers_X : 0;
    dividers_y = Dividers ? Dividers_Y : 0;
    
    // Generate the label
    translate([start_x, start_y - depth, (Grids_Z * Basic_Unit_Z) - Top_Clearance_Offset - Label_Height]) cube([width, depth, Label_Height]);
    
    // Define the label rips
    rips_max_bridge = 13.0;
    rips = (Label_Position == "Full" && Dividers == true) ? (ceil((Grids_X_ * Basic_Unit_XY + dividers_x * Wall_Thickness - 2.0 * Offset_XY) / (rips_max_bridge * (dividers_x + 1))) * (dividers_x + 1)) - dividers_x : ceil(width / rips_max_bridge) + 1;
    rips_distance = (width - rips * Wall_Thickness) / (rips - 1);
    
    // Generate the label rips
    
    difference() {
        hull() {
            translate([start_x, start_y - depth, (Grids_Z * Basic_Unit_Z) - Top_Clearance_Offset - Label_Height]) cube([width, depth, 0.0001]);
            translate([start_x, start_y, (Grids_Z * Basic_Unit_Z) - Top_Clearance_Offset - Label_Height - depth]) cube([width, 0.0001, 0.0001]);
        }
        if (Ultra_Light_Labels) {
            for (r = [0 : 1 : rips - 1]) {
                translate([start_x + Wall_Thickness + (r * (rips_distance + Wall_Thickness)), start_y - depth, (Grids_Z * Basic_Unit_Z) - Top_Clearance_Offset - Label_Height - depth]) cube([rips_distance, depth, depth]);
            }
        }
    }
}


module makeBinScoops() {
    // Define parameters
    dividers_y = Dividers ? Dividers_Y : 0;
    
    // Create the scoops
    for (d_y = [0 : 1 : dividers_y]) {
        spacing = (d_y == 0) ? Stacking_Lip_Width : Wall_Thickness;
        makeBinScoop(Offset_XY + (((Grids_Y_ * Basic_Unit_XY) - (2 * Offset_XY) - Wall_Thickness) / (dividers_y + 1)) * d_y, spacing);
    }    
}


module makeBinScoop(start_y = 0.0, spacing = 0.0) {
    // Define parameters
    height_0 = 0.6;
    height_1 = Ultra_Light_Base ? 0 : 4.75;

    // Create the scoop
    difference() {
        translate([Offset_XY, start_y, Wall_Thickness]) cube([(Grids_X_ * Basic_Unit_XY) - (2.0 * Offset_XY), Scoop_Radius + spacing, (Grids_Z_ * Basic_Unit_Z) - Wall_Thickness - height_0]);
        union() {
            translate([Offset_XY, start_y + Scoop_Radius + spacing, Wall_Thickness + Scoop_Radius + height_1]) rotate([0, 90, 0]) cylinder((Grids_X_ * Basic_Unit_XY) - (2.0 * Offset_XY), Scoop_Radius, Scoop_Radius);
            translate([Offset_XY, start_y + spacing, Wall_Thickness + Scoop_Radius + height_1]) cube([(Grids_X_ * Basic_Unit_XY) - (2.0 * Offset_XY), 2.0 * Scoop_Radius, Grids_Z_ * Basic_Unit_Z]);
        }
    }
}


module makeBinClean() {
    // Clean each base segment
    difference() {
        union() {
            // Clean full-sized base segments
            for (g_x = [0:1:Grids_X_ - 1]) {
                for (g_y = [0:1:Grids_Y_ - 1]) {
                    makeBinBaseCleanSingle(g_x * Basic_Unit_XY, g_y * Basic_Unit_XY, 1.0, 1.0);
                }
            }
            // Clean half-sized base segments
            if (Grids_X_ % 1 > 0) {
                for (g_y = [0:1:Grids_Y_ - 1]) {
                    makeBinBaseCleanSingle(floor(Grids_X_) * Basic_Unit_XY, g_y * Basic_Unit_XY, 0.5, 1.0);
                }
            }
            if (Grids_Y_ % 1 > 0) {
                for (g_x = [0:1:Grids_X_ - 1]) {
                    makeBinBaseCleanSingle(g_x * Basic_Unit_XY, floor(Grids_Y_) * Basic_Unit_XY, 1.0, 0.5);
                }
            }
            // Clean quader-sized base segments
            if (Grids_X_ % 1 > 0 && Grids_Y_ % 1 > 0) {
                makeBinBaseCleanSingle(floor(Grids_X_) * Basic_Unit_XY, floor(Grids_Y_) * Basic_Unit_XY, 0.5, 0.5);
            }
        }
    }

    // Define parameters
    radius_0 = Basic_Radius_1 - Offset_XY;
    height_0 = 4.40;
    
    // Calculate corners
    corner_0 = [Basic_Radius_1, Basic_Radius_1];
    corner_1 = [(Grids_X_ * Basic_Unit_XY) - Basic_Radius_1, Basic_Radius_1];
    corner_2 = [Basic_Radius_1, (Grids_Y_ * Basic_Unit_XY) - Basic_Radius_1];
    corner_3 = [(Grids_X_ * Basic_Unit_XY) - Basic_Radius_1, (Grids_Y_ * Basic_Unit_XY) - Basic_Radius_1];
    
    // Generate a shape all around
    difference() {
        cube([(Grids_X_ * Basic_Unit_XY), (Grids_Y_ * Basic_Unit_XY), Grids_Z * Basic_Unit_Z + height_0]);
        hull() {     
            translate([corner_0[0], corner_0[1], 0.0]) cylinder(Grids_Z * Basic_Unit_Z + height_0, radius_0, radius_0);
            translate([corner_1[0], corner_1[1], 0.0]) cylinder(Grids_Z * Basic_Unit_Z + height_0, radius_0, radius_0);
            translate([corner_2[0], corner_2[1], 0.0]) cylinder(Grids_Z * Basic_Unit_Z + height_0, radius_0, radius_0);
            translate([corner_3[0], corner_3[1], 0.0]) cylinder(Grids_Z * Basic_Unit_Z + height_0, radius_0, radius_0);
        }
    }
    
    // Generat a shape below the bin (just in case for label rips
    bellow_height = 12.0;
    translate([0.0, 0.0, -bellow_height]) cube([(Grids_X_ * Basic_Unit_XY), (Grids_Y_ * Basic_Unit_XY), bellow_height]);
}


module makeBinBaseCleanSingle(start_x = 0.0, start_y = 0.0, width_x = 1.0, width_y = 1.0) {
    // Define parameters
    radius_0 = 1.05 - Offset_XY;
    radius_1 = 1.85 - Offset_XY;
    radius_2 = Basic_Radius_1 - Offset_XY;
    height_0 = 0.80;
    height_1 = 1.80;
    height_2 = 2.15;
    
    // Calculate corners
    corner_0 = [start_x + Basic_Radius_1, start_y + Basic_Radius_1];
    corner_1 = [start_x + (width_x * Basic_Unit_XY) - Basic_Radius_1, start_y + Basic_Radius_1];
    corner_2 = [start_x + Basic_Radius_1, start_y + (width_y * Basic_Unit_XY) - Basic_Radius_1];
    corner_3 = [start_x + (width_x * Basic_Unit_XY) - Basic_Radius_1, start_y + (width_y * Basic_Unit_XY) - Basic_Radius_1];
    
    // Create the outer shape
    difference() {
        translate([start_x, start_y, 0.0]) cube([(width_x * Basic_Unit_XY), (width_y * Basic_Unit_XY), height_0 + height_1 + height_2]);
        union() {  
            hull() {     
                translate([corner_0[0], corner_0[1], 0.0]) cylinder(height_0, radius_0, radius_1);
                translate([corner_1[0], corner_1[1], 0.0]) cylinder(height_0, radius_0, radius_1);
                translate([corner_2[0], corner_2[1], 0.0]) cylinder(height_0, radius_0, radius_1);
                translate([corner_3[0], corner_3[1], 0.0]) cylinder(height_0, radius_0, radius_1);
            }
            hull() {
                translate([corner_0[0], corner_0[1], height_0]) cylinder(height_1, radius_1, radius_1);
                translate([corner_1[0], corner_1[1], height_0]) cylinder(height_1, radius_1, radius_1);
                translate([corner_2[0], corner_2[1], height_0]) cylinder(height_1, radius_1, radius_1);
                translate([corner_3[0], corner_3[1], height_0]) cylinder(height_1, radius_1, radius_1);
            }
            hull() {
                translate([corner_0[0], corner_0[1], (height_0 + height_1)]) cylinder(height_2, radius_1, radius_2);
                translate([corner_1[0], corner_1[1], (height_0 + height_1)]) cylinder(height_2, radius_1, radius_2);
                translate([corner_2[0], corner_2[1], (height_0 + height_1)]) cylinder(height_2, radius_1, radius_2);
                translate([corner_3[0], corner_3[1], (height_0 + height_1)]) cylinder(height_2, radius_1, radius_2);
            }
        }
    }
    
    // Create the magnet holes
    if (!Half_Grid_Base && Magnets && width_x == 1.0 && width_y == 1.0) {
        makeMagnetHoles(start_x, start_y);
    }
}

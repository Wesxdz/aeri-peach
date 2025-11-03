include <pentagon_plate.scad>
include <dodecahedroid_config.scad>
include <omniball.scad>
include <connector_pentagon_plate.scad>
include <wheel_panel.scad>

module OmniballBrace()
{
$fn=64;
intersection()
{
union()
{
translate([0, 50, -100]) rotate([90, 0, 0]) linear_extrude(100) import("omni_support_surve.svg");

//for (i=[0:18])
//{
//translate([0, -50, -100]) rotate([90, 0, -i]) linear_extrude(10) import("omni_support_surve.svg");
//mirror([0, 1, 0]) translate([0, -50, -100]) rotate([90, 0, -i]) linear_extrude(10) import("omni_support_surve.svg");
//}

for (i=[0:1:14])
{
    translate([0, -50, -100]) rotate([90, 0, -i]) linear_extrude(10) import("omni_support_surve.svg");
    // scale([((18-i)/18)/8+0.875, 1, 1])
    // to get a curve at the end...
mirror([0, 1, 0]) translate([0, -50, -100]) rotate([90, 0, -i]) linear_extrude(10) import("omni_support_surve.svg");
    }
}

chamfer_radius = 10;

translate([chamfer_radius, 0, 0]) hull()
{
    rotate([0, 180, 0]) translate([0, 50-10, 0]) 
    {
        cylinder(10, chamfer_radius, chamfer_radius);
        translate([0, 0, 100-chamfer_radius]) sphere(chamfer_radius);
    }
    rotate([0, 180, 0]) translate([0, -50+10, 0]) 
    {
        cylinder(10, chamfer_radius, chamfer_radius);
        translate([0, 0, 100-chamfer_radius]) sphere(chamfer_radius);
    }
    translate([100, 0, -40]) cube([10, 200, 100], center=true);
}

}
}

//ConnectorPentagonPlate(panel_radius, cell_size, wall_thickness, panel_thickness, border_edge, false, render_color, m3_distance_from_panel_corner);
WheelPanelPrefab(36, panel_radius, cell_size, wall_thickness, panel_thickness, border_edge, show_cradle_vent, color([0, 1, 1, 1]), true, show_rest=false, 1);
scale(0.1) rotate([0, 0, 180])
{
translate([-90, 0, 0])
{
$fn = 64;
omniball_radius = wheel_radius;
omniball_spacing = 9.0;
move_omniball_forward = wheel_radius*.8;
difference()
{
scale([1.4, 1.4, 1.2]) OmniballBrace();

translate([move_omniball_forward, 0, -omniball_radius*1.5]) sphere(omniball_radius+omniball_spacing);
}
//translate([move_omniball_forward, 0, -omniball_radius*1.8]) sphere(omniball_radius);
translate([move_omniball_forward, 0, -omniball_radius*1.5]) import("omniball.stl");
}
}

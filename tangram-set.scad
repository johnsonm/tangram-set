// Copyright 2018 Michael K Johnson
// Use allowed under Attribution 4.0 International (CC BY 4.0) license terms
// https://creativecommons.org/licenses/by/4.0/legalcode

// X/Y scale factor relative to 100x100 assembled set
f = 1.0;
// corner radius in % of full set
r = 1; // [0.01:2]
// height of tiles in mm (not scaled by f)
h = 5;
// separate the tiles by approximately s for printing
s = 2;
// preview[view:south, tilt:top]

module tile(points, r=r, h=h) {
    hull() for (point=points) translate([point[0], point[1]])
        cylinder(r=r, h=h, $fn=15);
}
function offset(angle) = r / tan(angle/2);
module t1() {
    // largest triangle
    x1 = r;
    y1 = offset(45);
    y2 = 100 - offset(45);
    x3 = 50 - r*sqrt(2);
    tile([[x1, y1], [x1, y2], [x3, 50]]);
    %tile([[0, 0], [0, 100], [50, 50]], r=0.01, h=h+1);
}
module t2() {
    translate([0, 100, 0]) rotate([0, 0, -90]) t1();
}
module t3() {
    // smallest triangle
    x1 = 100-r;
    y1 = 50+offset(45);
    y2 = 100 - offset(45);
    x3 = 75 + r*sqrt(2);
    tile([[x1, y1], [x1, y2], [x3, 75]]);
    %tile([[100, 50], [100, 100], [75, 75]], r=0.01, h=h+1);
}
module t4() {
    // medium triangle
    x1 = 50+offset(45);
    y1 = r;
    x2 = 100 - r;
    y2 = 50 - offset(45);
    x3 = 100 - r*sqrt(2);
    y3 = r*sqrt(2);
    tile([[x1, y1], [x2, y2], [x3, y3]]);
    %tile([[50, 0], [100, 50], [100, 0]], r=0.01, h=h+1);
}
module t5() {
    // rhombus
    x1 = offset(45);
    y1 = r;
    x2 = 25 + offset(135);
    y2 = 25 - r;
    x3 = 75 - offset(45);
    y3 = y2;
    x4 = 50 - offset(135);
    y4 = r;
    tile([[x1, y1], [x2, y2], [x3, y3], [x4, y4]]);
    %tile([[0, 0], [25, 25], [75, 25], [50, 0]], r=0.01, h=h+1);
}
module t6() {
    translate([-25, 125, 0]) rotate([0, 0, -90]) t3();
}
module t7() {
    // square
    x1 = 75;
    y1 = 25+ r*sqrt(2);
    x2 = 50 + r*sqrt(2);
    y2 = 50;
    x3 = 75;
    y3 = 75 - r*sqrt(2);
    x4 = 100 - r*sqrt(2);
    y4 = 50;
    tile([[x1, y1], [x2, y2], [x3, y3], [x4, y4]]);
    %tile([[75, 25], [50, 50], [75, 75], [100, 50]], r=0.01, h=h+1);
}
module set() {
    // separate by some without trying to evenly distribute the space...
    translate([-s, 0]) t1();
    translate([0, s]) t2();
    translate([s, s]) t3();
    translate([s, -2*s]) t4();
    translate([-s, -2*s]) t5();
    translate([0, -s]) t6();
    translate([s, 0]) t7();
}
scale([f, f, 1]) set();

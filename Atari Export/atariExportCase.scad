


module pcb(){
  color("red",1){
    translate([-111.4,77,0]) import("Atari Export_polyd.stl",center=1);
  }
}

module pcb_hull(){

  hull(){
    pcb();
  }
}


module midi_port_cutout(){
  cutout_diameter = 18;
  rotate([90,0,90])cylinder(h= 10, d= 18, center =true);

}
module midi_port_cutouts(){
  pos_x = 25;
  pos_y = 22;
  pos_z=12;

  //middle
  translate([pos_x,0,pos_z])midi_port_cutout();
  // left
  translate([pos_x,pos_y,pos_z])midi_port_cutout();
  // right
  translate([pos_x,-pos_y,pos_z])midi_port_cutout();
}

module serial_port_cutout(){

  translate([-25,0,6])cube([12,54,16],center=true);
}

standoff_x = 7;
standoff_y = 10;
pcb_x = 2;
drill_d = 2;
drill_depth = 6;
module standoff(){

  translate([-7.5,30,(top_case_z-thickness)/4]){
    difference() {

      cube([standoff_x,standoff_y,(top_case_z/2)-pcb_x], center=true);
      translate([0,-1.5,-9])cylinder(d=drill_d, h=6, center=true);
    }
  }
}
module standoffs(){

  mirror([0,1,0]) standoff();
  standoff();
}

top_case_x = 48;
top_case_y = 70;
top_case_z = 50;
thickness = 1.5;

module top_case(){

  //top
  translate([0,0,top_case_z/2-thickness/2])cube([top_case_x,top_case_y,thickness],center=true);
  //left side
  translate([0,(top_case_y/2)-thickness/2,top_case_z/4-thickness/2])cube([top_case_x,thickness,top_case_z/2],center=true);

  //right side
  translate([0,-(top_case_y/2)+thickness/2,top_case_z/4-thickness/2])cube([top_case_x,thickness,top_case_z/2],center=true);
  //back midi
  translate([top_case_x/2-(thickness/2),0,top_case_z/4-thickness/2])cube([thickness,top_case_y,top_case_z/2],center=true);

  //front serial
  translate([-top_case_x/2+(thickness/2),0,top_case_z/4-thickness/2])cube([thickness,top_case_y,top_case_z/2],center=true);

}

module bottom_case(){

  //base
  translate([0,0,-thickness*2])cube([top_case_x,top_case_y,thickness*4],center=true);

}

standoff_offset_x = -7.5;
standoff_offset_y = 30;
standoff_offset_z = -thickness*2;

module bottom_standoff(){

  translate([standoff_offset_x,standoff_offset_y,standoff_offset_z]){
    difference() {

      cube([standoff_x,standoff_y,(thickness*4)], center=true);
      drill_holes();
    }
  }
}
module bottom_standoffs(){

  bottom_standoff();
  mirror([0,1,0]) bottom_standoff();
}
module drill_hole(){
    translate([0,-1.5,0])cylinder(d=drill_d, h=80, center=true);
}
module drill_holes(){

  mirror([0,1,0]){translate([standoff_offset_x,standoff_offset_y,standoff_offset_z])
  drill_hole();}
      translate([standoff_offset_x,standoff_offset_y,standoff_offset_z])
      drill_hole();


}
module compose_bottom(){
difference(){
bottom_standoffs();
drill_holes();

}


  //serial port LiP
  translate([-23.25,0,1])cube([thickness,54,2],center=true);


  difference() {
    bottom_case();
    pcb_hull();
    drill_holes();


  }
}
module compose_top(){
  standoffs();
  difference() {
    union(){
      standoffs();
      top_case();
    }

    serial_port_cutout();
    midi_port_cutouts();
    pcb();
  }

}

module both_parts(){

  translate([0,0,6]) compose_bottom();
  translate([-50,0,25]) rotate([0,180,0]) compose_top();

  //sprues
  sprue_d = 2;
  sprue_len= 5;
  sprue_x = -27;

  translate([sprue_x,0,4])rotate([0,90.0])cylinder(d=sprue_d, h= sprue_len);
  translate([sprue_x,10,4])rotate([0,90.0])cylinder(d=sprue_d, h= sprue_len);
  translate([sprue_x,20,4])rotate([0,90.0])cylinder(d=sprue_d, h= sprue_len);
  translate([sprue_x,30,4])rotate([0,90.0])cylinder(d=sprue_d, h= sprue_len);
  translate([sprue_x,-10,4])rotate([0,90.0])cylinder(d=sprue_d, h= sprue_len);
  translate([sprue_x,-20,4])rotate([0,90.0])cylinder(d=sprue_d, h= sprue_len);
  translate([sprue_x,-30,4])rotate([0,90.0])cylinder(d=sprue_d, h= sprue_len);
}

//top_case();
pcb();
//pcb_hull();
//compose_top();
//compose_bottom();
//midi_port_cutouts();
//serial_port_cutout();
//standoff();
both_parts();

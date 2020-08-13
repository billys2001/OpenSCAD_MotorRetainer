$fn=50;
include <threads.scad>

Tube_Dia = 25.1;
Height = 10;
Thread_Thickness = 6;
Base_Height = 2.5;

Hole =20;
module MaleRetain(TD,Base_Height,Height,Thread_Thickness,Lead_In=0){
  Thread_Dia = TD + Thread_Thickness;
  Base_Dia = Thread_Dia+4;

  difference(){
    union(){
      translate([0,0,Base_Height])
        metric_thread (diameter=Thread_Dia, pitch=2, internal=false, length=Height, leadin=Lead_In);
      cylinder(d=Base_Dia, h=Base_Height, center=false);
      }
    cylinder(d=Tube_Dia, h=2*(Height+Base_Height+1), center=true);
    cylinder(d1=Tube_Dia+1, d2=Tube_Dia, h=Base_Height);
    translate([0,0,Base_Height+Height-2])
      cylinder(d=Tube_Dia+2, h=2+1,center=false);
  }
}



module FemaleRetain(TD,Base_Height,Height,Thread_Thickness,Hole, Lead_In,offset){
  Thread_Dia = TD + Thread_Thickness+offset;
  Base_Dia = Thread_Dia+4-offset;
  difference(){
    cylinder(d=Base_Dia, h=Base_Height+Height, center=false);
    cylinder(d=Hole, h=2*(Base_Height+Height)+1, center=true);
    translate([0,0,-.1])
    metric_thread (diameter=Thread_Dia, pitch=2, internal=true, length=Height, leadin=Lead_In);
    for (i=[0:30:359]) {
      translate([sin(i)*Base_Dia/2,cos(i)*Base_Dia/2,0])
        cylinder(r=1, h=2*(Base_Height+Height)+1, center=true);
    }
  }
}


for (i=[1:5]){
  translate([40*i,0,0])
    FemaleRetain(Tube_Dia,Base_Height,Height,Thread_Thickness,Hole,2,i*0.2);
}



/*
translate([0,0,0])
  FemaleRetain(Tube_Dia,Base_Height,Height,Thread_Thickness,Hole,2);
translate([50,0,0])
  MaleRetain(Tube_Dia,Base_Height,Height,Thread_Thickness,1);
translate([0,50,0])
  FemaleRetain(Tube_Dia,Base_Height,Height,Thread_Thickness,Hole,2);
translate([50,50,0])
  MaleRetain(Tube_Dia,Base_Height,Height,Thread_Thickness,1);

translate([0,-50,0])
  FemaleRetain(Tube_Dia,Base_Height,Height,Thread_Thickness,Hole);
translate([50,-50,0])
  MaleRetain(Tube_Dia,Base_Height,Height,Thread_Thickness);
  */

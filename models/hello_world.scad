$fn = 20;

font = "Nooble Wooble";
height = 40;
font_size = 180;

wall = 10;

// inserts
// adding 0.1 because different letters have different
// curves and thicknesses, so 0.1 allows some room for that
// the excess can be trimmed after printing if necessary.

insert_wall = 0.8 + 0.1;
insert_height = height/2;
insert_support_wall_sub = 1;

// distance difference for insert support = 1 mm
// this leaves a gap of insert 
// wall - 1.3mm leaves 0.5mm gap for the 0.8mm insert

support_wall_sub = wall - 1.3;

// bottom letters are thicker to support
// the top letters

bottom_height = height *2;

led_length = 20;
led_width = 30;
//led_height = height;
led_height = 15;

//cable pass trhough hole from top to bottom
pass_through_length = 10;
pass_through_width = 10;

h_x = 0;
e_x = 135;
l1_x = 268;
l2_x = 325;
o1_x = 379;

w_y = -190;
w_z = 0;

o2_x = 200;
o2_y = w_y; 

r_x = 353;
r_y = w_y;

l3_x = 497;
l3_y = w_y;

d_x = 552;
d_y = w_y;

exclamation_x = 703;
exclamation_y = w_y;

wall_mount_y_top = 120;
wall_mount_y_bottom = -85;

h();
//e();
//l1();
//l2();
//o1();

//w();
//o2();
//r();
//l3();
//d();
//exclamation();

//inserts
//h_insert();
//e_insert();
//l1_insert();
//l2_insert();
//o1_insert();

//w_insert();
//o2_insert();
//r_insert();
//l3_insert();
//d_insert();
//exclamation_insert();

// wall mount test
//difference(){
//    cube([20,20,5]);
//    translate([10,6,0])
//    wall_mount_hole();
//}

//lol1n hole test
//difference(){
//    cube([30,60,5]);
//    
//    translate([2.5,4,0])
//    lol1n_holes();
//}

module h(){
    difference(){
        letter("h",
               font,
               font_size,
               height,
               wall,
               support_wall_sub);
        
        translate([e_x - led_width/2 ,15,0])
        cube([led_width,led_length,led_height]);
        
        translate([20,-38,- wall])
        cube([pass_through_width,
              pass_through_length,
              height]);
        
        translate([25,wall_mount_y_top,0])
        wall_mount_hole();
    }
}

module h_insert(){
    letter("h",
       font,
       font_size,
       height,
       insert_wall);
}

module e(){
    difference(){
        // h and e cross section
        translate([e_x,0,0])
        letter("e",
               font,
               font_size,
               height,
               wall,
               support_wall_sub);
        
        letter("h",
               font,
               font_size,
               height,
               wall,
               support_wall_sub,
               hollow=false);
        
        translate([l1_x - led_width/2 ,0,0])
        cube([led_width,led_length,led_height]);
    }
}

module e_insert(){
    difference(){
        minkowski(){
            difference(){
                translate([e_x,0,0])
                make_text("e",
                          font,
                          font_size,
                          insert_height);

                letter("h",
                       font,
                       font_size,
                       height,
                       wall,
                       hollow=false);
            }
            
            cube(insert_wall, center=true);
        }
        
    minkowski(){
        difference(){
            translate([e_x,0,0])
            make_text("e",
                      font,
                      font_size,
                      insert_height);

            letter("h",
                   font,
                   font_size,
                   height,
                   wall,
                   hollow=false);
            }

    }
        translate([font_size*2 - font_size*2/2,
                   0,
                   height/2])
        cube([font_size*2,font_size*2,insert_wall+0.001],true);
    }
}

module l1(){
    difference(){
        // h and e cross section
        translate([l1_x,0,0])
        letter("l",
               font,
               font_size,
               height,
               wall,
               support_wall_sub);
        
        translate([e_x,0,0])
        letter("e",
               font,
               font_size,
               height,
               wall,
               support_wall_sub,
               hollow=false);
        
        translate([l1_x - led_width/2 ,0,0])
        cube([led_width,led_length,led_height]);
        
        translate([l2_x - led_width/2 ,-20,0])
        cube([led_width,led_length,led_height]);
    }
}

module l1_insert(){
    translate([l1_x,0,0])
    letter("l",
       font,
       font_size,
       height,
       insert_wall);
}

module l2(){
    difference(){
        // h and e cross section
        translate([l2_x,0,0])
        letter("l",
               font,
               font_size,
               height,
               wall,
               support_wall_sub);
        
        translate([l1_x,0,0])
        letter("l",
               font,
               font_size,
               height,
               wall,
               support_wall_sub,
               hollow=false);
        
        translate([l2_x - led_width/2 ,-20,0])
        cube([led_width,led_length,led_height]);
        
        translate([o1_x - led_width/2 ,20,0])
        cube([led_width,led_length,led_height]);
    }
}

module l2_insert(){
    translate([l2_x,0,0])
    letter("l",
       font,
       font_size,
       height,
       insert_wall);
}

module o1(){
    difference(){
        // h and e cross section
        translate([o1_x,0,0])
        letter("o",
               font,
               font_size,
               height,
               wall,
               support_wall_sub);
        
        translate([l2_x,0,0])
        letter("l",
               font,
               font_size,
               height,
               wall,
               support_wall_sub,
               hollow=false);
        
        translate([o1_x - led_width/2 ,20,0])
        cube([led_width,led_length,led_height]);
        
        translate([o1_x+ 70,wall_mount_y_top,0])
        wall_mount_hole();
    }
}

module o1_insert(){
    translate([o1_x,0,0])
    letter("o",
       font,
       font_size,
       height,
       insert_wall);
}

module w(){
    difference(){
        translate([0,w_y,w_z])
        letter("w",
               font,
               font_size,
               height,
               wall,
               support_wall_sub);
        
        translate([o2_x - 20 ,o2_y + 30,0])
        cube([led_width,led_length,led_height]);
        
        translate([20,-68,-wall])
        cube([pass_through_length,
              pass_through_width,
              height]);

        translate([95, w_y+80,0])
        LM2596_holes();
        
        translate([10,w_y+10,0])
        lol1n_holes();
        
        translate([25,wall_mount_y_bottom,0])
        wall_mount_hole();
    }
    

}


module w_insert(){
    translate([0,w_y,0])
    letter("w",
       font,
       font_size,
       height,
       insert_wall);
}


module o2(){
    difference(){
        // h and e cross section
        translate([o2_x,o2_y,0])
        letter("o",
               font,
               font_size,
               height,
               wall,
               support_wall_sub);
        
        translate([0,w_y,0])
        letter("w",
               font,
               font_size,
               height,
               wall,
               support_wall_sub,
               hollow=false);
               
        translate([o2_x - 20 ,o2_y + 30,0])
        cube([led_width,led_length,led_height]);
        
        translate([r_x - led_width/2 ,r_y + 35,0])
        cube([led_width,led_length,led_height]);
    }
    

}

module o2_insert(){
    translate([o2_x,o2_y,0])
    letter("o",
       font,
       font_size,
       height,
       insert_wall);
}

module r(){
    difference(){
        // h and e cross section
        translate([r_x,r_y,0])
        letter("r",
               font,
               font_size,
               height,
               wall,
               support_wall_sub);
        
        translate([o2_x,o2_y,0])
        letter("o",
               font,
               font_size,
               height,
               wall,
               support_wall_sub,
               hollow=false);
               
        translate([r_x - led_width/2 ,r_y + 35,0])
        cube([led_width,led_length,led_height]);
        
        translate([l3_x - 20 ,l3_y + 70,0])
        cube([led_width,led_length,led_height]);
    }
}

module r_insert(){
    translate([r_x,r_y,0])
    letter("r",
       font,
       font_size,
       height,
       insert_wall);
}

module l3(){
    difference(){
        translate([l3_x,l3_y,0])
        letter("l",
               font,
               font_size,
               height,
               wall,
               support_wall_sub);
        
        translate([r_x,r_y,0])
        letter("r",
               font,
               font_size,
               height,
               wall,
               support_wall_sub,
               hollow=false);
        
        translate([l3_x - 20 ,l3_y + 70,0])
        cube([led_width,led_length,led_height]);
        
        translate([d_x - 20 ,d_y-15,0])
        cube([led_width,led_length,led_height]);
    }
}

module l3_insert(){
    translate([l3_x,l3_y,0])
    letter("l",
       font,
       font_size,
       height,
       insert_wall);
}

module d(){
    difference(){
        translate([d_x,d_y,0])
        letter("d",
               font,
               font_size,
               height,
               wall,
               support_wall_sub);
        
        translate([l3_x,l3_y,0])
        letter("l",
               font,
               font_size,
               height,
               wall,
               support_wall_sub,
               hollow=false);
        
        translate([d_x - 20 ,d_y-15,0])
        cube([led_width,led_length,led_height]);
        
        translate([exclamation_x-15,
                   exclamation_y +70,
                   0])
        cube([led_width,led_length,led_height]);
    }
}

module d_insert(){
    translate([d_x,d_y,0])
    letter("d",
       font,
       font_size,
       height,
       insert_wall);
}

module exclamation(){
    difference(){
        translate([exclamation_x,exclamation_y,0])
        letter("!",
               font,
               font_size,
               height,
               wall,
               support_wall_sub);
        
        translate([d_x,d_y,0])
        letter("d",
               font,
               font_size,
               height,
               wall,
               support_wall_sub,
               hollow=false);
        
        translate([exclamation_x-15,
                   exclamation_y +70,
                   0])
        cube([led_width,led_length,led_height]);
        
        translate([exclamation_x+40,
                   exclamation_y ,
                   0])
        rotate(90)
        cube([led_width,led_length,led_height]);
        
        translate([exclamation_x + 35,
                   wall_mount_y_bottom,
                   0])
        wall_mount_hole();
        
        // power hole for dc adapter
        translate([exclamation_x+23, exclamation_y-20,wall-3])
        rotate([90,0,0])
        cylinder(r=11/2, h=height);
    }
    
    
    difference(){
        translate([exclamation_x+23,
                   exclamation_y-35,
                   7])
        rotate([180,0,0])
        color("red")
        dc_female_plug_insert();
        
        translate([exclamation_x+12,
                   exclamation_y-35,
                   8])
        cube([20,100,20]);
    }


    // dc_adapter_support
    difference(){
        translate([exclamation_x+14.5,
                   exclamation_y-35,0])
        cube([17.07,18.5,5]);
        
        difference(){
            translate([exclamation_x+23,
                       exclamation_y-35,
                       7])
            scale([1.2,1.2,1.2])
            rotate([180,0,0])
            dc_female_adapter();
        }
    }

}


module exclamation_insert(){
    translate([exclamation_x,exclamation_y,0])
    letter("!",
       font,
       font_size,
       height,
       insert_wall);
}

module wall_mount_hole(){
    insert_r = 8/2;
    slide_r = 4/2;
    slide_length = 10;
    
    cylinder(r = insert_r,
             h = height,
             center = true);

    hull(){
        cylinder(r = slide_r, h = height, center=true);
        
        translate([0,slide_length,0])
        cylinder(r = slide_r, h = height, center=true);
    }
}

module lol1n_holes(){
    
    // measure using caliper
    x_dist = 25;
    y_dist = 52;
    
    //m2.5 screws;
    screw_r = 2.75/2;
    
    cylinder(r=screw_r, h = height, center=true);
    
    translate([x_dist,0,0])
    cylinder(r=screw_r, h = height, center=true);
    
    translate([0,y_dist,0])
    cylinder(r=screw_r, h = height, center=true);
    
    translate([x_dist,y_dist,0])
    cylinder(r=screw_r, h = height, center=true);
}

module LM2596_holes(){
    y_dist = 30;
    x_dist = 15;
    
    standoff_r = 2.7/2;
    
    translate([0, 0, 0])
    cylinder(r=standoff_r, h=height, center=true);
    
    translate([x_dist, -y_dist, 0])
    cylinder(r=standoff_r, h=height, center=true);
}


module dc_female_plug_insert(){
    plug_r = 7/2;
    plug_h = 2.30;
    
    plug_depth = 32;
    
    plug_plastic_r = 10/2;
        
    plug_rect_height = 12;
    plug_rect_width = 14.30;
    
    
    inside_size = 1.05;
    outside_size = 1.2;
    
    wall_width = inside_size - outside_size;
    
    plug_front_r = plug_r * inside_size;
    
    holder_wall_width = 0.5;
    holder_width = 1.5;

    
    difference(){
        scale([outside_size, outside_size, outside_size]) {
            dc_female_adapter();
        }
        
       // plug tip
       rotate([90,0,0])
       translate([0,0,0])
       cylinder(r=plug_r * inside_size, h=plug_h);
        
       rotate([90,0,0])
       translate([0,0,plug_h])
       cylinder(r=plug_plastic_r * inside_size, h=plug_depth * inside_size);
        
        translate([0,-inside_size - outside_size -3 , 0])
        scale([inside_size,inside_size,inside_size]){
              dc_female_adapter();
            }
       }
       
    // back to hold it in place
    translate([plug_rect_width * inside_size /2 -holder_width +0.8,-plug_depth * inside_size - 1.45+ plug_h,0])
    cube([holder_width,holder_wall_width,plug_rect_height * outside_size], true);
       
    //translate([-plug_rect_width/2 - wall_width - holder_width/2,-plug_depth * outside_size + holder_wall_width,-7.2])
    //cube([holder_width,holder_wall_width,plug_rect_height * outside_size]);
    }
    

// this can be changeed to a cylinder for better consistency
module dc_female_adapter(){
    // these values need to be confirmed with a caliper
    
    plug_r = 7/2;
    plug_h = 2.30;
    
    plug_plastic_r = 10/2;
    plug_plastic_h = 5.5;
    
    // adding a bit more room to greate holder for insert
    room = 1;

    
    plug_rect_width = 14.30;
    plug_rect_height = 12;
    plug_rect_depth = 11;
    
    cone_h = 10;
    
    // tip of plug
    //rotate([90,0,0])
    //cylinder(r=plug_r, h=plug_h);
    
    // plastic after tip
    rotate([90,0,0])
    translate([0, 0,0])
    cylinder(r=plug_plastic_r , h=plug_rect_depth);
        
    // cone of plug with squared top
    
    //translate([0,- plug_h - plug_plastic_h- cone_h,0])
    translate([0,-plug_plastic_h- cone_h ,0])
    rotate([-90,0,0])
    hull(){
    rotate([90,0,0])
    cube([plug_rect_width,0.1, plug_rect_height], true);
        
    cylinder(r2=plug_plastic_r, h=cone_h);
    }
    
    difference(){
    
    // end of plug
    //translate([0,,plug_h - plug_plastic_h - cone_h- plug_rect_depth + 1])
    translate([0,-plug_plastic_h - cone_h - 6.0])
    cube([plug_rect_width,plug_rect_depth + room , plug_rect_height], true);
        
        
    translate([0,-plug_plastic_h - cone_h- 1.2 -10.79])
    cube([plug_rect_width -room -0.78, 2,plug_rect_height+ room], true);
    }
}


module letter(character,
              font,
              font_size,
              height,
              wall,
              support_wall_sub,
              hollow=true){
                  

    difference(){
        hollow_letter(character,
                      font,
                      font_size,
                      height,
                      wall,
                      hollow=hollow);
        
        if (hollow){
            translate([0,0,(wall/2)- height/2])
            support(character,
                    font,
                    font_size,
                    height,
                    wall,
                    support_wall_sub);
        }
    }
}

module make_text(character, font, font_size, height){
    linear_extrude(height=height)
    text(character,font_size,font);
}

module hollow_letter(character,
                     font,
                     font_size,
                     height,
                     wall,
                     support_wall_sub,
                     hollow =true){

    difference(){
        //container
        minkowski(){
            make_text(character,
                      font,
                      font_size,
                      height);
            
            cube([wall,wall,wall],center=true);
        }
        
        if (hollow){
            make_text(character,
                      font,
                      font_size,
                      height);
        }
    }
}

module support(character,
               font,
               font_size,
               height,
               wall,
               wall_sub){

    color("pink")
    translate([0,0,height])
    minkowski(){
        make_text(character, font, font_size, height);
        cube(wall - wall_sub,
              center=true);
        }
}
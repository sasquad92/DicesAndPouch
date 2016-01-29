camera
{
  orthographic
  up <0, 1, 0>
  right <1, 0, 0>
  location <0,40,0>
  look_at <0,0,0>
  angle 11
}

#include "colors.inc"

#declare threadthick=1.7;
#declare grad_h=4+threadthick*2;
#declare grad_off=grad_h/2;

#declare redpaint = texture { pigment { color rgb <1,0,0> } finish { ambient 0.5 } }
#declare heightgrad = texture {
  pigment {
    gradient y
    pigment_map {
      [0 color Black]
      [0.5 color Black]
      [1 color White]
    }
    scale grad_h*y translate grad_off*y
  }
  finish { ambient 1 }
}

background { color Black }

difference {
  torus { 2 threadthick rotate 90*x }
  box { <-5,-5,-5> <5,0,5> texture { redpaint } }
  translate <-2,0,-2>
  texture { heightgrad }
}
difference {
  torus { 2 threadthick rotate 90*z }
  box { <-5,0,-5> <5,5,5> texture { redpaint } }
  translate <-2,0,-2>
  texture { heightgrad }
}

difference {
  torus { 2 threadthick rotate 90*x }
  box { <-5,0,-5> <5,5,5> texture { redpaint } }
  translate <-2,0,2>
  texture { heightgrad }
}
difference {
  torus { 2 threadthick rotate 90*z }
  box { <-5,-5,-5> <5,0,5> texture { redpaint } }
  translate <-2,0,2>
  texture { heightgrad }
}

difference {
  torus { 2 threadthick rotate 90*x }
  box { <-5,0,-5> <5,5,5> texture { redpaint } }
  translate <2,0,-2>
  texture { heightgrad }
}
difference {
  torus { 2 threadthick rotate 90*z }
  box { <-5,-5,-5> <5,0,5> texture { redpaint } }
  translate <2,0,-2>
  texture { heightgrad }
}

difference {
  torus { 2 threadthick rotate 90*z }
  box { <-5,0,-5> <5,5,5> texture { redpaint } }
  translate <2,0,2>
  texture { heightgrad }
}
difference {
  torus { 2 threadthick rotate 90*x }
  box { <-5,-5,-5> <5,0,5> texture { redpaint } }
  translate <2,0,2>
  texture { heightgrad }
}

difference {
  torus { 2 threadthick rotate 90*x }
  box { <-5,-5,-5> <5,0,5> texture { redpaint } }
  translate <-6,0,2>
  texture { heightgrad }
}
difference {
  torus { 2 threadthick rotate 90*x }
  box { <-5,-5,-5> <5,0,5> texture { redpaint } }
  translate <6,0,-2>
  texture { heightgrad }
}
difference {
  torus { 2 threadthick rotate 90*z }
  box { <-5,-5,-5> <5,0,5> texture { redpaint } }
  translate <-2,0,-6>
  texture { heightgrad }
}
difference {
  torus { 2 threadthick rotate 90*z }
  box { <-5,-5,-5> <5,0,5> texture { redpaint } }
  translate <2,0,6>
  texture { heightgrad }
}

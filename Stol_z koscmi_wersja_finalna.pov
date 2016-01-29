//------------------------------------------------------------------------
#version 3.7;
global_settings{ assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 }} 
//------------------------------------------------------------------------
#include "colors.inc"
#include "textures.inc"
#include "glass.inc"
#include "metals.inc"
#include "golds.inc"
#include "stones.inc"
#include "woods.inc"
#include "shapes.inc"
#include "shapes2.inc"
#include "shapes3.inc"
#include "functions.inc"
#include "math.inc"
#include "transforms.inc"
//------------------------------------------------------------------------   
      
//--------------------------------------------------------------------------
//---------------------------- kamery --------------------------------------
//--------------------------------------------------------------------------


#declare Camera_0 = camera {/*ultra_wide_angle*/ angle 15      //kamera z boku sto³u
                            location  <0.0 , 5.0 ,-30.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 4.0 , 0.0>}
#declare Camera_1 = camera {/*ultra_wide_angle*/ angle 14   //kamera na blat
                            location  <8.0 , 7.0 ,-6.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 4 , 0.0>}
#declare Camera_2 = camera {/*ultra_wide_angle*/ angle 90  //kamera #1 na koœæ
                            //location  <0, 0.25, 0.25>  
                            location <0,0,0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 0.1 , 0.0>}
#declare Camera_3 = camera {/*ultra_wide_angle*/ angle 90        //kamera #2 na koœæ
                            location  <-0.2 , 0.2 ,-0.2>
                            right     x*image_width/image_height
                            look_at   <0.0 , 0.0 , 0.0>}   
#declare Camera_4 =  camera {/*ultra_wide_angle*/ angle 14   //kamera na blat
                            location  <5.0 , 6.0 ,-1.0>
                            right     x*image_width/image_height
                            look_at   <0.5 , 4 , 0.3>}
#declare Camera_5 =  camera {/*ultra_wide_angle*/ angle 100       //kamera #3 na koœæ
                            location  <-0.4 , 4.7 ,-0.6>
                            right     x*image_width/image_height
                            look_at   <0.0 , 4.3 , 0.0>}
camera{Camera_5}  

                                    
//--------------------------------------------------------------------------
//---------------------------- tekstury ------------------------------------
//--------------------------------------------------------------------------                                     


#declare drewno=texture{ 
                        Rosewood     
                        finish { phong 1} 
                        rotate<60,0,45> scale 0.5
                      }
#declare drewno2=texture{
                         T_Wood4     
                         finish { phong 1 } 
                         rotate<0,0,0> scale 0.04 translate<0,0,0>
                         }

#declare drewno3= texture{
                          DMFWood5    
                          normal { wood 0.125 scale 0.05 turbulence 0.0 rotate<0,0,0> }
                          finish { phong 1 } 
                          rotate<0,0,0> scale 1  translate<0,0,0>
                         }
               
#declare szklo_zielone=texture{
                               NBwinebottle 
                               pigment {rgb<0.1,1,0.1>}
                               }
                        
#declare szklo_czerwone=texture{
                                 Ruby_Glass
                                } 
 
#declare granit_czarny=texture{ 
                               T_Grnt15
                               finish { phong 0.5 } 
                               scale 1 
                               } 
   
#declare granit_bialy=texture{
                              T_Grnt9
                              finish { phong 0.5 } 
                              scale 1 
                             }               
            
#declare granit_zielony=texture{ 
                                pigment{ Jade } 
                                normal { bumps 0.5 scale 0.05}
                                finish { phong 1} 
                                scale 0.25 
                                } 
                                
#declare szklo_zolte=texture{
                             Yellow_Glass 
                             pigment {rgb<1,0.9,0>}
                             }
#declare szklo_niebieskie= texture{
                                   Dark_Green_Glass
                                   }
//tekstury worka            
#declare H_streaks = pigment { bozo color_map { [0.2 color rgb <0.4,0.3,0.2>] [0.8 color rgb <0.9,0.8,0.7>] } scale <10,0.1,1> }
#declare V_streaks = pigment { bozo color_map { [0.2 color rgb <0.4,0.3,0.2>] [0.8 color rgb <0.9,0.8,0.7>] } scale <0.1,10,1> }
      
#declare fabric = texture {
  pigment { checker pigment { H_streaks } pigment { V_streaks } scale 0.5*0.07 }
 normal { bump_map { png "./fabricbumps.png" bump_size 50 } scale 0.05 }
  finish { diffuse 0.8 specular 0.2 }
}

//--------------------------------------------------------------------------
//---------------------------- œwiat³o i scena -----------------------------
//--------------------------------------------------------------------------
   
light_source{<1500,2500,-2500> color White}


sky_sphere{pigment{ gradient <0,1,0>
                     color_map{ [0   color rgb<1,1,1>         ]//White
                                [0.4 color rgb<0.14,0.14,0.56>]//~Navy
                                [0.6 color rgb<0.14,0.14,0.56>]//~Navy
                                [1.0 color rgb<1,1,1>         ]//White
                              }
                     scale 2 }
           } 
          
           
           
  
 /*
//-----------------plaszczyzna xyz z podzia³k¹ do testow-------------------------       
//---------------------------------<<< settings of squared plane dimensions
#declare RasterScale = 1.0;
#declare RasterHalfLine  = 0.035;  
#declare RasterHalfLineZ = 0.035; 
//-------------------------------------------------------------------------
#macro Raster(RScale, HLine) 
       pigment{ gradient x scale RScale
                color_map{[0.000   color rgbt<1,1,1,0>*0.6]
                          [0+HLine color rgbt<1,1,1,0>*0.6]
                          [0+HLine color rgbt<1,1,1,1>]
                          [1-HLine color rgbt<1,1,1,1>]
                          [1-HLine color rgbt<1,1,1,0>*0.6]
                          [1.000   color rgbt<1,1,1,0>*0.6]} }
 #end// of Raster(RScale, HLine)-macro    
//-------------------------------------------------------------------------
    

plane { <0,1,0>, 0    // plane with layered textures
        texture { pigment{color White*1.1}
                  finish {ambient 0.45 diffuse 0.85}}
        texture { Raster(RasterScale,RasterHalfLine ) rotate<0,0,0> }
        texture { Raster(RasterScale,RasterHalfLineZ) rotate<0,90,0>}
        rotate<0,0,0>
      }
//------------------------------------------------ end of squared plane XZ  

*/

//----------------------------------------------------------------------------------------
//-------------------Scena z pe³nym pokojem, dlugie renderowanie-------------------------
//----------------------------------------------------------------------------------------

 

 global_settings { assumed_gamma 1 }
 //camera { location <14.9, 9, -5> look_at z angle 70 }
 camera{Camera_5}  
 //oswietlenie za oknem
 light_source { <10,100,150>, 1 }
 background { rgb <0.3, 0.6, 0.9> }

 //oœwietlenie pokoju
 light_source { <5, 12, 2>, 0.5 media_interaction off }

 // Pokój
 union
 { difference   
 //bryla pokoju
   { box { <-11, 0, -11>, <16,14, 10.5> }
     box { <-10, 1, -10>, <15, 13, 10> } 
        
     
     //wyciecie okna
     box { <-4, 5, 9.9>, <2, 10, 10.6> }  
        texture{ pigment{ color rgb<0.76,0.75,1>} 
                normal { bozo 8.5 scale 0.050 }
                finish { phong 1 reflection{ 0.05 } }
              } // end of texture
              
   } 
   //krzyz w oknie
   box { <-1.25, 5, 10>, <-0.75, 10, 10.5> texture{ drewno }} 
   
   box { <-4, 7.25, 10>, <2, 8, 10.5> texture{ drewno }}
   pigment { rgb 1 }
 } 
 //ulepszenie œwiat³a zza okna 
 box
 { <-5, 0, -10.5>, <3, 12.5, 10.25>
   pigment { rgbt 1 } hollow
   interior
   { media
     { scattering { 1, 0.07 extinction 0.01 }
       samples 30
     }
   }
 }  
         // */
//--------------------------------------------------------------------------
//---------------------------- deklaracje ----------------------------------
//--------------------------------------------------------------------------


//------------------------------------stó³---------------------------------
//noga od sto³u                                                         
#declare noga=cylinder { <0,0,0>,<0,4.00,0>, 0.30 
           
           scale <1,1,1> 
           rotate<0,0,0> 
           translate<0,0,0>
}

//blat sto³u
#declare blat=box { <-4.60, 4.00, -2.80>,< 4.60, 4.3, 2.80>   
      
      scale<1,1,1>
      rotate<0,0,0>
      translate<0,0,0>  
}
#declare wysokosc_stolu=4.3;


//-----------------------------cyfry na koœciach---------------------------
#declare cyfra1=text {
    ttf "timrom.ttf" "1" 0.1, 0
    scale<0.1,0.1,0.1>
}  
#declare cyfra2=text 
{
    ttf "timrom.ttf" "2" 0.1, 0
    scale<0.1,0.1,0.1>
}
#declare cyfra3=text 
{
    ttf "timrom.ttf" "3" 0.1, 0
    scale<0.1,0.1,0.1>
}
#declare cyfra4=text 
{
    ttf "timrom.ttf" "4" 0.1, 0
    scale<0.1,0.1,0.1>
}
#declare cyfra5=text 
{
    ttf "timrom.ttf" "5" 0.1, 0
    scale<0.1,0.1,0.1>
}
#declare cyfra6=text 
{
    ttf "timrom.ttf" "6." 0.1, 0
    scale<0.1,0.1,0.1>
} 
//tablice z numerami na koœci wieloœcienne   
#declare num_gorna_polowa_k10 = array[5] {"0", "4", "6", "2", "8"}
#declare num_dolna_polowa_k10 = array[5] {"7", "1", "9", "5", "3"}
#declare num_gorna_polowa_k100 = array[5] {"00", "40", "60", "20", "80"}
#declare num_dolna_polowa_k100 = array[5] {"70", "10", "90", "50", "30"}


//--------------------------¿³obienia na koœciach---------------------------
#declare zewn=1.25; //kropka_przesuniecie_na_zewnatrz 
#declare na_scianie=0.475;  //kropka_przesuniecie_na_scianie 

#declare kropka=sphere{ 0,0.3
              texture { granit_bialy}

}


// ---------------------------------- koœci --------------------------------   

//koœæ k6 - bry³a  
#declare kosc_k6= box { <-1.00, 0.00, -1.00>,< 1.00, 2.00, 1.00>   

      scale <0.05,0.05,0.05> rotate<0,0,0> translate<0,0,0> 
} 
 
//koœæ k6 z kropkami -bry³a
#declare bryla_kostka_6=superellipsoid {
        <0.25, 0.25>                       
    }

//koœæ k4 - bry³a
#declare  kosc_k4 = object{ Tetrahedron  
        scale <1,1,1>*0.045  rotate<0,0,0> translate<0,0,0>
}

//tworzenie po³owy koœci wieloœciennej na bazie ostros³upa
#declare sciany = 5;
#declare wysokosc = .5;
#declare pochylenie = -37;
#declare obrot_scian = 360/sciany;
#declare numer_sciany = sciany;
    
#declare polowa_kostki_wielosciennej=intersection{
        #while (numer_sciany > 0)
            plane {
                z, 0
                rotate <pochylenie, 0, 0>
                rotate <0,obrot_scian*numer_sciany,0>
                translate <0,wysokosc,0>
            }
            #declare numer_sciany = numer_sciany- 1;
        #end
  
    }  
    
//koœæ k10- bry³a
#declare kostka_10=intersection{
    object{polowa_kostki_wielosciennej texture {granit_czarny} }
    object{polowa_kostki_wielosciennej scale <1,-1,1> rotate <0,obrot_scian/2,0> texture {granit_czarny} }
     
} 

//koœæ k100- bry³a
#declare kostka_100=intersection{
    object{polowa_kostki_wielosciennej texture {granit_bialy} }
    object{polowa_kostki_wielosciennej scale <1,-1,1> rotate <0,obrot_scian/2,0> texture {granit_bialy} }
     
} 
//-------------------------------------worek------------------------------- 
//czesc dolna
#declare bag = sor{
  11,
  <0.360,0.000>,   //radius, height
  <0.380,0.120>,
  <0.400,0.240>,
  <0.380,0.360>,
  <0.340,0.480>,
  <0.280,0.600>,
  <0.200,0.720>,
  <0.140,0.840>,
  <0.070,0.960>,
  <0.140,1.080>,
  <0.140,1.100>
  
     scale 1.0  rotate<0,0,0> translate<0,-0.12,0>
   }
   
//wyciecie gornej czesci    
#declare wycinek = intersection { 
   box{ <-2,0,-2.5>,<2.5, 4.00,2.5> }
   object{ Paraboloid_Y }  

   scale <1,1,1>*0.5 rotate<0,0,0> translate<0,0.00,0.0>
} 

//----------------------------------wiazanie--------------------------------
//petla na worku
#declare sznurek = torus { 0.08,0.02 
        texture { pigment{ color rgb <0,0.0,0.0>}  
                  finish { phong 1 reflection { 0.00 metallic 0.50} }
                } // end of texture
        scale <1,1,1> rotate<0,0,0> translate<0,0.830,0>
      }
//petla kokardy  
#declare petla=object{Round_Conic_Torus( 1.00, 0.80, 0.50, 0.10, 0) 
         texture{ pigment{ color rgb<0,0,0>}
                  finish { phong 1}
          }
          scale<1,1,1>  rotate<0,0,0>  translate<0,0,0>
       }  
//zwis kokardy cz.1       
#declare Ball = 
 sphere{<0,0,0>,0.01 
        scale <1,1,1>
        rotate<0,0,0> 
        translate<0,0,0>
	        texture{pigment{ color rgb<0,0,0>}
                finish { phong 1}
                    }
        }
//zwis kokardy cz.2  
#declare sznurek2=union{
  #declare start=0;
  #declare rozdz=200;
  #declare koniec=2;
        #while(start<rozdz*koniec)
                object{Ball translate <start*0.25/rozdz,0,0>
                rotate <0,0,12/rozdz*start>}
                #local start=start+1;
         #end 

}
//---------------------------------------------------------------------------- 
  
//----------------------------------------------------------------------------
//------------------------------Z£O¯ENIA KOŒCI--------------------------------
//----------------------------------------------------------------------------  

//---------------------------------koœæ k4 - ca³oœæ----------------------------      
#declare k4 = union{                     
difference{
    object {kosc_k4}
    object {cyfra1 pigment { Gold }scale <1,1,1>*0.5 rotate<19.5,0,0>  translate <-0.01,0.01,-0.048>} // #1  
    object {cyfra2 pigment { Gold }scale <1,1,1>*0.5 rotate<-8,-19.5,120> translate<0.03,0.06,-0.031>} // #1    
    object {cyfra4 pigment { Gold }scale <1,1,1>*0.5 rotate<-8,19.5,-120> translate<-0.03,0.075,-0.025>} // #1
    
    
    object {cyfra1 pigment { Gold }scale <1,1,1>*0.5 rotate<19.5,0,0>  translate <-0.01,0.01,-0.048> rotate<0,120,0>} // #2  
    object {cyfra3 pigment { Gold }scale <1,1,1>*0.5 rotate<-8,-19.5,120> translate<0.035,0.06,-0.031> rotate<0,120,0>} // #2    
    object {cyfra2 pigment { Gold }scale <1,1,1>*0.5 rotate<-8,19.5,-120> translate<-0.03,0.075,-0.025> rotate<0,120,0>} // #2


    object {cyfra1 pigment { Gold }scale <1,1,1>*0.5 rotate<19.5,0,0>  translate <-0.01,0.01,-0.048> rotate<0,-120,0>} // #3  
    object {cyfra4 pigment { Gold }scale <1,1,1>*0.5 rotate<-8,-19.5,120> translate<0.037,0.06,-0.031> rotate<0,-120,0>} // #3    
    object {cyfra3 pigment { Gold }scale <1,1,1>*0.5 rotate<-8,19.5,-120> translate<-0.03,0.075,-0.025> rotate<0,-120,0>} // #3
       

    object {cyfra3 pigment { Gold }scale <1,1,1>*0.5 rotate<-90,180,0>  translate <0.01,-0.048,-0.043>} // #4  
    object {cyfra2 pigment { Gold }scale <1,1,1>*0.5 rotate<-90,60,0> translate<0.035,-0.048,0.03>} // #4    
    object {cyfra4 pigment { Gold }scale <1,1,1>*0.5 rotate<-90,-60,0> translate<-0.045,-0.048,0.01>} // #4
    }
} 

//-----------------------------koœæ k6 - ca³oœæ-------------------------------
#declare k6 = union{    
difference{
    object {kosc_k6} 
    object {cyfra1 pigment {Red }rotate<0,90,0>  translate <-0.058,0.02,0.01>}
    object {cyfra2 pigment {Red }rotate<0,-90,-90> translate<-0.035,-0.008,-0.03>}
    object {cyfra3 pigment {Red }translate <-0.02,0.02,-0.058>}
    object {cyfra4 pigment {Red }rotate<180,0,-90> translate<0.035,0.078,0.058>}
    object {cyfra5 pigment {Red }rotate<0,90,-90> translate<-0.035,0.108,0.02>}
    object {cyfra6 pigment {Red }rotate<0,-90,0> translate<0.058,00.02,-0.02>}
    }
}
//-----------------------koœæ k6_z kropkami - ca³oœæ------------------------- 
#declare kostka_6=union{
 difference {
    object { bryla_kostka_6}  
      //1
      object { kropka translate <0,0,-zewn> }  
      //2  
      object { kropka translate <-na_scianie,-zewn,-na_scianie> } 
      object { kropka translate <na_scianie,-zewn,na_scianie> } 
      //3 
      object { kropka translate <zewn,-na_scianie,-na_scianie> } 
      object { kropka translate <zewn,na_scianie,na_scianie> } 
      object { kropka translate <zewn,0,0> } 
      //4                                    
      object { kropka translate <-zewn,-na_scianie,-na_scianie> } 
      object { kropka translate <-zewn,-na_scianie,na_scianie> } 
      object { kropka translate <-zewn,na_scianie,na_scianie> } 
      object { kropka translate <-zewn,na_scianie,-na_scianie> } 
      //5                                     
      object { kropka translate <0,zewn,0> } 
      object { kropka translate <-na_scianie,zewn,-na_scianie> } 
      object { kropka translate <-na_scianie,zewn,na_scianie> } 
      object { kropka translate <na_scianie,zewn,-na_scianie> } 
      object { kropka translate <na_scianie,zewn,na_scianie> } 
      
      //6 
      object { kropka translate <0,-na_scianie,zewn> } 
      object { kropka translate <0,na_scianie,zewn> } 
      object { kropka translate <-na_scianie,-na_scianie,zewn> } 
      object { kropka translate <na_scianie,-na_scianie,zewn> } 
      object { kropka translate <-na_scianie,na_scianie,zewn> } 
      object { kropka translate <na_scianie,na_scianie,zewn> } 
        
        scale <1,1,1>*0.05 
        translate <0,0.05,0>
        }
}
                          

//--------------------------------kosc k10 - ca³oœæ-------------------------------
#declare k10 = union{
 difference {       
object {kostka_10 rotate<0,0,0> translate <0,0,0>} 

//bry³a      
#declare numer_sciany = sciany;  
   
    #while (numer_sciany > 0)

        #declare numer_gorny_k10 = num_gorna_polowa_k10[numer_sciany-1]
        #declare numer_dolny_k10 = num_dolna_polowa_k10[numer_sciany-1]
            //gorne numery
            text {
                ttf "timrom",
                numer_gorny_k10
                wysokosc/10, 0
                translate <-.25,0,0>
                scale .35
                scale <-1,1,1>
                translate <0, 0, wysokosc/1.6>
                rotate <pochylenie,0,0>
                translate <0, -wysokosc*.3,.08>
                rotate <0,-obrot_scian*numer_sciany,0>
                    pigment {
                        color Gold
                    }    
                }
            //dolne nummery
            text {
                ttf "timrom"
                numer_dolny_k10
                wysokosc/10, 0
                translate <-.25,0,0>
                scale .35
                scale <-1,1,1>
                translate <0,0, wysokosc/1.6>
                rotate <-pochylenie,0,0>
                translate <0, -wysokosc*.18, -.1>
                rotate <0, 180-obrot_scian*numer_sciany,0>
                    pigment {
                        color Gold
                    }
                }
      
        #declare numer_sciany = numer_sciany - 1;
    #end 
    }
  scale <1,1,1>*0.17
  translate <0,0.085,0>
 }  
 
//-------------------------------kosc k100 - ca³oœæ---------------------------------
#declare k100 = union{

//bry³a       
object {kostka_100 rotate<0,0,0> translate <0,0,0>} 
    
#declare numer_sciany = sciany;

    #while (numer_sciany > 0)

        #declare numer_gorny_k100 = num_gorna_polowa_k100[numer_sciany-1]
        #declare numer_dolny_k100 = num_dolna_polowa_k100[numer_sciany-1]
            //gorne numery
                text {
                    ttf "timrom",
                    numer_gorny_k100
                    wysokosc/10, 0
                    translate <-.5,0,0>
                    scale .30
                    scale <-1,1,1>
                    translate <0, 0, wysokosc/1.6>
                    rotate <pochylenie,0,0>
                    translate <0, -wysokosc*.3,.08>
                    rotate <0,-obrot_scian*numer_sciany,0>
                        pigment {
                            color Black
                        }    
                    }
            //dolne nummery
                text {
                    ttf "timrom"
                    numer_dolny_k100
                    wysokosc/10, 0
                    translate <-.5,0.3,0>
                    scale .3
                    scale <-1,1,1>
                    translate <0,0, wysokosc/1.6>
                    rotate <-pochylenie,0,0>
                    translate <0, -wysokosc*.18, -.1>
                    rotate <0, 180-obrot_scian*numer_sciany,0>
                        pigment {
                            color Black
                        }
                    }
      
        #declare numer_sciany = numer_sciany - 1;

    #end
    
  scale <1,1,1>*0.17
  translate <0,0.085,0>
} 
//----------------------------------------------------------------------------
//------------------------------Z£O¯ENIE WORKA--------------------------------
//----------------------------------------------------------------------------

//--------------------------------worek - caloœæ--------------------------------
#declare worek=difference {
object {bag texture {fabric} rotate<0,0,0> translate <0,0,0>}
object {wycinek texture {fabric} scale<1,1,1>*0.18 translate<0,0.8,0>}    
}
//-------------------------------sznurek - ca³oœæ------------------------------
#declare wiazanie=union{
object {sznurek rotate<0,0,0> translate<0,0,0>}
object {petla  scale<1,1,1>*0.1 rotate<0,-36,120>translate<-0.05,0.82,-0.08>}
object {petla  scale<1,1,1>*0.1  rotate<0,36,-120>translate<0.05,0.82,-0.08>}
object{sznurek2 rotate<0,36,-144> translate<0,0.82,-0.08>}
object{sznurek2 rotate<180,36,180+144> translate<00,0.82,-0.08>} 
}

#declare sakiewka=union{
object{wiazanie}
object{worek}
} 
//----------------------------------------------------------------------------
//------------------------------Z£O¯ENIE STO£U--------------------------------
//----------------------------------------------------------------------------

#declare stol = union{ 
object {noga translate <-4,0,-2>}
object {noga translate <4,0,-2>}
object {noga translate <4,0,2>}
object {noga translate <-4,0,2>}
object {blat}
texture{drewno3}
}


//--------------------------------------------------------------------------
//---------------------------- obiekty na scenie ---------------------------
//--------------------------------------------------------------------------


object {stol}  
union{ 

object {k6 texture {granit_zielony} rotate<0,0,0> translate <0, wysokosc_stolu, 0>}  
object {k6 texture {szklo_zolte} rotate<0,45,180> translate <0, wysokosc_stolu+0.1, 0.5>}      
object {k4 texture {szklo_niebieskie} rotate <0,0,0> translate<0.2,wysokosc_stolu,0.2>} 
object {kostka_6 texture {granit_czarny} rotate<0,35,0> translate <-0.2,wysokosc_stolu,0.2>}
object {kostka_6 texture {szklo_zielone} rotate<0,0,0> translate <-0.2,wysokosc_stolu,-0.2> }
object {kostka_6 texture {szklo_czerwone} rotate<0,240,0> translate <0.3,wysokosc_stolu,0.5> }
object {k100 rotate<-(90+pochylenie),120,0> translate <0.5,wysokosc_stolu,0.3>}  
object {k10 rotate<-(90+pochylenie),0,0> translate <-.2,wysokosc_stolu,0.8>}
object {k10 rotate<(90+pochylenie),55,0> translate <0.2,wysokosc_stolu,-0.2>} 
object {sakiewka scale <1,1,1>*0.4 rotate<0,30,0> translate <0.6,wysokosc_stolu,0>} 
}



import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import controlP5.*; 
import java.util.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class puzzle8 extends PApplet {



ControlP5 cp5; 
String input = "";
String output = "";
String edoIn = "";
String edoFin = "";
String[] lines ;
String respuesta =""; 
PImage bg;
int y;
PrintWriter infi, respt;
boolean cond = true;
char var1=' ', var2=' ', var3=' ', var4=' ', var5=' ', var6=' ', var7=' ', var8=' ', var9=' '; 
char var11=' ', var22=' ', var33=' ', var44=' ', var55=' ', var66=' ', var77=' ', var88=' ', var99=' '; 
public void setup(){
  
  cp5 = new ControlP5(this);
  cp5.addTextfield("input").setPosition(350,100).setSize(100,50).setAutoClear(false);
  cp5.addTextfield("output").setPosition(450,100).setSize(100,50).setAutoClear(false);
  cp5.addBang("submit").setPosition(550,100).setSize(100,50);
  
  //bg = loadImage("puzz.jpg");
}

public void draw(){
  background(145);
  textSize(16);
  text("Puzzle8",470,50);
  text("Estado Inicial",295, 200);
  text("Estado Final",605,200);
  text(respuesta,25,350);

  fill(0,0,0); 
  line(300,220,300,310); 
  line(330,220,330,310); 
  line(360,220,360,310); 
  line(390,220,390,310); 
  
  line(300,220,390,220); 
  line(300,250,390,250); 
  line(300,280,390,280); 
  line(300,310,390,310); 
  
  line(610,220,610,310); 
  line(640,220,640,310); 
  line(670,220,670,310); 
  line(700,220,700,310); 
 
  line(610,220,700,220); 
  line(610,250,700,250); 
  line(610,280,700,280); 
  line(610,310,700,310); 
  
  
  text(var1,310,240); 
  text(var2,340,240); 
  text(var3,370,240); 
  text(var4,310,270); 
  text(var5,340,270); 
  text(var6,370,270); 
  text(var7,310,300); 
  text(var8,340,300); 
  text(var9,370,300); 
  text(var11,620,240); 
  text(var22,650,240); 
  text(var33,680,240); 
  text(var44,620,270); 
  text(var55,650,270); 
  text(var66,680,270); 
  text(var77,620,300); 
  text(var88,650,300); 
  text(var99,680,300); 
  
  
}

public void submit(){
  println("Puzzle8 inicial:");
  input=cp5.get(Textfield.class,"input").getText();
  output=cp5.get(Textfield.class,"output").getText();
  
  var1 = input.charAt(0);
  var2 = input.charAt(1);
  var3 = input.charAt(2);
  var4 = input.charAt(3);
  var5 = input.charAt(4);
  var6 = input.charAt(5);
  var7 = input.charAt(6);
  var8 = input.charAt(7);
  var9 = input.charAt(8);
  
  var11 = output.charAt(0);
  var22 = output.charAt(1);
  var33 = output.charAt(2);
  var44 = output.charAt(3);
  var55 = output.charAt(4);
  var66 = output.charAt(5);
  var77 = output.charAt(6);
  var88 = output.charAt(7);
  var99 = output.charAt(8);
  
  edoIn='('+str(var1)+' '+str(var2)+' '+str(var3)+')'+'('+str(var4)+' '+str(var5)+' '+str(var6)+')'+'('+str(var7)+' '+str(var8)+' '+str(var9)+')';
  edoFin='('+str(var11)+' '+str(var22)+' '+str(var33)+')'+'('+str(var44)+' '+str(var55)+' '+str(var66)+')'+'('+str(var77)+' '+str(var88)+' '+str(var99)+')';
  println(edoIn);
  println(edoFin);
  
  infi = createWriter("./input.txt");
  infi.println(edoIn);
  infi.println(edoFin);
  infi.flush();
  infi.close();

  String [] res = loadStrings("./output.txt");

  println(res.length);

  int j=0;
  while(res.length==1 && res[0].length()==12 && j<100){
    delay(500);
    res = loadStrings("./output.txt");
    j++;
    print(j);
    respuesta="Buscando solucion...";
  }
  
  infi = createWriter("./input.txt");
  infi.println("");
  infi.flush();
  infi.close();
  
  respuesta="";
  if(res.length==0)
    respuesta="NO HAY SOLUCION";
  else{
  for (int i = 1; i < res.length; i = i+1) {
    
      if(res[i].charAt(1) == '1')
        respuesta  = respuesta + " Abajo,";
      else if(res[i].charAt(1) == '2')
        respuesta  = respuesta + " Arriba,";
      else if(res[i].charAt(1) == '3')
        respuesta  = respuesta + " Derecha,";
      else if(res[i].charAt(1) == '4')
        respuesta  = respuesta + " Izquierda,";
      if(i % 13 == 0)
        respuesta = respuesta + "\n"; 
      print(respuesta); 
    
    }
  }
    
 
    
}
  public void settings() {  size(1000,700); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "puzzle8" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}


class timer{
  int past;
  int now;
  int duration;
  boolean alarm = false;
  timer(int d){
    this.duration = d;
  }
  void trip(){
    past = millis();
    alarm = false;
  }
  void update(){
   now = millis();
   if(now - past > duration){
     alarm = true;
   }
  }
}

final int size = 20;
class snake{
  ArrayList<PVector> tail;
  boolean isGrowing = false;
  int x, y;
  int vx,vy,tvx,tvy;
  food Foo = new food();
  snake(int x,int y){
   tail = new ArrayList();
   this.x = x;
   this.y = y;
   this.vx = 0;
   this.vy = 0;
  }
  void collision(){
   if(tail.contains(new PVector(x,y))){
     int cut_point = tail.indexOf(new PVector(x,y));
     for(int i = 0;i < cut_point;i++){
       tail.remove(i);
     }
     cut_point = 0;
   }
  }
  void setvel(int x,int y){
    vx = x;
    vy = y;
  }
  
  final void draw() {
   if(tz.alarm){
     fill(0);
     textFont(Font,40);
     text(str(S.tail.size()),0,60);
     Foo.draw();
     fill(0,255,0);
     rect(x,y,20,20);
     for(int i = 0;i < tail.size();i++){
        rect((int)(tail.get(i).x),(int)(tail.get(i).y),size,size);
     }   
     update();
   }

  }
  void move(int vx, int vy){
    if(tz.alarm){
         x += vx * size;
         y += vy * size;
       if(x/size >= 20)
         x = 0*size;
       else if(x/size < 0)
         x = 20*size;
       else if(y/size >= 20)
         y = 0*size;
       else if(y/ size < 0)
         y = 20 * size;
       tz.trip();
     }
     
   }
  
  boolean isEat(){
     if(x/size == Foo.ax && y/size == Foo.ay){
        Foo.update();
        return true;
     }
     else
        return false;
  }
  void update(){
      tail.add(new PVector(x,y));
      tt.update();
      tz.update();
      isGrowing = isEat();
      if(isGrowing){
        isGrowing= false;
      }
      else{
         tail.remove(0);
      }
      move(vx,vy);
      collision();
   }
  public void print_tail(){
     for(int i = 0;i < tail.size();i++){
       print(tail.get(i).x,tail.get(i).y);
     }
  }
  void clrscr(){
    if(tz.alarm){
     fill(200);
     rect(0,0,400,400);
    }
  }
}


class food{
    int ax;
    int ay;
    snake s;
   food(){
    this.ax = (int)random(20);
    this.ay = (int)random(20);
   }
   public void update(){
      this.ax = (int)random(20);
      this.ay = (int)random(20);
   }
   public void draw(){
     fill(255,0,0);  
     rect(ax*size,ay*size,size,size); 
   }
}
snake S;
timer tt;
timer tz = new timer(100);
PFont Font;
void setup(){
  size(400,400);
  stroke(0);
  S = new snake(10*size,10*size);
  tt = new timer(80);
  tz.trip();
  tt.trip();
  fill(100);
  S.setvel(0,0);
  Font = createFont("Chilanka",16,true);
}
void draw(){
  S.clrscr();
  S.draw();
  tz.update();
}
int cnt = 0;
void keyPressed(){
 if(key == CODED && tt.alarm){
   switch(keyCode){
      case DOWN:
        if(S.vy != -1){
          S.setvel(0,1);
        }
        break;
      case RIGHT:
        if(S.vx != -1){
          S.setvel(1,0);
        }
        break;
      case UP:
        if(S.vy != 1){
          S.setvel(0,-1);
        }
        break;
      case LEFT:
        if(S.vx != 1){
          S.setvel(-1,0);
        }
        break;
      }
      tt.trip();
   }
}

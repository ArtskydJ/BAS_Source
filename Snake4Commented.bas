'snake.bas

 'First, please note, I have subroutines. This makes the code modular, and much easier to read.
 'When I write "Intro", "SelectGameplay", etc. it will go to "sub Intro", and "sub SelectGameplay", etc.

Intro                               'Go to sub Intro, it shows who made the game and creates some variables
SelectGameplay                      'Go to sub SelectGameplay, it lets you select what type of gameplay you want
while slct!=0                      'This is the "everything" loop
  MakeSnake                         'Go to sub MakeSnake, it creates the snake and board
  while dead=0                     'This is the "alive" loop
    MakeFood                        'Make the Food in a random place
    'Debug1                         'Debugging purposes only
    foodeaten=0 : dead=0            'These assign the value of 0 to the variables "foodeaten" and "dead".^ 
    while (foodeaten=0 and dead=0) 'This is the "alive and food not eaten" loop          '
      delay delaytime               'this creates a delay so that the loop does not execute too fast, if this was not here it...
      Move                          'Go to sub Move, it moves the snake             '...would loop hundreds of times in a second
      'Debug2                       '###  Debugging purposes only. If you do uncomment this and Debug3, than you might have to ---|
      Display                       'Go to sub Display, it displays what needs to be seen on the screen.                          |
      'Debug3                       '###  Debugging purposes only.       '...change previous line (Display) into ('Display).   <--|
    wend                           'This is END of the "alive and food not eaten" loop 
    SnakeGrow                       'This grows the snake
  wend                             'This is the END of the "alive" loop. If it exits the loop, it means that variable "dead" is not 0*
  at width*b/2-30, height*b/2-7 : print "Game Over"                  'write "game over" in the center of the screen           
  at width*b/2-80, height*b/2+7 : print "Press Space to Continue"    'write "Press Space To Continue" in the center of the screen       
  while (inkey != chr(32)) : wend                'loop until inkey (last key pressed) is 32 (<Spacebar>)
  cls                                            'CLear Screen
  SelectGameplay                                 'Go to sub SelectGameplay, it lets you select what type of gameplay you want
wend                                             'This is the END of the "everything" loop
cls                                              'CLear Screen
end                                              'end program

' *    0 usually means false, 1 usually means true
' **   A CONST declares the following variable to be a constant. A constant can't be changed while the program is running
' ^    A colon, ':' will allow two statements on one line, using up less lines
' ^^   A throwaway variable is a variable with a short name. In this program, "Snake", I use it for different things throughout...
      '...the program, so I try to reset it each time I use it, so that I don't get any old irrelevant values in it.


sub Intro 'introductory things
print "  /-----\  |\      |        /\        |   /  |----- "
print " (         | \     |       /  \       |  /   |      "
print "  \        |  \    |      /    \      | /    |      "
print "   \--\    |   \   |     /------\     |(     |----- "
print "       \   |    \  |    /        \    | \    |      "
print "        )  |     \ |   /          \   |  \   |      "
print " \-----/   |      \|  /            \  |   \  |----- "
print "" 'display big "SNAKE' on the screen
print " |\    /|   /\   |--\  |--     |--\ \  /     --|--  /--\  /--\ |-- |-\ |  |     |--\  \  / | / /--\ --|-- |-\   /\   "
print " | \  / |  /--\  |   ) |--     |--<  \/        |   (    ) \--\ |-- |-/ |--|     |   )  \/  |<  \--\   |   |-/  /--\  "
print " |  \/  | /    \ |--/  |--     |--/   |      \-|    \--/  \--/ |-- |   |  |     |--/    |  | \ \--/   |   | \ /    \ "
print "" 'display who made ths snake program
print " \    /\    / -|- --|-- |  |     --|--  /--\  /--\ -|-   /\   |  |     | / |-\ |  | --|-- \-- "
print "  \  /  \  /   |    |   |--|       |   (    ) \--\  |   /--\  |--|     |<  |-/ |  |   |    \  "
print "   \/    \/   -|-   |   |  |     \-|    \--/  \--/ -|- /    \ |  |     | \ | \ \--/   |   --\ "
delay 3000      'show the things for 3000 ms (3 sec) and then...
cls             '... CLear the Screen
slct=1          'SeLeCT=1 ... all of these following variables will be the same, no matter what gameplay you choose
const b=16      'how big each Block is (measured in pixels), this is a CONSTant**
const f=255     'constant** for Full transparency (used for shortening lines a little bit)
const height=24 'how many blocks high it is, this is a CONSTant**
const width=24  'how many blocks wide it is, this is a CONSTant**
end             'this ends "sub Intro"


sub SelectGameplay   'you select the type of gameplay you want
enter=0 : x=0 : lx=1 'set "enter", "x", and "lx" (lx means last x, or previous x)^
while enter=0        'while you have not pressed <Enter>*
 if lx!=x then       'if "lx" (last x) is different (!=) than "x"...
  if x=chr(27) + chr(9) then slct=slct-1  'if you pushed down subtract 1 from SeLeCT
  if x=chr(27) + chr(10) then slct=slct+1 'if you pushed  up    add    1  to  SeLeCT
  if x=chr(13) then enter=1  'if you pushed <Enter> than set the variable "enter" to 1*
  cls                        'CLear Screen
  if slct<0 then slct=4      'if SeLeCT is too small, than wrap it around
  if slct>4 then slct=0      'if SeLeCT is too large, than wrap it around
  print "Quit"               'display "Quit"
  print "Easy"               'display "Easy"
  print "Medium"             'display "Meduim" 
  print "Hard"               'display "Hard"
  print "Death"              'display "Death"
  rect 0,(slct*15)+4,45,(slct+1)*15, color rgb(0,0,0) 'display a RECTangle where SeLeCT is
 fi                  'end the "if "lx" (last x) is different (!=) than "x"..."
 lx=x                'LastX is now equal to current X
 x=inkey             'X is equal to the last keyboard button pressed
wend                 'end the "while you have not pressed <Enter>" loop
if slct=1 then InitLevel 2,3,0.975,110   'Input numbers into "InitLevel" for Easy   mode if Easy   mode was selected
if slct=2 then InitLevel 3,3,0.9375,100  'Input numbers into "InitLevel" for Medium mode if Medium mode was selected
if slct=3 then InitLevel 4,3,0.9,90      'Input numbers into "InitLevel" for Hard   mode if Hard   mode was selected
if slct=4 then InitLevel 10,10,1,80      'Input numbers into "InitLevel" for Death  mode if Death  mode was selected
end                  'End "sub SelectGameplay"

func InitLevel (gro,strtlngth,spdp,dlytm)  'Func means function, which allows you to input numbers into it.
const grow=gro                'how much it grows, constant**
const startlength=strtlngth   'constant**, how long the snake is when the game starts
const speedup=spdp            'constant**, 1 stay same, 0.95 if pretty good
delaytime=dlytm               'delay time in MilliSeconds are delays each time around the "alive and food not eaten" loop...
dir=27                        'direction, 25=L, 26=U, 27=R, 28=D              '...lower value, more speed, 80 is pretty good
dead=0                        'if the snake is dead*
foodeaten=0                   'if the food is eaten*
score=0                       'how much score you start with
end                           'end "func InitLevel"

sub MakeSnake      'makes the snake
length=startlength 'how long the snake is
x=1                'throwaway variable^^
y=1                'throwaway variable^^
z=1                'throwaway variable^^
fx=startlength 'x position of the front of the snake, First X
fy=1 'y position of the front of the snake,           First Y
lx=1 'x position of the back of the snake,            Last  X
ly=1 'y position of the back of the snake,            Last  Y
dim pos(width+1,height+1) 'dimension the array, to slightly bigger that what is needed. If you want to know the...
for x=0 to width+1      'loops through x (width)             '...in depth, detailed reason, feel free to email me
 for y=0 to height+1    'loops through y (height)
  pos(x,y)=0            'make pos (position) entirely 0's
 next y                 'adds 1 to ... y (height)
next x                  'adds 1 to ... x (width)
for x=1 to startlength  'loops through x (width) until up to where snake ends
 pos(x,1)=x             'creates the snake
next x                  'adds 1 to ... x (width)
end                     'end "sub MakeSnake"

sub SnakeGrow        'Grow the snake
if dead=0 then       'if you're still alive
 for x=1 to width    'loops through x (width)
  for y=1 to height  'loops through y (height)
   if pos(x,y)>0 then pos(x,y)=pos(x,y)+grow  'add "grow" to whatever is part of the snake
  next y             'adds 1 to ... y (height)
 next x              'adds 1 to ... x (width)
 score=score+1       'add to your score
fi                   'end "if you're still alive"
delaytime=delaytime*speedup  'change delaytime
end                  'end "sub SnakeGrow"

sub MakeFood    'make the food
z=0             '^^
while z=0
 x=round((rnd)*(width-1))+1    'at a random x...
 y=round((rnd)*(height-1))+1   '...and random y...
 if pos(x,y)=0 then z=1 : pos(x,y)=-1 '...and if no snake at that position, make the food there and exit loop
wend 're-loop if a snake was at that position
end  'end "sub MakeFood"

sub Move  'move snake
x=inkey   'check last pressed key
if x=chr(27) + chr(4) and dir!=27 then dir=25  'If it was <Left>  and current DIRection isn't right, then current direction is left
if x=chr(27) + chr(9) and dir!=28 then dir=26  'If it was <Up>    and current DIRection isn't down,  then current direction is up
if x=chr(27) + chr(5) and dir!=25 then dir=27  'If it was <Right> and current DIRection isn't left,  then current direction is right
if x=chr(27) + chr(10) and dir!=26 then dir=28 'If it was <Down>  and current DIRection isn't up,    then current direction is down
if dir=25 then 'if moving LEFT
 n=pos(fx-1,fy)
 if fx<2 then dead=1                             'if you'll hit the wall, you're dead
 if n>1 then dead=1                              'if you'll hit yourself, you're dead
 if n<2 then fx=fx-1 : pos(fx,fy)=length+1       'if empty or food, move in
 if n=-1 then foodeaten=1 : length=length+grow   'if food, grow
fi
if dir=26 then 'if moving UP
 n=pos(fx,fy-1)
 if fy<2 then dead=1                             'if you'll hit the wall, you're dead
 if n>1 then dead=1                              'if you'll hit yourself, you're dead
 if n<2 then fy=fy-1 : pos(fx,fy)=length+1       'if empty or food, move in
 if n=-1 then foodeaten=1 : length=length+grow   'if food, grow
fi
if dir=27 then 'if moving RIGHT
 n=pos(fx+1,fy)
 if fx+1>width then dead=1                       'if you'll hit the wall, you're dead
 if n>1 then dead=1                              'if you'll hit yourself, you're dead
 if n<2 then fx=fx+1 : pos(fx,fy)=length+1       'if empty or food, move in
 if n=-1 then foodeaten=1 : length=length+grow   'if food, grow
fi
if dir=28 then 'if moving DOWN
 n=pos(fx,fy+1)
 if fy+1>height then dead=1                      'if you'll hit the wall, you're dead
 if n>1 then dead=1                              'if you'll hit yourself, you're dead
 if n<2 then fy=fy+1 : pos(fx,fy)=length+1       'if empty or food, move in
 if n=-1 then foodeaten=1 : length=length+grow   'if food, grow
fi
if dead=0 then                  'if alive
 for x=1 to width
  for y=1 to height
   if pos(x,y)=1 then lx=x : ly=y          'check where lx (last x) and ly (last y) are
   if pos(x,y)>0 then pos(x,y)=pos(x,y)-1  'move the snake, delete last block, will make more sense if you uncomment...
  next y 'add 1 to y                                                      '...Debug2 and Debug3 where you see "###"
 next x  'add 1 to x
fi                              'end "if alive"
end               'end "sub Move"

sub Display                                                                              'draws all things on the screen
rect 0,0,480,640, color rgb(f,f,f) filled                                                'draw outline
rect lx*b-(b-1), ly*b-(b-1), STEP b-1, b-1, color rgb(f,f,f) filled         
rect 0, 0, b*width, b*height, color rgb(0,0,100)
for x=1 to width   'search through pos array...
 for y=1 to height 'search through pos array...
  if pos(x,y)>0 then rect x*b-(b-1), y*b-(b-1), STEP b-1, b-1, color rgb(0,f,0) filled   'draw snake
  if pos(x,y)<0 then rect x*b-(b-1), y*b-(b-1), STEP b-1, b-1, color rgb(f,0,0) filled   'draw food
 next y            'search through pos array...
next x             'search through pos array...
at width*b+2,2 : print "Score: ";score                                                   'draw score on left of board
end                                                                                      'end "sub Display"

'if you want to figure out the physics for how this snake game works, uncomment Debug2 and Debug3 where you see "###"

sub Debug1                                     'displays where the food was made
at width*b+2,14 : print "x=";x;", y=";y
end

sub Debug2                                     'clears part of the screen
'(with Debug3)
rect 0,160,480,640, color rgb(f,f,f) filled
end

sub Debug3                                     'displays the values of the array pos, basically the board, but text
'(with Debug2)
for x=1 to width
 for y=1 to height
  at (x*b)*2, (y*b+(b*height)+2)*2 : print pos(x,y)
 next y
next x
end
001 #snake.bas 'INIT start
002 print "  /-----\  |\      |        /\        |   /  |-----  | "
003 print " (         | \     |       /  \       |  /   |       | "
004 print "  \        |  \    |      /    \      | /    |       | "
005 print "   \--\    |   \   |     /------\     |<     |-----  | "
006 print "       \   |    \  |    /        \    | \    |       | "
007 print "        )  |     \ |   /          \   |  \   |         "
008 print " \-----/   |      \|  /            \  |   \  |-----  * "
009 print " "
010 print " |\    /|   /\   |--\  |--     |--\ \  /     --|--  /--\  /--\ |-- |-\ |  |     |--\  \  / | / /--\ --|-- |-\   /\   "
011 print " | \  / |  /--\  |   ) |--     |--<  \/        |   (    ) \--\ |-- |-/ |--|     |   )  \/  |<  \--\   |   |-/  /--\  "
012 print " |  \/  | /    \ |--/  |--     |--/  |       \-|    \--/  \--/ |-- |   |  |     |--/   |   | \ \--/   |   | \ /    \ "
013 print " "
014 print " \    /\    / -|- --|-- |  |     --|--  /--\  /--\ -|-   /\   |  |     | / |-\ |  | --|-- \-- "
015 print "  \  /  \  /   |    |   |--|       |   (    ) \--\  |   /--\  |--|     |<  |-/ |  |   |    \  "
016 print "   \/    \/   -|-   |   |  |     \-|    \--/  \--/ -|- /    \ |  |     | \ | \ \--/   |   --\ "
017 delay 3000
018 'playing="y"
019 'while playing="y"
020  'button 0, 0, 100, 20, type, "Slow|Medium|Fast|Death", "choice"
021  const grow=1 'if (type="Death", 25 if (type!="Death", 1)) 'how much it grows
030  const startlength=3 'if (type="Death", 1, if (type!="Death", 3)) 'constant, how long the snake is when the game starts
040  const b=16 'how many pixels each block is
050  const f=255 'constant for full transparency
060  const height=24 'how many blocks high it is
070  const width=24  'how many blocks wide it is
080  dir=27 'direction, 25=L, 26=U, 27=R, 28=D
090  dead=0 '0=false, 1=true, if the snake is dead
100  foodeaten=0 '0=false, 1=true, if the food is eaten
110  delaytime=100 'if(type="Death", 50 (if type!="Death", 80) 'starting speed, lower value, more speed, 80 is good
120  score=0 'how much score you start with
130  length=startlength 'how long the snake is
135  'm="Game Over"
140  x=1 'throwaway variable
150  y=1 'throwaway variable
160  z=1 'throwaway variable
170  fx=startlength 'x position of the front of the snake
180  fy=1 'y position of the front of the snake
190  lx=1 'x position of the back of the snake
200  ly=1 'y position of the back of the snake
210  dim pos(width,height)
220  for x=1 to width
230   for y=1 to height
240    pos(x,y)=0
250   next y
260  next x
270  for x=1 to startlength
280   pos(x,1)=x
290  next x
300  cls 'INIT end
310  while dead=0 'HUGE LOOP
320   z=0 'reset z
330   while z=0 'FOOD start
340    x=round((rnd)*(width-1))+1
350    y=round((rnd)*(height-1))+1
360    if pos(x,y)=0 then z=1 : pos(x,y)=-1 'FOOD end
370   wend 'debugging:  at width*b+2,14 : print "x=";x;", y=";y
380   x=0 'reset x
390   y=0 'reset y
400   z=0 'reset z
410   foodeaten=0 : dead=0
420   while (foodeaten=0 and dead=0)
440    delay delaytime
450    x=inkey 'MOVING start
460    if x=chr(27) + chr(4) and dir<>27 then dir=25  '(Left)
470    if x=chr(27) + chr(9) and dir<>28 then dir=26  '(Up)
480    if x=chr(27) + chr(5) and dir<>25 then dir=27  '(Right)
490    if x=chr(27) + chr(10) and dir<>26 then dir=28 '(Down)
500    if dir=25 then 'if moving LEFT
510     n=pos(fx-1,fy)
520     if fx<2 then dead=1
530     if n>1 then dead=1
540     if n<2 then fx=fx-1 : pos(fx,fy)=length+1
550     if n=-1 then foodeaten=1 : length=length+grow
560    endif
570    if dir=26 then 'if moving UP
580     n=pos(fx,fy-1)
590     if fy<2 then dead=1
600     if n>1 then dead=1
610     if n<2 then fy=fy-1 : pos(fx,fy)=length+1
620     if n=-1 then foodeaten=1 : length=length+grow
630    endif
640    if dir=27 then 'if moving RIGHT
650     n=pos(fx+1,fy)
660     if fx>width-1 then dead=1
670     if n>1 then dead=1
680     if n<2 then fx=fx+1 : pos(fx,fy)=length+1
690     if n=-1 then foodeaten=1 : length=length+grow
700    fi
710    if dir=28 then 'if moving DOWN
720     n=pos(fx,fy+1)
730     if fy>height-1 then dead=1
740     if n>1 then dead=1
750     if n<2 then fy=fy+1 : pos(fx,fy)=length+1
760     if n=-1 then foodeaten=1 : length=length+grow
770    fi
780    if dead=0 then
790     for x=1 to width
800      for y=1 to height
810       if pos(x,y)=1 then lx=x :  ly=y
820       if pos(x,y)>0 then pos(x,y)=pos(x,y)-1
830      next y
840     next x 'MOVING end
850    fi
851    rect 0,0,480,640, color rgb(f,f,f) filled
'debugging, with code below:
'852    rect 0,160,480,640, color rgb(f,f,f) filled
'end of debugging
860    rect lx*b-(b-1), ly*b-(b-1), STEP b-1, b-1, color rgb(f,f,f) filled
870    rect 0, 0, b*width, b*height, color rgb(0,0,100)
880    for x=1 to width
890     for y=1 to height
900      if pos(x,y)>0 then rect x*b-(b-1), y*b-(b-1), STEP b-1, b-1, color rgb(0,f,0) filled
910      if pos(x,y)<0 then rect x*b-(b-1), y*b-(b-1), STEP b-1, b-1, color rgb(f,0,0) filled
920     next y
930    next x
931    at width*b+2,2 : print "Score: ";score
'debugging, with code above:
'932    for x=1 to width
'933     for y=1 to height
'934     at (x*b)*2, (y*b+(b*height)+2)*2 : print pos(x,y)
'935    next y
'936   next x
'end of debugging
940   wend
941   if dead=0 then
942    for x=1 to width
943     for y=1 to height
944      if pos(x,y)>0 then pos(x,y)=pos(x,y)+grow
945     next y
946    next x
947    score=score+1
950   fi
960   delaytime=delaytime*0.9
970  wend
980  'at (width*b-textwidth(m))/2, (height*b-textheight(m))/2 : print m
985  'delay 1000 'at width*b/2-50, height*b/2+5  : input "Play again, y/n", playing
990  'cls
995 'wend
999 end
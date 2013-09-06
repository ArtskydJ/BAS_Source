'snake.bas
Intro
SelectGameplay
while slct!=0
	MakeSnake
	while dead=0
		MakeFood
		'Debug1
		foodeaten=0 : dead=0
		while (foodeaten=0 and dead=0)
			delay delaytime
			Move
			'Debug2
			Display
			'Debug3
		wend
		SnakeGrow
	wend
	at width*b/2-30, height*b/2-7 : print "Game Over"
	at width*b/2-80, height*b/2+7 : print "Press Space to Continue"
	while (inkey != chr(32)) : wend
	cls
	SelectGameplay
wend
cls
end


sub Intro
print "  /-----\  |\      |        /\        |   /  |----- "
print " (         | \     |       /  \       |  /   |      "
print "  \        |  \    |      /    \      | /    |      "
print "   \--\    |   \   |     /------\     |(     |----- "
print "       \   |    \  |    /        \    | \    |      "
print "        )  |     \ |   /          \   |  \   |      "
print " \-----/   |      \|  /            \  |   \  |----- "
print ""
print " |\    /|   /\   |--\  |--     |--\ \  /     --|--  /--\  /--\ |-- |-\ |  |     |--\  \  / | / /--\ --|-- |-\   /\   "
print " | \  / |  /--\  |   ) |--     |--<  \/        |   (    ) \--\ |-- |-/ |--|     |   )  \/  |<  \--\   |   |-/  /--\  "
print " |  \/  | /    \ |--/  |--     |--/   |      \-|    \--/  \--/ |-- |   |  |     |--/    |  | \ \--/   |   | \ /    \ "
print ""
print " \    /\    / -|- --|-- |  |     --|--  /--\  /--\ -|-   /\   |  |     | / |-\ |  | --|-- \-- "
print "  \  /  \  /   |    |   |--|       |   (    ) \--\  |   /--\  |--|     |<  |-/ |  |   |    \  "
print "   \/    \/   -|-   |   |  |     \-|    \--/  \--/ -|- /    \ |  |     | \ | \ \--/   |   --\ "
delay 3000
cls
slct=1
const b=16 'how many pixels each block is
const f=255 'constant for full transparency
const height=24 'how many blocks high it is
const width=24  'how many blocks wide it is
end


sub SelectGameplay
	enter=0 : x=0 : lx=1
	while enter=0 'use mouse sometime?
		if lx!=x then
			if x=chr(27) + chr(9) then slct=slct-1
			if x=chr(27) + chr(10) then slct=slct+1
			if x=chr(13) then enter=1
			cls
			if slct<0 then slct=4
			if slct>4 then slct=0
			print "Quit"
			print "Easy"
			print "Medium"
			print "Hard"
			print "Death"
			rect 0,(slct*15)+4,45,(slct+1)*15, color rgb(0,0,0)
		fi
		lx=x
		x=inkey
	wend
	if slct=1 then InitLevel 2,3,0.975,110
	if slct=2 then InitLevel 3,3,0.9375,100
	if slct=3 then InitLevel 4,3,0.9,90
	if slct=4 then InitLevel 10,10,1,80
end

func InitLevel (gro,strtlngth,spdp,dlytm)
	const grow=gro 'how much it grows
	const startlength=strtlngth 'constant, how long the snake is when the game starts
	const speedup=spdp '1 stay same, 0.95 is good
	delaytime=dlytm 'starting speed, lower value, more speed, 80 is good
	dir=27 'direction, 25=L, 26=U, 27=R, 28=D
	dead=0 '0=false, 1=true, if the snake is dead
	foodeaten=0 '0=false, 1=true, if the food is eaten
	score=0 'how much score you start with
end

sub MakeSnake
	length=startlength 'how long the snake is
	x=1 'throwaway variable
	y=1 'throwaway variable
	z=1 'throwaway variable
	fx=startlength 'x position of the front of the snake
	fy=1 'y position of the front of the snake
	lx=1 'x position of the back of the snake
	ly=1 'y position of the back of the snake
	dim pos(width+1,height+1) 'was dim pos(width,height)
	for x=0 to width+1    'was for x=1 to width
		for y=0 to height+1  'was for y=1 to height
			pos(x,y)=0
		next y
	next x
	for x=1 to startlength
		pos(x,1)=x
	next x
end

sub SnakeGrow
	if dead=0 then
		for x=1 to width
			for y=1 to height
				if pos(x,y)>0 then pos(x,y)=pos(x,y)+grow
			next y
		next x
		score=score+1
	fi
	delaytime=delaytime*speedup
end

sub MakeFood
	z=0
	while z=0
		x=round((rnd)*(width-1))+1
		y=round((rnd)*(height-1))+1
		if pos(x,y)=0 then z=1 : pos(x,y)=-1
	wend
end

sub Move
	x=inkey
	if x=chr(27) + chr(4) and dir!=27 then dir=25  '(Left)
	if x=chr(27) + chr(9) and dir!=28 then dir=26  '(Up)
	if x=chr(27) + chr(5) and dir!=25 then dir=27  '(Right)
	if x=chr(27) + chr(10) and dir!=26 then dir=28 '(Down)
	if dir=25 then 'if moving LEFT
		n=pos(fx-1,fy)
		if fx<2 then dead=1
		if n>1 then dead=1
		if n<2 then fx=fx-1 : pos(fx,fy)=length+1
		if n=-1 then foodeaten=1 : length=length+grow
	fi
	if dir=26 then 'if moving UP
		n=pos(fx,fy-1)
		if fy<2 then dead=1
		if n>1 then dead=1
		if n<2 then fy=fy-1 : pos(fx,fy)=length+1
		if n=-1 then foodeaten=1 : length=length+grow
	fi
	if dir=27 then 'if moving RIGHT
		n=pos(fx+1,fy)
		if fx+1>width then dead=1
		if n>1 then dead=1
		if n<2 then fx=fx+1 : pos(fx,fy)=length+1
		if n=-1 then foodeaten=1 : length=length+grow
	fi
	if dir=28 then 'if moving DOWN
		n=pos(fx,fy+1)
		if fy+1>height then dead=1
		if n>1 then dead=1
		if n<2 then fy=fy+1 : pos(fx,fy)=length+1
		if n=-1 then foodeaten=1 : length=length+grow
	fi
	if dead=0 then
		for x=1 to width
			for y=1 to height
				if pos(x,y)=1 then lx=x : ly=y
				if pos(x,y)>0 then pos(x,y)=pos(x,y)-1
			next y
		next x
	fi
end

sub Display
	rect 0,0,480,640, color rgb(f,f,f) filled
	rect lx*b-(b-1), ly*b-(b-1), STEP b-1, b-1, color rgb(f,f,f) filled
	rect 0, 0, b*width, b*height, color rgb(0,0,100)
	for x=1 to width
		for y=1 to height
			if pos(x,y)>0 then rect x*b-(b-1), y*b-(b-1), STEP b-1, b-1, color rgb(0,f,0) filled
			if pos(x,y)<0 then rect x*b-(b-1), y*b-(b-1), STEP b-1, b-1, color rgb(f,0,0) filled
		next y
	next x
	at width*b+2,2 : print "Score: ";score
end

sub Debug1
	at width*b+2,14 : print "x=";x;", y=";y
end

sub Debug2
	'(with Debug3)
	rect 0,160,480,640, color rgb(f,f,f) filled
end

sub Debug3
	'(with Debug2)
	for x=1 to width
		for y=1 to height
			at (x*b)*2, (y*b+(b*height)+2)*2 : print pos(x,y)
		next y
	next x
end
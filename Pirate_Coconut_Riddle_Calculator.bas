currentcalculate=1
add=1
currentcalulatenumber=-1
showatend=-1
while add=1
 currentcalculatenumber=(7/6*(7/6*(7/6*(7/6*(7/6*(7/6*(7*currentcalculate+1)+1)+1)+1)+1)+1)+1)+1
 showatend=currentcalculatenumber
  while currentcalculatenumber>1
    currentcalculatenumber-=1
  wend
  if currentcalculatenumber=1 then add=0
  currentcalculate+=add
  print currentcalculate
wend
print ""
print showatend
delay (20000)
end
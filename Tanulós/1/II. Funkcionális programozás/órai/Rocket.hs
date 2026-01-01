union
[
  -- Háttér
  rect 400 300 
    `fill` blue,

  -- Teljes hold
  circle 2 
    `fill` yellow 
    `stroke` yellow 
    `move` (10, 4.6),

  -- Hold árnyék
  circle 2.3 
    `fill` blue 
    `stroke` blue 
    `move` (9, 5),

  -- Csillagok, csillagok..
  -- Mondjátok el nekem..
  -- https://en.wikipedia.org/wiki/Lissajous_curve
  union [
    circle 0.1 
      `fill` white 
      `stroke` white 
      `move` (16 * sin(i * pi / 10 + pi/2), 12 * sin(i * pi / 9))      
    | i <- [1..50] 
  ],
  -- Rakéta
  union [
    -- Test
    rect 2 4
      `fill` green
      `stroke` white,
    
    polygon [(1,2), (-1,2), (0,4)] ]
      `fill` red
      `stroke` white,

  ]
  `move` (3,3) 
  `rotate` -30

]
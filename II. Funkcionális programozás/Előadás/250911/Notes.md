
- Feladatközpontúság
	- A feladatot pontosan érteni akarom, meg akarom fogalmazni, pontosan tudom a sorok jelentését
- Szemantika
	- A jelentés 
- "Ha bármiről megkérdezem, hogy mi az, azzal a válasszal nehezen lehet mellélőni, hogy ez egy függvény."
- Statikus, szigorú típusrendszer
```haskell

inc x = x + 1
square x = x * x
squareinc = square ( inc x )
fact n = prod [1..n]

fact 10 
squareinc 7
```

^^ 
Vigyázni kell, nem módosít, csak visszaad egy új eredményt. 


- Függvény definíciója
	- Függvényazonosító
		- A függvény neve
		- Óriási szabadság. 
		- Case-sensitive!
	- Formális paraméter - argumentum 

- Egyenlőség jel
	- definiál
- Függvénytörzs 
	- egy kifejezés
	- definiálja a visszatérési értéket
- A névtér azonosítók halmaza


- A tisztán funkcionális világban
	- Nem újradefiniálható a függvény 
	- **Értéket adni tilos!**
	- Ha mégis, értéket változtatni **bűn**. 
	- A változó nem változik, hanem konstans. 


## Kiértékelési stratégiák

- Szigorú - strict 
- Lusta - lazy 
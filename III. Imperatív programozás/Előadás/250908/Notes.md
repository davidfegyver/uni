https://gsd.web.elte.hu/lectures/imper/imper-lecture-1/
# Programozási alapfogalmak

## Szintaxis (syntax) 
- A programozási nyelv helyes nyelvtana.
- Mik a helyes kulcsszavak, hogyan nézhet ki egy változó neve, hova tegyünk pontosvesszőt, stb.
## Szemantika (semantics)
- A szintaktikailag helyes programok jelentése.
- Szabályos-e a használat?
- Milyen típusrendszere van a nyelvnek, milyen konverziók történnek, melyik függvényt hívjuk meg egy híváskor, stb.
## Pragmatika (pragmatics)
- Hogyan közelítünk meg egy feladatot? 
- Melyik az adott esetben a legjobb konstrukció? 
- Melyik a legolvashatóbb, legkarbantarthatóbb, leghatékonyabb?
- Melyik a legkönnyebben debuggálhatóbb?
- Elegante megoldás! 
## Programozási paradigmák
- A bonyolult informatikai feladatok megoldásának kisebb részekre bontása
	- hatékonyabban, könnyebben megoldható legyen
		- sztenderd könyvtár által megoldható feladat
		- önállóan megoldható
	- részfeladatok
- Milyen elvek szerint oldjam meg? 
### Imperatív programozás 
- Explicit mi vezéreljük, hogy a program hogyan változtassa meg az állapotát 
#### Procedurális
- A feladatot felbonthatjuk az elvégzendő feladatok (algoritmusok) szerint
- Ezek alprogramokként (függvények, eljárások) valósítjuk meg
- Köztük paraméterátadással, visszatérő érdékkel kommunikálunk
- Háttérbe szorulnak az adatszerkezetek 

- C, Pascal, Go. 
#### Objektumelvű 
- Hasonló tulajdonságú objektumokat összegyűjtünk, modellezzük őket
- Osztályokat alkotunk belőlük 
- Adatszerkezet, és a rajtuk értemezett műveleteken van a hangsúly

- Java, C# 
### Deklaratív programozás 
- Csak deklarálni akarjuk a program működését, nem akarjuk meghatározni annak a mikéntjét.
### Multiparadigma programozás
- Lambda függvények
- Generatív függvények
- Kiegészítik egymást 
- A mai programozási nyelvek
## Random
- Bytecode - Bájtkód
	- hardverfüggetlen 
	- Egységes, egy van
- Machine code - Gépi kód
	- Hardverfüggő
	- Ember számára olvasható verziója: Assembly
## A végrehajtás módja
### Interpretálás
- Az interpreter egy önálló program
	- Olvassa a végrehajtandó program forrását, és lépésenként végrehajtja 
- Rugalmasak
- Önmódosítóak
- Előellenőrzés, előfordítás

- Python, JavaScript
### Fordítás
- Egy fordítóprogram **tárgykóddá** (object code) fordítja a kódot. 
- Hardvernek megfelelő gépi kód - platformfüggő
- optimalizált 
- Hivatkozások
	- **szerkesztő** (linker)
	- más tárgykódokból vagy könyvtárakból 
	- **könyvtár** (library)
		- Szerkesztésre optimalizált tárgykódok halmaza 
	- A nyelv szabványos könyvtára: Standard library

	- Dinamikus
		- Futásidő alatt feloldva
		- Ez az elterjedtebb
	- Statikus

- + Sok hiba megtalálható a fordítás közben
- - Lassú fejlesztés, nehéz hibareresés, platformspecifikus 
### Nem ide tartozik
- Java
	- közbülső kódra fordít 
	- JVM (Java Virtuális Gép) interpreterként hajt végre
	- hibrid megoldások
	- Just In Time compiler (JIT)
		- A sűrűn végrehajtott bájtkódot gépi kódra fordítja, gyorsabban tudja végrehajtani
- C# 
- Scala

# Hello.c 
- Az első kódunk
- A második a Fahrenheit - Celsius konverzió ;)

```c
#include <stdio.h>
int main()
{
  printf( "hello world\n" );
  return 0;   
}
```

```bash
$ gcc  hello.c
$ ./a.out
$ gcc -std=c11 -ansi -pedantic -Wall -Wextra hello.c -o a.exe
```

- `gcc` - GNU C fordító
- `-std=c11` - A használandó C nyelvi sztenderd
- `-ansi` - ANSI C megfelelést biztosítja
- `-pedantic` - ISO C megfelelés, figyelmeztet sztenderd ellenes kódra
- `-Wall` - Figyelmeztetések bekapcsolása (nem használt változók, hiányzó visszatérési értékek
- `-Wextra` - Még több figyelmeztetés
- `hello.c` - A forrásfájl
- `-meow.c` - Kimeneti fájlnév
- `-S` - Assembly kódot készít, gépi kód, ember által olvasható formátumban
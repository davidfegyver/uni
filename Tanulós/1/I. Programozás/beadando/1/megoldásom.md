* Neptun kód: **MKLH4B**
* Név: **Fegyver Dávid Bátor**
* Beadás verziószáma: **1.**
### Feladat
#### Fagyos napok száma az előrejelzésben
- Egy időjárás előrejelzésben megkaptuk a következő N napra várható minimális és maximális hőmérséklet értékeket.
- Írj programot, amely megadja azon napok számát, amikor fagyni fog, azaz a hőmérséklet kisebb lesz 0 foknál!
#### Bemenet 
- A standard bemenet első sorában a napok száma (0≤N≤100), alatta pedig soronként egy-egy nap várható legkisebb és legnagyobb hőmérsékletei vannak (-20≤Min, Max≤30).
```
6
-5 5
0 10
-5 -3
-5 0
2 10
10 13
```
#### Kimenet
- A standard kimenet egyetlen sorába azon napok számát kell kiírni, amikor fagyni fog várhatóan! 
```
3
```
### Specifikáció
[speci_online](https://progalap.elte.hu/specifikacio/v1/?uuid=8684e4be-4fd8-41c4-95b9-16e2acae27c5)
```
Be: napokszama ∈ N, napimin∈R[1..napokszama] 
Ki: fagyosnap∈N
Ef: 0 <= napokszama és napokszama <= 100 és ∀i∈[1..napokszama]:(-20<=napimin[i]  és napimin[i] <= 30 )
Uf: fagyosnap=DARAB(i=1..napokszama, napimin[i]<0)
```


### Sablon
![[Pasted image 20251012220929.png]]
### Visszavezetés
```
db ~ fagyosnap
e..u ~ 1..napokszama
T(i) ~ napimin[i]<0
```
### Algoritmus
[stuki_online](https://progalap.elte.hu/stuki/v1/?uuid=df606e9c-385f-4cba-ba4a-ab41a33c7e51)

![[Pasted image 20251012221835.png]]
## Kód (C#)

```cs
using System;
namespace Bead_kód
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.Error.Write("Add meg a napok számát:");
            int napokszama = int.Parse(Console.ReadLine());
            double[] napimin = new double[napokszama];
            for (int i = 0; i < napokszama; i++)
            {
                Console.Error.Write($"Add meg a(z) {i + 1}. nap hőmérsékleteit:");
                napimin[i] = double.Parse(Console.ReadLine().Split(" ")[0]);
            }

            int fagyosnap = 0;
            for (int i = 0; i < napokszama; i++)
            {
                if (napimin[i] < 0)
                {
                    fagyosnap++;
                }
            }
            Console.Error.WriteLine("Fagyos napok száma:");
            Console.WriteLine(fagyosnap);
        }
    }
}

```

## Bíró pontszám és képernyőkép
**100/100**
![[Pasted image 20251022195504.png]]
## Saját tesztfájlok

### 1.
#### Bemenet
```
1
-1 1
```
#### Kimenet
```
1
```

### 2.
#### Bemenet
```
2
0 30
-10 10
```
#### Kimenet
```
1
```

### 3.
#### Bemenet
```
4
-2 2
-3 5
-1 0
20 30
```
#### Kimenet
```
3
```


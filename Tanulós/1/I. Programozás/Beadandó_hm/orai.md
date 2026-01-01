* Neptun kód: **MKLH4B**
* Név: **Fegyver Dávid Bátor**
* Beadás verziószáma: **1.**
### Feladat
#### Leghosszabb egyszínű gyöngyökből álló szakasz
- Egy nyakláncon különböző színű gyöngyök találhatók. Tudjuk, hogy minden szín kezdőbetűje más, így a gyöngyöket a színük kezdőbetűjével adjuk meg. A lánc gyöngyeit egy tetszőleges pontjától kezdve adjuk meg.
- Készíts programot, amely kiírja, hogy hány egyforma gyöngyből áll és milyen színű az egymás mellett levő leghosszabb egyszínű gyöngyökből álló
szakasz!
#### Bemenet 
- A standard bemenet első sorában a gyöngyök száma van (1≤N≤100), majd a második sorban N gyöngy színe (egy-egy színt egy-egy betű jelöl).
```
12
SSLLLPPPPSSS
```
#### Kimenet
- A standard kimenet első sorába kiírja, hogy hány egyforma gyöngyből áll a leghosszabb egyforma gyöngyökből álló szakasz, a következő sorba pedig annak színét (ha több ilyen is van, akkor az elsőt)!
```
5
S
```
### Specifikáció
[speci_online](https://progalap.elte.hu/specifikacio/v1/?uuid=8684e4be-4fd8-41c4-95b9-16e2acae27c5)
```
Be: napokszama ∈ N, napimin∈R[1..napokszama] 
Ki: fagyosnap∈N
Ef: 0 <= napokszama és napokszama <= 100 és ∀i∈[1..napokszama]:(-20<=napimin[i]  és napimin[i] <= 30 )
Uf: fagyosnap=DARAB(i=1..napokszama, napimin[i]<0)
```
  (Blee. A speciben nem vettem fel a számunkra nem releváns adatot, a napi max hőmérsékletet. Ha nagyon szeretnénk, az utófeltételben csekkolhatjuk, hogy a max 0 fok alatti-e, viszont az eléggé redundáns ... :p ) 

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
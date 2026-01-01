* Neptun kód: **MKLH4B**
* Név: **Fegyver Dávid Bátor**
* Beadás verziószáma: **1.**
### Feladat
#### Legmelegebb települések 
* A meteorológiai intézet az ország N településére adott M napos időjárás előrejelzést, az adott településen az adott napra várt legmagasabb hőmérsékletet. 
* Készíts programot, amely megadja azt a települést, ahol a legmagasabb hőmérséklet várható!
#### Bemenet 
- A standard bemenet első sorában a települések száma (1≤N≤1000) és a napok száma (1≤M≤1000) van. Az ezt követő N sorban az egyes napokra jósolt M hőmérséklet értéke található (-50≤Hi,j≤50)
```
3 5
10 15 12 10 10
11 11 11 11 20
12 16 16 16 20
```
#### Kimenet
- A standard kimenet első sorába azon települések T számát kell kiírni, ahol a legmagasabb hőmérséklet várható! Ezt kövesse ezen települések sorszáma, növekvő sorrendben!

```
2 2 3
```
### Specifikáció
[speci_online](https://progalap.elte.hu/specifikacio/v1/?uuid=32b578a5-9dc8-4b69-8b1f-00ae0c53decf)

```cs
Be: n ∈ N, m ∈ N, homletek ∈ N[1..n,1..m]
Ki: db ∈ N, maxhomletek∈N[]
Fv: telepulesMax:N->N, 
    telepulesMax(i)=MAX(j=1..m, homletek[i][j]).maxért
Fv: telepulesMaxOsszMaxE: N->L,
    telepulesMaxOsszMaxE(i) = MAX(i=1..n,telepulesMax(i)).maxért = telepulesMax(i)
Ef: 1<=n<=1000 és  1<=m<=1000 és ∀i∈[1..n]:(∃j∈[1..m]:(-50<=homletek[i,j]<=50))
Uf: (db,maxhomletek)=KIVÁLOGAT(i=1..n,telepulesMaxOsszMaxE(i),i)
```
### Visszavezetés 1.
```js
i ~ i 
e ~ 1 
u ~ m
f(i) ~ homletek[i][j]
```

### Visszavezetés 2.
```js
i ~ i 
e ~ 1 
u ~ n
f(i) ~ telepulesMax(i)
```

### Visszavezetés 3.

```js
db ~ db
y ~ maxhomletek
i ~ i
e ~ 1
u ~ n
T(i) ~ telepulesMaxOsszMaxE(i)
f(i) ~ i
```
### Algoritmus
[stuki_online](https://progalap.elte.hu/stuki/v1/?uuid=80534ff4-06a1-4988-9660-ddd82dce3a5e)
![[Pasted image 20251213153518.png]]
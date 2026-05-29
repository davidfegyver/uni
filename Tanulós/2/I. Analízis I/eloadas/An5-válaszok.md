**1. Az $e$ számot definiáló sorozat** 
Az $e$ számot az $a_n := \left(1 + \frac{1}{n}\right)^n$ $(n \in \mathbb{N}^+)$ sorozat határértékeként definiáljuk.

**2. A közrefogási elv** 
Tegyük fel, hogy az $(a_n)$, $(b_n)$ és $(c_n)$ sorozatokra létezik olyan $N \in \mathbb{N}$ küszöbindex, hogy minden $n > N$ indexre $a_n \le b_n \le c_n$. Ha az $(a_n)$ és a $(c_n)$ sorozatnak van határértéke, és $\lim(a_n) = \lim(c_n) = A \in \overline{\mathbb{R}}$, akkor a $(b_n)$ sorozatnak is van határértéke, és $\lim(b_n) = A$.

**3. Monoton sorozatok határértékére vonatkozó tétel** Minden $(a_n)$ monoton sorozatnak van határértéke. Ha a sorozat monoton növekvő és felülről korlátos, akkor konvergens, és a határértéke a szuprémuma; ha felülről nem korlátos, akkor a határértéke $+\infty$. (Hasonló megállapítások érvényesek a csökkenő és alulról korlátos/nem korlátos sorozatokra az infimummal és a $-\infty$-nel ).

**4. A szigorú egyenlőtlenség megőrződése a határértéknél**

**Nem igaz.** A rendezés és a határérték kapcsolatára vonatkozó tétel csak az $a_n \le b_n \implies \lim(a_n) \le \lim(b_n)$ irányt garantálja. Az $a_n < b_n$ szigorú egyenlőtlenségből nem következtethetünk arra, hogy $\lim(a_n) < \lim(b_n)$ is teljesül. Erre a jegyzet a következő ellenpéldát hozza: legyen $a_n := -\frac{1}{n}$ és $b_n := \frac{1}{n}$ $(n \in \mathbb{N}^+)$, ekkor $a_n < b_n$ minden esetben fennáll, azonban $\lim(a_n) = \lim(b_n) = 0$.

**5. Az $m$-edik gyök létezése és közelítő eljárása (Newton-féle iteráció)** Bármely $A > 0$ valós számhoz és $m \ge 2$ természetes számhoz létezik egyértelmű $\alpha > 0$ határérték, amelyre $\alpha^m = A$. Ennek előállítására a következő rekurziós eljárás (iteráció) szolgál: választunk egy tetszőleges $a_0 > 0$ valós kezdőértéket, majd az $a_{n+1} := \frac{1}{m}\left(\frac{A}{a_n^{m-1}} + (m-1)a_n\right)$ $(n \in \mathbb{N})$ képlettel sorozatot generálunk. Ez a sorozat konvergens lesz és pont ehhez a gyökhöz tart.

**6. Bolzano–Weierstrass-féle kiválasztási tétel** Minden korlátos valós sorozatnak van konvergens részsorozata.

**7. A Cauchy-sorozat fogalma** Egy $(a_n)$ valós sorozatot Cauchy-sorozatnak nevezünk, ha minden $\epsilon > 0$-hoz létezik olyan $n_0 \in \mathbb{N}$ küszöbindex, amelyre bármely $m, n > n_0$ esetén teljesül, hogy $|a_n - a_m| [cite_start]< \epsilon$.

**8. Kapcsolat a konvergens és a Cauchy-sorozatok között** A Cauchy-féle konvergenciakritérium értelmében egy valós sorozat akkor és csak akkor konvergens, ha Cauchy-sorozat. A Cauchy-tulajdonság tehát a konvergencia szükséges és elégséges feltétele a véges határértékű sorozatoknál.
## 1. A végtelen sorokra vonatkozó Cauchy-féle konvergenciakritérium

> *A $\sum a_n$ sor akkor és csak akkor konvergens, ha*
> $$\forall \varepsilon > 0\text{-hoz } \exists n_0 \in \mathbb{N},\ \forall m > n > n_0 : |a_{n+1} + a_{n+2} + \cdots + a_m| < \varepsilon.$$

**Bizonyítás.** Tudjuk, hogy

$$\sum a_n \text{ konvergens} \iff (s_n) \text{ konvergens} \iff (s_n) \text{ Cauchy-sorozat,}$$

azaz

$$\forall \varepsilon > 0\text{-hoz } \exists n_0 \in \mathbb{N},\ \forall n, m > n_0 : |s_m - s_n| < \varepsilon$$

teljesül. Állításunk abból következik, hogy ha $m > n$, akkor

$$s_m - s_n = a_{n+1} + a_{n+2} + \cdots + a_m.$$

---

## 2. Végtelen sorokra vonatkozó összehasonlító kritériumok

> *Legyenek $\sum a_n$ és $\sum b_n$ nemnegatív tagú sorok. Tegyük fel, hogy*
> $$\exists N \in \mathbb{N},\ \forall n \geq N : 0 \leq a_n \leq b_n.$$
> *Ekkor*
> 1. **Majoráns kritérium:** *ha a $\sum b_n$ sor konvergens, akkor $\sum a_n$ sor is konvergens.*
> 2. **Minoráns kritérium:** *ha a $\sum a_n$ sor divergens, akkor a $\sum b_n$ sor is divergens.*

**Bizonyítás.** Az általánosság megszorítása nélkül feltehetjük, hogy $a_n \leq b_n$ minden $n \in \mathbb{N}$ esetén, hiszen véges sok tag megváltozásával egy sor konvergenciája nem változik. Jelölje $(s_n)$, illetve $(t_n)$ a $\sum a_n$, illetve a $\sum b_n$ sorok részletösszegeiből álló sorozatokat. A feltevésünk miatt $s_n \leq t_n$ $(n \in \mathbb{N})$.

Ekkor a nemnegatív tagú sorok konvergenciájáról szóló tétel szerint

1. ha a $\sum b_n$ sor konvergens, akkor $(t_n)$ korlátos, így $(s_n)$ is az. Ezért a $\sum a_n$ sor is konvergens.
2. ha $\sum a_n$ sor divergens, akkor $(s_n)$ nem korlátos, így $(t_n)$ sem az. Ezért a $\sum b_n$ sor is divergens.

---

## 3. A Cauchy-féle gyökkritérium

> *Tekintsük a $\sum a_n$ végtelen sort, és tegyük fel, hogy létezik az*
> $$A := \lim_{n \to +\infty} \sqrt[n]{|a_n|} \in \mathbb{R}$$
> *határérték. Ekkor*
> 1. $0 \leq A < 1$ esetén a $\sum a_n$ sor abszolút konvergens (tehát konvergens is),
> 2. $A > 1$ esetén a $\sum a_n$ sor divergens,
> 3. $A = 1$ esetén a $\sum a_n$ sor lehet konvergens is, divergens is.

**Bizonyítás.** Mivel $\sqrt[n]{|a_n|} \geq 0$ $(n \in \mathbb{N})$, ezért $A \geq 0$.

**1.** Tegyük fel, hogy $\boxed{0 \leq A < 1}$. Vegyünk egy $A$ és $1$ közötti $q$ számot!

$$\lim\!\left(\sqrt[n]{|a_n|}\right) < q \implies \exists n_0 \in \mathbb{N},\ \forall n > n_0 : \sqrt[n]{|a_n|} < q, \text{ azaz } |a_n| < q^n.$$

Mivel $0 < q < 1$, ezért a $\sum q^n$ mértani sor konvergens. Így a majoráns kritérium szerint a $\sum |a_n|$ sor is konvergens, és ez azt jelenti, hogy a $\sum a_n$ végtelen sor abszolút konvergens.

**2.** Tegyük fel, hogy $\boxed{A > 1}$. Vegyünk most egy $1$ és $A$ közötti $q$ számot!

$$\lim\!\left(\sqrt[n]{|a_n|}\right) > q \implies \exists n_0 \in \mathbb{N},\ \forall n > n_0 : \sqrt[n]{|a_n|} > q, \text{ azaz } |a_n| > q^n.$$

Tehát, véges sok $n$ indextől eltekintve $|a_n| > q^n > 1$. Ebből következik, hogy $\lim(a_n) \neq 0$, és így a $\sum a_n$ sor divergens.

**3.** Tegyük fel, hogy $\boxed{A = 1}$. Ekkor

- a $\sum \frac{1}{n}$ divergens sor esetében $|a_n| = \frac{1}{n}$, azaz
$$\lim_{n \to +\infty} \sqrt[n]{|a_n|} = \lim_{n \to +\infty} \frac{1}{\sqrt[n]{n}} = 1;$$
- a $\sum \frac{1}{n^2}$ konvergens sor esetében $|a_n| = \frac{1}{n^2}$, azaz
$$\lim_{n \to +\infty} \sqrt[n]{|a_n|} = \lim_{n \to +\infty} \frac{1}{\sqrt[n]{n^2}} = 1.$$

---

## 4. A d'Alembert-féle hányadoskritérium

> *Tegyük fel, hogy a $\sum a_n$ végtelen sor tagjái közül egyik sem 0 és létezik az*
> $$A := \lim_{n \to +\infty} \left|\frac{a_{n+1}}{a_n}\right| \in \mathbb{R}$$
> *határérték. Ekkor*
> 1. $0 \leq A < 1$ *esetén a* $\sum a_n$ *sor abszolút konvergens (tehát konvergens is),*
> 2. $A > 1$ *esetén a* $\sum a_n$ *sor divergens,*
> 3. $A = 1$ *esetén a* $\sum a_n$ *sor lehet konvergens is, divergens is.*

**Bizonyítás.** Világos, hogy $A \geq 0$.

**1.** Legyen $\boxed{0 \leq A < 1}$ és vegyünk egy olyan $q$ számot, amire $A < q < 1$ teljesül. Ekkor

$$\lim_{n \to +\infty} \left|\frac{a_{n+1}}{a_n}\right| < q \implies \exists n_0 \in \mathbb{N},\ \forall n \geq n_0 : \left|\frac{a_{n+1}}{a_n}\right| < q, \text{ azaz } |a_{n+1}| < q|a_n|.$$

Ez azt jelenti, hogy

$$|a_{n_0+1}| < q|a_{n_0}|,\quad |a_{n_0+2}| < q|a_{n_0+1}|, \quad \ldots,\quad |a_n| < q|a_{n-1}|,$$

minden $n \geq n_0$ esetén, így

$$|a_n| < q|a_{n-1}| < q^2|a_{n-2}| < \cdots < q^{n-n_0}|a_{n_0}| = q^{-n_0}|a_{n_0}| \cdot q^n =: aq^n,$$

ahol $a := q^{-n_0}|a_{n_0}|$ egy $n$-től független konstans. A $\sum aq^n$ mértani sor konvergens, mert $0 < q < 1$. Ezért a majoráns kritérium szerint a $\sum |a_n|$ sor is konvergens, vagyis a $\sum a_n$ végtelen sor abszolút konvergens.

**2.** Legyen $\boxed{A > 1}$ és vegyünk most egy olyan $q$ számot, amire $1 < q < A$ teljesül. Ekkor

$$\lim_{n \to +\infty} \left|\frac{a_{n+1}}{a_n}\right| > q \implies \exists n_0 \in \mathbb{N},\ \forall n > n_0 : \left|\frac{a_{n+1}}{a_n}\right| > q, \text{ azaz } |a_{n+1}| > q|a_n| > |a_n|.$$

Ebből következik, hogy $\lim(a_n) \neq 0$, így a $\sum a_n$ sor divergens.

**3.** Tegyük fel, hogy $\boxed{A = 1}$. Ekkor

- a $\sum \frac{1}{n}$ divergens sor esetében $|a_n| = \frac{1}{n}$, azaz
$$\lim_{n\to+\infty} \left|\frac{a_{n+1}}{a_n}\right| = \lim_{n\to+\infty} \frac{n}{n+1} = 1;$$
- a $\sum \frac{1}{n^2}$ konvergens sor esetében $|a_n| = \frac{1}{n^2}$, azaz
$$\lim_{n\to+\infty} \left|\frac{a_{n+1}}{a_n}\right| = \lim_{n\to+\infty} \frac{n^2}{(n+1)^2} = 1. $$

---

## 5. Leibniz-típusú sorok konvergenciája

> *A $\sum_{n=1}^{\infty} (-1)^{n+1} a_n$ Leibniz-típusú sor akkor és csak akkor konvergens, ha $\lim(a_n) = 0$.*

**Bizonyítás.**

$(\Rightarrow)$ A sorok konvergenciájának szükséges feltétele értelmében, ha a $\sum(-1)^{n+1}a_n$ sor konvergens, akkor $\lim\!\left((-1)^{n+1}a_n\right) = 0$, ami csak akkor lehetséges, ha $\lim(a_n) = 0$.

$(\Leftarrow)$ Tegyük fel, hogy $\sum(-1)^{n+1}a_n$ egy Leibniz-típusú sor, és $\lim(a_n) = 0$. Igazoljuk, hogy a sor konvergens. Legyen

$$s_n := \sum_{k=1}^{n} (-1)^{k+1} a_k = a_1 - a_2 + a_3 - a_4 + a_5 - \cdots + (-1)^{n+1} a_n \qquad (n \in \mathbb{N}^+).$$

Szemléltessük az $(s_n)$ részletösszeg-sorozat első néhány tagját:

$$s_1 = a_1,$$
$$s_2 = a_1 - a_2 = s_1 - a_2,$$
$$s_3 = a_1 - a_2 + a_3 = s_2 + a_3,$$
$$s_4 = a_1 - a_2 + a_3 - a_4 = s_3 - a_4,$$
$$s_5 = a_1 - a_2 + a_3 - a_4 + a_5 = s_4 + a_5.$$

Most megmutatjuk, hogy a sejthető tendencia valóban igaz, azaz, hogy az $(s_{2n})$ sorozat monoton növekvő, és az $(s_{2n+1})$ sorozat monoton csökkenő.

- A páros indexű részsorozatnál a következő csoportosításból látható, hogy

$$s_{2n} = \underbrace{(a_1 - a_2)}_{\geq 0} + \underbrace{(a_3 - a_4)}_{\geq 0} + \cdots + \underbrace{(a_{2n-3} - a_{2n-2})}_{\geq 0} + \underbrace{(a_{2n-1} - a_{2n})}_{\geq 0}$$

minden $n \in \mathbb{N}^+$ esetén, tehát $(s_{2n})$ valóban monoton növekvő.

- Hasonlóan, a páratlan indexű részsorozatnál

$$s_{2n+1} = a_1 + \underbrace{(-a_2 + a_3)}_{\leq 0} + \underbrace{(-a_4 + a_5)}_{\leq 0} + \cdots + \underbrace{(-a_{2n-2} + a_{2n-1})}_{\leq 0} + \underbrace{(-a_{2n} + a_{2n+1})}_{\leq 0}$$

minden $n \in \mathbb{N}^+$ esetén, tehát $(s_{2n+1})$ monoton csökkenő sorozat.

Másrészt, az $s_0 := 0$ értelmezés mellett

$$s_{2n+1} - s_{2n} = a_{2n+1} \geq 0 \qquad (n \in \mathbb{N})$$

teljesül, amiből következik, hogy $s_{2n} \leq s_{2n+1}$ minden $n \in \mathbb{N}$ esetén. Ekkor

$$\tag{1} s_2 \leq s_4 \leq s_6 \leq \cdots \leq s_{2n} \leq s_{2n+1} \leq \cdots \leq s_5 \leq s_3 \leq s_1.$$

Tehát $(s_{2n})$ és $(s_{2n+1})$ korlátos sorozatok. Mivel mindkettő monoton és korlátos, ezért konvergens is. Jelölje $A = \lim(s_{2n+1})$ és $B = \lim(s_{2n})$ a határértékeiket. Ekkor

$$A - B = \lim_{n \to +\infty} s_{2n+1} - \lim_{n \to +\infty} s_{2n} = \lim_{n \to +\infty} (s_{2n+1} - s_{2n}) = \lim_{n \to +\infty} a_{2n+1} = \lim_{n \to +\infty} a_n = 0,$$

hiszen $(a_{2n+1})$ részsorozata az $(a_n)$ sorozatnak. Ezért $A = B$, tehát az $(s_{2n})$ és az $(s_{2n+1})$ részsorozatok határértéke megegyezik. Ebből következik, hogy az $(s_n)$ sorozat konvergens. Ez pedig azt jelenti, hogy a Leibniz-típusú sor valóban konvergens.

---

## 6. Minden $[0,1]$-beli szám felírható tizedes tört alakban

> *Minden $\alpha \in [0,1]$ számhoz létezik olyan*
> $$(a_n) : \mathbb{N}^+ \to \{0, 1, 2, \ldots, 9\}$$
> *sorozat, amire teljesül, hogy*
> $$\alpha = \sum_{n=1}^{+\infty} \frac{a_n}{10^n}.$$

**Bizonyítás.** Rögzítsük egy $\alpha \in [0,1]$ számot!

Az első lépésben osszuk fel a $[0,1]$ intervallumot 10 egyenlő hosszúságú részre. Ekkor

$$\exists a_1 \in \{0,1,2,\ldots,9\} : \alpha \in \left[\frac{a_1}{10}, \frac{a_1}{10} + \frac{1}{10}\right] =: I_1, \quad \text{azaz} \quad \frac{a_1}{10} \leq \alpha \leq \frac{a_1}{10} + \frac{1}{10}.$$

A második lépésben osszuk fel az $I_1$ intervallumot 10 egyenlő hosszúságú részre. Ekkor

$$\exists a_2 \in \{0,1,2,\ldots,9\} : \alpha \in \left[\frac{a_1}{10} + \frac{a_2}{10^2}, \frac{a_1}{10} + \frac{a_2}{10^2} + \frac{1}{10^2}\right] =: I_2, \quad \text{azaz} \quad \frac{a_1}{10} + \frac{a_2}{10^2} \leq \alpha \leq \frac{a_1}{10} + \frac{a_2}{10^2} + \frac{1}{10^2}.$$

Ha az eljárást folytatjuk, akkor az $n$-edik lépésben találunk olyan $a_n \in \{0,1,2,\ldots,9\}$ számot, hogy

$$s_n := \frac{a_1}{10} + \frac{a_2}{10^2} + \cdots + \frac{a_n}{10^n} \leq \alpha \leq \frac{a_1}{10} + \frac{a_2}{10^2} + \cdots + \frac{a_n}{10^n} + \frac{1}{10^n} = s_n + \frac{1}{10^n},$$

ahol $s_n$ a sor $n$-edik részletösszege. Ekkor

$$|\alpha - s_n| = \left|\alpha - \left(\frac{a_1}{10} + \frac{a_2}{10^2} + \cdots + \frac{a_n}{10^n}\right)\right| \leq \frac{1}{10^n} \xrightarrow[n \to +\infty]{} 0,$$

és így

$$\alpha = \lim_{n \to +\infty} s_n = \sum_{n=1}^{+\infty} \frac{a_n}{10^n}.$$

---

## 7. Konvergens sorok zárójelezése

> *Egy konvergens sor minden zárójelezése is konvergens sor, és összege az eredeti sor összegével egyenlő.*

**Bizonyítás.** Legyen $\sum_{n=1} \alpha_n$ a $\sum_{n=1} a_n$ sor $(m_n)$ által meghatározott zárójelezése, és jelölje $(\sigma_n)$ és $(s_n)$ rendre a két sor részletösszegeiből álló sorozatokat. Ha $\sum_{n=1} a_n$ konvergens, akkor $(s_n)$ minden részsorozata is konvergens, és határértéke megegyezik $(s_n)$ sorozat határértékével.

Mivel $\forall n \in \mathbb{N}^+$ indexre $\sigma_n = s_{m_n}$ teljesül, így $(\sigma_n)$ részsorozata az $(s_n)$ sorozatnak. Tehát a $(\sigma_n)$ sorozat konvergens és $\lim(\sigma_n) = \lim(s_n)$. Ez azt jelenti, hogy a $\sum a_n$ sor konvergens, és

$$\sum_{n=1}^{+\infty} \alpha_n = \lim_{n \to +\infty} \sigma_n = \lim_{n \to +\infty} s_n = \sum_{n=1}^{+\infty} a_n.$$

---

## 8. Abszolút konvergens sorok átrendezése

> *Ha a $\sum a_n$ végtelen sor abszolút konvergens, akkor tetszőleges $(p_n) : \mathbb{N} \to \mathbb{N}$ permutációval képzett $\sum a_{p_n}$ átrendezése is abszolút konvergens, és
> $$\sum_{n=0}^{+\infty} a_{p_n} = \sum_{n=0}^{+\infty} a_n.$$
> Tehát egy abszolút konvergens sor bármely átrendezése is abszolút konvergens sor, és összege ugyanaz, mint az eredeti soré.*

**Bizonyítás.** Legyen

$$s_n := \sum_{k=0}^{n} a_k \quad \text{és} \quad \sigma_n := \sum_{k=0}^{n} a_{p_k} \qquad (n \in \mathbb{N}).$$

**1. lépés.** Igazoljuk, hogy a $\sum a_{p_n}$ sor abszolút konvergens. Valóban, mivel $\sum a_n$ abszolút konvergens, ezért minden $n \in \mathbb{N}$-re

$$\sum_{k=0}^{n} |a_{p_k}| = |a_{p_0}| + |a_{p_1}| + \cdots + |a_{p_n}| \leq \sum_{k=0}^{+\infty} |a_k| = K < +\infty,$$

azaz a $\sum_{k=0}^{n} |a_{p_k}|$ $(n \in \mathbb{N})$ sorozat felülről korlátos, de nyilván monoton növekvő is, következésképpen a $\sum |a_{p_n}|$ sor konvergens. Így a $\sum a_{p_n}$ sor valóban abszolút konvergens.

**2. lépés.** Azt igazoljuk, hogy

$$\sum_{n=0}^{+\infty} a_{p_n} = \sum_{n=0}^{+\infty} a_n.$$

Legyen

$$A := \sum_{n=0}^{+\infty} a_n = \lim_{n \to +\infty} s_n \qquad \text{és} \qquad B := \sum_{n=0}^{+\infty} a_{p_n} = \lim_{n \to +\infty} \sigma_n.$$

Tudjuk, hogy a $\sum |a_n|$ sor konvergens, így a Cauchy-kritérium szerint

$$\forall \varepsilon > 0\text{-hoz } \exists n_0 \in \mathbb{N},\ \forall m > n \geq n_0 : |a_{n+1}| + |a_{n+2}| + \cdots + |a_m| < \varepsilon.$$

Ezért $n = n_0$ mellett, ha $m > n_0$, akkor $\sum_{k=n_0+1}^{m} |a_k| < \varepsilon$.

Adott $\varepsilon > 0$-ra tekintsük az $a_0, a_1, a_2, \ldots, a_{n_0}$ tagokat, és legyen $N_0$ olyan index, amire az $a_{p_0} + a_{p_1} + \cdots + a_{p_{N_0}}$ összeg már tartalmazza ezeket a tagokat. Ilyen $N_0$ nyilván létezik, és $N_0 \geq n_0$. Legyen $n > N_0$. Ekkor

$$\sigma_n - s_n = \left(a_{p_0} + a_{p_1} + \cdots + a_{p_{N_0}} + \cdots + a_{p_n}\right) - \left(a_0 + a_1 + \cdots + a_{n_0} + a_{n_0+1} + \cdots + a_m\right)$$

nem tartalmazza az $a_0, a_1, a_2, \ldots, a_{n_0}$ tagokat. Így

$$|\sigma_n - s_n| \leq \sum_{k=n_0+1}^{m} |a_k| < \varepsilon,$$

ahol $m := \max\{p_0, p_1, \ldots, p_n\}$, hiszen $m \geq n > N_0 \geq n_0$. Ez azt jelenti, hogy $(\sigma_n - s_n)$ nullsorozat. Ezért

$$\sigma_n = (\sigma_n - s_n) + s_n \xrightarrow[n \to +\infty]{} 0 + A = A,$$

azaz

$$B = \sum_{n=0}^{+\infty} a_{p_n} = \lim_{n \to +\infty} \sigma_n = \lim_{n \to +\infty} s_n = \sum_{n=0}^{+\infty} a_n = A.$$

---

## 9. Sorok téglányszorzatának konvergenciája

>  Tegyük fel, hogy a $\sum a_n$ és a $\sum b_n$ végtelen sorok konvergensek. Ekkor a
> $$\sum_{n=0}^{+\infty} t_n \text{ téglányszorzatuk is konvergens és}$$
> $$\sum_{n=0}^{+\infty} t_n = \sum_{n=0}^{+\infty} a_n \cdot \sum_{n=0}^{+\infty} b_n,$$
> azaz a konvergens sorok téglányszorzata is konvergens, és a téglányszorzat összege a két sor összegének szorzatával egyezik meg.

**Bizonyítás.** A bizonyítás alapja a sorozatoknál tanult műveletek és a határátmenet felcserélhetőségére vonatkozó tétel. Jelölje $A_n$, $B_n$ és $T_n$ rendre a $\sum_{n=0}^{\infty} a_n$, $\sum_{n=0}^{\infty} b_n$ és $\sum_{n=0}^{\infty} t_n$ sorok $n$-edik részletösszegeit. Ekkor

$$T_n = \sum_{k=0}^{n} t_k = \sum_{k=0}^{n} \left(\sum_{\max\{i,j\}=k} a_i b_j\right) = \sum_{\max\{i,j\} \leq n} a_i b_j = \left(\sum_{i=0}^{n} a_i\right) \cdot \left(\sum_{j=0}^{n} b_j\right) = A_n B_n,$$

és $A_n B_n \to \left(\sum_{n=0}^{+\infty} a_n\right) \cdot \left(\sum_{n=0}^{+\infty} b_n\right)$, ha $n \to +\infty$.

Ez azt jelenti, hogy a $(T_n)$ sorozat konvergens, és így a $\sum t_n$ végtelen sor is konvergens, és

$$\sum_{n=0}^{+\infty} t_n = \lim(T_n) = \left(\sum_{n=0}^{+\infty} a_n\right) \cdot \left(\sum_{n=0}^{+\infty} b_n\right).$$

---

## 10. Abszolút konvergens sorok szorzatai

> *Tegyük fel, hogy a $\sum a_n$ és $\sum b_n$ végtelen sorok mindegyike abszolút konvergens. Ekkor*
> 1. *a $\sum t_n$ téglányszorzat is abszolút konvergens,*
> 2. *a $\sum c_n$ Cauchy-szorzat is abszolút konvergens,*
> 3. *az összes $a_i b_j$ $(i, j \in \mathbb{N})$ szorzatból tetszés szerinti sorrendben és csoportosításban képzett $\sum d_n$ végtelen sor is abszolút konvergens, és*
> $$(*) \qquad \sum_{n=0}^{+\infty} d_n = \sum_{n=0}^{+\infty} t_n = \sum_{n=0}^{+\infty} c_n = \left(\sum_{n=0}^{+\infty} a_n\right) \cdot \left(\sum_{n=0}^{+\infty} b_n\right)  $$

**Bizonyítás.** Elég a 3. állítást igazolni. Mivel $\sum a_n$ és $\sum b_n$ abszolút konvergensek, ezért

$$A_N := \sum_{n=0}^{N} |a_n| \to A \in \mathbb{R}, \qquad B_N := \sum_{n=0}^{N} |b_n| \to B \in \mathbb{R} \quad (N \to +\infty).$$

Tekintsünk egy tetszőleges $\sum d_n$ sort, ahol $d_n = \sum a_i b_j$. Legyen $N \in \mathbb{N}$ tetszőleges. Jelölje $I$, illetve $J$ a maximális $i$, illetve $j$ indexet a $d_0, d_1, \ldots, d_N$ összegekben. Ekkor

$$\sum_{n=0}^{N} |d_n| \leq \sum_{\substack{0 \leq i \leq I \\ 0 \leq j \leq J}} |a_i b_j| = \left(\sum_{n=0}^{I} |a_n|\right) \cdot \left(\sum_{n=0}^{J} |b_n|\right) \leq A \cdot B,$$

és ez azt jelenti, hogy a $\sum |d_n|$ nemnegatív tagú sor konvergens, mert részletösszegei korlátotak. Tehát $\sum d_n$ abszolút konvergens.

A fentiek érvényesek $d_n = t_n$ esetén, így a $\sum t_n$ téglányszorzat is abszolút konvergens, tehát konvergens is. Ekkor az előző tétel szerint $(*)$ teljesül a $\sum t_n$ sorra, azaz

$$\sum_{n=0}^{+\infty} t_n = \sum_{n=0}^{+\infty} a_n \cdot \sum_{n=0}^{+\infty} b_n.$$

Legyen $\sum t_n^*$ az a sor, amelyet a $\sum t_n$ téglányszorzatban szereplő zárójelek elhagyásával kapunk. Mivel $\sum t_n^*$ is egy lehetséges $\sum d_n$ típusú sor, ezért $\sum t_n^*$ is abszolút konvergens, és így bármely zárójelezésével az összege nem változik, azaz $(*)$ teljesül a $\sum t_n^*$ sorra:

$$\sum_{n=0}^{+\infty} t_n^* = \sum_{n=0}^{+\infty} t_n = \sum_{n=0}^{+\infty} a_n \cdot \sum_{n=0}^{+\infty} b_n.$$

Azonban bármely $\sum d_n$ típusú sor megkapható a $\sum t_n^*$ sorból megfelelő átrendezéssel és csoportosítással. Ekkor a sor összege nem változik, tehát $(*)$ teljesül tetszőleges $\sum d_n$ sorra.

---

## 11. Hatványsorok konvergenciasugara

> Tetszőleges $\sum_{n=0}^{\infty} \alpha_n(x-a)^n$ hatványsor konvergenciahalmazára a következő három eset egyike áll fenn:
> 1. *$\exists\, 0 < R < +\infty$, hogy a hatványsor $\forall x \in \mathbb{R} : |x - a| < R$ pontban abszolút konvergens és $\forall x \in \mathbb{R} : |x - a| > R$ pontban divergens.*
> 2. *A hatványsor csak az $x = a$ pontban konvergens. Ekkor legyen $R := 0$.*
> 3. *A hatványsor abszolút konvergens $\forall x \in \mathbb{R}$ esetén. Ekkor legyen $R := +\infty$.*
> *$R$-et a hatványsor* **konvergenciasugarának** *nevezzük.*

**Bizonyítás.** Az állítást elég $a = 0$ esetén igazolni.

**Segédtétel.** Tegyük fel, hogy a $\sum \alpha_n x^n$ hatványsor konvergens egy $x_0 \neq 0$ pontban. Ekkor $\forall x \in \mathbb{R} : |x| < |x_0|$ esetén a hatványsor abszolút konvergens az $x$ pontban.

**A segédtétel bizonyítása.** Mivel a $\sum \alpha_n x_0^n$ végtelen sor konvergens, ezért $\lim(\alpha_n x_0^n) = 0$, így az $(\alpha_n x_0^n)$ sorozat korlátos, azaz

$$\exists M > 0 : |\alpha_n x_0^n| \leq M < +\infty \qquad (n \in \mathbb{N}).$$

Legyen $x \in \mathbb{R}$ olyan, amire $|x| < |x_0|$ teljesül. Ekkor

$$|\alpha_n x^n| = |\alpha_n x_0^n| \cdot \left|\frac{x}{x_0}\right|^n \leq M \cdot \left|\frac{x}{x_0}\right|^n =: Mq^n \qquad (n \in \mathbb{N}).$$

A $\sum |\alpha_n x^n|$ végtelen sor tehát majorálható a $\sum Mq^n$ mértani sorral, ami konvergens, mert $|q| = \left|\frac{x}{x_0}\right| < 1$. Így a majoráns kritérium szerint a $\sum |\alpha_n x^n|$ sor is konvergens, tehát a $\sum \alpha_n x^n$ végtelen sor abszolút konvergens. 

**A tétel bizonyítása.** Tekintsük a $\sum \alpha_n x^n$ hatványsort. Ez $x = 0$-ban nyilván konvergens, ezért $\mathrm{KH}\!\left(\sum \alpha_n x^n\right) \neq \emptyset$, és így

$$(1) \qquad  \exists \sup \mathrm{KH}\!\left(\sum \alpha_n x^n\right) =: R \in \overline{\mathbb{R}} \quad \text{és} \quad R \geq 0.$$

A következő három eset lehetséges.

1. $\underline{0 < R < +\infty}$. Legyen $|x| < R$ tetszőleges. Ekkor a szuprémum definíciója szerint $\exists x_0 > 0 : |x| < x_0 < R$ és $x_0$ a konvergenciahalmaz eleme, azaz $\sum \alpha_n x_0^n$ konvergens. Ekkor a segédtétel szerint $\sum \alpha_n x^n$ abszolút konvergens. Ha $|x| > R$ tetszőleges, akkor az $R$ szám definíciója és a segédtétel szerint a $\sum \alpha_n x^n$ sor divergens.

2. $\underline{R = 0}$. A $\sum \alpha_n x^n$ hatványsor az $x = 0$ pontban nyilván konvergens. Tegyük fel, hogy $x \neq 0$ olyan pont ahol $\sum \alpha_n x^n$ konvergens. Ekkor a segédtétel szerint a hatványsor konvergens az $\frac{|x|}{2} > 0$ pontban, ami nem lehetséges, mert $R = 0$. A hatványsor tehát csak az $x = 0$ pontban konvergens.

3. $\underline{R = +\infty}$. Legyen $x \in \mathbb{R}$ tetszőleges. Ekkor a szuprémum definíciója értelmében $\exists x_0 > 0 : |x| < x_0$ és $x_0$ a konvergenciahalmaz eleme, azaz $\sum \alpha_n x_0^n$ konvergens. Ekkor a segédtétel szerint $\sum \alpha_n x^n$ abszolút konvergens.

---

## 12. A Cauchy–Hadamard-tétel

> *Tekintsük a $\sum_{n=0}^{\infty} \alpha_n(x-a)^n$ hatványsort, és tegyük fel, hogy
> $$\exists \lim\!\left(\sqrt[n]{|\alpha_n|}\right) =: A \in \overline{\mathbb{R}}.$$
> Ekkor a hatványsor konvergenciasugara
> $$R = \frac{1}{A} \qquad \left(\frac{1}{+\infty} := 0,\quad \frac{1}{0} := +\infty\right).$$*

**Bizonyítás.** Nyilványvaló, hogy $A \geq 0$. Rögzítsük tetszőlegesen az $x \in \mathbb{R}$ számot, és alkalmazzuk a Cauchy-féle gyökkritériumot a $\sum \alpha_n(x-a)^n$ végtelen számsorra:

$$\lim_{n \to +\infty} \sqrt[n]{|\alpha_n(x-a)^n|} = \left(\lim_{n \to +\infty} \sqrt[n]{|\alpha_n|}\right) \cdot |x-a| = A|x-a|,$$

és így

$$A|x-a| < 1 \implies \text{a sor konvergens}, \qquad A|x-a| > 1 \implies \text{a sor divergens}.$$

1. Ha $0 < A < +\infty$, akkor $A$-val lehet osztani, és ekkor

$$x \in \left(a - \frac{1}{A},\, a + \frac{1}{A}\right) \implies \text{a sor konv.,} \qquad x \notin \left[a - \frac{1}{A},\, a + \frac{1}{A}\right] \implies \text{a sor div.,}$$

amiből következik, hogy $R = 1/A$.

2. Ha $A = +\infty$, akkor $\forall x \in \mathbb{R},\, x \neq a : A|x-a| = (+\infty) \cdot |x-a| = +\infty > 1$. Ezért a hatványsor az $x = a$ pont kivételével divergens, azaz $R = 0$.

3. Ha $A = 0$, akkor $\forall x \in \mathbb{R} : A|x-a| = 0 \cdot |x-a| = 0 < 1$. Ezért a hatványsor minden $x \in \mathbb{R}$ pontban konvergens, azaz $R = +\infty$.

---

## 13. Függvények határértékének egyértelműsége

> Ha az $f \in \mathbb{R} \to \mathbb{R}$ függvénynek az $a \in \mathcal{D}'_f$ pontban van határértéke, akkor a definícióban szereplő $A \in \overline{\mathbb{R}}$ egyértelműen létezik.

**Bizonyítás.** Tegyük fel, hogy két különböző $A_1, A_2 \in \overline{\mathbb{R}}$ elem eleget tesz a definíció feltételeinek. Mivel két különböző $\overline{\mathbb{R}}$-beli elem diszjunkt környezetekkel szétválasztható, ezért

$$\exists \varepsilon > 0 : K_\varepsilon(A_1) \cap K_\varepsilon(A_2) = \emptyset.$$

A határérték definíciója szerint egy ilyen $\varepsilon$-hoz

$$\exists \delta_1 > 0,\ \forall x \in \dot{K}_{\delta_1}(a) \cap \mathcal{D}_f : f(x) \in K_\varepsilon(A_1),$$
$$\exists \delta_2 > 0,\ \forall x \in \dot{K}_{\delta_2}(a) \cap \mathcal{D}_f : f(x) \in K_\varepsilon(A_2).$$

Legyen $\delta := \min\{\delta_1, \delta_2\}$. Ekkor

$$\forall x \in \dot{K}_\delta(a) \cap \mathcal{D}_f : f(x) \in K_\varepsilon(A_1) \cap K_\varepsilon(A_2) = \emptyset, \quad \text{de } \dot{K}_\delta(a) \cap \mathcal{D}_f \neq \emptyset, \text{ mert } a \in \mathcal{D}'_f.$$

Ellentmondásra jutottunk, és ezzel a határérték egyértelműségét igazoltuk.

---

## 14. A határértékre vonatkozó átviteli elv

> Legyen $f \in \mathbb{R} \to \mathbb{R}$, $a \in \mathcal{D}'_f$ és $A \in \overline{\mathbb{R}}$. Ekkor
> $$\lim_a f = A \iff \forall (x_n) : \mathbb{N} \to \mathcal{D}_f \setminus \{a\},\ \lim_{n \to +\infty} x_n = a \text{ esetén } \lim_{n \to +\infty} f(x_n) = A.$$

**Bizonyítás.**

$(\Rightarrow)$ $\lim_a f = A \implies \forall \varepsilon > 0$-hoz $\exists \delta > 0$, $\forall x \in \dot{K}_\delta(a) \cap \mathcal{D}_f : f(x) \in K_\varepsilon(A)$.

Legyen $(x_n)$ egy a tételben szereplő sorozat, és $\varepsilon > 0$ egy tetszőlegesen rögzített érték.

$$\lim(x_n) = a \implies \delta\text{-hoz } \exists n_0 \in \mathbb{N},\ \forall n > n_0 : x_n \in K_\delta(a).$$

Mivel $x_n \in \mathcal{D}_f \setminus \{a\}$, így $x_n \in \dot{K}_\delta(a) \cap \mathcal{D}_f$, amiből $f(x_n) \in K_\varepsilon(A)$ teljesül minden $n > n_0$ indexre. Ez azt jelenti, hogy az $\left(f(x_n)\right)$ sorozatnak van határértéke, és $\lim_{n \to +\infty} f(x_n) = A$.

$(\Leftarrow)$ Tegyük fel, hogy

$$\forall (x_n) : \mathbb{N} \to \mathcal{D}_f \setminus \{a\},\quad \lim_{n \to +\infty} x_n = a \text{ esetén } \lim_{n \to +\infty} f(x_n) = A.$$

Megmutatjuk, hogy $\lim_a f = A$.

Indirekt módon tegyük fel, hogy a $\lim_a f = A$ egyenlőség nem igaz. Ez pontosan azt jelenti, hogy

$$\exists \varepsilon > 0,\ \forall \delta > 0\text{-hoz } \exists x_\delta \in \dot{K}_\delta(a) \cap \mathcal{D}_f : f(x_\delta) \notin K_\varepsilon(A).$$

A $\delta = \frac{1}{n}$ $(n \in \mathbb{N}^+)$ választással ez azt jelenti, hogy

$$\exists \varepsilon > 0,\ \forall n \in \mathbb{N}^+\text{-hoz } \exists x_n \in \dot{K}_{1/n}(a) \cap \mathcal{D}_f : f(x_n) \notin K_\varepsilon(A).$$

Legyen $x_0 \in \mathcal{D}_f \setminus \{a\}$ tetszőleges. Az $(x_n) : \mathbb{N} \to \mathcal{D}_f \setminus \{a\}$ sorozat nyilván $a$-hoz tart (hiszen $x_n \in K_{1/n}(a)$), de a függvényértékek $\left(f(x_n)\right)$ sorozata nem tart $A$-hoz (hiszen $f(x_n) \notin K_\varepsilon(A)$), ami ellentmond a feltételünknek. 

---

## 15. Monoton függvények határértéke

> *Legyen $(\alpha, \beta) \subset \mathbb{R}$ tetszőleges (korlátos vagy nem korlátos) nyílt intervallum. Ha az $f$ függvény monoton $(\alpha, \beta)$-n, akkor $f$-nek $\forall a \in (\alpha, \beta)$ pontban létezik a jobb oldali, illetve a bal oldali határértéke, és ezek végesek.
> a) Ha $f$ növekvő $(\alpha, \beta)$-n, akkor
> $$\lim_{x \to a^+} f(x) = \inf\{ f(x) \mid x \in (\alpha, \beta),\, x > a \},$$
> $$\lim_{x \to a^-} f(x) = \sup\{ f(x) \mid x \in (\alpha, \beta),\, x < a \}.$$
> b) Ha $f$ csökkenő $(\alpha, \beta)$-n, akkor
> $$\lim_{x \to a^+} f(x) = \sup\{ f(x) \mid x \in (\alpha, \beta),\, x > a \},$$
> $$\lim_{x \to a^-} f(x) = \inf\{ f(x) \mid x \in (\alpha, \beta),\, x < a \}.$$*

**Bizonyítás.** Tegyük fel, hogy $f$ növekvő $(\alpha, \beta)$-n. A jobb oldali határértékre vonatkozó állítást igazoljuk.

Legyen

$$m := \inf\{ f(x) \mid x \in (\alpha, \beta),\, x > a \}.$$

Világos, hogy $m \in \mathbb{R}$. Az infimum definíciójából következik, hogy

i) $\forall x \in (\alpha, \beta),\, x > a : m \leq f(x)$,

ii) $\forall \varepsilon > 0$-hoz $\exists x_1 \in (\alpha, \beta),\, x_1 > a : f(x_1) < m + \varepsilon$.

Így $m \leq f(x_1) \leq m + \varepsilon$. Mivel $f$ növekvő $(\alpha, \beta)$-n, ezért

$$m \leq f(x) \leq f(x_1) < m + \varepsilon \qquad \bigl(x \in (a, x_1)\bigr).$$

A $\delta := x_1 - a > 0$ választással tehát azt mutattuk meg, hogy

$$\forall \varepsilon > 0\text{-hoz}\ \exists \delta > 0,\ \forall x \in (\alpha, \beta),\, a < x < a + \delta : 0 \leq f(x) - m < \varepsilon,$$

vagyis $f(x) \in K_\varepsilon(m)$. Ez pedig azt jelenti, hogy $f$-nek $a$-ban van jobb oldali határértéke, és az $m$-mel egyenlő, azaz

$$\lim_{x \to a^+} f(x) = m = \inf\{ f(x) \mid x \in (\alpha, \beta),\, x > a \}.$$

A tétel többi állítása hasonlóan bizonyítható.

---

## 16. Az összetett függvény folytonossága

> *Tegyük fel, hogy $f, g \in \mathbb{R} \to \mathbb{R}$, $g \in C\{a\}$ és $f \in C\{g(a)\}$. Ekkor $f \circ g \in C\{a\}$, azaz az összetett függvény „örökli" a belső- és a külső függvény folytonosságát.*

**Bizonyítás.** A feltételek szerint $g(a) \in \mathcal{D}_f$, ezért $g(a) \in \mathcal{R}_g \cap \mathcal{D}_f$, azaz $\mathcal{R}_g \cap \mathcal{D}_f \neq \emptyset$. Így valóban beszélhetünk az $f \circ g$ összetett függvényről, és $a \in \mathcal{D}_{f \circ g}$ is igaz.

Legyen $(x_n) : \mathbb{N} \to \mathcal{D}_{f \circ g} \subset \mathcal{D}_g$ egy olyan sorozat, amelyre $\lim(x_n) = a$. Mivel $g \in C\{a\}$, így a folytonosságra vonatkozó átviteli elv szerint $\lim\!\left(g(x_n)\right) = g(a)$. Jelölje

$$b := g(a) \qquad \text{és} \qquad y_n := g(x_n) \quad (n \in \mathbb{N}).$$

Ekkor $(y_n) : \mathbb{N} \to \mathcal{D}_f$ és $\lim(y_n) = b$. Mivel $f \in C\{b\}$, így a folytonosságra vonatkozó átviteli elv szerint $\lim\!\left(f(y_n)\right) = f(b)$. Ugyanakkor

$$f(b) = f\!\left(g(a)\right) = (f \circ g)(a) \qquad \text{és} \qquad f(y_n) = f\!\left(g(x_n)\right) = (f \circ g)(x_n) \quad (n \in \mathbb{N}).$$

Azt igazoltuk tehát, hogy $\forall (x_n) : \mathbb{N} \to \mathcal{D}_{f \circ g}$, $\lim(x_n) = a$ sorozat esetén igaz, hogy

$$\lim_{n \to +\infty} (f \circ g)(x_n) = \lim_{n \to +\infty} \left(f(y_n)\right) = f(b) = (f \circ g)(a).$$

Ezért a folytonosságra vonatkozó átviteli elv szerint $f \circ g \in C\{a\}$. 
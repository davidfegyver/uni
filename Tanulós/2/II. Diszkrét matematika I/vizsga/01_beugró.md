### I. Logika és halmazok

**1. Predikátum**
* A predikátumok olyan változóktól függő kijelentések, amelyekhez a változóik értékétől függően valamilyen igazságérték tartozik (igaz vagy hamis, de a kettő egyszerre nem teljesülhet).

**2. ÉS ($\wedge$), VAGY ($\vee$) igazságtáblája**

* **ÉS ($\wedge$) tábla:** Csak akkor Igaz (I), ha mindkét állítás Igaz (I).
* **VAGY ($\vee$) tábla:** Akkor Hamis (H), ha mindkét állítás Hamis (H), minden más esetben Igaz (I).

**3. Tagadás ($\neg$) és implikáció ($\Rightarrow$)**
* ***Tagadás:** Ha az állítás I, a tagadása H, és fordítva.
* **Implikáció ($A \Rightarrow B$):** Csak akkor Hamis (H), ha A igaz (I), de B hamis (H).

**4. Kvantorok**
* Az egzisztenciális kvantor ($\exists$) jelentése: "létezik" vagy "van olyan".
* Az univerzális kvantor ($\forall$) jelentése: "minden".

**5-6. Halmazműveletek**
* ***Unió:** $A \cup B = \{x : x \in A \vee x \in B\}$.
* **Metszet:** $A \cap B = \{x : x \in A \wedge x \in B\}$.
* **Szimmetrikus differencia:** $A \triangle B = (A \setminus B) \cup (B \setminus A)$.

**7. Ekvivalenciareláció**
- reflexív,
- tranzitív és 
- szimmetrikus
**8. Osztályozás**
Az X halmaz osztályozása olyan nem üres részhalmazok rendszere, amelyek
- páronként diszjunktak,
- uniójuk X.

---

### II. Relációk

**1. Binér reláció fogalma**
* Legyen X és Y két tetszőleges halmaz. Ekkor az $R \subset X \times Y$ halmazt egy (binér) relációnak nevezzük az X és Y halmazok között.
**2. Értelmezési tartomány és értékkészlet**
* **Értelmezési tartomány:** $dmn(R) = \{x \in X : \exists y \in Y : (x,y) \in R\}$.
* **Értékkészlet:** $rng(R) = \{y \in Y : \exists x \in X : (x,y) \in R\}$.
* **Feladat:** Az $R=\{(a,1),(a,2),(b,1),(b,4)\}$ reláció esetén: $dmn(R) = \{a, b\}$, az értékkészlet pedig $rng(R) = \{1, 2, 4\}$.
**3. Kompozíció ($S \circ R$)**
* $R \circ S = \{(x,y) : \exists z : (x,z) \in S, (z,y) \in R\}$
**4-6. Relációk tulajdonságai**
- **Szimmetrikus reláció:**  $\forall x,y \in X : xRy \Rightarrow yRx$
- **Reflexív reláció:**  ha $\forall x \in X : xRx$
- **Tranzitív reláció:** Egy $R$ reláció tranzitív, ha $\forall x,y,z \in X : xRy \wedge yRz \Rightarrow xRz$. 
---

### III. Komplex számok

**1. Trigonometrikus alak**
* A $z = a + bi$ trigonometrikus alakja: $z = r(\cos\varphi + i\sin\varphi)$, ahol $r = |z|$. A $z=1+i$ esetén: $r = \sqrt{1^2+1^2} = \sqrt{2}$, $\varphi = \pi/4$. Tehát: $z = \sqrt{2}(\cos(\frac{\pi}{4}) + i\sin(\frac{\pi}{4}))$.

**2. Szorzás (Moivre)**
* **Tétel:** $z \cdot w = |z||w|(\cos(\varphi+\psi) + i\sin(\varphi+\psi))$.
**3. Osztás (Moivre)**
* **Tétel:** $z / w = \frac{|z|}{|w|}(\cos(\varphi-\psi) + i\sin(\varphi-\psi))$.
**4. Hatványozás (Moivre)**
* **Tétel:** $z^n = |z|^n(\cos(n\varphi) + i\sin(n\varphi))$.
**5. N-edik gyökök**
Ha
$$w=r(\cos\varphi+i\sin\varphi)  $$
akkor
$$z_k=  
\sqrt[n]{r}  
\left(  
\cos\frac{\varphi+2k\pi}{n}  
+  
i\sin\frac{\varphi+2k\pi}{n}  
\right)  $$
ahol
$$k=0,1,\dots,n-1.  $$

---

### IV. Kombinatorika

* **1. Ismétlés nélküli permutáció:** $n$ különböző elem lehetséges sorrendjeinek száma $n!$
* **2. Ismétléses permutáció:** Ha az $n$ elem között vannak azonosak, a formula: $\frac{n!}{k_1!\cdot k_2! \cdot ... \cdot k_m!}$.
* **3. Ismétléses variáció:** Sorrend számít, elem ismétlődhet: $n^k$. 
* **4. Ismétlés nélküli variáció:** Sorrend számít, elem nem ismétlődhet: $\frac{n!}{(n-k)!}$. 7 betűből 5 hosszú szó: $\frac{7!}{(7-5)!} = 2520$.
* **5. Ismétlés nélküli kombináció:** Sorrend nem számít, ismétlés nincs: $\binom{n}{k} = \frac{n!}{k!(n-k)!}$.
* **6. Ismétléses kombináció:** Sorrend nem számít, elem ismétlődhet: $\binom{n+k-1}{k}$. 5 fajta fagyiból 3 gombóc: $\binom{5+3-1}{3} = \binom{7}{3} = 35$.

---

### V. Gráfok
**1. Fokszámtétel**
* Minden $G=(V,E)$ gráfra a csúcsok fokszámainak összege egyenlő az élek számának kétszeresével: $\sum_{v \in V} d(v) = 2|E|$
**2. Izomorfia**
* **Definíció:** Két gráf ($G$ és $H$) izomorf, ha léteznek olyan bijekciók (egyértelmű megfeleltetések) a csúcsaik és éleik között, amelyek tartják az illeszkedést
**3. Részgráf és feszített részgráf**
- **Definíciók:**
    - **Részgráf:** Egy $H$ gráf részgráfja a $G$ gráfnak, ha a $H$ csúcsai megtalálhatóak a $G$ csúcsai között, és a $H$ élei is benne vannak a $G$ éleiben.
    - **Feszített részgráf:** Olyan részgráf, amelyik az adott csúcshalmaz között a _lehető legtöbb_ élt tartalmazza. Tehát, ha kiválasztunk néhány csúcsot az eredeti $G$ gráfból, akkor a feszített részgráfba az **összes** olyan él is bekerül, ami az eredeti gráfban összekötötte ezeket a csúcsokat.
**4. Séta**
- **Definíció:** Legyen $G = (V,E)$ egy gráf. Egy $v_0, e_1, v_1, ..., v_{k-1}, e_k, v_k$ sorozatot $k$-hosszú sétának nevezünk, ha minden $v_i$ egy csúcs ($v_i \in V$), minden $e_i$ egy él ($e_i \in E$), és az $e_i$ él pontosan a $v_{i-1}$ és $v_i$ csúcsokat köti össze. A sétában lehetnek ismétlődő csúcsok és élek is.
**5. Út**
- **Definíció:** Egy séta akkor egy $k$-hosszú út, ha abban semmilyen csúcs nem ismétlődik, azaz $v_i \ne v_j$, ha $i \ne j$.
**6. Összefüggő gráf**
- **Definíció:** Egy gráf összefüggő, ha bármely $u$ és $v$ ($u \ne v$) csúcsa között halad séta.
**7. Fa**
- **Definíció:** Egy $G=(V,E)$ gráfot fának hívunk, ha egyszerre összefüggő és körmentes.
**8. Euler-séta**
* **Definíció:** Olyan séta, amely a gráf minden élét pontosan egyszer tartalmazza. (Zárt, ha a kezdő- és végpont megegyezik)
**9. Hamilton-út**
* **Definíció:** A Hamilton-út egy olyan út a gráfban, amely a gráf minden csúcsát pontosan egyszer érinti.
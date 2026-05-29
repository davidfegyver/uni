## 1. **Mit jelent az, hogy $a \in \overline{\mathbb{R}}$ torlódási pontja a $H \subset \mathbb{R}$ halmaznak?**
Az $a \in \overline{\mathbb{R}}$ elem akkor és csak akkor torlódási pontja a $\emptyset \neq H \subset \mathbb{R}$ halmaznak, ha $a$ minden környezete tartalmaz $a$-tól különböző $H$-beli elemet. 
$$a \in H' \iff \forall \epsilon > 0 : \dot{K}_{\epsilon}(a) \cap H \neq \emptyset$$
ahol a $\dot{K}_{\epsilon}(a) = K_{\epsilon}(a) \setminus \{a\}$ a pontozott környezetet jelöli.

## 2. **Környezetek segítségével adja meg a függvényhatárérték egységes definícióját!**
Azt mondjuk, hogy az $f : \mathbb{R} \to \mathbb{R}$ függvénynek az $a \in \mathcal{D}_f'$ pontban van határértéke, ha létezik olyan $A \in \overline{\mathbb{R}}$, amelyre:
$$\forall \epsilon > 0 \text{-hoz } \exists \delta > 0, \forall x \in (K_{\delta}(a) \setminus \{a\}) \cap \mathcal{D}_f : f(x) \in K_{\epsilon}(A)$$
Ezt pontozott környezetekkel rövidebben is felírhatjuk: $\forall x \in \dot{K}_{\delta}(a) \cap \mathcal{D}_f : f(x) \in K_{\epsilon}(A)$
## 3. **Adja meg egyenlőtlenségek segítségével a végesben vett véges határérték definícióját!**
Ebben az esetben $a \in \mathbb{R}$ és $A \in \mathbb{R}$. 
$$\forall \epsilon > 0 \text{-hoz } \exists \delta > 0, \forall x \in \mathcal{D}_f, 0 < |x - a| < \delta : |f(x) - A| < \epsilon$$

## 4. **Adja meg egyenlőtlenségek segítségével a plusz végtelenben vett véges határérték definícióját!**
Ebben az esetben $a = +\infty$ és $A \in \mathbb{R}$. 
$$\forall \epsilon > 0 \text{-hoz } \exists x_0 > 0, \forall x \in \mathcal{D}_f, x > x_0 : |f(x) - A| < \epsilon$$
## 5. **Írja le a határértékre vonatkozó átviteli elvet!** ??
Legyen $f : \mathbb{R} \to \mathbb{R}$, $a \in \mathcal{D}_f'$ és $A \in \overline{\mathbb{R}}$. Az átviteli elv kimondja, hogy a függvényhatárérték sorozatok határértékével jellemezhető:
$$\lim_{a} f = A \iff \forall (x_n) : \mathbb{N} \to \mathcal{D}_f \setminus \{a\}, \lim_{n \to +\infty} x_n = a \text{ esetén } \lim_{n \to +\infty} f(x_n) = A$$

## 6. **Hogyan szól a függvények hányadosának a határértékére vonatkozó tétel?**
Tegyük fel, hogy $f, g : \mathbb{R} \to \mathbb{R}$, $a \in (\mathcal{D}_f \cap \mathcal{D}_g)'$, és léteznek az $A := \lim_{a} f \in \overline{\mathbb{R}}$ és $B := \lim_{a} g \in \overline{\mathbb{R}}$ határértékek. Ekkor az $f/g$ hányadosfüggvénynek is van határértéke az $a$ pontban, és:
$$\lim_{a} \frac{f}{g} = \frac{\lim_{a} f}{\lim_{a} g} = \frac{A}{B}$$
feltéve, hogy az $\frac{A}{B} \in \overline{\mathbb{R}}$ hányados értelmezve van.

## 7. **Definiálja függvény jobb oldali határértékét!**
Legyen $f : \mathbb{R} \to \mathbb{R}$, és tegyük fel, hogy $a \in \mathbb{R}$, valamint $a \in (\mathcal{D}_f \cap (a, +\infty))'$. Azt mondjuk, hogy az $f$ függvénynek az $a$ helyen van jobb oldali határértéke, ha $\exists A \in \overline{\mathbb{R}}$, hogy:
$$\forall \epsilon > 0 \text{-hoz } \exists \delta > 0, \forall x \in \mathcal{D}_f, a < x < a + \delta : f(x) \in K_{\epsilon}(A)$$
![[Pasted image 20260417152121.png]]
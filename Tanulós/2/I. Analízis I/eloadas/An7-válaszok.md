### 1. Írja le a hatványsor definícióját!

Az adott $(\alpha_{n}):\mathbb{N}\rightarrow\mathbb{R}$ sorozattal és az $a\in\mathbb{R}$ számmal képzett

$$\sum_{n=0}\alpha_{n}(x-a)^{n}=\alpha_{0}+\alpha_{1}(x-a)+\alpha_{2}(x-a)^{2}+\dots$$

$(x\in\mathbb{R})$ függvénysort $a\in\mathbb{R}$ középpontú, $(\alpha_{n})$ együtthatójú hatványsornak nevezzük.

### 2. Hogyan szól a hatványsor konvergenciahalmazára vonatkozó, a konvergenciasugarát meghatározó tétel?

Tetszőleges $\sum_{n=0}\alpha_{n}(x-a)^{n}$ hatványsor konvergenciahalmazára a következő három eset egyike áll fenn:

1. $\exists0<R<+\infty$, hogy a hatványsor $\forall x\in\mathbb{R}:|x-a|<R$ pontban abszolút konvergens és $\forall x\in\mathbb{R}:|x-a|>R$ pontban divergens.
2. A hatványsor csak az $x=a$ pontban konvergens. Ekkor legyen $R:=0$.
3. A hatványsor abszolút konvergens $\forall x\in\mathbb{R}$ esetén. Ekkor legyen $R:=+\infty$.

Az $R$-et a hatványsor konvergenciasugarának nevezzük.

### 3. Adjon meg egy olyan hatványsort, amelyiknek a konvergenciahalmaza a $(-1, 1)$ intervallum!

Ilyen hatványsor például a $\sum_{n=0}x^{n}$ , amelynek konvergenciahalmaza $(-1,1)$.
### 4. Adjon meg egy olyan hatványsort, amelyiknek a konvergenciahalmaza a $[-1, 1)$ intervallum!

Ilyen hatványsor például a $\sum_{n=1}\frac{1}{n}x^{n}$, amelynek konvergenciahalmaza $[-1,1)$.

### 5. Definiálja az $\exp$ függvényt!

A $\sum_{n=0}\frac{x^{n}}{n!}$ hatványsor minden $x\in\mathbb{R}$ pontban abszolút konvergens. Az összegfüggvényét, vagyis az

$$\exp(x):=\sum_{n=0}^{+\infty}\frac{x^{n}}{n!}=1+x+\frac{x^{2}}{2!}+\frac{x^{3}}{3!}+\frac{x^{4}}{4!}+\dots$$

függvényt exponenciális függvénynek nevezzük.

### 6. Definiálja a $\sin$ függvényt!

A $\sum_{n=0}(-1)^{n}\frac{x^{2n+1}}{(2n+1)!}$ hatványsor minden $x\in\mathbb{R}$ pontban abszolút konvergens. Az összegfüggvényét, vagyis a

$$\sin(x):=\sum_{n=0}^{+\infty}(-1)^{n}\frac{x^{2n+1}}{(2n+1)!}=x-\frac{x^{3}}{3!}+\frac{x^{5}}{5!}+\dots$$

függvényt szinuszfüggvénynek nevezzük.

### 7. Definiálja a $\cos$ függvényt!

A $\sum_{n=0}(-1)^{n}\frac{x^{2n}}{(2n)!}$ hatványsor minden $x\in\mathbb{R}$ pontban abszolút konvergens. Az összegfüggvényét, vagyis a

$$\cos(x):=\sum_{n=0}^{+\infty}(-1)^{n}\frac{x^{2n}}{(2n)!}=1-\frac{x^{2}}{2!}+\frac{x^{4}}{4!}+\dots$$

függvényt koszinuszfüggvénynek nevezzük.
* Bemenet: `int[] x`
	* Első elem - `0`
	* Utolsó elem - `x.Length - 1`
- Feltételek:
	- `bool T(int val)`
### 1. Összegzés

```cs
int s = 0; 

for (int i = e; i <= u; i++) 
{
    s = s + x[i];
}
//Ki: 's'
```

---
### 2. Megszámolás

```cs
int db = 0;

for (int i = e; i <= u; i++) 
{
    if (T(x[i])) 
    {
        db = db + 1;
    }
}
// Ki: 'db'
```

---
### 3. Maximumkiválasztás 

```cs
int maxért = x[e];
int maxind = e;

for (int i = e + 1; i <= u; i++) 
{
    if (x[i] > maxért) 
    {
        maxért = x[i];
        maxind = i;
    }
}
// Ki: 'maxind', 'maxért'
```

---
### 4. Minimumkiválasztás

```cs
int minért = x[e];
int minind = e;

for (int i = e + 1; i <= u; i++) 
{
    if (x[i] < minért) 
    {
        minért = x[i];
        minind = i;
    }
}
// Ki: 'minind', 'minért' 
```

---
### 5. Feltételes Maximumkeresés

```cs
bool van = false;
int maxind = -1;
int maxért = 0;

for (int i = e; i <= u; i++) 
{
    if (T(x[i])) 
    {
        if (!van) 
        {
            van = true;
            maxért = x[i];
            maxind = i;
        }
        else 
        {
            if (x[i] > maxért) 
            {
                maxért = x[i];
                maxind = i;
            }
        }
    }
}
// Ki: 'van', 'maxind', 'maxért'
```

---
### 6. Keresés 

```cs
int i = e;

while (i <= u && !T(x[i])) 
{
    i = i + 1;
}

bool van = (i <= u);
int ind = i; 

// Ki: 'van', 'ind'
```

---
### 7. Eldöntés

```cs
int i = e;

while (i <= u && !T(x[i])) 
{
    i = i + 1;
}

bool van = (i <= u);
// Ki: 'van'
```

---
### 8. Mind eldöntés

```cs
int i = e;

while (i <= u && T(x[i])) 
{
    i = i + 1;
}

bool mind = (i > u);
// Ki: 'mind'
```

---
### 9. Kiválasztás

```cs
int i = e;

while (!T(x[i])) 
{
    i = i + 1;
}

int ind = i;
// Ki: 'ind' 
```

---
### 10. Másolás

```cs
int[] y = new int[u - e + 1];

for (int i = e; i <= u; i++) 
{
    y[i - e] = x[i];
}
// Ki: 'y'
```

---
### 11. Kiválogatás

**Tömb és számláló használatával

```cs
int[] y = new int[u - e + 1];
int db = 0;

for (int i = e; i <= u; i++) 
{
    if (T(x[i])) 
    {
        y[db] = x[i];
        db = db + 1;
    }
}
// Ki: 'y' 
```

**Dinamikus lista használatával 
```cs
List<int> y = new List<int>();

for (int i = e; i <= u; i++) 
{
    if (T(x[i])) 
    {
        y.Add(x[i]);
    }
}
// Ki: 'y'
```
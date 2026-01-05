# *✨A "tetszőleges papír alapú segédanyag"✨📄*
---
⚠️ `using System;` – bírós futtatáshoz kell
#### 1. Alaptípusok & Konstansok
```cs
byte byteValue = 255;            // 0-tól 255-ig (8 bites előjel nélküli egész)
int intValue = -2147483648;      // 32 bites előjeles egész
float floatValue = 3.14f;        // 32 bites lebegőpontos (az 'f' kötelező a végére!)
double doubleValue = 3.14159;    // 64 bites (ez az alapértelmezett tizedeseknél)
bool trueValue = true;           // logikai: true (igaz) vagy false (hamis)
char escapeChar = '\n';          // Egyetlen karakter (itt: sortörés)

// Konstansok (Fordítási idejű állandó, nem változhat)
const double Pi = 3.14159;
const string MyPokemon = "Pikachu";
```

#### 2. String (Szöveg) Kezelés
```cs
string name = "Angyi";
string path = "C:\\Windows";

// Interpoláció (Behelyettesítés) & Szószerinti (Verbatim) mód
string greeting = $"Szia, {name}!";  // $ jel: változó beillesztése
string verbatim = $@"User: {name}
Path: {path}"; // @ jel: megőrzi a sortörést és nem kell dupla backslash (\\)

// Gyakori Metódusok
string text = "Hello, Világ!";
int len = text.Length;                        // Hossz: 13
bool hasWorld = text.Contains("Világ");       // Tartalmazza-e? (true)
string sub = text.Substring(0, 5);            // Kivágás (start index, hossz): "Hello"
string upper = text.ToUpper();                // Nagybetűsítés: "HELLO, VILÁG!"
string clean = "  szöveg  ".Trim();           // Szóköz levágás a szélekről: "szöveg"
string replaced = text.Replace("Hello", "Szia"); // Csere: "Szia, Világ!"
string[] parts = text.Split(',');             // Darabolás karakter mentén

// Kis/nagybetű független összehasonlítás
bool same = string.Equals("abc", "ABC", StringComparison.OrdinalIgnoreCase); 
```

#### 3. Logika & Vezérlés
```cs
int age = 20;

// Ternary (Háromoperandusú) Operátor (rövid if-else)
// Feltétel ? Ha_Igaz : Ha_Hamis
string status = age >= 18 ? "Felnőtt" : "Kiskorú";

// Null-Coalescing (??)
// Visszaadja a balt, ha nem null, különben a jobbat
string currentName = userName ?? "Vendég"; 

// If / Else If / Else
if (age > 60) {
    Console.WriteLine("Nyugdíjas");
} else if (age > 18) {
    Console.WriteLine("Felnőtt");
} else {
    Console.WriteLine("Kiskorú");
}

// Switch Szerkezet (többágú elágazás)
DayOfWeek today = DayOfWeek.Monday;
switch (today)
{
    case DayOfWeek.Monday:
        Console.WriteLine("Hétkezdés");
        break; // Fontos a kilépéshez!
    case DayOfWeek.Saturday: // "Fall-through" (átesés)
    case DayOfWeek.Sunday:   // Szombatra és Vasárnapra is ez fut le
        Console.WriteLine("Hétvége");
        break;
    default: // Ha egyik fenti sem igaz
        Console.WriteLine("Hétköznap");
        break;
}

// Switch Szerkezet (Modern szintaxis)
string type = today switch
{
    DayOfWeek.Monday => "Hétkezdés",
    DayOfWeek.Saturday or DayOfWeek.Sunday => "Hétvége",
    _ => "Hétköznap" // _ jelenti a default ágat
};
```

#### 4. Ciklusok
```cs
// Hagyományos For ciklus (számlálós)
for (int i = 0; i < 5; i++) {
    if (i == 2) continue; // Kihagyja ezt a kört, ugrik a köv. i-re
    if (i == 4) break;    // Azonnal kilép a teljes ciklusból
    Console.WriteLine(i);
}

// Foreach (gyűjtemények bejárására)
foreach (string item in names) {
    Console.WriteLine(item);
}

// While (Elöltesztelő)
while (condition) { /* addig fut, amíg a feltétel igaz */ }

// Do-While (Hátultesztelő - egyszer mindenképp lefut)
do {
    /* logika */
} while (condition);
```

#### 5. Tömbök (Fix méret)
```cs
// Deklaráció
int[] numbers = new int[5];                // 5 elemű, alapértékekkel (csupa 0)
string[] names = { "Kristóf", "Csenge" };  // Rövidített inicializálás

// Elérés & Módosítás
names[0] = "Dávid";                   // 0. elem módosítása
int first = numbers[0];               // 0. elem olvasása

// Tömb Segédek
Array.Sort(names);                         // Rendezés A-Z
Array.Reverse(names);                      // Sorrend megfordítása
int idx = Array.IndexOf(names, "Kristóf"); // Keresés: indexet vagy -1-et ad vissza
bool exists = Array.Exists(numbers, n => n > 10); // Van-e 10-nél nagyobb?

// Többdimenziós tömb (Mátrix)
int[,] matrix = {
    { 1, 2, 3 },
    { 4, 5, 6 }
}; 
int val = matrix[0, 1]; // 0. sor, 1. oszlop elérése (Érték: 2)
```

#### 6. Listák (Dinamikus méret)
_Kell hozzá:_ `using System.Collections.Generic;`

```cs
List<int> scoreList = new List<int> { 10, 20, 30 };

// Módosítások
scoreList.Add(40);                    // Hozzáadás a végére
scoreList.AddRange(new[] { 50, 60 }); // Több elem hozzáadása
scoreList.Remove(20);                 // Konkrét érték törlése (az elsőt)
scoreList.RemoveAt(0);                // Törlés index alapján
scoreList.Clear();                    // Teljes lista törlése

// LINQ-szerű metódusok Listán
bool hasTen = scoreList.Contains(10);                // Tartalmazza-e?
int found = scoreList.Find(x => x > 25);             // Első találat
List<int> allHigh = scoreList.FindAll(x => x > 25);  // Összes találat új listába
```

#### 7. Modern Gyűjtemény Kifejezések (Collection Expressions)
```cs
// Egységes szintaxis (szögletes zárójel) bármelyikhez:
int[] arr = [1, 2, 3];
List<string> list = ["A", "B", "C"];

// Spread Operátor (Gyűjtemények összefűzése)
int[] combined = [0, ..arr, 4]; // Eredmény: [0, 1, 2, 3, 4]
```

#### 8. Metódusok (Függvények)
```cs
// Hagyományos Metódus
// public: láthatóság, int: visszatérési típus
public int Add(int a, int b) {
    return a + b;
}

// Expression-Bodied (Nyílfüggvény / Egysoros)
public int Multiply(int a, int b) => a * b;

// Statikus Metódus (Példányosítás nélkül hívható az osztályon)
public static double GetArea(double r) => Math.PI * r * r;

// Helyi függvény (Metódus egy metóduson belül)
public int Factorial(int n) {
    int Calc(int num) {
        if (num <= 1) return 1;
        return num * Calc(num - 1);
    }
    return Calc(n);
}
```

#### 9. Enumok & Struktúrák (Struct)

```cs
// Enum (Felsorolás)
// Értéket adhatsz a neveknek, ha nem adsz, 0-tól számoz
public enum Status { 
    Active = 1, 
    Paused = 2, 
    Stopped = 0 
}
Status current = Status.Active;

// Struct
// Kicsi, egyszerű adatszerkezetekhez jó
public struct Person {
    public string Name;
    public int Age;
}

// Struct Használata
Person p1 = new Person { Name = "Dávid", Age = 19 };
```

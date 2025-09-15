- Cuki trükk: Ctrl + Space és Enter, ad egy alapstruktúrát a Spec szerkesztőbe
### Spec
```
Be: ó ∈ N, p ∈ N, mp ∈ N
Ki: t ∈ N
Ef: ó ∈ [0..23] és p ∈ [0..59] és mp ∈ [0..59]
Uf: t = ó * 60 * 60 + p * 60 + mp
```
https://progalap.elte.hu/specifikacio/v1/?uuid=291048aa-e994-4816-86b1-f9b4c0174383

![[Pasted image 20250913183044.png]]

### Stuki
https://progalap.elte.hu/stuki/v1/?uuid=cbbf3239-6f13-46d8-b97b-f8d09d4ea776
![[Pasted image 20250914102344.png]]
## C\#
```cs

try
{
    Console.Write("Add meg az órát (0-23): ");
    int ora = int.Parse(Console.ReadLine());

    Console.Write("Add meg a percet (0-59): ");
    int perc = int.Parse(Console.ReadLine());

    Console.Write("Add meg a másodpercet (0-59): ");
    int masodperc = int.Parse(Console.ReadLine());

    if (!ErvenyesIdo(ora, perc, masodperc))
    {
        Console.WriteLine("\nNem érvényes időadatok");
        return;
    }

    int napiMasodperc = ora * 3600 + perc * 60 + masodperc;

    Console.Write("\nA nap kezdetétől eltelt másodpercek száma: ");
    Console.WriteLine(napiMasodperc);
}
catch
{
    Console.WriteLine("\nCsak számokat adj meg");
}

static bool ErvenyesIdo(int ora, int perc, int masodperc)
{
    return ora >= 0 && ora <= 23 &&
           perc >= 0 && perc <= 59 &&
           masodperc >= 0 && masodperc <= 59;
}
 ```
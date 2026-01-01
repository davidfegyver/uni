using System;

namespace Beadando_2
{
  internal class Program
  {
    static void LakasSzamBeolv(out int lakasszam)
    {
      bool joe = false;

      do
      {
        Console.Error.Write("Add meg a lakások számát: ");
        joe = int.TryParse(Console.ReadLine(), out lakasszam);
        joe = joe && (1 <= lakasszam && lakasszam <= 100);
        if (!joe)
        {
          Console.Error.WriteLine("Hibás bemenet. Egész számot adj meg, 1 és 100 között.");
        }
      }
      while (!joe);
    }

    static void AlapteruletekBeolv(int lakasszam, out int[] alapteruletek)
    {
      alapteruletek = new int[lakasszam];
      for (int i = 0; i < lakasszam; i++)
      {
        bool joe;


        do
        {
          Console.Error.Write("\nAdd meg a(z) " + (i + 1).ToString() + ". lakás alapterületét és árát szóközzel elválasztva: ");

          joe = int.TryParse(Console.ReadLine().Split(" ")[0], out alapteruletek[i]);
          joe = joe && (1 <= alapteruletek[i] && alapteruletek[i] <= 1000);

          if (!joe)
          {
            Console.Error.WriteLine("Hibás bemenet. Egész számot adj meg, 1 és 1000 között.");
          }
        }
        while (!joe);

      }

    }

    static void Feldolgoz(int lakasszam, int[] alapteruletek, out int hanyfele)
    {
      hanyfele = 0;

      for (int i = 0; i < lakasszam; i++)
      {
        if (t(i))
        {
          hanyfele++;
        }
      }

      bool t(int i)
      {

        int meow = 0;
        for (int j = i ; j < lakasszam; j++)
        {
          if (alapteruletek[j] == alapteruletek[i])
          {
            meow++;
          }
        }

        return meow == 1;
      }


    }

    static void Kiir(int hanyfele)
    {
      Console.Write(hanyfele);
    }

    static void Main()
    {
      LakasSzamBeolv(out int lakasokszama);
      AlapteruletekBeolv(lakasokszama, out int[] alapteruletek);

      Feldolgoz(lakasokszama, alapteruletek, out int hanyfele);

      Kiir(hanyfele);
    }

  }
}
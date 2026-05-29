using System;

public class Dispenser
{
    class InvalidParameterException : Exception {}
    private double max;
    private double dose;
    private double act;

    public Dispenser(double a, double b)
    {
        if (!(a > 0 && b > 0))
        {
            throw new InvalidParameterException();
        }

        max = a;
        dose = b;
        act = 0.0;
    }

    public void Push()
    {
        act = Math.Max(act - dose, 0.0);
    }

    public void Fill()
    {
        act = max;
    }

    public bool Empty()
    {
        return act == 0.0;
    }
}
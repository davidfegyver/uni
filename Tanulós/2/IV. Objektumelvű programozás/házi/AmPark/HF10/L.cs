namespace HF10;

public sealed class L : ISize
{
    private static readonly L instance = new L();
    private L() { }
    public static L Instance()
    {
        return instance;
    }
    public int Multi()
    {
        return 3;
    }
}
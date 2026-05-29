namespace HF10;

public sealed class M : ISize
{
    private static readonly M instance = new M();
    private M() { }
    public static M Instance()
    {
        return instance;
    }
    public int Multi()
    {
        return 2;
    }
}
namespace HF10;

public sealed class XL : ISize
{
    private static readonly XL instance = new XL();
    private XL() { }
    public static XL Instance()
    {
        return instance;
    }
    public int Multi()
    {
        return 4;
    }
}
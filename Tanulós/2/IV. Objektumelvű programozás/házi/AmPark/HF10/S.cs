namespace HF10;

public sealed class S : ISize
{
    private static readonly S instance = new S();
    private S() { }
    public static S Instance()
    {
        return instance;
    }
    public int Multi()
    {
        return 1;
    }
}
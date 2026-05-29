namespace HF10;

public sealed class Plush : Gift
{
    public Plush(ISize size) : base(size)
    {
    }

    public override int Points()
    {
        return 3;
    }
}
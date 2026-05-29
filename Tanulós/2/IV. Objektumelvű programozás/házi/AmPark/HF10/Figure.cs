namespace HF10;

public sealed class Figure : Gift
{
    public Figure(ISize size) : base(size)
    {
    }

    public override int Points()
    {
        return 2;
    }
}
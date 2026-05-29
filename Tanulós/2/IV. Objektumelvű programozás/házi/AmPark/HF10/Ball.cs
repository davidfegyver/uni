namespace HF10;

public sealed class Ball : Gift
{
    public Ball(ISize size) : base(size)
    {
    }

    public override int Points()
    {
        return 1;
    }
}
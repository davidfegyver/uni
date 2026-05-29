namespace HF10;

public abstract class Gift
{
    private readonly ISize size;

    protected Gift(ISize size)
    {
        this.size = size ?? throw new ArgumentNullException();
    }

    public TargetShot? Target { get; internal set; }

    public ISize Size
    {
        get { return size; }
    }

    public int Value()
    {
        return Points() * size.Multi();
    }

    public abstract int Points();
}
namespace HF10;

public sealed class TargetShot
{
    private readonly HashSet<Gift> gifts = new HashSet<Gift>();

    public TargetShot(string location)
    {
        Location = location ?? throw new ArgumentNullException();
    }

    public string Location { get; }

    public IReadOnlyCollection<Gift> Gifts
    {
        get { return gifts; }
    }

    public void Shows(Gift gift)
    {
        if (gift == null)
        {
            throw new ArgumentNullException();
        }

        if (gift.Target != null)
        {
            throw new InvalidOperationException();
        }

        gift.Target = this;
        gifts.Add(gift);
    }

    internal void RemoveGift(Gift gift)
    {
        if (!gifts.Remove(gift))
        {
            throw new InvalidOperationException();
        }
    }
}
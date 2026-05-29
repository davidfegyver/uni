namespace HF10;

public sealed class Guest
{
    private readonly HashSet<Gift> prizes = new HashSet<Gift>();

    public Guest(string name)
    {
        Name = name ?? throw new ArgumentNullException();
    }

    public string Name { get; }

    public IReadOnlyCollection<Gift> Prizes
    {
        get { return prizes; }
    }

    public void Wins(Gift gift)
    {
        if (gift == null)
        {
            throw new ArgumentNullException();
        }

        if (gift.Target == null)
        {
            throw new InvalidOperationException();
        }

        if (!gift.Target.Gifts.Contains(gift))
        {
            throw new InvalidOperationException();
        }

        gift.Target.RemoveGift(gift);
        prizes.Add(gift);
    }

    public int Result(TargetShot target)
    {
        if (target == null)
        {
            throw new ArgumentNullException();
        }

        return prizes
            .Where(gift => gift.Target == target)
            .Sum(gift => gift.Value());
    }
}
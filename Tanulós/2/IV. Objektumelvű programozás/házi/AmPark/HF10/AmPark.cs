namespace HF10;

public sealed class AmPark
{
    private readonly List<TargetShot> targets;
    private readonly HashSet<Guest> guests = new HashSet<Guest>();

    public AmPark(IEnumerable<TargetShot> targets)
    {
        if (targets == null)
        {
            throw new ArgumentNullException();
        }

        this.targets = targets.ToList();

        if (this.targets.Count < 2)
        {
            throw new ArgumentException();
        }
    }

    public IReadOnlyCollection<TargetShot> Targets
    {
        get { return targets; }
    }

    public IReadOnlyCollection<Guest> Guests
    {
        get { return guests; }
    }

    public void Receives(Guest guest)
    {
        if (guest == null)
        {
            throw new ArgumentNullException();
        }

        if (guests.Contains(guest))
        {
            throw new InvalidOperationException();
        }

        guests.Add(guest);
    }

    public string Best(TargetShot target)
    {
        if (target == null)
        {
            throw new ArgumentNullException();
        }

        if (guests.Count == 0)
        {
            throw new InvalidOperationException();
        }

        var bestGuess = guests
            .Select(g => new
            {
                Guest = g,
                Score = g.Result(target)
            })
            .OrderByDescending(x => x.Score)
            .First();

        if (bestGuess.Score == 0)
        {
            throw new InvalidOperationException();
        }

        return bestGuess.Guest.Name;
    }
}
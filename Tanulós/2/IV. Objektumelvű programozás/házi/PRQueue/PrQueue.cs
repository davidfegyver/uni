using System;
using System.Collections.Generic;

public struct Item
{
    public int pr;
    public string data;
}

public class PrQueue
{
    private List<Item> seq;

    public PrQueue()
    {
        seq = new List<Item>();
    }

    public void SetEmpty()
    {
        seq.Clear();
    }

    public bool IsEmpty()
    {
        return seq.Count == 0;
    }

    public void Add(Item e)
    {
        seq.Add(e);
    }

    public Item GetMax()
    {
        if (seq.Count == 0)
        {
            throw new InvalidOperationException();
        }
        
        int ind = MaxIndex();
        return seq[ind];
    }

    public Item RemMax()
    {
        if (seq.Count == 0)
        {
            throw new InvalidOperationException();
        }
        
        int ind = MaxIndex(); 
        Item e = seq[ind];
        seq.RemoveAt(ind);
        
        return e;
    }

    private int MaxIndex()
    {
        if (seq.Count == 0)
        {
            throw new InvalidOperationException();
        }

        int maxPr = seq[0].pr;
        int maxInd = 0;

        for (int i = 1; i < seq.Count; i++)
        {
            if (seq[i].pr > maxPr)
            {
                maxPr = seq[i].pr;
                maxInd = i;
            }
        }

        return maxInd;
    }
}
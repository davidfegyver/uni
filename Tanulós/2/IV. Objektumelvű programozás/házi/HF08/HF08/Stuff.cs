using System;
using System.Collections.Generic;

namespace HF08
{
    public abstract class Registration
    {
        protected int size;

        public virtual int GetSize()
        {
            return size;
        }
    }

    public class File : Registration
    {
        public File(int size)
        {
            this.size = size;
        }

        public override int GetSize()
        {
            return size;
        }
    }

    public class Folder : Registration
    {
        protected List<Registration> items;

        public Folder()
        {
            this.size = 0;
            this.items = new List<Registration>();
        }

        public override int GetSize()
        {
            int totalSize = size;
            foreach (Registration e in items)
            {
                totalSize += e.GetSize();
            }
            return totalSize;
        }

        public void Add(Registration r)
        {
            items.Add(r);
        }

        public void Remove(Registration r)
        {
            items.Remove(r);
        }
    }

    public class FileSystem : Folder
    {
        public FileSystem() : base()
        {
        }
    }
}
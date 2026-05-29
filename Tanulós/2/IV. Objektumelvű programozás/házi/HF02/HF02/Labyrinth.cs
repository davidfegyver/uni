namespace HF02
{

    public enum Content
    {
        EMPTY,
        WALL,
        GHOST,
        TREASURE
    }

    public struct Position
    {
        private int x;
        private int y;

        public Position(int _x, int _y)
        {
            this.x = _x;
            this.y = _y;
        }

        public bool Inside(int l, int n, int k, int m)
        {
            return l <= x && x <= n && k <= y && y <= m;
        }

        public bool Direction()
        {
            return Inside(-1, 1, -1, 1) && ((x == 0 && y != 0) || (x != 0 && y == 0));
        }

        public static Position operator +(Position a, Position b)
        {
            return new Position(a.x + b.x, a.y + b.y);
        }
    }
    public class Labyrinth
    {
        private int n;
        private int m;
        private Dictionary<Position, Content> map;

        public Labyrinth(int _n, int _m)
        {
            n = _n;
            m = _m;
            map = new Dictionary<Position, Content>();

            for (int i = 1; i <= n; i++)
            {
                for (int j = 1; j <= m; j++)
                {
                    map[new Position(i, j)] = Content.EMPTY;
                }
            }
        }

        public void Place(Position pos, Content c)
        {
            if (!map.ContainsKey(pos))
            {
                throw new ArgumentException();
            }

            map[pos] = c;
        }

        public Content Spy(Position pos, Position dir)
        {
            if (!(pos.Inside(1, n, 1, m) && (pos + dir).Inside(1, n, 1, m) && dir.Direction()))
            {
                throw new ArgumentException();
            }

            return map[pos + dir];
        }

        public void Gather(Position pos)
        {
            if (!pos.Inside(1, n, 1, m))
            {
                throw new ArgumentException();
            }

            if (map[pos] != Content.TREASURE)
            {
                throw new InvalidOperationException();
            }

            map[pos] = Content.EMPTY;
        }
    }
}
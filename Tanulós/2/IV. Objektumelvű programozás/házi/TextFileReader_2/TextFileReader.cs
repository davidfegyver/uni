//Author:   Gregorics Tibor
//Date:     2021.10.24.
//Title:    Read from text file

using System;
using System.Globalization;
using System.IO;

namespace TextFile {
    public class TextFileReader : IDisposable {
        private StreamReader? reader;
        public string FileName { get; private set; }
        public TextFileReader(string filename) {
            if (!File.Exists(filename)) throw new FileNotFoundException();
            reader = new StreamReader(filename);
            FileName = filename;
        }

        //Task: 	reading the next character 
        //Input:    StreamReader reader -  datachannel to a text file
        //Output:   char ch             -  char
        //          bool l              -  true if the character exists
        //Activity: it uses the Read() method of reader if the text file is not empty
        public bool ReadChar(out char ch) {
            if (reader == null) throw new FileNotFoundException();
            ch = '\0';
            int x = reader.Read();
            if (x == -1) return false;
            ch = Convert.ToChar(x);
            return true;
        }

        public char? ReadChar() {
            if (reader == null) throw new FileNotFoundException();
            int x = reader.Read();
            if (x == -1) return null;
            char ch = Convert.ToChar(x);
            return ch;
        }

        //Task: 	reading the next character overstepping the white spaces
        //Input:    StreamReader reader -  datachannel to a text file
        //Output:   char ch             -  char
        //          bool l              -  true if the character exists
        //Activity: it uses the Read() method of reader if the text file is not empty
        public bool ReadSign(out char ch) {
            if (reader == null) throw new FileNotFoundException();
            ch = '\0';
            string limiter = " \n\t\r";
            int x;
            while ((x = reader.Read()) != -1 && limiter.Contains(Convert.ToChar(x))) ;
            if (x == -1) return false;
            ch = Convert.ToChar(x);
            return true;
        }

        public char? ReadSign() {
            if (reader == null) throw new FileNotFoundException();

            string limiter = " \n\t\r";
            int x;
            while ((x = reader.Read()) != -1 && limiter.Contains(Convert.ToChar(x))) ;
            if (x == -1) return null;
            char ch = Convert.ToChar(x);
            return ch;
        }

        //Task: 	reading the next string that is terminated by whitespace or eof
        //Input:    StreamReader reader -  datachannel to a text file
        //Output:   string str          -  string
        //          bool l              -  true if the string exists
        //Activity: it finds the beginning of the next string overstepping whitespaces, 
        //          and if this string exists, it concatenates its characters bordered by whitespace or eof
        public bool ReadString(out string str) {
            str = "";
            if (reader == null) throw new FileNotFoundException();

            string limiter = " \n\t\r";
            int x;
            while ((x = reader.Read()) != -1 && limiter.Contains(Convert.ToChar(x))) ;
            if (x == -1) return false;

            str += Convert.ToChar(x);
            while ((x = reader.Read()) != -1 && !limiter.Contains(Convert.ToChar(x))) {
                str += Convert.ToChar(x);
            }
            return true;
        }

        public string ReadString() {
            if (reader == null) throw new FileNotFoundException();

            string limiter = " \n\t\r";
            int x;
            while ((x = reader.Read()) != -1 && limiter.Contains(Convert.ToChar(x))) ;
            if (x == -1) return "";

            string str = "" + Convert.ToChar(x);
            while ((x = reader.Read()) != -1 && !limiter.Contains(Convert.ToChar(x))) {
                str += Convert.ToChar(x);
            }
            return str;
        }

        //Task: 	reading the next integer that is terminated by white-space or eof
        //Input:    StreamReader reader -  datachannel to a text file
        //Output:   int n               -  integer
        //          bool l              -  true if the string exists
        //Activity: it reads the next string (see ReadString()), and then it will be converted to integer
        public bool ReadInt(out int n) {
            if (reader == null) throw new FileNotFoundException();
            n = 0;
            bool l = ReadString(out string str);
            if (l) n = int.Parse(str);
            return l;
        }

        public int? ReadInt() {
            if (reader == null) throw new FileNotFoundException();
            string str = ReadString()!;
            if (str == null) return null;
            return int.Parse(str);
        }

        //Task: 	reading the next bouble number that is terminated by white-space or eof
        //Input:    StreamReader reader -  datachannel to a text file
        //Output:   double a            -  double
        //          bool l              -  true if the string exists
        //Activity: it reads the next string (see ReadString()), and then it will be converted to double
        public bool ReadDouble(out double a) {
            if (reader == null) throw new FileNotFoundException();
            a = 0.0;
            bool l = ReadString(out string str);
            if (l) a = str.Contains('.') ? double.Parse(str, CultureInfo.CreateSpecificCulture("en-GB")) : double.Parse(str);
            return l;
        }

        public double? ReadDouble() {
            if (reader == null) throw new FileNotFoundException();
            string str = ReadString()!;
            if (str == null) return null;
            return double.Parse(str);
        }

        //Task: 	reading the next line
        //Input:    StreamReader reader -  datachannel to a text file
        //Output:   string line         -  char
        //          bool l              -  true if the character exists
        //Activity: it uses the ReadLine() method of reader
        public bool ReadLine(out string line) {
            line = ReadLine();
            return line != null;
        }
        public string ReadLine() {
            if (reader == null) throw new FileNotFoundException();
            return reader.ReadLine()!;
        }
        private bool disposedValue = false;
        public bool WhileOpen { get => !disposedValue; }
        protected virtual void Dispose(bool disposing) {
            if (!disposedValue) {
                if (disposing && reader != null) {
                    reader.Dispose();
                    reader = null;
                } else if (reader != null) reader.Close();
                disposedValue=true;
            }
        }
        ~TextFileReader() {
            Dispose(disposing: false);
        }
        public void CloseFile() {
            Dispose(disposing: true);
        }
        public void OpenFile() {
            if (reader != null) return;
            reader = new StreamReader(FileName);
            disposedValue = false;
        }
        public void Dispose() {
            Dispose(disposing: true);
            GC.SuppressFinalize(this);
        }
    }
}

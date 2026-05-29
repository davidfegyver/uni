using System;
using System.Collections.Generic;

namespace Courses
{
    class Centre
    {
        public class PersonNotAuthenticated : Exception { }
        public class PersonHasAlreadyRegistrated : Exception { }

        private readonly Dictionary<string, string> table = new Dictionary<string, string>();
        private readonly Dictionary<string, string> admin = new Dictionary<string, string>();

        public Centre(Person adm)
        {
            admin.Add(adm.Id, adm.Id);
        }
        public void Authentication(Person person)
        {
            if (!table.ContainsKey(person.Id) || !person.OKPW(table[person.Id])) throw new PersonNotAuthenticated(); ;
        }
        public string Registrate(Person person, Person adm)
        {
            if (!(admin.ContainsKey(adm.Id) && adm.OKPW(admin[adm.Id]))) throw new PersonNotAuthenticated();
            if (table.ContainsKey(person.Id)) throw new PersonHasAlreadyRegistrated();
            table[person.Id] = person.Id;
            person.centre = this;
            return table[person.Id];
        }
        public void ModifyPassword(Person person, string oldpw, string newpw)
        {
            Authentication(person);
            if (table[person.Id] != oldpw) throw new Person.WrongPassword();
            table[person.Id] = newpw;
        }
    }
}

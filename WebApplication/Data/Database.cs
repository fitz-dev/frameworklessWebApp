using System.Collections.Generic;
using System.Linq;

namespace WebApplication.Data
{
    public class Database : IDatabase
    {
        private const string PowerUser = "Tom";
        public List<User> AllUsers = new List<User>();

        public Database()
        {
            AllUsers.Add(new User(PowerUser));
        }

        public List<User> GetUsers()
        {
            return AllUsers;
        }
        
        public void AddUser(string user)
        {
            AllUsers.Add(new User(user.Trim('/')));
        }

        public void UpdateUser(string oldName, string newName)
        {
            foreach (var user in AllUsers.Where(user => user.Name == oldName))
            {
                user.Name = newName;
            }
        }

        public void DeleteUser(string userName)
        {
            foreach (var user in AllUsers.Where( user => user.Name == userName))
            {
                AllUsers.Remove(user);
            }
        }
        
    }
}
using System.Data.SqlClient;
using Microsoft.Extensions.Configuration;

class Program
{
    static void Main()
    {
        var builder = new ConfigurationBuilder();
        builder.AddJsonFile("appsettings.json");
        var config = builder.Build();
        var connectionString = config.GetConnectionString("Default");

        using SqlConnection conn = new SqlConnection(connectionString);

        SqlCommand commandSelect = new SqlCommand("SELECT * FROM People", conn);

        conn.Open();

        using SqlDataReader reader = commandSelect.ExecuteReader();

        while (reader.Read())
        {
            var id = reader.GetInt32(0);
            Console.WriteLine($"{reader[0]}\t{reader[1]}\t{reader[2]}\t{reader[3]}");
        }

        //ExecuteScalar
        //1

        SqlCommand scalarCommand1 = new SqlCommand("SELECT COUNT(*) FROM People", conn);
        int totalPeopleCount = (int)scalarCommand1.ExecuteScalar();
        Console.WriteLine($"Total num of people: {totalPeopleCount}");
        //2

        SqlCommand scalarCommand2 = new SqlCommand("SELECT MAX(Age) FROM People", conn);
        int maxAge = (int)scalarCommand2.ExecuteScalar();
        Console.WriteLine($"Maximum age of people: {maxAge}");
        //3

        SqlCommand scalarCommand3 = new SqlCommand("SELECT MIN(Age) FROM People", conn);
        int minAge = (int)scalarCommand3.ExecuteScalar();
        Console.WriteLine($"Minimum age of people: {minAge}");
        //----------------------------------------------------------------------------------------
        //ExecuteNonQuery
        //1

        SqlCommand nonQueryCommand1 = new SqlCommand("INSERT INTO People(Name, Surname, Age) VALUES (N'Sara', N'Valiyeva', 20)", conn);
        int rowsInserted1 = nonQueryCommand1.ExecuteNonQuery();
        Console.WriteLine($"Rows inserted: {rowsInserted1}");
        //2

        SqlCommand nonQueryCommand2 = new SqlCommand("UPDATE People SET Age = Age + 1 WHERE Name = N''Samed", conn);
        int rowsUpdated = nonQueryCommand2.ExecuteNonQuery();
        Console.WriteLine($"Rows updated: {rowsUpdated}");
        //3

        SqlCommand nonQueryCommand3 = new SqlCommand("DELETE FROM People WHERE Age < 18", conn);
        int rowsDeleted = nonQueryCommand3.ExecuteNonQuery();
        Console.WriteLine($"Rows deleted: {rowsDeleted}");
    }
}
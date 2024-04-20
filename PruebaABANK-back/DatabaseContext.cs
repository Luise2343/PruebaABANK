using Npgsql;

public class DatabaseContext
{

    public DatabaseContext(string connectionString) => ConenctionString = connectionString;
    public string ConenctionString { get; set; }
}


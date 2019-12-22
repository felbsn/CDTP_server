using Npgsql;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using System.Web;


public static class Sql
{
    public static NpgsqlConnection static_conn = new NpgsqlConnection("Server=127.0.0.1;Database=CDTP;User Id=postgres;Password=o;");
    public static NpgsqlConnection notify_conn = new NpgsqlConnection();
    public static bool isListening   = false;

    public static DataTable Query(string query)
    {
        DataTable table = new DataTable();
        var conn = new NpgsqlConnection("Server=127.0.0.1;Database=CDTP;User Id=postgres;Password=o; ");
        conn.Open();

        Npgsql.NpgsqlDataAdapter npgsqlDataAdapter = new NpgsqlDataAdapter(query, conn);



        npgsqlDataAdapter.Fill(table);
        conn.Close();


        return table;
    }

    public static DataTable StaticQuery(string query)
    {
        DataTable table = new DataTable();
        if (static_conn.State != ConnectionState.Open)
            static_conn.Open();

        Npgsql.NpgsqlDataAdapter npgsqlDataAdapter = new NpgsqlDataAdapter(query, static_conn);

        npgsqlDataAdapter.Fill(table);
        return table;
    }



    public static void Listen(    )
    {
        notify_conn.ConnectionString = new NpgsqlConnectionStringBuilder
        {
            Host = "127.0.0.1",
            Database = "CDTP",
            Username = "postgres",
            Password = "o"
            //,KeepAlive = 0
        }.ConnectionString;


        if (notify_conn.State != ConnectionState.Open)
            notify_conn.Open();

        using (var command = new NpgsqlCommand("listen usage_insert", notify_conn))
        {
            command.ExecuteNonQuery();

        }

        //Sql.notify_conn.WaitAsync().ContinueWith((t)=>
        //{
        //    
        //});

        isListening = true;

          new Thread(() =>
        {
            while (true)
            {
                notify_conn.Wait();
            }
        }).Start();
 

    }

    public static void ListenRegister(NotificationEventHandler notificationEventHandler)
    {
        if(notify_conn.State != ConnectionState.Open)
        {
            Listen();
        }

        notify_conn.Notification += notificationEventHandler;
    }

}



public class UserInfo
{
    public int id;
    public string name;
    public string surname;
    public string username;
    public string deviceID;
}


public static class Util
{
    public static string ConvertDataTableToHTML(DataTable dt)
    {
        string html = "<table class=\"table\">";
        //add header row
        html += "<tr>";
        for (int i = 0; i < dt.Columns.Count; i++)
            html += "<td>" + dt.Columns[i].ColumnName + "</td>";
        html += "</tr>";
        //add rows
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            html += "<tr>";
            for (int j = 0; j < dt.Columns.Count; j++)
                html += "<td>" + dt.Rows[i][j].ToString() + "</td>";
            html += "</tr>";
        }
        html += "</table>";
        return html;
    }
}

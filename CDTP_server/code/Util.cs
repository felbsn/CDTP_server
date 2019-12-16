using Npgsql;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;


    public class Sql
    {
        public static  DataTable Query(string query)
        {
            DataTable table = new DataTable();
            var conn = new NpgsqlConnection("Server=127.0.0.1;Database=CDTP;User Id=postgres;Password=o; ");
            conn.Open();
            
            Npgsql.NpgsqlDataAdapter npgsqlDataAdapter = new NpgsqlDataAdapter(query, conn);



            npgsqlDataAdapter.Fill(table);
            conn.Close();
            
           
            return table;
        }


    }

    public class UserInfo
    {
        public int id;
        public string name;
        public string surname;
        public string username;
    }


    public class Util
    {
    }

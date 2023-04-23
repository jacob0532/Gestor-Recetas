using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaDatos.Conexion
{
    public class dbConexion
    {
        public SqlConnectionStringBuilder obtenerConexión(string inServer, string inDatabase, string inUser, string inPassword)
        {
            SqlConnectionStringBuilder conn = new SqlConnectionStringBuilder();
            conn.DataSource = inServer;
            conn.InitialCatalog = inDatabase;
            conn.UserID = inUser;
            conn.Password = inPassword;
            return conn;
        }
    }
}

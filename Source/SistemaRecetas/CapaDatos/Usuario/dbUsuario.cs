using CapaUtilitarios.Receta;
using CapaUtilitarios.Usuario;
using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.ConstrainedExecution;
using System.Text;
using System.Threading.Tasks;

namespace CapaDatos.Usuario
{
    public class dbUsuario
    {
        public List<clUsuario> loginUsuario(SqlConnectionStringBuilder connString, string inUsuario, string inContrasena) {
            List<clUsuario> listaUsuarios = new List<clUsuario>();

            string queryString = "EXEC dbo.sp_Login " +
                "'" + inUsuario + "', " +
                "" + 0 + "";

            using (SqlConnection conexion = new SqlConnection(connString.ConnectionString))
            {
                using (var cmd = new SqlCommand(queryString, conexion))
                {
                    cmd.Connection = conexion;
                    conexion.Open();

                    using (var reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            clUsuario user = new clUsuario();
                            user.id = reader.GetInt32(0);
                            user.nombre = reader.GetString(1);
                            user.correo = reader.GetString(2);
                            user.usuario = reader.GetString(3);
                            user.contrasena = reader.GetString(4);
                            user.telefono = reader.GetInt32(5);
                            user.isAdministrador = reader.GetBoolean(6);
                            listaUsuarios.Add(user);
                        }
                    }
                }
            }

            return listaUsuarios;
        }


        public List<clUsuario> listarUsuarios(SqlConnectionStringBuilder connString)
        {
            List<clUsuario> listaUsuarios = new List<clUsuario>();

            string queryString = "EXEC dbo.sp_ConsultaUsuarios " +
                "" + 0 + "";

            using (SqlConnection conexion = new SqlConnection(connString.ConnectionString))
            {
                using (var cmd = new SqlCommand(queryString, conexion))
                {
                    cmd.Connection = conexion;
                    conexion.Open();

                    using (var reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            clUsuario r = new clUsuario();
                            r.id = reader.GetInt32(0);
                            r.nombre = reader.GetString(1);
                            r.correo = reader.GetString(2);
                            r.usuario = reader.GetString(3);
                            r.contrasena = reader.GetString(4);
                            r.telefono = reader.GetInt32(5);
                            r.isAdministrador = reader.GetBoolean(6);

                            listaUsuarios.Add(r);
                        }
                    }
                }
            }

            return listaUsuarios;
        }


        public int crearUsuario(SqlConnectionStringBuilder connString, clUsuario inUsuario) {
            int resultCode = 0;
            int administradorValue = 0;

            if (inUsuario.isAdministrador) {
                administradorValue = 1;
            }

            string queryString = "EXEC dbo.sp_InsertarUsuario " +
                "'" + inUsuario.nombre + "', " +
                "'" + inUsuario.correo + "', " +
                "'" + inUsuario.usuario + "', " +
                "'" + inUsuario.contrasena + "', " +
                "" + inUsuario.telefono + ", " +
                "" + administradorValue + ", " +
                "" + 0 + "";

            using (SqlConnection conexion = new SqlConnection(connString.ConnectionString))
            {
                using (var cmd = new SqlCommand(queryString, conexion))
                {
                    cmd.Connection = conexion;
                    conexion.Open();

                    using (var reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            resultCode = reader.GetInt32(0);
                        }
                    }
                }
            }
            return resultCode;
        }
    }
}

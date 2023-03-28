using CapaUtilitarios.Receta;
using CapaUtilitarios.Usuario;
using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaDatos.Receta
{
    public class dbReceta
    {
        public List<clReceta> listarRecetas(SqlConnectionStringBuilder connString)
        {
            List<clReceta> listaRecetas = new List<clReceta>();

            string queryString = "EXEC dbo.sp_ConsultaRecetas " +
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
                            clReceta r = new clReceta();
                            r.id = reader.GetInt32(0);
                            r.nombre = reader.GetString(1);
                            r.descripcion = reader.GetString(2);
                            r.area = reader.GetString(3);
                            r.subarea = reader.GetString(4);
                            //r.imagenes = reader.GetString(5);

                            listaRecetas.Add(r);
                        }
                    }
                }
            }

            return listaRecetas;
        }


        public int crearReceta(SqlConnectionStringBuilder connString, clReceta inReceta)
        {
            int resultCode = 0;

            string queryString = "EXEC dbo.sp_InsertarRecetaCmp " +
                "'" + inReceta.nombre + "', " +
                "" + inReceta.idArea + ", " +
                "" + inReceta.idSubArea + ", " +
                "'" + inReceta.descripcion + "', " +
                "NULL, " +
                "'" + inReceta.pasos + "', " +
                "'" + inReceta.ingredientes + "', " +
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

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
        public int eliminarReceta(SqlConnectionStringBuilder connString, int? InIdReceta)
        {
            int ResultCode = 0;

            string queryString = "EXEC dbo.sp_EliminarReceta " +
                "" + InIdReceta + ", " + 0 + "";

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
                            
                        }
                    }
                }
            }

            return ResultCode;
        }

        public int eliminarImagenXReceta(SqlConnectionStringBuilder connString, int? InIdImagenReceta)
        {
            int ResultCode = 0;

            string queryString = "EXEC dbo.sp_EliminarImagenesXReceta " +
                "" + InIdImagenReceta + ", " + 0 + "";

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

                        }
                    }
                }
            }

            return ResultCode;
        }

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
        public clReceta verRecetaEspecifica(SqlConnectionStringBuilder connString, int? InIdReceta)
        {
            clReceta receta = new clReceta();
            string queryString = "EXEC dbo.sp_ConsultaRecetaEspecifica " +
                "" + InIdReceta + ", " + 0 + "";

            using (SqlConnection conexion = new SqlConnection(connString.ConnectionString))
            {
                using (var cmd = new SqlCommand(queryString, conexion))
                {
                    cmd.Connection = conexion;
                    conexion.Open();

                    using (var reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            receta.id = reader.GetInt32(0);
                            receta.nombre = reader.GetString(1);
                            receta.descripcion = reader.GetString(2);
                            receta.area = reader.GetString(3);
                            receta.subarea = reader.GetString(4);
                            receta.imagenes = verImagenesXReceta(connString, InIdReceta);
                            receta.idImagenes = verIdImagenesXReceta(connString, InIdReceta);
                            receta.idArea = reader.GetInt32(5);
                            receta.idSubArea = reader.GetInt32(6);
                            receta.ingredientes = verIngredientesXReceta(connString, InIdReceta);
                            receta.pasos = verPasosXReceta(connString, InIdReceta);
                        }
                    }
                }
            }
            return receta;
        }

        public string[] verImagenesXReceta(SqlConnectionStringBuilder connString, int? InIdReceta)
        {
            List<string> listaImagenes = new List<string>();
            string queryString = "EXEC dbo.ConsultaImagenesEnReceta " +
                "" + InIdReceta + ", " + 0 + "";
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
                            listaImagenes.Add(reader.GetString(1));
                        }
                    }
                }
            }
            string[] imagenes = listaImagenes.ToArray();
            return imagenes;
        }

        public int[] verIdImagenesXReceta(SqlConnectionStringBuilder connString, int? InIdReceta)
        {
            List<int> listaIdImagenes = new List<int>();
            string queryString = "EXEC dbo.ConsultaImagenesEnReceta " +
                "" + InIdReceta + ", " + 0 + "";
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
                            listaIdImagenes.Add(reader.GetInt32(0));
                        }
                    }
                }
            }
            int[] idImagenes = listaIdImagenes.ToArray();
            return idImagenes;
        }

        public String verIngredientesXReceta(SqlConnectionStringBuilder connString, int? InIdReceta)
        {
            String ingredientes = "";
            string queryString = "EXEC dbo.sp_ConsultaIngredientesxReceta " +
                "" + InIdReceta + ", " + 0 + "";

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
                            ingredientes += reader.GetString(1) + "-";
                        }
                    }
                }
            }
            return ingredientes;
        }

        public String verPasosXReceta(SqlConnectionStringBuilder connString, int? InIdReceta)
        {
            String pasos = "";
            string queryString = "EXEC dbo.sp_ConsultaPasoxReceta " +
                "" + InIdReceta + ", " + 0 + "";

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
                            pasos += reader.GetString(1) + "-";
                        }
                    }
                }
            }
            return pasos;
        }
        public int editarReceta(SqlConnectionStringBuilder connString, clReceta inReceta)
        {
            int resultCode = 0;

            string queryString = "EXEC dbo.sp_EditarRecetaCmp " +
                "" + inReceta.id + ", " +
                "'" + inReceta.nombre + "', " +
                "" + inReceta.idArea + ", " +
                "" + inReceta.idSubArea + ", " +
                "'" + inReceta.descripcion + "', " +
                //"'" + inReceta.imagenes + "', " +
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
        //public int crearReceta(SqlConnectionStringBuilder connString, clReceta inReceta)
        //{
        //    int resultCode = 0;

        //    string queryString = "EXEC dbo.sp_EditarRecetaCmp " +
        //        "" + inReceta.id + ", " +
        //        "'" + inReceta.nombre + "', " +
        //        "" + inReceta.idArea + ", " +
        //        "" + inReceta.idSubArea + ", " +
        //        "'" + inReceta.descripcion + "', " +
        //        //"'" + inReceta.imagenes + "', " +
        //        "'" + inReceta.pasos + "', " +
        //        "'" + inReceta.ingredientes + "', " +
        //        "" + 0 + "";

        //    using (SqlConnection conexion = new SqlConnection(connString.ConnectionString))
        //    {
        //        using (var cmd = new SqlCommand(queryString, conexion))
        //        {
        //            cmd.Connection = conexion;
        //            conexion.Open();

        //            using (var reader = cmd.ExecuteReader())
        //            {
        //                while (reader.Read())
        //                {
        //                    resultCode = reader.GetInt32(0);
        //                }
        //            }
        //        }
        //    }
        //    return resultCode;
        //}
        public int crearReceta(SqlConnectionStringBuilder connString, clReceta inReceta)
        {
            int resultCode = 0;

            string queryString = "EXEC dbo.sp_InsertarRecetaCmp " +
                "'" + inReceta.nombre + "', " +
                "" + inReceta.idArea + ", " +
                "" + inReceta.idSubArea + ", " +
                "'" + inReceta.descripcion + "', " +
                //"'" + inReceta.imagenes + "', " +
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
        public int insertarImagenReceta(SqlConnectionStringBuilder connString, int inIdReceta, string imagen)
        {
            int resultCode = 0;

            string queryString = "EXEC dbo.InsertarImagenEnReceta " +
            "'" + inIdReceta + "', " +
            "'" + imagen + "', " +
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

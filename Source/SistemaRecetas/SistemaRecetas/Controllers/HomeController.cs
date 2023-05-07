using CapaDatos.Conexion;
using CapaDatos.Receta;
using CapaDatos.Usuario;
using CapaUtilitarios.Receta;
using CapaUtilitarios.Usuario;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using Newtonsoft.Json;
using SistemaRecetas.Models;
using System.Data;
using System.Diagnostics;
using System.IO;

namespace SistemaRecetas.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;

        dbReceta dbReceta = new dbReceta();
        dbUsuario dbUsuario = new dbUsuario();
        dbConexion dbConexion = new dbConexion();

        SqlConnectionStringBuilder conexionString = new SqlConnectionStringBuilder();

        public HomeController(ILogger<HomeController> logger)
        {
            _logger = logger;

            /*string servidor = "LAPTOP-IHP166E9\\SQLEXPRESS01";
            string baseDatos = "GestorRecetas";
            string usuario = "daniel";
            string clave = "daniel";*/
            //conexionString = dbConexion.obtenerConexión(servidor, baseDatos, usuario, clave);

            /*
            string servidor = "LAPTOP-B647LCTK\\SQLEXPRESS";
            string baseDatos = "Prueba";
            string usuario = "sa";
            string clave = "sa1234"; 
            */

            var builder = new ConfigurationBuilder()
                .SetBasePath(Directory.GetCurrentDirectory())
                .AddJsonFile("appsettings.json", optional: true, reloadOnChange: true);
            var configuration = builder.Build();
            var servidor = configuration["Servidor"];
            var baseDatos = configuration["BaseDatos"];
            var usr = configuration["Usuario"];
            var pass = configuration["Clave"];
            conexionString = dbConexion.obtenerConexión(servidor, baseDatos, usr, pass);
        }

        public List<Departamento> ObtenerDepartamentos()
        {
            List<Departamento> departamentos = new List<Departamento>();
            string query = "SELECT idDepartamento, nombre FROM departamento";
            using (SqlConnection connection = new SqlConnection(conexionString.ConnectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    connection.Open();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            Departamento departamento = new Departamento();
                            departamento.IdDepartamento = Convert.ToInt32(reader["idDepartamento"]);
                            departamento.Nombre = Convert.ToString(reader["nombre"]);
                            departamentos.Add(departamento);
                        }
                    }
                }
            }
            return departamentos;
        }

        public IActionResult ObtenerSubDepartamentos()
        {
            List<subDepartamento> subdepartamentos = new List<subDepartamento>();
            string query = "SELECT idSubDepartamento, nombre, idDepartamento FROM subDepartamento";
            using (SqlConnection connection = new SqlConnection(conexionString.ConnectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    connection.Open();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            subDepartamento subdepartamento = new subDepartamento();
                            subdepartamento.IdSubdepartamento = Convert.ToInt32(reader["idSubDepartamento"]);
                            subdepartamento.Nombre = Convert.ToString(reader["nombre"]);
                            subdepartamento.IdDepartamento = Convert.ToInt32(reader["idDepartamento"]);
                            subdepartamentos.Add(subdepartamento);
                        }
                    }
                }
            }
            return Json(subdepartamentos);
        }

        public IActionResult ObtenerSubDepartamentosPorDepartamento(int idDepartamento)
        {
            List<subDepartamento> subdepartamentos = new List<subDepartamento>();
            string query = "SELECT idSubDepartamento, nombre, idDepartamento FROM subDepartamento WHERE idDepartamento=@idDepartamento";
            using (SqlConnection connection = new SqlConnection(conexionString.ConnectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@idDepartamento", idDepartamento);
                    connection.Open();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            subDepartamento subdepartamento = new subDepartamento();
                            subdepartamento.IdSubdepartamento = Convert.ToInt32(reader["idSubDepartamento"]);
                            subdepartamento.Nombre = Convert.ToString(reader["nombre"]);
                            subdepartamento.IdDepartamento = Convert.ToInt32(reader["idDepartamento"]);
                            subdepartamentos.Add(subdepartamento);
                        }
                    }
                }
            }
            return Json(subdepartamentos);
        }

        public JsonResult ObtenerRecetaPorDepartamentoySubDepartamento(int idDepartamento, int idSubDepartamento)
        {
            List<Receta> recetas = new List<Receta>();
            string query = "SELECT idReceta, nombre, idArea, idSubarea, descripcion, imagenes from receta " +
                "WHERE idArea = @idDepartamento AND idSubarea = @idSubDepartamento";
            using (SqlConnection connection = new SqlConnection(conexionString.ConnectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@idDepartamento", idDepartamento);
                    command.Parameters.AddWithValue("@idSubDepartamento", idSubDepartamento);
                    connection.Open();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            Receta receta = new Receta();
                            receta.idReceta = Convert.ToInt32(reader["idReceta"]);
                            receta.nombre = Convert.ToString(reader["nombre"]);
                            receta.idDepartamento = Convert.ToInt32(reader["idArea"]);
                            receta.idSubdepartamento = Convert.ToInt32(reader["idSubarea"]);
                            receta.descripcion = Convert.ToString(reader["descripcion"]);
                            //receta.imagenes = Convert.ToByte(reader["imagenes"]);
                            recetas.Add(receta);
                            Console.WriteLine(receta.nombre);
                        }
                    }
                }
            }
            var result = JsonConvert.SerializeObject(recetas);
            return Json(result);
        }


        public IActionResult Index()
        {
            List<Departamento> departamentos = ObtenerDepartamentos();

            ViewBag.Subdepartamentos = new List<subDepartamento>();

            return View(departamentos);
        }

        public IActionResult Inicio()
        {
            return View();
        }

        public IActionResult Usuarios()
        {
            return View();
        }

        public IActionResult NuevaReceta()
        {
            return View();
        }

        public IActionResult NuevoUsuario()
        {
            return View();
        }


        public IActionResult Privacy()
        {
            return View();
        }

        public IActionResult CerrarSesion()
        {
            return RedirectToAction("Index", "Home");
        }


        // Iniciar sesión
        public int IniciarSesion(string inUsuario, string inContrasena)
        {
            int resultCode = 0;
            List<clUsuario> listaUsuarios = new List<clUsuario>();

            try
            {
                listaUsuarios = dbUsuario.loginUsuario(conexionString, inUsuario, inContrasena);

                foreach (clUsuario usuario in listaUsuarios)
                {
                    if (usuario.usuario == inUsuario && usuario.contrasena == inContrasena)
                    {
                        //HttpContext.Session.SetString("Usuario", usuario.usuario);
                        return 0; // Inicio correcto

                    }
                    return 2;   // Usuario correcto pero contraseña incorrecta
                }

                return 1;   // Usuario no encontrado
            }
            catch (Exception e)
            {

                return 501;
            }
        }

        // Crear usuario
        public int crearUsuario(string inNombre, string inCorreo, int inTelefono, int inAdministrador, string inUsuario, string inContrasena)
        {
            int resultCode = 0;
            clUsuario usuario = new clUsuario();
            usuario.nombre = inNombre;
            usuario.correo = inCorreo;
            usuario.telefono = inTelefono;
            usuario.usuario = inUsuario;
            usuario.contrasena = inContrasena;

            if (inAdministrador == 1)
                usuario.isAdministrador = true;
            else
                usuario.isAdministrador = false;

            try
            {
                resultCode = dbUsuario.crearUsuario(conexionString, usuario);

                return resultCode;
            }
            catch (Exception e)
            {

                return 501;
            }
        }


        // Crear receta
        public int crearReceta(string inNombre, int inArea, int inSubarea, string inDescripcion, string inMateriales, string inProcedimientos, String inImagenes)
        {
            int resultCode = 0;
            clReceta receta = new clReceta();
            receta.nombre = inNombre;
            receta.idArea = inArea;
            receta.idSubArea = inSubarea;
            receta.descripcion = inDescripcion;
            receta.ingredientes = inMateriales;
            receta.pasos = inProcedimientos;
            receta.imagenes = inImagenes; 

            try
            {
                resultCode = dbReceta.crearReceta(conexionString, receta);

                return resultCode;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
                return 501;
            }
        }


        // Listar Recetas
        public JsonResult listarRecetas()
        {
            List<clReceta> listaRecetas = new List<clReceta>();
            listaRecetas = dbReceta.listarRecetas(conexionString);
            var result = JsonConvert.SerializeObject(listaRecetas);
            return Json(result);
        }

        // Receta especifica
        public JsonResult verRecetaEspecifica(int idReceta)
        {
            clReceta receta = new clReceta();
            receta = dbReceta.verRecetaEspecifica(conexionString, idReceta);
            var result = JsonConvert.SerializeObject(receta);
            return Json(result);
        }



        // Listar Usuarios
        public JsonResult listarUsuarios()
        {
            List<clUsuario> listaUsuarios = new List<clUsuario>();
            listaUsuarios = dbUsuario.listarUsuarios(conexionString);
            var result = JsonConvert.SerializeObject(listaUsuarios);

            return Json(result);
        }



        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
﻿using CapaDatos.Conexion;
using CapaDatos.Receta;
using CapaDatos.Usuario;
using CapaUtilitarios.Receta;
using CapaUtilitarios.Usuario;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using Newtonsoft.Json;
using SistemaRecetas.Models;
using System.Diagnostics;

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

            //Datos de conexión Rolbin 
            /*string servidor = "LAPTOP-B647LCTK\\SQLEXPRESS";
            string baseDatos = "Prueba";
            string usuario = "sa";
            string clave = "sa1234";*/

            //Datos de conexión Jacob
            string servidor = "LAPTOP-140FDP4P\\JACOBBD";
            string baseDatos = "GestorRecetas";
            //"Data Source=LAPTOP-140FDP4P;Initial Catalog=ProyectoBD1;Integrated Security=true;";


            //conexionString = dbConexion.obtenerConexión(servidor, baseDatos, usuario, clave);
            conexionString = dbConexion.obtenerConexion2(servidor, baseDatos);



        }

        public IActionResult Index()
        {
            return View();
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
        public int crearReceta(string inNombre, int inArea, int inSubarea, string inDescripcion, string inMateriales, string inProcedimientos)
        {
            int resultCode = 0;
            clReceta receta = new clReceta();
            receta.nombre = inNombre;
            receta.idArea = inArea;
            receta.idSubArea = inSubarea;
            receta.descripcion = inDescripcion;
            receta.ingredientes = inMateriales;
            receta.pasos = inProcedimientos;

            try
            {
                resultCode = dbReceta.crearReceta(conexionString, receta);

                return resultCode;
            }
            catch (Exception e)
            {

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
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaUtilitarios.Usuario
{
    public class clUsuario
    {
        public int id { get; set; }
        public string nombre { get; set; }
        public string correo { get; set; }
        public string usuario { get; set; }
        public string contrasena { get; set; }
        public int telefono { get; set; }
        public bool isAdministrador { get; set; }
    }
}

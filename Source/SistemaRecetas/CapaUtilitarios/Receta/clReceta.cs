using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaUtilitarios.Receta
{
    public class clReceta
    {
        public int id { get; set; }
        public int idArea { get; set; }
        public string area { get; set; }
        public int idSubArea { get; set; }
        public string subarea { get; set; }
        public string nombre { get; set; }
        public string descripcion { get; set; }
        public string pasos { get; set; }
        public string ingredientes { get; set; }
    }
}

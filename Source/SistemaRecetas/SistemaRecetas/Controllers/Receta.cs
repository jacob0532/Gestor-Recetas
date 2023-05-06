namespace SistemaRecetas.Controllers
{
    public class Receta
    {
        public int idReceta { get; set; }
        public string nombre { get; set; }
        public int idDepartamento { get; set; }
        public int idSubdepartamento { get; set; }
        public string descripcion { get; set; }
        public Byte imagenes { get; set;}

          
    }
}

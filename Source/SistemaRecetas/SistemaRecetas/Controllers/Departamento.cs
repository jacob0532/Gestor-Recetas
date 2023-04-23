namespace SistemaRecetas.Controllers
{
    public class Departamento
    {
        public int IdDepartamento { get; set; }
        public string Nombre { get; set; }
    }

    internal class subDepartamento
    {
        public int IDsubDepartamento { get; set; }
        public string Nombre { get; set; }
        public int IdDepartamento { get; set; }
    }
}
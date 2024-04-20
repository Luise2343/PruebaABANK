namespace PruebaTecnica.Models
{
    public class Empleado
    {
        public int id { get; set; }
        public string nombres { get; set; }
        public string apellidos { get; set; }
        public string telefono { get; set; }
        public string correo { get; set; }
        public DateTime? fechacontratacion { get; set; }
        public int? idarea { get; set; }
        public DateTime fechacreacion { get; set; }
        public DateTime fechamodificacion { get; set; }
        public string departamento { get; set; }
    }
}

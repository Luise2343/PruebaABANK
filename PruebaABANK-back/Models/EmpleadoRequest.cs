namespace PruebaABANK.Models
{
    public class EmpleadoRequest
    {
        public string nombres { get; set; }
        public string apellidos { get; set; }
        public string telefono { get; set; }
        public string correo { get; set; }
        public DateTime? fechacontratacion { get; set; }
        public int? idarea { get; set; }
    }
}

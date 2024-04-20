using Microsoft.AspNetCore.Mvc;
using PruebaTecnica.Models;
using System.Data;
using Npgsql;
using Dapper;

namespace PruebaTecnica.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UsuariosController : ControllerBase
    {
        private readonly string _connectionString;

        public UsuariosController(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }

        [HttpPost("authenticate")]
        public IActionResult Authenticate([FromBody] LoginRequest model)
        {
            using (IDbConnection dbConnection = new NpgsqlConnection(_connectionString))
            {
                try
                {
                    var query = "SELECT * FROM usuarios WHERE usuario = @usuario AND password = @password";

                    var user = dbConnection.QueryFirstOrDefault<usuarios>(query, new { usuario = model.Usuario, password = model.Password });

                    if (user == null)
                    {
                        return BadRequest(new { message = "Usuario o contraseña incorrectos" });
                    }

                    return Ok(user);
                }
                catch (Exception ex)
                {
                    return StatusCode(500, new { message = "Error de servidor" });
                }
                finally
                {
                    dbConnection.Close();
                }
            }
        }
    }
}




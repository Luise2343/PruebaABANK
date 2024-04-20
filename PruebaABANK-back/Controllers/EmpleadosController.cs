
using Dapper;
using Microsoft.AspNetCore.Mvc;
using Npgsql;
using PruebaABANK.Models;
using System.Data;

namespace PruebaTecnica.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class EmpleadosController : ControllerBase
    {
        private readonly string _connectionString;

        public EmpleadosController(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }

        [HttpGet]
        public IActionResult GetAllEmployees()
        {
            using (IDbConnection dbConnection = new NpgsqlConnection(_connectionString))
            {
                try
                {
                    var query = @"
                    SELECT e.Id, e.Nombres, e.Apellidos, e.Telefono, e.Correo, d.Nombre as ""departamento""
                    FROM Empleados e
                    INNER JOIN Departamento d ON e.IdArea = d.Id;";

                    var employees = dbConnection.Query<empleadoResponse>(query);

                    return Ok(employees);
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


        [HttpPost("crear")]
        public IActionResult CrearEmpleado([FromBody] EmpleadoRequest empleado)
        {
            using (IDbConnection dbConnection = new NpgsqlConnection(_connectionString))
            {
                try
                {
                    var query = "CALL crearempleado(@p_nombres::varchar, @p_apellidos::varchar, @p_telefono::varchar, @p_correo::varchar, @p_fechacontratacion::date, @p_idarea::integer)";
                    var parameters = new
                    {
                        p_nombres = empleado.nombres,
                        p_apellidos = empleado.apellidos,
                        p_telefono = empleado.telefono,
                        p_correo = empleado.correo,
                        p_fechacontratacion = empleado.fechacontratacion,
                        p_idarea = empleado.idarea
                    };
                    dbConnection.Execute(query, parameters);

                    return Ok();
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



        [HttpPut("editar/{id}")]
        public IActionResult EditarEmpleado(int id, [FromBody] EmpleadoRequest model)
        {
            using (IDbConnection dbConnection = new NpgsqlConnection(_connectionString))
            {
                try
                {
                    var query = "CALL editarempleado(@p_id::integer, @p_nombres::varchar, @p_apellidos::varchar, @p_telefono::varchar, @p_correo::varchar, @p_fechacontratacion::date, @p_idarea::integer)";
                    var parameters = new
                    {
                        p_id = id,
                        p_nombres = model.nombres,
                        p_apellidos = model.apellidos,
                        p_telefono = model.telefono,
                        p_correo = model.correo,
                        p_fechacontratacion = model.fechacontratacion,
                        p_idarea = model.idarea
                    };

                    dbConnection.Execute(query, parameters);

                    return Ok(new { message = "Empleado editado exitosamente" });
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
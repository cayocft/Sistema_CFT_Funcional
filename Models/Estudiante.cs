﻿using System;
using System.Collections.Generic;

namespace Sistema_CFT.Models;

public partial class Estudiante
{
    public int Id { get; set; }

    public string Nombre { get; set; } = null!;

    public string Apellido { get; set; } = null!;

    public string Rut { get; set; } = null!;

    public string Correo { get; set; } = null!;

    public int? Edad { get; set; }

    public DateOnly? FechaNacimiento { get; set; }

    public virtual ICollection<Asignaturaasignada> Asignaturaasignada { get; set; } = new List<Asignaturaasignada>();
}

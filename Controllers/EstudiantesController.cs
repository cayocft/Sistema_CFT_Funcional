using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using Sistema_CFT.Models;

namespace Sistema_CFT.Controllers
{
    public class EstudiantesController : Controller
    {
        private readonly SistemaCftContext _context;

        public EstudiantesController(SistemaCftContext context)
        {
            _context = context;
        }

        // GET: Estudiantes
        public async Task<IActionResult> Index()
        {
              return _context.Estudiantes != null ? 
                          View(await _context.Estudiantes.ToListAsync()) :
                          Problem("Entity set 'SistemaCftContext.Estudiantes'  is null.");
        }

        // GET: Estudiantes/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null || _context.Estudiantes == null)
            {
                return NotFound();
            }

            var estudiante = await _context.Estudiantes
                .FirstOrDefaultAsync(m => m.Id == id);
            if (estudiante == null)
            {
                return NotFound();
            }

            return View(estudiante);
        }

        // GET: Estudiantes/NotasEstudiante/1
        [HttpGet]
        public async Task<IActionResult> NotasEstudiante(int? id_estudiante, int? id_asignatura)
        {
            float promedio = 0;
            int avancePonderacion = 0;
            if (id_estudiante == 0 && id_asignatura == 0)
            {
                return NotFound();
            }
            IQueryable<Nota> Notas = _context.Nota;
            Notas = Notas.Where(m => m.EstudianteId == id_estudiante)
                .Where(m => m.AsignaturaId == id_asignatura);
                
            var notas = await Notas.ToListAsync();

            //IQueryable<Asignatura> Asignaturas = _context.Asignaturas;
            var Asignatura = _context.Asignaturas.First(a => a.Id == id_asignatura);
            
            foreach(var nota in notas)
            {
                if(nota.Calificacion != null && nota.Ponderacion != null)
                {
                    promedio = promedio + (float)(nota.Calificacion * (nota.Ponderacion/100));
                    avancePonderacion = (int)(avancePonderacion + nota.Ponderacion);
                }
               
            }
            System.Diagnostics.Debug.WriteLine("------------------------------------------");
            Debug.WriteLine(promedio);
            if (notas.Count() == 0)
            {
                return NotFound();
            }
            ViewData["Promedio"] = promedio;
            ViewData["AvancePonderacion"] = avancePonderacion;
            ViewData["Asignatura"] = Asignatura.Nombre;
            return View(notas);
            //var notas = _context.Nota.Find(EstudianteId, AsignaturaId);

        }


        // GET: Estudiantes/AsignaturasPorEstudiante/1
        [HttpGet]
        public async Task<IActionResult> AsignaturasPorEstudiante(int? id)
        {

            if (id == 0)
            {
                return NotFound();
            }
            System.Diagnostics.Debug.WriteLine("------------------------------------------");
            Debug.WriteLine(id);
            IQueryable<Asignaturaasignada> AsignaturasAsignadas = _context.Asignaturaasignada;
            AsignaturasAsignadas =  AsignaturasAsignadas.Where(m => m.EstudianteId == id)
                .Include(m => m.Asignatura);

            
            var asignaturasAsignadas = await AsignaturasAsignadas.ToListAsync();
            if (asignaturasAsignadas.Count() == 0)
            {
                return NotFound();
            }
            System.Diagnostics.Debug.WriteLine("------------------------------------------");
            Debug.WriteLine(asignaturasAsignadas);
            return View(asignaturasAsignadas);
            //var notas = _context.Nota.Find(EstudianteId, AsignaturaId);

        }


        // GET: Estudiantes/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: Estudiantes/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("Id,Nombre,Apellido,Rut,Correo,Edad,FechaNacimiento")] Estudiante estudiante)
        {
            if (ModelState.IsValid)
            {
                _context.Add(estudiante);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return View(estudiante);
        }

        // GET: Estudiantes/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null || _context.Estudiantes == null)
            {
                return NotFound();
            }

            var estudiante = await _context.Estudiantes.FindAsync(id);
            if (estudiante == null)
            {
                return NotFound();
            }
            return View(estudiante);
        }

        // POST: Estudiantes/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("Id,Nombre,Apellido,Rut,Correo,Edad,FechaNacimiento")] Estudiante estudiante)
        {
            if (id != estudiante.Id)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(estudiante);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!EstudianteExists(estudiante.Id))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction(nameof(Index));
            }
            return View(estudiante);
        }

        // GET: Estudiantes/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null || _context.Estudiantes == null)
            {
                return NotFound();
            }

            var estudiante = await _context.Estudiantes
                .FirstOrDefaultAsync(m => m.Id == id);
            if (estudiante == null)
            {
                return NotFound();
            }

            return View(estudiante);
        }

        // POST: Estudiantes/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            if (_context.Estudiantes == null)
            {
                return Problem("Entity set 'SistemaCftContext.Estudiantes'  is null.");
            }
            var estudiante = await _context.Estudiantes.FindAsync(id);
            if (estudiante != null)
            {
                _context.Estudiantes.Remove(estudiante);
            }
            
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool EstudianteExists(int id)
        {
          return (_context.Estudiantes?.Any(e => e.Id == id)).GetValueOrDefault();
        }
    }
}

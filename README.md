# Backend Sitio Oficial Waliex

Sistema CFT para pruebas de desarrollo.

## Comenzando 🚀

_Estas instrucciones te permitirán obtener una copia del proyecto en funcionamiento en tu máquina local para propósitos de desarrollo,  pruebas y mostrará los servicios disponibles._

Mira **Deployment** para conocer como desplegar el proyecto.


### Pre-requisitos 📋

_Que cosas necesitas para instalar el software y como instalarlas_

```
1. .NET 7.0
2. Visual Studio 2022
3. Base de datos adjunta en el mismo proyecto
4. 
```

### Instalación 🔧

_Debe contener los pre requisitos_

_Depurar el el proyecto_

```
1. Iniciar para depurar
```
_Para generar los modelos conectando a la base de datos_
```
1. Scaffold-DbContext "server=localhost; port=3306; database=sistema_cft; uid=root; password=;" Pomelo.EntityFrameworkCore.MySql -o Models
2. Considera cambiar "database" el usuario y password: "uid" y "password"
```

_Agregar en el archivo "appsettings.json" la conexción a la base de datos del proyecto_

```
  "ConnectionStrings": {
    "ConexionDb": "server=localhost;port=3306;database=db_sistema_cft;uid=root"
  }
```


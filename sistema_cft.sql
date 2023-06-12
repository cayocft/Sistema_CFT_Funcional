-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 29-05-2023 a las 07:26:49
-- Versión del servidor: 10.4.25-MariaDB
-- Versión de PHP: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `sistema_cft`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asignatura`
--

CREATE TABLE `asignatura` (
  `Id` int(11) NOT NULL,
  `Nombre` varchar(100) NOT NULL,
  `Descripcion` varchar(300) NOT NULL,
  `Codigo` varchar(20) NOT NULL,
  `FechaActualizacion` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `asignatura`
--

INSERT INTO `asignatura` (`Id`, `Nombre`, `Descripcion`, `Codigo`, `FechaActualizacion`) VALUES
(1, 'Matematica', 'Matematica Asignatura', 'MAT887', '2023-09-20');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asignaturaasignada`
--

CREATE TABLE `asignaturaasignada` (
  `Id` int(11) UNSIGNED ZEROFILL NOT NULL,
  `EstudianteId` int(11) NOT NULL,
  `AsignaturaId` int(11) NOT NULL,
  `FechaRegistro` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `asignaturaasignada`
--

INSERT INTO `asignaturaasignada` (`Id`, `EstudianteId`, `AsignaturaId`, `FechaRegistro`) VALUES
(00000000002, 1, 1, '2022-04-22'),
(00000000003, 1, 1, '2022-04-02');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estudiante`
--

CREATE TABLE `estudiante` (
  `Id` int(11) NOT NULL,
  `Nombre` varchar(100) NOT NULL,
  `Apellido` varchar(100) NOT NULL,
  `Rut` varchar(45) NOT NULL,
  `Correo` varchar(100) NOT NULL,
  `Edad` int(11) DEFAULT NULL,
  `FechaNacimiento` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `estudiante`
--

INSERT INTO `estudiante` (`Id`, `Nombre`, `Apellido`, `Rut`, `Correo`, `Edad`, `FechaNacimiento`) VALUES
(1, 'Juanito', 'Lara', '7676767', 'juanito@gmail.com', 11, '2022-06-15');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `nota`
--

CREATE TABLE `nota` (
  `Id` int(11) NOT NULL,
  `Calificacion` float NOT NULL,
  `Ponderacion` float NOT NULL,
  `FechaRegistro` date DEFAULT NULL,
  `EstudianteId` int(11) NOT NULL,
  `AsignaturaId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `nota`
--

INSERT INTO `nota` (`Id`, `Calificacion`, `Ponderacion`, `FechaRegistro`, `EstudianteId`, `AsignaturaId`) VALUES
(1, 55, 25, '2022-04-02', 1, 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `asignatura`
--
ALTER TABLE `asignatura`
  ADD PRIMARY KEY (`Id`);

--
-- Indices de la tabla `asignaturaasignada`
--
ALTER TABLE `asignaturaasignada`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `fk_Estudiante_has_Asignatura_Asignatura1_idx` (`AsignaturaId`),
  ADD KEY `fk_Estudiante_has_Asignatura_Estudiante_idx` (`EstudianteId`);

--
-- Indices de la tabla `estudiante`
--
ALTER TABLE `estudiante`
  ADD PRIMARY KEY (`Id`);

--
-- Indices de la tabla `nota`
--
ALTER TABLE `nota`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `fk_Nota_Estudiante1_idx` (`EstudianteId`),
  ADD KEY `fk_Nota_Asignatura1_idx` (`AsignaturaId`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `asignatura`
--
ALTER TABLE `asignatura`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `asignaturaasignada`
--
ALTER TABLE `asignaturaasignada`
  MODIFY `Id` int(11) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `estudiante`
--
ALTER TABLE `estudiante`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `nota`
--
ALTER TABLE `nota`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `asignaturaasignada`
--
ALTER TABLE `asignaturaasignada`
  ADD CONSTRAINT `fk_Estudiante_has_Asignatura_Asignatura1` FOREIGN KEY (`AsignaturaId`) REFERENCES `asignatura` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Estudiante_has_Asignatura_Estudiante` FOREIGN KEY (`EstudianteId`) REFERENCES `estudiante` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `nota`
--
ALTER TABLE `nota`
  ADD CONSTRAINT `fk_Nota_Asignatura1` FOREIGN KEY (`AsignaturaId`) REFERENCES `asignatura` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Nota_Estudiante1` FOREIGN KEY (`EstudianteId`) REFERENCES `estudiante` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

# 01 - SRS (Resumen) - Plataforma de Aprendizaje Adaptativo y Colaborativo

> Este documento es un resumen del SRS, derivado del SAD v1.0 (Marzo 2026).  
> El SRS completo puede ampliarse con historias de usuario, reglas de negocio y criterios de aceptacion.

---

## Alcance

La plataforma permite gestionar cursos, evaluaciones y recomendaciones adaptativas para estudiantes, con capacidades de analitica para profesores y operacion para administradores.

## Actores

- Estudiante
- Profesor
- Administrador

## Requisitos Funcionales (Resumen)

- Gestion de usuarios, autenticacion y autorizacion por roles.
- Creacion y publicacion de cursos y contenidos.
- Motor de recomendacion adaptativa basado en desempeno.
- Evaluaciones, calificaciones y retroalimentacion.
- Reportes y analitica para toma de decisiones.

## Requisitos No Funcionales (Escenarios medibles)

- RNF-01 Escalabilidad: >5.000 usuarios concurrentes al inicio de semestre sin degradacion.
- RNF-02 Disponibilidad: 99.5% uptime mensual (~3.6h/mes).
- RNF-03 Rendimiento: p95 <2s para cargar curso o enviar evaluacion.
- RNF-04 Seguridad: JWT + RBAC; accesos indebidos se deniegan y se auditan.
- RNF-05 Mantenibilidad: Incorporar un nuevo modulo sin afectar los existentes.
- RNF-06 Interoperabilidad: APIs REST documentadas con OpenAPI 3.0 y soporte OAuth 2.0.

## Restricciones

- Despliegue en cloud (AWS) con escalabilidad elastica.
- Todo trafico sobre HTTPS.
- Base de datos transaccional ACID (PostgreSQL) para evaluaciones.
- Cumplimiento de normativas de proteccion de datos personales.

## Requisitos No Funcionales (Resumen)

- Disponibilidad objetivo del servicio >= 99.5%.
- Escalabilidad horizontal para componentes stateless.
- Seguridad de datos y trazabilidad de auditoria.
- Tiempos de respuesta p95 menores a 2 segundos para operaciones de consulta.

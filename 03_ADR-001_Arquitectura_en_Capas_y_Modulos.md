# ADR-001: Arquitectura en Capas con Modulos de Servicio

Estado: Aceptado  
Fecha: Marzo 2026  
Decisores: Equipo de arquitectura

## Contexto

El sistema requiere modulos (usuarios, cursos, evaluaciones, adaptacion, colaboracion, analitica) con necesidades de escalado y evolucion independientes. Un monolito dificultaria cumplir RNF-01 (escalabilidad) y RNF-05 (mantenibilidad). Microservicios con BDs separadas exceden complejidad operativa para el alcance academico.

## Decision

Arquitectura en capas (Presentacion, Aplicacion, Dominio, Infraestructura) y backend descompuesto en modulos de servicio cohesionados por capacidad de negocio. Cada modulo tiene su propio repositorio logico en PostgreSQL (schema), contratos claros expuestos via API Gateway.

## Alternativas consideradas

- Monolito clasico: Menor complejidad inicial pero escalar todo-o-nada y alto acoplamiento. Rechazado por RNF-01 y RNF-05.
- Microservicios puros con BD independiente por servicio: Maximo aislamiento pero requiere orquestacion y transacciones distribuidas; complejo para el contexto del curso. Rechazado por costo-operativo.

## Consecuencias

- Positivas: Escalamiento por modulo, despliegue independiente, mejor trazabilidad de cambios y pruebas. Cumple RNF-01 y RNF-05.
- Negativas: Mayor disciplina en versionar contratos y respetar limites de modulo. Sobrecarga inicial en definir estructuras por modulo.
- Mitigacion: Lineamientos de arquitectura, revisiones periodicas de contratos, plantillas de modulo y pruebas de contrato en el pipeline.

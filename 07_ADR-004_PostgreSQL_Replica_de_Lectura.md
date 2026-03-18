# ADR-004: PostgreSQL como Base de Datos Principal con Replica de Lectura

Estado: Aceptado  
Fecha: Marzo 2026  
Decisores: Equipo de arquitectura

## Contexto

Las evaluaciones y progreso academico requieren transacciones ACID (RNF-04). Analitica y dashboards generan lecturas intensivas que pueden degradar escrituras y latencia (RNF-03). Se necesita aislar cargas de lectura sin perder consistencia fuerte en operaciones criticas.

## Decision

Adoptar PostgreSQL 16 como base de datos principal (AWS RDS) con replica de lectura dedicada para consultas de Analitica. Escrituras y operaciones transaccionales van siempre a la primaria; lecturas de dashboards se enrutan a la replica.

## Alternativas consideradas

- MongoDB: Esquema flexible pero transacciones ACID limitadas; no adecuado para datos academicos criticos. Rechazado.
- BD separada por modulo: Aislamiento maximo, pero introduce transacciones distribuidas y alta complejidad operativa. Rechazado por alcance del proyecto.

## Consecuencias

- Positivas: ACID garantizado para evaluaciones; lecturas intensivas no afectan escrituras; alineado con RNF-03 y RNF-04. Aprovecha capacidades gestionadas de RDS (backups, failover).
- Negativas: Retraso de replicacion (~100ms) puede mostrar datos ligeramente desfasados en analitica; mayor costo por replica.
- Mitigacion: Comunicar en UI que dashboards pueden tener hasta 5 minutos de retraso; cache Redis 5 min; monitoreo de lag de replica y alertas.

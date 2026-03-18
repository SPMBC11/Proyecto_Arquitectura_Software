# ADR-003: Procesamiento Asincrono del Motor Adaptativo con RabbitMQ

Estado: Aceptado  
Fecha: Marzo 2026  
Decisores: Equipo de arquitectura

## Contexto

El motor adaptativo necesita procesar resultados de evaluaciones (200ms-2s). Si se hace sincrono, la respuesta al estudiante superaria RNF-03 (<2s p95). Se requiere desacoplar el flujo transaccional de evaluaciones del procesamiento adaptativo y soportar picos (RNF-01).

## Decision

Usar RabbitMQ para publicar el evento evaluacion.completada desde el modulo de Evaluaciones. El Motor Adaptativo consume asincronamente y actualiza recomendaciones en Redis/PostgreSQL. El endpoint de envio de evaluacion responde sin esperar el procesamiento.

## Alternativas consideradas

- Llamada sincrona directa Evaluaciones -> Motor Adaptativo: Simple pero viola RNF-03 bajo carga. Rechazado.
- Procesamiento batch nocturno: No refleja progreso del dia y reduce valor pedagogico. Rechazado.

## Consecuencias

- Positivas: Cumple RNF-03, absorbe picos con colas, desacopla temporalmente productores y consumidores. Escala horizontalmente el consumidor. Aporta a RNF-01.
- Negativas: Consistencia eventual y mayor complejidad operativa (DLQ, reintentos).
- Mitigacion: Mensajes idempotentes, DLQ, reintentos exponenciales, trazas distribuidas, alertas de backlog y capacidad HA en AmazonMQ.

# ADR-002: API Gateway (Kong) como Punto Unico de Entrada

Estado: Aceptado  
Fecha: Marzo 2026  
Decisores: Equipo de arquitectura

## Contexto

Multiples modulos de servicio requeririan duplicar autenticacion JWT, RBAC y rate limiting. Esto introduce riesgo de inconsistencias y vulnerabilidades (RNF-04). Se necesita un punto unico de entrada para aplicar politicas transversales y observabilidad.

## Decision

Usar Kong como API Gateway centralizado para interceptar todas las peticiones, validar JWT, aplicar RBAC y rate limiting antes de enrutar a cada servicio. Exponer OpenAPI 3.0 y logs estructurados.

## Alternativas consideradas

- Seguridad en cada servicio: Duplica logica y configuracion; alto riesgo de inconsistencia. Rechazado.
- AWS API Gateway: Servicio gestionado pero con lock-in y menor flexibilidad de plugins. Rechazado en favor de Kong por portabilidad.

## Consecuencias

- Positivas: Seguridad consistente, un unico punto para auditoria, facilidad para agregar nuevas politicas. Cumple RNF-04 y aporta a RNF-05.
- Negativas: Potencial punto unico de fallo y latencia adicional (~5ms).
- Mitigacion: Desplegar multiples instancias detras de ALB, health checks, auto-scaling y pruebas de capacidad periodicas.

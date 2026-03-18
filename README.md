# Proyecto_Arquitectura_Software

# Plataforma de Aprendizaje Adaptativo y Colaborativo — Documentacion Arquitectural

Pontificia Universidad Javeriana — Arquitectura de Software 2026  
Version: SAD v1.0 (Marzo 2026)

## Proposito

Repositorio de documentacion arquitectonica del proyecto (SRS, vistas C4 en Structurizr DSL, ADRs, SAD). El SRS define el QUE, los ADRs documentan el POR QUE, el SAD consolida el COMO.

## Estructura

```
Proyecto_Arquitectura_Software/
│
├── proyecto_ArquiSoftware/                               # Placeholder de codigo
│
├── 01_SRS_Plataforma.md                                  # Resumen SRS (QUÉ)
├── 02_Plataforma_Architecture.dsl                        # Vistas C4 en Structurizr DSL
├── 03_ADR-001_Arquitectura_en_Capas_y_Modulos.md         # ADR: arquitectura en capas + modulos
├── 04_ADR-002_API_Gateway_Kong.md                        # ADR: gateway y seguridad centralizada
├── 05_ADR-003_Procesamiento_Asincrono_Motor_Adaptativo_RabbitMQ.md # ADR: async RabbitMQ
├── 06_SAD_Plataforma.md                                  # SAD completo (documento maestro)
├── 07_ADR-004_PostgreSQL_Replica_de_Lectura.md           # ADR: BD principal + replica de lectura
├── diagrams/README.md                                    # Diagramas Mermaid (contenedores, secuencias, despliegue) + PNG/SVG exportados en diagrams/img
└── README.md                                             # Este puntero breve
```

## Diagramas (PNG/SVG)

- Contenedores: [diagrams/img/containers.png](diagrams/img/containers.png)
- Secuencia UC-01: [diagrams/img/uc01-secuencia.png](diagrams/img/uc01-secuencia.png)
- Circuit Breaker: [diagrams/img/circuit-breaker.png](diagrams/img/circuit-breaker.png)
- Desarrollo (organizacion repo): [diagrams/img/desarrollo.png](diagrams/img/desarrollo.png)
- Despliegue: [diagrams/img/despliegue.png](diagrams/img/despliegue.png)
- Escenarios (+1): [diagrams/img/escenarios.png](diagrams/img/escenarios.png)

<p>
<img src="diagrams/img/containers.png" alt="Vista de Contenedores" style="max-width: 100%; height: auto;" />
</p>
<p>
<img src="diagrams/img/uc01-secuencia.png" alt="Secuencia UC-01" style="max-width: 100%; height: auto;" />
</p>
<p>
<img src="diagrams/img/circuit-breaker.png" alt="Circuit Breaker" style="max-width: 420px; width: 100%; height: auto;" />
</p>
<p>
<img src="diagrams/img/desarrollo.png" alt="Vista de Desarrollo" style="max-width: 100%; height: auto;" />
</p>
<p>
<img src="diagrams/img/despliegue.png" alt="Vista de Despliegue" style="max-width: 100%; height: auto;" />
</p>
<p>
<img src="diagrams/img/escenarios.png" alt="Escenarios +1" style="max-width: 100%; height: auto;" />
</p>

## Como visualizar las vistas (Structurizr DSL)

Opcion A (Structurizr Online):
1) Abrir el editor DSL de Structurizr.  
2) Copiar el contenido de `02_Plataforma_Architecture.dsl`.  
3) Renderizar las vistas (Contexto y Contenedores).

Opcion B (local con Structurizr Lite):
```
docker pull structurizr/lite
docker run -it --rm -p 8080:8080 \
	-v "$(pwd)":/usr/local/structurizr \
	structurizr/lite
# Abrir http://localhost:8080
```

## Orden recomendado de lectura

1) `01_SRS_Plataforma.md`
2) ADRs (`03_*.md`, `04_*.md`, `05_*.md`, `07_*.md`)
3) `02_Plataforma_Architecture.dsl`
4) `06_SAD_Plataforma.md`

Nota: en Windows no es posible tener simultaneamente README.md y Readme.md solo por mayusculas/minusculas; se mantiene este archivo y el SAD completo esta en `06_SAD_Plataforma.md`.
# Diagramas de Arquitectura

Este directorio contiene diagramas en Mermaid alineados con el SAD v1.0. Renderizar en cualquier visor compatible con Mermaid.

## Vista de Contenedores (C4 nivel contenedor)
Imagen: [img/containers.png](img/containers.png)
Mermaid base:
```mermaid
flowchart LR
  subgraph Presentation["Capa de Presentacion"]
    web["React SPA (Web)"]
    mobile["React Native (Mobile)"]
  end
  subgraph Gateway
    kong["Kong Gateway\nJWT/RBAC/Rate limiting"]
  end
  subgraph Backend["Servicios Backend"]
    eval["Servicio Evaluaciones"]
    courses["Servicio Cursos"]
    users["Servicio Usuarios"]
    collab["Servicio Colaboracion"]
    analytics["Servicio Analitica"]
    adaptive["Motor Adaptativo"]
  end
  subgraph Messaging["Mensajeria"]
    rabbit["RabbitMQ Pub/Sub"]
  end
  subgraph Data["Capa de Datos"]
    redis["Redis Cache + Sesiones"]
    pgPrimary["PostgreSQL Primaria"]
    pgReplica["PostgreSQL Replica"]
    s3["AWS S3 Materiales"]
  end

  web --> kong
  mobile --> kong
  kong --> eval
  kong --> courses
  kong --> users
  kong --> collab
  kong --> analytics
  kong --> adaptive

  eval --> rabbit
  rabbit --> adaptive

  adaptive --> redis
  adaptive --> pgPrimary
  analytics --> pgReplica
  analytics --> redis
  collab --> pgPrimary
  courses --> pgPrimary
  courses --> s3
  users --> pgPrimary
  kong --> redis
  pgPrimary --> pgReplica
```


## Secuencia UC-01 (evaluacion.completada)
Imagen: [img/uc01-secuencia.png](img/uc01-secuencia.png)
  Mermaid base:
```mermaid
sequenceDiagram
  participant Estudiante
  participant APIGateway as API Gateway
  participant Evaluaciones as Modulo Evaluaciones
  participant RabbitMQ
  participant Adaptativo as Motor Adaptativo
  participant Redis as Redis Cache
  participant Postgres as PostgreSQL

  Estudiante->>APIGateway: Enviar evaluacion
  APIGateway->>Evaluaciones: POST /assessments/submit
  Evaluaciones-->>Estudiante: 200 OK (<2s)
  Evaluaciones->>RabbitMQ: Publicar evento evaluacion.completada
  RabbitMQ->>Adaptativo: Evento evaluacion.completada
  Adaptativo->>Redis: Consultar progreso cache
  Alt Cache hit
    Adaptativo->>Adaptativo: Usar progreso cache
  Else Cache miss
    Adaptativo->>Postgres: Consultar historial estudiante
  End
  Adaptativo->>Adaptativo: Aplicar reglas pedagogicas
  Adaptativo->>Redis: Guardar recomendaciones
  Adaptativo->>Postgres: Guardar resultado
```


## Circuit Breaker (Motor Adaptativo)
Imagen: [img/circuit-breaker.png](img/circuit-breaker.png)
Mermaid base:
```mermaid
flowchart TD
  req["Peticion al Motor Adaptativo"] --> decision{"Error rate > 50%?"}
  decision -->|SI| open["Circuit Breaker ABIERTO\nRecomendacion generica"] --> log["Registrar fallo en logs"]
  decision -->|NO| normal["Procesamiento normal\nMotor Adaptativo"]
```


## Vista de Desarrollo (organizacion del repo)
Imagen: [img/desarrollo.png](img/desarrollo.png)
Mermaid base:
```mermaid
flowchart LR
  repo["Repositorio Plataforma"]
  subgraph Frontend
    react["React SPA"]
    comps["Componentes"]
    api["Servicios API"]
    state["Context / Estado"]
  end
  subgraph Gateway
    kong["API Gateway Kong"]
  end
  subgraph Services
    usersSvc["User Service"]
    coursesSvc["Course Service"]
    assessmentsSvc["Assessment Service"]
    adaptiveSvc["Adaptive Engine"]
    collabSvc["Collaboration Service"]
    analyticsSvc["Analytics Service"]
  end
  subgraph Shared
    repos["Repositories"]
    middleware["Middleware JWT / Logs"]
    events["Eventos RabbitMQ"]
  end
  subgraph Infra
    docker["Dockerfiles"]
    tf["Terraform IaC"]
    k8s["Kubernetes"]
  end

  repo --> Frontend
  repo --> Gateway
  repo --> Services
  repo --> Shared
  repo --> Infra

  Frontend --> kong
  kong --> Services
  Services --> Shared
```


## Vista de Despliegue (alto nivel)
Imagen: [img/despliegue.png](img/despliegue.png)
Mermaid base:
```mermaid
flowchart TB
  internet[Internet]
  route53[Route53 DNS]
  alb["AWS ALB / Load Balancer"]
  subgraph ecs["ECS Cluster Auto Scaling"]
    gateway1[API Gateway]
    backend1[Servicios Backend]
  end
  subgraph data["Data Layer"]
    pgPrimary["PostgreSQL RDS Primaria"]
    pgReplica["PostgreSQL Read Replica"]
    redis["Redis ElastiCache"]
    rabbit["RabbitMQ AmazonMQ"]
    s3["AWS S3"]
  end

  internet --> route53 --> alb --> gateway1 --> backend1
  backend1 --> pgPrimary
  backend1 --> redis
  backend1 --> rabbit
  backend1 --> s3
  pgPrimary --> pgReplica
```


## Escenarios (+1)
Imagen: [img/escenarios.png](img/escenarios.png)
Mermaid base:
```mermaid
flowchart LR
  uc1["UC-01 Estudiante completa evaluacion"] --> eval["Modulo Evaluaciones"] --> rabbit["RabbitMQ"] --> adaptive["Motor Adaptativo"]
  uc2["UC-02 Profesor monitorea progreso"] --> analytics["Modulo Analitica"] --> redis["Redis Cache"]
  uc3["UC-03 5000 usuarios simultaneos"] --> alb["Load Balancer"] --> back["Servicios Backend"]
  uc4["UC-04 Participacion en foro"] --> collab["Servicio Colaborativo"] --> ws["WebSockets"]
  uc5["UC-05 Falla del motor adaptativo"] --> cb["Circuit Breaker"]
```


workspace "Plataforma de Aprendizaje Adaptativo y Colaborativo" "Arquitectura basada en SAD v1.0 (Marzo 2026)" {

  model {
    estudiante = person "Estudiante" "Consume cursos, realiza evaluaciones y recibe recomendaciones"
    profesor = person "Profesor" "Crea cursos/evaluaciones y consulta analitica"
    administrador = person "Administrador" "Administra usuarios, roles, seguridad y operacion"

    plataforma = softwareSystem "Plataforma de Aprendizaje" "Sistema principal de aprendizaje adaptativo"

    webApp = container plataforma "Web App" "SPA para estudiantes, profesores y administradores" "React 18 / TypeScript"
    apiGateway = container plataforma "API Gateway" "Punto unico de entrada, seguridad, RBAC y rate limiting" "Kong"

    usuarios = container plataforma "Servicio Usuarios" "Registro, autenticacion, roles JWT/RBAC" "Node.js / Express"
    cursos = container plataforma "Servicio Cursos" "Gestion de cursos, modulos, materiales" "Node.js / Express"
    evaluaciones = container plataforma "Servicio Evaluaciones" "Creacion y envio de evaluaciones ACID" "Node.js / Express"
    motorAdaptativo = container plataforma "Motor Adaptativo" "Aplica reglas y genera recomendaciones" "Node.js"
    colaboracion = container plataforma "Servicio Colaboracion" "Foros, grupos, mensajeria tiempo real" "Node.js / Express / Socket.io"
    analitica = container plataforma "Servicio Analitica" "Dashboards y reportes agregados" "Node.js / Express"

    broker = container plataforma "Broker de Mensajes" "Pub/Sub para eventos academicos" "RabbitMQ"
    redis = container plataforma "Cache" "Cache de progreso, recomendaciones, rate limiting" "Redis"
    dbPrimaria = container plataforma "Base de Datos Primaria" "Persistencia transaccional ACID" "PostgreSQL"
    dbReplica = container plataforma "Replica de Lectura" "Consultas analiticas y dashboards" "PostgreSQL (read replica)"
    s3 = container plataforma "Almacenamiento de Materiales" "Archivos educativos" "AWS S3"

    estudiante -> webApp "Usa"
    profesor -> webApp "Usa"
    administrador -> webApp "Administra"

    webApp -> apiGateway "HTTPS"
    apiGateway -> usuarios "REST"
    apiGateway -> cursos "REST"
    apiGateway -> evaluaciones "REST"
    apiGateway -> colaboracion "REST/WebSocket upgrade"
    apiGateway -> analitica "REST"
    apiGateway -> motorAdaptativo "REST (recomendaciones)"

    usuarios -> dbPrimaria "CRUD usuarios/roles"
    usuarios -> redis "Gestion de refresh tokens"

    cursos -> dbPrimaria "CRUD cursos/modulos"
    cursos -> s3 "Descarga de materiales"

    evaluaciones -> dbPrimaria "Transacciones evaluaciones"
    evaluaciones -> broker "Publica evaluacion.completada"

    motorAdaptativo -> broker "Consume evaluacion.completada"
    motorAdaptativo -> redis "Cache de recomendaciones"
    motorAdaptativo -> dbPrimaria "Historial de progreso"
    motorAdaptativo -> cursos "Consulta catalogo"

    colaboracion -> dbPrimaria "Persistencia foros/grupos"

    analitica -> dbReplica "Lecturas agregadas"
    analitica -> redis "Cache dashboards"

    apiGateway -> redis "Rate limiting"
  }

  views {
    systemContext plataforma {
      include *
      autolayout lr
    }

    container plataforma {
      include *
      autolayout lr
    }

    theme default
  }
}

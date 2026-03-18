# Proyecto_Arquitectura_Software
# 📚 Plataforma de Aprendizaje Adaptativo y Colaborativo — Documentación Arquitectural

**Pontificia Universidad Javeriana — Arquitectura de Software 2026**  
**Versión:** SAD v1.0 (Marzo 2026)

---

## 🎯 Propósito de este repositorio

Este repositorio contiene la documentación arquitectónica del proyecto **Plataforma de Aprendizaje Adaptativo y Colaborativo**, siguiendo un flujo similar al repositorio de referencia **CourtBooker**:

1. **SRS** (requisitos) — define el QUÉ.
2. **Structurizr DSL** — vistas C4 como “diagramas como código”.
3. **ADRs** — decisiones arquitectónicas y justificación (POR QUÉ).
4. **SAD** — documento maestro que consolida el CÓMO y el POR QUÉ.

---

## 📁 Estructura

```
Proyecto_Arquitectura_Software/
│
├── proyecto_ArquiSoftware/                               # (placeholder de código)
│
├── 01_SRS_Plataforma.md                                  # Requisitos (resumen SRS)
├── 02_Plataforma_Architecture.dsl                        # Vistas C4 en Structurizr DSL
├── 03_ADR-001_Arquitectura_en_Capas_y_Modulos.md         # Decisión: arquitectura en capas + módulos
├── 04_ADR-002_API_Gateway_Kong.md                        # Decisión: API Gateway + seguridad centralizada (y nota OAuth2/OpenAPI)
├── 05_ADR-003_Procesamiento_Asincrono_Motor_Adaptativo_RabbitMQ.md # Decisión: async con RabbitMQ
├── 06_SAD_Plataforma.md                                  # SAD completo (documento maestro)
���── README.md                                              # (puntero corto opcional)
```

---

## 👀 Cómo visualizar los diagramas (Structurizr DSL)

**Opción A (recomendada): Structurizr Online**
1. Abrir el editor DSL: (Structurizr DSL)
2. Copiar y pegar el contenido de `02_Plataforma_Architecture.dsl`
3. Renderizar para ver las vistas.

**Opción B (local): Structurizr Lite**
```bash
docker pull structurizr/lite
docker run -it --rm -p 8080:8080 \
  -v "$(pwd)":/usr/local/structurizr \
  structurizr/lite
# Abrir http://localhost:8080
```

---

## ✅ Orden recomendado de lectura

1. `01_SRS_Plataforma.md`
2. `03_*.md`, `04_*.md`, `05_*.md` (ADRs)
3. `02_Plataforma_Architecture.dsl` (vistas)
4. `06_SAD_Plataforma.md`

---

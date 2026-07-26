# ============================================================
# UNIVERSIDAD NACIONAL DEL CENTRO DEL PERRÚ
# Facultad de Economía
# Curso: Programación con R
# Tema: ANÁLISIS EXPLORATORIO DE LOS INGRESOS Y GASTOS DE LOS HOGARES PERUANOS: EVIDENCIA DE LA ENAHO 2024
# Base de datos : ENAHO 2024 - SUMARIA
# Institución   : Instituto Nacional de Estadística e Informática (INEI)
# Región        : Junín
# Autora        : Talita Echevarría Camarena
# ============================================================
# ============================================================
# OBJETIVO
# ============================================================
Aplicar los conocimientos adquiridos durante las primeras cuatro clases para desarrollar un Análisis Exploratorio de Datos (EDA) utilizando R, con el propósito de comprender el comportamiento de los hogares de la región Junín a partir de la Encuesta Nacional de Hogares (ENAHO) 2024, identificar patrones, detectar posibles problemas y generar evidencia que permita obtener conclusiones.

# ============================================================
# 1. CONTEXTO DEL CONJUNTO DE DATOS
# ============================================================

## Institución

Instituto Nacional de Estadística e Informática (INEI).

## Fuente de datos

Encuesta Nacional de Hogares (ENAHO) 2024.

## Objetivo del conjunto de datos

La ENAHO recopila información sobre las características socioeconómicas de los hogares peruanos con la finalidad de producir estadísticas oficiales para el análisis de las condiciones de vida de la población.

## Variables analizadas

- UBIGEO
- MIEPERHO
- PERCEPHO
- INGHOG1D
- GASHOG1D
- POBREZA
- INGRESO_PCAPITA
- GASTO_PCAPITA
# ============================================================
# 2. IMPORTACIÓN DE DATOS
# ============================================================

La base de datos se importó en R utilizando el paquete **haven**, ya que el archivo original se encuentra en formato `.SAV`.

# ============================================================
# 3. LIMPIEZA Y PREPARACIÓN DE DATOS
# ============================================================

Se realizaron las siguientes actividades:

- Filtrado de los hogares pertenecientes a la región Junín.
- Selección de las variables de interés.
- Creación de las variables ingreso per cápita y gasto per cápita.
- Verificación de valores faltantes.
- Revisión de valores infinitos.
# ============================================================
# 4. ESTADÍSTICAS DESCRIPTIVAS
# ============================================================

Se calcularon medidas descriptivas para las principales variables del estudio:

- Número de observaciones.
- Media.
- Mediana.
- Desviación estándar.

Asimismo, se generó una tabla resumen con las estadísticas descriptivas.

# ============================================================
# 5. VISUALIZACIÓN DE DATOS
# ============================================================

Se elaboraron los siguientes gráficos:

- Histograma del ingreso per cápita.
- Gráfico de dispersión entre ingreso y gasto per cápita.
- Collage de gráficos.
# ============================================================
# PRINCIPALES RESULTADOS
# ============================================================

El análisis exploratorio permitió identificar que:

- La distribución del ingreso per cápita presenta una marcada asimetría.
- Existe una relación positiva entre el ingreso per cápita y el gasto per cápita de los hogares.
- Se observan diferencias importantes en el tamaño de los hogares y en el número de perceptores de ingreso.
# ============================================================
# ESTRUCTURA DEL PROYECTO
# ============================================================

```text
Proyecto_Final/
│
├── data/
├── figures/
├── scripts/
└── README.md
```
# ============================================================
# SOFTWARE UTILIZADO
# ============================================================
- R
- RStudio

## Paquetes
# Análisis Final

## Pregunta de análisis

¿Existe una relación entre el ingreso per cápita y el gasto per cápita de los hogares de la región Junín según la ENAHO 2024?

## Planteamiento del problema

Durante el análisis exploratorio de datos se identificó una relación entre los niveles de ingreso y gasto de los hogares. Por ello, se busca analizar si los hogares con mayores ingresos presentan también mayores niveles de gasto per cápita.

## Metodología

Para responder la pregunta planteada se realizó un análisis adicional utilizando:

- Cálculo de la correlación entre ingreso y gasto per cápita.
- Modelo de regresión lineal simple.
- Gráfico de dispersión con línea de tendencia.

## Resultados

El análisis muestra una relación positiva entre el ingreso per cápita y el gasto per cápita de los hogares de Junín.

Los resultados indican que, a medida que aumenta el ingreso disponible del hogar, también tiende a incrementarse el gasto realizado.

## Conclusiones finales

- Existe una asociación positiva entre ingreso y gasto per cápita.
- Los hogares con mayores ingresos presentan una mayor capacidad de consumo.
- El análisis final confirma el patrón observado durante el análisis exploratorio inicial.
- La información de la ENAHO 2024 permite identificar características económicas de los hogares de la región Junín.
- haven
- tidyverse
- ggplot2
- patchwork
# ============================================================
# FUENTE DE DATOS
# ============================================================

Instituto Nacional de Estadística e Informática (INEI).

Encuesta Nacional de Hogares (ENAHO) 2024.

list.files()
# ============================================================
# PROYECTO FINAL - ANÁLISIS EXPLORATORIO DE DATOS (EDA)
# Base de datos: ENAHO 2024 - INEI
# Autora: Talita Echevarría Camarena
# ============================================================

# Instalar paquetes (solo la primera vez)
install.packages("haven")
install.packages("tidyverse")
# Cargar paquetes
library(haven)
library(tidyverse)
# Importar base de datos ENAHO 2024
base <- read_sav("data/SUMARIA-2024.SAV")
# Ver las primeras observaciones
head(base)
# Ver las dimensiones de la base
dim(base)
# Ver nombres de las variables
names(base)
# Ver estructura de la base
glimpse(base)
# ============================================================
# IDENTIFICACIÓN DEL DEPARTAMENTO
# ============================================================

# Ver los primeros códigos UBIGEO
head(base$UBIGEO, 20)
# Crear código de departamento a partir de UBIGEO
base <- base %>%
  mutate(DEPARTAMENTO = substr(UBIGEO, 1, 2))
# Ver códigos de departamentos
sort(unique(base$DEPARTAMENTO))
# Filtrar observaciones del departamento de Junín
junin <- base %>%
  filter(DEPARTAMENTO == "12")
# Ver dimensiones de la base de Junín
dim(junin)
# Ver los códigos UBIGEO de Junín
head(junin$UBIGEO, 20)
dim(junin)
# ============================================================
# SELECCIÓN DE VARIABLES PARA EL ANÁLISIS
# ============================================================

eda_junin <- junin %>%
  select(
    UBIGEO,
    MIEPERHO,
    PERCEPHO,
    INGHOG1D,
    GASHOG1D,
    POBREZA,
    FACTOR07,
    DEPARTAMENTO
  )
# Revisar estructura de la base seleccionada
glimpse(eda_junin)
# Contar valores faltantes por variable
colSums(is.na(eda_junin))
glimpse(eda_junin)
# ============================================================
# CREACIÓN DE NUEVAS VARIABLES
# ============================================================

eda_junin <- eda_junin %>%
  mutate(
    INGRESO_PCAPITA = INGHOG1D / MIEPERHO,
    GASTO_PCAPITA = GASHOG1D / MIEPERHO
  )
# Revisar las nuevas variables
eda_junin %>%
  select(INGHOG1D, MIEPERHO, INGRESO_PCAPITA,
         GASHOG1D, GASTO_PCAPITA) %>%
  head()
# Revisar valores faltantes después de crear variables
colSums(is.na(eda_junin))
# Revisar valores infinitos
sum(is.infinite(eda_junin$INGRESO_PCAPITA))
sum(is.infinite(eda_junin$GASTO_PCAPITA))
eda_junin %>%
  select(INGHOG1D, MIEPERHO, INGRESO_PCAPITA,
         GASHOG1D, GASTO_PCAPITA) %>%
  head()
colSums(is.na(eda_junin))
sum(is.infinite(eda_junin$INGRESO_PCAPITA))
sum(is.infinite(eda_junin$GASTO_PCAPITA))
# ============================================================
# ESTADÍSTICAS DESCRIPTIVAS
# ============================================================

# Estadísticas descriptivas de las principales variables
summary(
  eda_junin %>%
    select(
      MIEPERHO,
      PERCEPHO,
      INGHOG1D,
      GASHOG1D,
      INGRESO_PCAPITA,
      GASTO_PCAPITA
    )
)
# Tabla de estadísticas descriptivas
estadisticas <- eda_junin %>%
  summarise(
    N = n(),
    Media_miembros = mean(MIEPERHO),
    Mediana_miembros = median(MIEPERHO),
    SD_miembros = sd(MIEPERHO),
    
    Media_perceptores = mean(PERCEPHO),
    Mediana_perceptores = median(PERCEPHO),
    
    Media_ingreso_pc = mean(INGRESO_PCAPITA),
    Mediana_ingreso_pc = median(INGRESO_PCAPITA),
    SD_ingreso_pc = sd(INGRESO_PCAPITA),
    
    Media_gasto_pc = mean(GASTO_PCAPITA),
    Mediana_gasto_pc = median(GASTO_PCAPITA),
    SD_gasto_pc = sd(GASTO_PCAPITA)
  )

estadisticas
# Guardar estadísticas descriptivas
write.csv(
  estadisticas,
  "figures/estadisticas_descriptivas.csv",
  row.names = FALSE
)
summary(
  eda_junin %>%
    select(
      MIEPERHO,
      PERCEPHO,
      INGHOG1D,
      GASHOG1D,
      INGRESO_PCAPITA,
      GASTO_PCAPITA
    )
)
estadisticas
print(estadisticas, width = Inf)
print(estadisticas, width = Inf)
# ============================================================
# GRÁFICO 1: DISTRIBUCIÓN DEL INGRESO PER CÁPITA
# ============================================================

grafico_ingreso <- ggplot(
  eda_junin,
  aes(x = INGRESO_PCAPITA)
) +
  geom_histogram(
    bins = 30,
    na.rm = TRUE
  ) +
  labs(
    title = "Distribución del ingreso per cápita de los hogares de Junín",
    subtitle = "ENAHO 2024",
    x = "Ingreso per cápita (S/)",
    y = "Número de hogares"
  ) +
  theme_minimal()

grafico_ingreso
# Guardar gráfico 1
ggsave(
  "figures/grafico_01_ingreso_percapita.png",
  plot = grafico_ingreso,
  width = 10,
  height = 6,
  dpi = 300
)
# ============================================================
# GRÁFICO 2: RELACIÓN ENTRE INGRESO Y GASTO PER CÁPITA
# ============================================================

grafico_ingreso_gasto <- ggplot(
  eda_junin,
  aes(
    x = INGRESO_PCAPITA,
    y = GASTO_PCAPITA
  )
) +
  geom_point(
    alpha = 0.5,
    na.rm = TRUE
  ) +
  geom_smooth(
    method = "lm",
    se = TRUE,
    na.rm = TRUE
  ) +
  labs(
    title = "Relación entre ingreso y gasto per cápita de los hogares",
    subtitle = "Región Junín, ENAHO 2024",
    x = "Ingreso per cápita (S/)",
    y = "Gasto per cápita (S/)"
  ) +
  theme_minimal()

grafico_ingreso_gasto
# Guardar gráfico 2
ggsave(
  "figures/grafico_02_ingreso_vs_gasto.png",
  plot = grafico_ingreso_gasto,
  width = 10,
  height = 6,
  dpi = 300
)
grafico_ingreso
grafico_ingreso_gasto
# ============================================================
# CREAR COLLAGE DE GRÁFICOS
# ============================================================

collage_graficos <- grafico_ingreso + grafico_ingreso_gasto +
  plot_annotation(
    title = "Análisis Exploratorio de Datos de los Hogares de Junín",
    subtitle = "ENAHO 2024"
  )

collage_graficos
class(grafico_ingreso)
class(grafico_ingreso_gasto)
sessionInfo()
library(patchwork)
collage_graficos <- grafico_ingreso + grafico_ingreso_gasto +
  plot_annotation(
    title = "Análisis Exploratorio de Datos de los Hogares de Junín",
    subtitle = "ENAHO 2024"
  )

collage_graficos
# ============================================================
# CREAR COLLAGE DE GRÁFICOS
# ============================================================

library(patchwork)

collage_graficos <- grafico_ingreso + grafico_ingreso_gasto +
  plot_annotation(
    title = "Análisis Exploratorio de Datos de los Hogares de Junín",
    subtitle = "ENAHO 2024"
  )

collage_graficos
# Guardar collage de gráficos
ggsave(
  filename = "figures/collage_graficos.png",
  plot = collage_graficos,
  width = 14,
  height = 7,
  dpi = 300
)

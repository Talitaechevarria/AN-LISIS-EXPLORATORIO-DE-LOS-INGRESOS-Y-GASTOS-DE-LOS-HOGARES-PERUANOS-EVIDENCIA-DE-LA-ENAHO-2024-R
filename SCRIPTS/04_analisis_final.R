#====================================================
# ANALISIS FINAL
# Proyecto Final
#====================================================

library(haven)
library(tidyverse)
# Cargar base

base <- read_sav("data/SUMARIA-2024.SAV")
# Seleccionar Junín

base <- base %>%
  mutate(DEPARTAMENTO = substr(UBIGEO,1,2))

junin <- base %>%
  filter(DEPARTAMENTO=="12")
# Variables

analisis <- junin %>%
  select(
    MIEPERHO,
    INGHOG1D,
    GASHOG1D,
    POBREZA
  ) %>%
  mutate(
    ingreso_pc = INGHOG1D/MIEPERHO,
    gasto_pc = GASHOG1D/MIEPERHO
  )
#========================================
# Correlación
#========================================

correlacion <- cor(
  analisis$ingreso_pc,
  analisis$gasto_pc,
  use="complete.obs"
)

correlacion
#========================================
# Modelo lineal
#========================================

modelo <- lm(
  gasto_pc ~ ingreso_pc,
  data=analisis
)

summary(modelo)
#========================================
# Gráfico final
#========================================

grafico_final <- ggplot(
  analisis,
  aes(
    ingreso_pc,
    gasto_pc
  )
)+
  geom_point(alpha=.4,color="steelblue")+
  geom_smooth(
    method="lm",
    color="red"
  )+
  labs(
    title="Relación entre ingreso y gasto per cápita",
    subtitle="Región Junín - ENAHO 2024",
    x="Ingreso per cápita",
    y="Gasto per cápita"
  )+
  theme_minimal()

grafico_final

ggsave(
  "figures/grafico_03_analisis_final.png",
  grafico_final,
  width=9,
  height=6,
  dpi=300
)

library(tidyverse)
library(rnaturalearth)
library(sf)

funding <- read_csv("data/africa-funding.csv")

africa <- ne_countries(continent = "Africa", returnclass = "sf")
stopifnot(all(funding$name %in% africa$name))

funded <- africa |>
  inner_join(funding, by = "name") |>
  mutate(
    lon = st_coordinates(st_point_on_surface(geometry))[, "X"],
    lat = st_coordinates(st_point_on_surface(geometry))[, "Y"]
  )

ggplot(africa) +
  geom_sf(fill = "grey90", color = "white", linewidth = 0.2) +
  geom_sf(data = funded, fill = "#00798c", color = "white") +
  geom_segment(
    data = funded, color = "#2e4057",
    aes(lon, lat, xend = lon + dx, yend = lat + dy)
  ) +
  geom_text(
    data = funded, color = "#2e4057", size = 5, lineheight = 0.9,
    family = "Fira Sans Condensed",
    aes(
      lon + dx, lat + dy, hjust = ifelse(dx > 0, -0.05, 1.05),
      label = paste0(name, "\n$", amount, "M")
    )
  ) +
  coord_sf(xlim = c(-38, 66), ylim = c(-36, 38)) +
  theme_void()

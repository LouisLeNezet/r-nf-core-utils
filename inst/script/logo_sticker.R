#### Libraries needed ####
library(dplyr)
library(hexSticker)
library(magick)

package_name <- "R nf-core utils"
path_no_ext <- "inst/figures/icon_nfcore_utils"
path_to_img <- "inst/figures/g31.png"
h_color <- "#24B064"
h_fill <- "#FFFFFF"
p_color <- "#000000"

# Create sticker
for (ext in c(".png", ".svg", ".pdf")) {
  p_size <- ifelse(ext == ".png", 50, 5)
  hexSticker::sticker(
    path_to_img,
    package = package_name, p_size = p_size, p_color = p_color,
    p_x = 1, p_y = 1.5, p_family = "Aller_Rg",
    s_x = 0.9, s_y = 0.85, s_width = 0.54,
    h_fill = h_fill, h_color = h_color, h_size = 2.5,
    filename = paste0(path_no_ext, ext), dpi = 1000,
    white_around_sticker = TRUE
  )
}

# Load the sticker
sticker <- magick::image_read(paste0(path_no_ext, ".png"))

# Remove the white background while keeping the full border
sticker_transp <- sticker |>
  magick::image_fill(
    color = "transparent", refcolor = "white",
    fuzz = 4, point = "+100+100"
  ) |>
  magick::image_fill(
    color = "transparent", refcolor = "white",
    fuzz = 4, point = "+1600+1800"
  ) |>
  magick::image_fill(
    color = "transparent", refcolor = "white",
    fuzz = 4, point = "+1600+100"
  ) |>
  magick::image_fill(
    color = "transparent", refcolor = "white",
    fuzz = 4, point = "+100+1800"
  )

# Save the final transparent sticker
magick::image_write(sticker_transp, path = paste0(path_no_ext, ".png"))

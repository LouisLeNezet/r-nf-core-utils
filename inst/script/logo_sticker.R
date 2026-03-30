#### Libraries needed ####
library(dplyr)
library(hexSticker)
library(magick)

package_name <- "nf-core R utils"
path_no_ext <- "inst/figures/icon_nf-core_utils"
h_color <- "#3792ad"
h_fill <- "#FFFFFF"
p_color <- "#000000"

# Create sticker
hexSticker::sticker(
    output_dir,
    package = package_name, p_size = 50, p_color = p_color,
    p_x = 1, p_y = 1.5, p_family = "Aller_Rg",
    s_x = 1, s_y = 0.8, s_width = 0.7, s_height = 0.4,
    h_fill = h_fill, h_color = h_color, h_size = 3,
    filename = paste0(path_no_ext, ".png"), dpi = 1000,
    white_around_sticker = TRUE
)

hexSticker::sticker(
    output_dir,
    package = package_name, p_size = 5, p_color = p_color,
    p_x = 1, p_y = 1.5, p_family = "Aller_Rg",
    s_x = 1, s_y = 0.8, s_width = 0.7, s_height = 0.4,
    h_fill = h_fill, h_color = h_color, h_size = 3,
    filename = paste0(path_no_ext, ".svg"), dpi = 1000,
    white_around_sticker = TRUE
)

hexSticker::sticker(
    output_dir,
    package = package_name, p_size = 5, p_color = p_color,
    p_x = 1, p_y = 1.5, p_family = "Aller_Rg",
    s_x = 1, s_y = 0.8, s_width = 0.7, s_height = 0.4,
    h_fill = h_fill, h_color = h_color, h_size = 3,
    filename = paste0(path_no_ext, ".pdf"), dpi = 1000,
    white_around_sticker = TRUE
)

# Load the sticker
sticker <- image_read(paste0(path_no_ext, ".png"))

# Remove the white background while keeping the full border
sticker_transp <- sticker %>%
    image_fill(
        color = "transparent", refcolor = "white",
        fuzz = 4, point = "+100+100"
    ) %>%
    image_fill(
        color = "transparent", refcolor = "white",
        fuzz = 4, point = "+1600+1800"
    ) %>%
    image_fill(
        color = "transparent", refcolor = "white",
        fuzz = 4, point = "+1600+100"
    ) %>%
    image_fill(
        color = "transparent", refcolor = "white",
        fuzz = 4, point = "+100+1800"
    )

# Save the final transparent sticker
image_write(sticker_transp, path = paste0(path_no_ext, ".png"))

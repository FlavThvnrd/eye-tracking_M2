#' Functions useful to generate heatmaps from the stimuli dataframe 

#' @param data dataframe to generate heatmaps
#' @param path_img path of the stimuli picture to have in a vector
#' @param width_size number of pixels on width heatmap
#' @param height_size number of pixels on height heatmap
#' @param add_img TRUE/FALSE argument to decide whether or not to add the background stimuli on the heatmap
#' @param transparency_img coefficient to modulate the transparency of the heatmap 

heatmap_generator <- function(data,
                             path_img = "experience/cockpit_utile/112.png",
                             file_name,
                             width_size = 160, 
                             height_size = 90, 
                             add_img = TRUE, 
                             only_img = FALSE,
                             transparency_img = 0.8){
  
  #get the background image
  img <- readPNG(path_img)
  img <- rasterGrob(img, interpolate=TRUE)
  
  if (add_img == TRUE & only_img == FALSE){
    
    heatmap <- ggplot(data, aes(x = new_x, y = new_y) ) +
      
      theme_void() +
      annotation_custom(img, xmin=0, xmax=16, ymin=0, ymax=9) +
      
      stat_density_2d(aes(fill = ..density..), 
                      geom = "raster", 
                      contour = FALSE, 
                      alpha = transparency_img) +
      
      scale_fill_distiller(palette= "Spectral", direction=-1) +
      scale_x_continuous(limits = c(0, 16)) +
      scale_y_continuous(limits = c(0, 9)) +
      
      coord_fixed(ratio = 1, xlim = c(0,16), ylim = c(0,9)) +
      
      theme(
        legend.position='none', 
        axis.title.x = element_blank(),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank(),
        axis.title.y = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank()
      )
  }
  
  else if (only_img == TRUE & add_img == TRUE) {
    
    heatmap <- ggplot(data, aes(x = x, y = y) ) +
      
      theme_void() +
      annotation_custom(img, xmin=0, xmax=16, ymin=0, ymax=9) +
      
      coord_fixed(ratio = 1, xlim = c(0,16), ylim = c(0,9)) +
      
      theme(
        legend.position='none', 
        axis.title.x = element_blank(),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank(),
        axis.title.y = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank()
      )
  }
  
  else {
    
    heatmap <- ggplot(data, aes(x = new_x, y = new_y) ) +
      
      theme_void() +
      
      stat_density_2d(aes(fill = ..density..), 
                      geom = "raster", 
                      contour = FALSE, 
                      alpha = transparency_img) +
      
      scale_fill_distiller(palette= "Spectral", direction=-1) +
      scale_x_continuous(limits = c(0, 16)) +
      scale_y_continuous(limits = c(0, 9)) +
      
      coord_fixed(ratio = 1, xlim = c(0,16), ylim = c(0,9))+
      
      theme(
        legend.position='none', 
        axis.title.x = element_blank(),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank(),
        axis.title.y = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank()
      )
  } 
 
  # save heatmap in the folder
  png(file = file_name, 
      width = width_size, 
      height = height_size)
  plot(heatmap)
  dev.off()
}



#' function to do a bigger heatmaps with background picture
#'
#' @param data the data to print colnames(data)  = c("new_x", "new_y", "t")  
#' @param path_img the path of the background picture
#' @param file_name the nme of the outputs picture
#' @param width_size width size
#' @param height_size heigth size
#' @param transparency_img thansparancy of the heatmaps
#'
#' @return
#' @export
#'
#' @examples
heatmap_generator_bigger <- function(data,
                             path_img = "experience/cockpit_utile/112.png",
                             file_name,
                             width_size = 160, 
                             height_size = 90, 
                             transparency_img = 0.8, 
                             title = NULL){
  
  # get the background image 
  img <- readPNG(path_img)
  img <- rasterGrob(img, interpolate=TRUE)
    
    heatmap <- ggplot(data, aes(x = new_x, y = new_y) ) +
      
      #theme_void() +
      annotation_custom(img, xmin=0, xmax=16, ymin=0, ymax=9) +
      
      stat_density_2d(aes(fill = ..density..), 
                      geom = "raster", 
                      contour = FALSE, 
                      alpha = transparency_img) +
      
      scale_fill_distiller(palette= "Spectral", direction=-1) +
      scale_x_continuous(limits = c(-8,24)) +
      scale_y_continuous(limits = c(-4.5,13.5)) +
      
      coord_fixed(ratio = 1, xlim = c(-8,24), ylim = c(-4.5,13.5)) +
      ggtitle(title) 

  # save heatmap in the folder
  
  png(file = file_name, 
      width = width_size, 
      height = height_size)
  plot(heatmap)
  dev.off()
}


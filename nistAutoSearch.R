
#' @created: 19-Feb-2025
#' @ver: 0.14
#' @author: Alex Ilchenko
#' @note: fixed latin characters issue & error handle

package= function() {
  packages <- c(
    "mssearchr",
    "stringi"
  )
  install.packages(setdiff(packages, rownames(installed.packages())), repos = "http://cran.us.r-project.org")
  #-----------
  lapply(packages, require, character.only = TRUE)
}
package()

suffix_name = "rda_nist_verified"

# Set locale to support UTF-8
Sys.setlocale("LC_ALL", "en_US.UTF-8")

#==========INPUT NIST (MSP) FILE=================
msp_file = file.choose()
dir_path = dirname(msp_file)
print(paste("Input file:", msp_file, sep=" "))
filename = basename(sub("\\..*$", "", msp_file))
output_file= paste0(suffix_name,".csv")

start_time= Sys.time()
#=======Read and Fix NIST file=========

#file = suppressWarnings(readLines(msp_file)) #читаю файл
file <- readLines(msp_file, encoding = "UTF-8")
# Function to ensure one space after each colon. INTEGRITY CHECK
fix_colon_spacing <- function(text) {
  # Use gsub to find colons without space or with multiple spaces and replace with colon + single space
  fixed_text <- gsub(":(\\S)", ": \\1", text)  # Add space if no space after colon
  fixed_text <- gsub(":(\\s+)", ": ", fixed_text)  # Replace multiple spaces with one space
  return(fixed_text)
}
writeLines(fix_colon_spacing(file), msp_file)

#======Import MSP data=======
msp_objs <- ReadMsp(msp_file)
len = length(msp_objs)
#len=10 #uncomment if you need a test run limited by 10 hits
print(paste("Found peaks:", len,  sep=" "))



df_output= data.frame()
# Searching using the MS Search (NIST) API
print("Searching...")
for (i in 1:len) {
  tryCatch({  # Error handling
    hitlists <- LibrarySearchUsingNistApi(msp_objs[i])
    hitlists_raw <- lapply(hitlists, function(x) charToRaw(as.character(x)))
    utf8_hitlists <- lapply(hitlists_raw, function(x) stri_encode(x, from = "latin1", to = "UTF-8"))
    df = do.call(rbind, hitlists)
    if (nrow(df) == 0) { # Add an empty row if 0 hits
      df <- rbind(df, setNames(as.list(rep(NA, 10)), colnames(df)))
    }
    rda_name = data.frame(msp_objs[[i]]$name)
    colnames(rda_name)[1] = "input name"
    df= cbind(rda_name, df)
    df_output = rbind(df_output, df)
    print(paste("#", i, " | ", msp_objs[[i]]$name, sep=""))
  }, error = function(e) {
    print(paste("#", i, " | ", msp_objs[[i]]$name, " | Error processing spectrum ", "-", i, "-", ":", e$message, sep=""))
  	tryCatch({
  		empty_row <- data.frame(matrix("NA", nrow = 1, ncol = ncol(df_output)))
  		colnames(empty_row) <- colnames(df_output)
  		empty_row[1, "input name"] <- msp_objs[[i]]$name
  		df_output <- rbind(df_output, empty_row)
      print(empty_row)
  		#df_output <- rbind(df_output, data.frame("rda name" = msp_objs[[i]]$name, matrix(NA, nrow=1, ncol=ncol(df)-1)))
  	}, error = function(e) {
  		print(paste(i, " | Error can't save the hit ", "-", i, "-", " : ", e$message, sep=""))
  	})
    
  })
}

write.csv(df_output, paste(dir_path,"/", output_file, sep=""), row.names = FALSE) #записываю csv файл
print("Done!")
print(paste("Saved to:", paste(dir_path,"/", output_file, sep=""), sep=" "))
end_time =Sys.time()
print(paste("-------------"))
print(paste("Elapsed Time:", round(as.numeric(gsub("Time difference of ", "", difftime(end_time, start_time, units="secs")/60)), 2), "min"))





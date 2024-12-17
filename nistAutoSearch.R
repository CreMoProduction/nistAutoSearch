
#' created: 17-Dec-202
#' ver: 0.1
#' @author: Alex Ilchenko

package= function() {
  packages <- c(
    "mssearchr"
  )
  install.packages(setdiff(packages, rownames(installed.packages())), repos = "http://cran.us.r-project.org")
  #-----------
  lapply(packages, require, character.only = TRUE)
}
package()

suffix_name = "rda_nist_verified"

#==========INPUT NIST (MSP) FILE=================
msp_file = file.choose()
dir_path = dirname(msp_file)
print(paste("Input file:", msp_file, sep=" "))
filename = basename(sub("\\..*$", "", msp_file))
output_file= paste0(suffix_name,".csv")

start_time= Sys.time()
#=======Fix NIST file=========
file = suppressWarnings(readLines(msp_file))
output_string <- gsub(":", ": ", file)
writeLines(output_string, msp_file)

#======Import MSP data=======
msp_objs <- ReadMsp(msp_file)
len = length(msp_objs)
#len=10 #uncomment if you need a test run limited by 10 hits
print(paste("Found peaks:", len,  sep=" "))



df_output= data.frame()
# Searching using the MS Search (NIST) API
print("Searching...")
for (i in 1:len) {
  hitlists <- LibrarySearchUsingNistApi(msp_objs[i])
  df = do.call(rbind, hitlists)
  rda_name = data.frame(msp_objs[[i]]$name)
  colnames(rda_name)[1] = "rda name"
  df= cbind(rda_name, df)
  df_output = rbind(df_output, df)
  print(i)
}

write.csv(df_output, paste(dir_path,"/", output_file, sep=""), row.names = FALSE) #записываю csv файл
print("Done!")
print(paste("Saved to:", paste(dir_path,"/", output_file, sep=""), sep=" "))
end_time =Sys.time()
print(paste("-------------"))
print(paste("Elapsed Time:", round(as.numeric(gsub("Time difference of ", "", difftime(end_time, start_time, units="secs")/60)), 2), "min"))





# Load the package required to read JSON files.
install.packages("RCurl", dependencies = TRUE)
library(jsonlite)
library(RCurl)

# Load sensitive information from environment file .env at base of project, this wont be committed to github
readRenviron(".env")
user <- Sys.getenv("USER")
pass <- Sys.getenv("PASS")
base_url <- Sys.getenv("BASE_URL") #base URL for the api endpoint

uri <- paste(base_url,"/v1/ona-data/download",sep="")
auth <- base64Encode(paste(user,sep=":",pass))

hdr=c(Accept="text/*",Accept="application/*",
              Authorization=paste("Basic",auth),
             'Content-Type' = "application/json")

#' Download a csv file specified in the body parameter
#'
#'
#'
#' This function takes three parameters
#' The download endpoint, name of the file to be saved and the details for the file being requested
#' @param url endpoint for the download
#' @param file name of the file to be saved
#' @param bod contains data to be sent to the download endpoint
#' @export
downloadCsvFile <- function(url,file,body){
  fileWriter = CFILE(file, mode="wb")
  curlResults = curlPerform(url = url, writedata = fileWriter@ref, noprogress=FALSE,
                  .opts = list(httpheader=hdr,postfields=body,verbose=TRUE))
  close(fileWriter)
  return(curlResults)
}

fileName=("SG Validation choice experiment _ Data collection.csv")
subFolder=("EiA_SAA") ##if CSV exists within a sub folder put the sub-folder here here
df <- data.frame(fileName,subFolder)

filePayload <- jsonlite::toJSON(unbox(df))

print(paste("Downloading from",uri))
ret = downloadCsvFile(uri, fileName,filePayload)

print("Download completed, do something with the data now")

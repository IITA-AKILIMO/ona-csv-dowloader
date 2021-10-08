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

bdown=function(url,file,body){
  f = CFILE(file, mode="wb")
  a = curlPerform(url = url, writedata = f@ref, noprogress=FALSE,
                  .opts = list(httpheader=hdr,postfields=body,verbose=TRUE))
  close(f)
  return(a)
}

fileName=("Assign_PA_AC.csv")
subFolder=("") ##if CSV exists withing a subfolder put it here
df <- data.frame(fileName,subFolder)

filePayload <- jsonlite::toJSON(unbox(df))

print(paste("Downloading from",uri))
ret = bdown(uri, fileName,filePayload)

print(ret)

print("Download completed, do something with the data now")

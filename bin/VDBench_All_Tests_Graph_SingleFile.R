#!/usr/bin/env Rscript
#tested against a CSV file created from VDBench with for example;
# vdbench parseflat -i flatfile.html -o output.csv -c run interval rate resp MB/sec Read_resp Write_resp MB_read MB_write cpu_wait 


PlotATestVariable <- function(frame, y){
  testFrame = frame
  TestFrameColnames <- colnames(frame)
  title = paste("Test:", 
                frame[1,1], 
                "Metric:", 
                TestFrameColnames[y], 
                sep=" ")
  footer = paste(summary(testFrame[y]))
  
  #sometimes the column is completely null, so skip
  if( sum(testFrame[y]) > 0) {
    
    matplot(testFrame[y],  
         ylab=TestFrameColnames[y], 
         xlab="seconds",
         col=(c("red","darkgreen")),
         type="b",
         pch = 20,
         ylim = c(0, max(testFrame[y]) )
    )
    #stats breakdown in above graph
    legend(x = "right", footer, bty = "n", cex=0.4)
    
    boxplot(testFrame[y], 
            #main=TestFrameColnames[y], 
            ylab=TestFrameColnames[y], 
            xlab="seconds",
            col=(c("gold","darkgreen"))

    )
    #title
    mtext(title, outer=TRUE,  cex=1, line=-1.5)
    }
}


PlotATest <- function(frame1, TestNo)
{
  
  #get the first data frame (subset - return a single item from the list)
  #frame1 <- vb[[TestNo]]
  #now we can get the column names with;
  frame1colnames <- colnames(frame1)
  #get the first cell in the first row for the test name
  #  and make it the filename
  #filename = paste(frame1[1,1], ".pdf", sep="")
  #print to STDOUT what we're doing
  #cat("about to graph: ", filename, "\n")

  #setup the PDF device
  #pdf("plot.pdf", width=8,height=11)
  #pdf(filename)

  #setup two images down the page,
  # oma is vector of the form c(bottom, left, top, right) giving 
  # the size of the outer margins in lines of text.
  #par(oma=c(0.5,3,2,0.5), mfrow=c(2,1))

  #we don't want to graph the first two columns, as they are;
  #1-testname
  #2-second count
  for (i in 3:length(frame1colnames)) 
  {
    PlotATestVariable(frame1, i)
  }

  #close the pdf file
  #dev.off()
}

CreatePDF <- function(CSVfilename, vb)
{
  #create the filename from the input file name for the PDF 
  #in a ridiculously
  # convoluted way, but I coud find no better. Oh R, honestly!
  OutputFilename = paste(lapply(strsplit(CSVfilename, "/"), tail, 1),
                         ".pdf", sep="")
  #setup the PDF device
  #pdf("plot.pdf", width=8,height=11)
  pdf(OutputFilename)
  
  #setup two images down the page,
  # oma is vector of the form c(bottom, left, top, right) giving 
  # the size of the outer margins in lines of text.
  par(oma=c(0.5,6,2,0.5), mfrow=c(2,1))
  
  for (i in 1:length(vb)) 
  {
    PlotATest(vb[[i]])
  }
  
  #close the pdf file
  dev.off()
}

#pull in caommand line arguments
args<-commandArgs(TRUE)

if (length(args) > 1) 
  {
  


  #read in the csv file 
  #CSVfilename <- "/Users/jc18/Documents/single.150531.162953.csv"
  CSVfilename <- args[1]
  vdbench <- read.csv(CSVfilename,
                    header = TRUE)

  #split into list of data frames, one for each test run within the CSV
  vb <- split(vdbench, vdbench$run)

  CreatePDF(CSVfilename,vb)
  
} else {
  print("Usage: $0 <CSV_to_convert>")
  print("Example:")
  print("vdbench parseflat -i flatfile.html -o output.csv -c run interval rate resp MB/sec Read_resp Write_resp MB_read MB_write cpu_wait ")
}
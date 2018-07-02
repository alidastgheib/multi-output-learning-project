require(farff)
require(stringr)
rm(list = ls())

setwd("C:/Users/Ali_D/Desktop/LMMO/Dataset/MLC/genbase")
genbase_DS <- readARFF("genbase.arff")
write.csv(genbase_DS, file = "genbase_DS.csv",
          row.names = F)

genbase_DS <- readARFF("genbase-test.arff")
write.csv(genbase_DS, file = "genbase_test_DS.csv",
          row.names = F)

genbase_DS <- readARFF("genbase-train.arff")
write.csv(genbase_DS, file = "genbase_train_DS.csv", 
          row.names = F)


##########################################################
genbase_DS <- readARFF("genbase.arff")
write.csv(colnames(genbase_DS), "col_names_genbase_DS.csv",
          row.names = F, col.names = F)

write.csv(head(genbase_DS), "head_genbase_DS.csv",
          row.names = F, col.names = T)


##########################################################
genbase_DS <- readARFF("genbase.arff")
col_names = colnames(genbase_DS)
col_PDOC = which(str_detect(col_names, "PDOC"))
col_PS = which(str_detect(col_names, "PS"))
col_PDOC = col_names[col_PDOC]
col_PS = col_names[col_PS]

fileConn <- file("outputFeatures.txt")
writeLines(c("Output Features (PDOCxxxxx)", col_PDOC), fileConn, sep = "\n")
close(fileConn)

fileConn <- file("inputFeatures.txt")
writeLines(c("Input Features (PSxxxxx)", col_PS), fileConn, sep = "\n")
close(fileConn)

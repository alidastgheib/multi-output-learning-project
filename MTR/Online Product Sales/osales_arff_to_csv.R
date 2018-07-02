require(farff)
require(imputeTS)
require(stringr)

rm(list = ls())

setwd("C:/Users/Ali_D/Desktop/LMMO/Dataset/MTR/Online Product Sales")
osales_DS <- readARFF("osales.arff")

col_names = colnames(osales_DS)
write.csv(as.data.frame(col_names), "osales_DS_feature_names.csv",
          row.names = F)


#######################################
col_names_input = col_names[1 : 401]

for (feat_name in col_names_input) {
  feat_idx = which(feat_name == col_names_input)
  feat_name = paste0("Input_", feat_name)
  col_names_input[feat_idx] = feat_name
}
col_names[1 : 401] = col_names_input
colnames(osales_DS)<- col_names


#######################################
col_names_cat = str_detect(col_names, "Cat")
col_names_cat_id = which(col_names_cat)
na_df = is.na.data.frame(osales_DS[, col_names_cat_id])
na_df = as.numeric(na_df); na_df = as.vector(na_df)
sum(na_df)
#
# There is no "NA" values in categorical features.
# "NA" values are only in quantitative features.
#


#######################################
# Missing Value Imputation By Mean Value
# Missing value replacement by mean values. Different means like median, mean, mode possible.
for (col_name in colnames(osales_DS)){
  osales_DS[, col_name] = na.mean(osales_DS[, col_name], option = "mean")
}


#######################################
write.csv(osales_DS, file = "osales_DS.csv",
          row.names = F)
#######################################
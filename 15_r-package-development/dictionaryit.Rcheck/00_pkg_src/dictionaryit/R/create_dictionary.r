#' Combining a Dataframe with Dictionary Counts
#'
#' @param data the data input 
#' @param string_vector the dictionary object 
#'
#' @return the combined dataframe with the dictionary counts as a new column to it
#'
#' @export 

dfm_dictionary <- function(data, string_vector){

temp_dic <- dictionary(list(string_vector))

dfm_merged_with_temp_dic <- dfm(corpus(data), dictionary = temp_dic)

return(dfm_merged_with_temp_dic)
}

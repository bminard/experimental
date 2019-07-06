#!/usr/bin/env Rscript


defect_history = commandArgs(trailingOnly = TRUE)
df <- read.table(defect_history, header = TRUE, sep = ",")


df$Created<-as.POSIXct(df$Created, format="%m/%d/%Y %I:%M:%S %p")

library(dplyr)
ncount<-function(x){
  target<-x[2]
  starttime<-as.POSIXct(x[1], format="%Y-%m-%d %H:%M:%S")
  endtime<-starttime+ 24*60*60  #1 day later
  nrow(filter(df, Number==target & Date_Time>=starttime & Date_Time<=endtime))
}

df$freq<-apply(df, 1, function(x){ncount(x)} )

#!/usr/bin/Rscript

#
# Calculate basic metrics on the word drill data.
#

metrics <- function(data, rowname) {
    rows <- c("total", "max", "min", "median", "mean", "standard deviation")
    measures <- matrix(c(sum(data), max(data), min(data), median(data), mean(data), sd(data)), ncol = 1, byrow = TRUE)
    names(measures) <- rows
    rownames(measures) <- paste(rows, rowname)
    return (as.table(measures))
}

#
# Generate a report vector for the metrics computed on the word drill data.
#

report <- function(data, name) {
    questions <- length(data$prob)
    never_attempted <- sum(is.nan(data$prob))
    stopifnot(questions >= never_attempted)

    correct <- sum(data$prob >= threshold)

    total <- metrics(data$total.attempts, "all attempts")
    stopifnot(total["total"] >= correct)

    successful <- metrics(data$successful.attempts, "successful attempts")
    stopifnot(successful["total"] >= correct)
    stopifnot(total["total"] >= successful["total"])

    proportion_correct <- correct / questions
    confidence_of_correct_answer <- successful["total"] / total["total"]

    measures <- matrix(c(questions, never_attempted, correct, proportion_correct, confidence_of_correct_answer), ncol = 1, byrow = TRUE)
    colnames(measures) <- name
    rownames(measures) <- c("total questions", "questions never attempted", "correct answers", "proportion of correct answers", "confidence of correct answer")
    report <- rbind(measures, total, successful)
    return (report)
}

setwd('~/Desktop/word_drill')

# important constants
quartile <- 0.25
sample_size <- 6 # tied to the python script sample size!
threshold <- 0.8

#
# Generate one report for each category of data: all, numeric and alphabetic.
#
data <- read.csv(file="words.txt")
prob <- (data$successful.attempts / data$total.attempts)
isnumeric <- grepl("[0-9][0-9]*",data$word)
all_data <- data.frame(data, prob, isnumeric)
numeric_data <- all_data[all_data$isnumeric == TRUE, ]
alphabetic_data <- all_data[all_data$isnumeric == FALSE, ]

#
# Convert the data for each category into information for the results.
#
all_info <- report(all_data, "all questions")
numeric_info <- report(numeric_data, "numeric questions")
alphabetic_info <- report(alphabetic_data, "alphabetic questions")
stopifnot(all_info[6] %% sample_size == 0)
stopifnot(all_info[6] == numeric_info[6] + alphabetic_info[6])

words <- function(data) {
    lower_quartile <- quantile(data$prob, quartile)
    entries <- data[data$prob <= lower_quartile & data$prob < 1.0, ]
    frame <- data.frame(entries$word, entries$prob)
    return(frame[order(entries$prob), ])
}

summary <- data.frame(all_info, numeric_info, alphabetic_info)
write.table(summary,file = "report.csv", sep = ", ", col.names = NA)

all_results <- words(all_data)
numeric_results <- words(numeric_data)
alphabetic_results <- words(alphabetic_data)
suppressWarnings(write.table(all_results, file = "report.csv", append = TRUE, sep = ", ", col.names = NA))
suppressWarnings(write.table(numeric_results, file = "report.csv", append = TRUE, sep = ", ", col.names = NA))
suppressWarnings(write.table(alphabetic_results, file = "report.csv", append = TRUE, sep = ", ", col.names = NA))


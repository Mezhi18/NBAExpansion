# NBA Expansion

## Overview

In this paper we will be investigating whether the NBA should be looking to expanding the league by adding additional NBA Teams.

Is it time for an NBA Expansion?

## Abstract

The NBA has not had an expansion in two decades. Using Data from the NBA and Basketball Reference we will investigate whether the NBA Should follow its peer the NHL and consider expanding, we will use multi-linear regression and other methods of statistical analysis to determine if the NBA should expand. Results show that the NBA has had their point per game increase a drastic amount in two decades and will continue to do so without intervention. We can conclude that the NBA should strongly consider expanding and adding a new team the the beautiful game of Basketball.

## File Structure

The repo is structured as:

-   `data/raw_data` contains the raw data as obtained from Basketball Reference
-   `data/analysis_data` contains the cleaned dataset that was constructed.
-   `model` contains fitted models. 
-   `other` contains relevant literature, details about LLM chat interactions, and sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to simulate, download and clean data.


## Statement on LLM usage

Aspects of the code were written with the help of Chat GPT and GPT-4 the link to the chat will be here:
https://chat.openai.com/g/g-TgjKDuQwZ-r-wizard/c/3afbc5ed-df77-4253-b6c5-8f85ec3e3990

## Data Collection

The process of data collection from Basketball Reference was a rather odd and tedious process as for every table needed to copy and pasted into excel before being converted to a .csv file that could read by R. The instructions can be found in the following Link:
https://www.sports-reference.com/blog/2016/11/exporting-data/



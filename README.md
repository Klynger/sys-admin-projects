# Sys Admin Projects

## This repo has all the programs develop developed in the SysAdmin subject.

### 1. Spool Project

#### Description
A print manager based on a monthly quota that is the same for all users, so that if a user moves from quota to impression, their balance becomes negative and is discounted from their quota for the next month.

#### Installation

Clone the repository and run:

``` bash
bash install.sh monthQuota

```

Next, a directory named **spool-project** will be created in **/home/yourUsername** containing the necessary files

#### Usage

First we need to add the name of the users who can print to the **users.txt** file.

To print, if the number of pages is not passed as a parameter, we consider the entire document.

``` bash
bash print.sh document pages

```
To generate a report with the following general and per-user metrics, the number of pages printed and the total number of printed files.

``` bash
bash report.sh year month

```
All print activities are logged in the **.logs** directory.

The **.quota** directory contains the number of impressions available for each user in that month.

#### Credits

Rafael Klynger

Ronaldo Medeiros


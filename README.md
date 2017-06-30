# ICPSR: Network Analysis I

## James D. Wilson

**Email**: jdwilson4@usfca.edu

**Class Time**: M-F, 1:00 - 3:00 PM in 1650 CHEM building

**Office Hours**: T, TH 11:30 AM - 12:30 PM in 1106 D Perry building


**Syllabus**: [Link](https://github.com/jdwilson4/Network-Analysis-I/blob/master/Syllabus_Network_Analtyics.pdf)

## Course Learning Outcomes

By the end of this course, you will be able to

- Proficiently wrangle, manipulate, and explore network data using the R programming language
- Utilize contemporary network R libraries including *statnet* and *igraph*
- Visualize network data
- Partition networks using contemporary community detection methods
- Formulate data-driven hypotheses about relational systems using network analysis tools

## Course Overview


The focus of this course will be to provide you with the basic techniques available for making informed, data-driven decisions with network data structures using the R programming language. In particular, we will discuss the following topics

- History of Networks
- Network Applications
- Types of Network data: static, temporal, multilayer, directed, undirected, bipartite
- Structural Importance and Centrality
- Topological Summaries of Networks
- Shortest Paths
- Automatic Feature Learning of Graphs
- Mesoscopic Properties of Graphs
- Community Detection
- Epidemics on Networks
- Intro to Statistical Network Modeling


### Schedule

**Completed Assignments:** [Submit](https://www.dropbox.com/request/mShmGgweXQGIhWxa1Xma)

**Basics of R and Data Science** 

| Topic | Reading | Practice |
|:--- | :---  | :---  |  
|[Intro and A Brief History of Data Science](https://github.com/jdwilson4/Network-Analysis-I/blob/master/Lecture%20Notes/Lecture%201%20Introduction.pdf)| [Ch. 1 of *Doing Data Science*](https://www.safaribooksonline.com/library/view/doing-data-science/9781449363871/ch01.html) |[Assignment 1](https://github.com/jdwilson4/Network-Analysis-I/blob/master/Assignments/Assignment1.pdf)|
|[Basics of R and RStudio](https://github.com/jdwilson4/Network-Analysis-I/blob/master/Lecture%20Notes/Lecture%202%20R%20and%20RStudio.pdf)|  [Ch. 2 and 4 of *R for Data Science*](http://r4ds.had.co.nz/index.html)|[Assignment 2](https://github.com/jdwilson4/Network-Analysis-I/blob/master/Assignments/Assignment2.pdf)|
|[Data Structures in R](https://github.com/jdwilson4/Network-Analysis-I/blob/master/Lecture%20Notes/Lecture%203%20Data%20Structures.pdf)| [Ch. 20 of *R for Data Science*](http://r4ds.had.co.nz/vectors.html) | [Assignment 3](https://github.com/jdwilson4/Network-Analysis-I/blob/master/Assignments/Assignment3.pdf)|


**Foundations of Network Analysis: A History, Applications, and Types**

| Topic | Reading | Practice |
|:--- | :---  | :---  | 
| [History of Network Analysis](https://github.com/jdwilson4/Network-Analysis-I/blob/master/Lecture%20Notes/Lecture%204%20History%20of%20Network%20Analysis.pdf) | [Ch 2.1 - 2.2 of Network Science](http://barabasi.com/networksciencebook/) | - |
| Network Types |[Ch 2.4 - 2.7 of Network Science](http://barabasi.com/networksciencebook/) | Assignment 4 |
| Where's the Network? | - | Assignment 5 |



**Network Statistics: Local and Global Summaries**

| Topic | Reading | Practice |
|:--- | :---  | :---  | 
| Paths, Shortest Paths, and Connected Components | - | - |
| Degree Distribution and Empirical Studies | - | - |
| Graph Counts | - | - |
| Structural Importance: Vertex Centrality | - | - |

**Mesoscopic Properties of Networks**

| Topic | Reading | Practice |
|:--- | :---  | :---  | 

**Dynamics on Networks**

| Topic | Reading | Practice |
|:--- | :---  | :---  | 

**Multilayer and Temporal Networks**

| Topic | Reading | Practice |
|:--- | :---  | :---  | 

### Additional Resources
- [Base R Cheat Sheet](https://www.rstudio.com/wp-content/uploads/2016/10/r-cheat-sheet-3.pdf)
- [Try R by CodeSchool](http://tryr.codeschool.com/) Quick, interactive R coding lessons
- [Swirl](http://swirlstats.com/students.html) (skip step 1 and 2 if you have already installed R and R Studio) Interactive coding lessions in R Studio

### Case Studies
| Case Study | Data |
|:---| :---  | 
|[I: The Basics - Input, Network Representations, and Visualization](https://raw.githubusercontent.com/jdwilson4/Network-Analysis-I/master/Case%20Studies/KarateClub_Centrality.Rmd) | [Zachary's Karate Club](https://raw.githubusercontent.com/jdwilson4/Network-Analysis-I/master/Data/karate.txt) | 
|[II: Network Motifs I - paths, shortest paths and connected components]() | []() |
|[III: Network Motifs II - graph counts]() | []() |
|[IV: Structural Importance]()| []()| 
|[V: Community Detection]() | []() |
|[VI: Epidemics on Networks - SIR, SIS, and Cascades]() | []() |
|[VII: Temporal Networks - Structures over Time]() | []() |



### Network Data
- [Zachary's Karate Club](https://github.com/jdwilson4/Network-Analysis-I/blob/master/Data/karate.txt): A social network of friendships between 34 members of a karate club at a US university in the 1970s.
- [Political Blog](https://github.com/jdwilson4/Network-Analysis-I/blob/master/Data/polblogs.txt): A directed network of hyperlinks between weblogs on US politics, recorded in 2005 by Adamic and Glance.
- [Les Miserables](https://github.com/jdwilson4/Network-Analysis-I/blob/master/Data/lesmis.txt): A coappearance network of characters in the novel Les Miserables. 
- [Power Grid](https://github.com/jdwilson4/Network-Analysis-I/blob/master/Data/power.txt): An undirected, unweighted network representing the topology of the Western States Power Grid of the United States.
- [Facebook Social Circles](https://github.com/jdwilson4/Network-Analysis-I/blob/master/Data/facebook_combined.txt): A network of anonymized social circles from Facebook. 
- [Enron Email Network](https://github.com/jdwilson4/Network-Analysis-I/blob/master/Data/email-Enron.txt): Enron email communication network where nodes are email addresses and edges are emails sent from *i* to *j*. 
- [Personal Facebook Network]() 
- [Political Co-Voting Network]()


### Important Dates

- Tuesday, June 27th - First day of class
- Tuesday, July 4th - Holiday, **no class**
- Friday, July 21st - Last day of class

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
- Community Detection
- Epidemics on Networks
- Intro to Statistical Network Modeling (if time permits)


### Schedule

**Completed Assignments:** [Submit](https://www.dropbox.com/request/mShmGgweXQGIhWxa1Xma)

**Basics of R and Data Science** 

| Topic | Reading | Practice | In-Class Code |
|:--- | :---  | :---  |  :--- |
|[Intro and A Brief History of Data Science](https://github.com/jdwilson4/Network-Analysis-I/blob/master/Lecture%20Notes/Introduction.pdf)| [Ch. 1 of *Doing Data Science*](https://www.safaribooksonline.com/library/view/doing-data-science/9781449363871/ch01.html) |[Assignment 1](https://github.com/jdwilson4/Network-Analysis-I/blob/master/Assignments/Assignment1.pdf)| - |
|[Basics of R and RStudio](https://github.com/jdwilson4/Network-Analysis-I/blob/master/Lecture%20Notes/R%20and%20RStudio.pdf)|  [Ch. 2 and 4 of *R for Data Science*](http://r4ds.had.co.nz/index.html)|[Assignment 2](https://github.com/jdwilson4/Network-Analysis-I/blob/master/Assignments/Assignment2.pdf)| [Coding Basics](https://github.com/jdwilson4/Network-Analysis-I/blob/master/Code/Basics_in_R.R)|
|[Data Structures in R](https://github.com/jdwilson4/Network-Analysis-I/blob/master/Lecture%20Notes/Data%20Structures.pdf)| [Ch. 20 of *R for Data Science*](http://r4ds.had.co.nz/vectors.html) |  [Assignment 3](https://github.com/jdwilson4/Network-Analysis-I/blob/master/Assignments/Assignment3.pdf)| [Lists and Data Frames](https://github.com/jdwilson4/Network-Analysis-I/blob/master/Code/Lists_Data_Frames.R) |


**Foundations of Network Analysis: A History, Applications, and Construction**

| Topic | Reading | Practice | In-Class Code |
|:--- | :---  | :---  | :---- |
| [History of Network Analysis](https://github.com/jdwilson4/Network-Analysis-I/blob/master/Lecture%20Notes/History%20of%20Network%20Analysis.pdf) | [Ch 2.1 - 2.2 of Network Science](http://barabasi.com/networksciencebook/) | - | [Data Frames](https://github.com/jdwilson4/Network-Analysis-I/blob/master/Code/Assignment3.R) |
| [Network Types](https://github.com/jdwilson4/Network-Analysis-I/blob/master/Lecture%20Notes/Network_Types.pdf) |[Ch 2.4 - 2.7 of Network Science](http://barabasi.com/networksciencebook/) | - | - |
|[Manipulating and Visualizing Network Data](http://jdwilson-statistics.com/statistical-network-analysis-with-r/) | [Ch 2 and 3 of SAND with R](https://github.com/kolaczyk/sand) | - | [[igraph]](https://github.com/jdwilson4/Network-Analysis-I/blob/master/Code/Network_Visualization.R) [[statnet]](https://github.com/jdwilson4/Network-Analysis-I/blob/master/Case%20Studies/Basics.Rmd)|
| [Where's the Network?](https://github.com/jdwilson4/Network-Analysis-I/blob/master/Lecture%20Notes/Where_is_the_network.pdf) | - | [[Assignment 4]](https://github.com/jdwilson4/Network-Analysis-I/blob/master/Assignments/Assignment4.pdf), [[Assignment Template]](https://github.com/jdwilson4/Network-Analysis-I/blob/master/Assignments/Assignment4.R), [[Solutions]](https://github.com/jdwilson4/Network-Analysis-I/blob/master/Assignments/Assignment4_Solutions.R)| [Fitting Networks](https://github.com/jdwilson4/Network-Analysis-I/blob/master/Code/Where_is_the_network.R) |



**Network Descriptions: Local and Global Summaries**

| Topic | Reading | Practice | In-Class Code |
|:--- | :---  | :---  | :--- |
| [Paths, Shortest Paths, and Connected Components](https://github.com/jdwilson4/Network-Analysis-I/blob/master/Lecture%20Notes/Paths.pdf) | [Ch. 2.8 - 2.9 of Network Science](http://barabasi.com/networksciencebook/) | - | [[Algorithm Demonstrations]](https://github.com/jdwilson4/Network-Analysis-I/blob/master/Lecture%20Notes/Shortest_Path_Demonstrations.pdf) [[Path Examples]](https://github.com/jdwilson4/Network-Analysis-I/blob/master/Case%20Studies/Path_Examples.R) |
| [Degree Distribution and Graph Counts](http://tuvalu.santafe.edu/~aaronc/courses/5352/csci5352_2016_L1.pdf) | [[Ch. 2.3 of Network Science]](http://barabasi.com/networksciencebook/) [[Ch. 4.1 - 4.3 of SAND]](http://jdwilson-statistics.com/statistical-network-analysis-with-r/) | - | [Network Summaries](https://github.com/jdwilson4/Network-Analysis-I/blob/master/Code/Descriptive_Network_Characteristics.R) |
| [Community Detection](https://github.com/jdwilson4/Network-Analysis-I/blob/master/Lecture%20Notes/Community_Detection.pdf) | [[Review Paper]](https://arxiv.org/pdf/0906.0612.pdf) [[Applications]](https://arxiv.org/pdf/1705.02305.pdf)| - | - |
| [Structural Importance: Vertex Centrality](http://tuvalu.santafe.edu/~aaronc/courses/5352/csci5352_2016_L2.pdf) | [Centrality in Social Networks](http://www.analytictech.com/borgatti/papers/centflow.pdf) | - | [Centrality Examples](https://github.com/jdwilson4/Network-Analysis-I/blob/master/Case%20Studies/Centrality.Rmd)|
| [Case Study: Descriptive Analysis in R](https://github.com/jdwilson4/Network-Analysis-I/blob/master/Code/Descriptive_Analysis.R)| - | - | - |
| [Feature Learning for Networks](https://github.com/jdwilson4/Network-Analysis-I/blob/master/Lecture%20Notes/FeatureLearningForNetworks.pdf)| [Intro to Machine Learning](https://github.com/jdwilson4/Network-Analysis-I/blob/master/Lecture%20Notes/Intro_Machine_Learning.pdf)| - | - |
<!-- | Empirical Network Models |  | - | - | -->

<!-- **Mesoscopic Properties of Networks**

| Topic | Reading | Practice |
|:- | :-  | :-  |  -->

**Dynamics on Networks**

| Topic | Reading | Practice | In-Class Code |
|:--- | :---  | :---  | :--- |
| [Epidemic Models - Ch. 8.5](https://static1.squarespace.com/static/5672e813bfe8739f7afa013a/t/595be67c46c3c48b86756cb2/1499195017846/Statistical%2BAnalysis%2Bof%2BNetwork%2BData%2Bwit.pdf) | [Watts Model](https://www.stat.berkeley.edu/~aldous/260-FMIE/Papers/watts.pdf)| - | - |
<!-- **Multilayer and Temporal Networks**

| Topic | Reading | Practice |
|:- | :-  | :-  |  -->

### Additional Resources
- [Base R Cheat Sheet](https://www.rstudio.com/wp-content/uploads/2016/10/r-cheat-sheet-3.pdf)
- [Try R by CodeSchool](http://tryr.codeschool.com/) Quick, interactive R coding lessons
- [Swirl](http://swirlstats.com/students.html) (skip step 1 and 2 if you have already installed R and R Studio) Interactive coding lessions in R Studio
- [SNAP Website](http://snap.stanford.edu/data/index.html) Great resource for large network data

<!-- ### Good Reading Material -->
<!-- ### Case Studies
| Case Study | Data |
|:-| :-  |
|[I: The Basics - Input, Network Representations, and Visualization](https://github.com/jdwilson4/Network-Analysis-I/blob/master/Case%20Studies/Basics.Rmd) | [Zachary's Karate Club](https://raw.githubusercontent.com/jdwilson4/Network-Analysis-I/master/Data/karate.txt), [Political Blogs](https://github.com/jdwilson4/Network-Analysis-I/blob/master/Data/polblogs.txt) |
|[II: Network Motifs I - paths, shortest paths and connected components]() | []() |
|[III: Network Motifs II - graph counts]() | []() |
|[IV: Structural Importance]()| []()|
|[V: Community Detection]() | []() |
|[VI: Epidemics on Networks - SIR, SIS, and Cascades]() | []() |
|[VII: Temporal Networks - Structures over Time]() | []() | -->



### Network Data
- [Zachary's Karate Club](https://github.com/jdwilson4/Network-Analysis-I/blob/master/Data/karate.txt): A social network of friendships between 34 members of a karate club at a US university in the 1970s.
- [Political Blog](https://github.com/jdwilson4/Network-Analysis-I/blob/master/Data/polblogs.txt): A directed network of hyperlinks between weblogs on US politics, recorded in 2005 by Adamic and Glance.
- [Les Miserables](https://github.com/jdwilson4/Network-Analysis-I/blob/master/Data/lesmis.txt): A coappearance network of characters in the novel Les Miserables. 
- [Power Grid](https://github.com/jdwilson4/Network-Analysis-I/blob/master/Data/power.txt): An undirected, unweighted network representing the topology of the Western States Power Grid of the United States.
- [Facebook Social Circles](https://github.com/jdwilson4/Network-Analysis-I/blob/master/Data/facebook_combined.txt): A network of anonymized social circles from Facebook. 
- [Enron Email Network](https://github.com/jdwilson4/Network-Analysis-I/blob/master/Data/email-Enron.txt): Enron email communication network where nodes are email addresses and edges are emails sent from *i* to *j*. 

### Important Dates

- Tuesday, June 27th - First day of class
- Tuesday, July 4th - Holiday, **no class**
- Friday, July 21st - Last day of class

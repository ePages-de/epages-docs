---
layout: post
title: "Online Schema Updates with MySQL"
date: "2016-03-08 07:16:17"
image: blog-header/database.jpg
categories: tech-stories
authors: ["Mario"]
---

Avoiding the planned downtime during software maintenance is a requirement of one of our major customers.
That means, all changes to the database, including schema changes, have to be done during running mode.
Read and write commands should be guaranteed without restricting the performance.
Copying tables should be avoided.

## Theory and choice of solutions

Every software release requires schema changes that have to be executed with DDL commands like `ADD INDEX` or `ADD COLUMN`.
At the same time, the entire functional range of the system has to be available, i.e. reading and writing to the database at a high performance.
Due to the scale of the data files, this should be realised without copying tables.
As potential approaches we evaluated Online-DDL, high-availability solutions as well as replication solutions.
MySQL 5.6 Online DDL turned out to be the most suitable solution.
This provides the advantage that we could challenge this project with our standard tools without using additional third-party software that has its own release cycles.

## Quality - range of functions and limitations

[MySQL](https://www.mysql.com/) does not cover the complete DDL command set according to the requirements mentioned above.
For example, the command `ADD FULLTEXT INDEX` does not allow simultaneous writing.
Changing the data type of a column is also restricted.
These restrictions can be partially managed via a special patch flow:

{% image blog/blog-online-schema-1.jpg %}

We use an interim version for preparatory and follow-up work on the database.

During testing, we figured out that we can leave out the options ALGORITHM (COPY or INPLACE) and LOCK (SHARED or NONE) without having any disadvantages.
The system is able to find the optimal variant without a measurable time delay.
Interim conclusion: most of the DDL commands in MySQL 5.6 meet the requirements.

## Quantity

{% imagecaption blog/blog-online-schema-2.jpg %} Test results with small database - UPDATE or SELECT operations {% endimagecaption %}

As we're working with Scrum processes at ePages, we have a new software release every two weeks.
The database changes accordingly.
All performance issues first have been tested with a small database and only then have been tested again with a real database.
These were mainly three tables with 0.6 million, 1.4 million and 9 million  entries.

To summarise the results:

* Parallel execution extends the write commands.
* It seems as if the commands `ADD FULLTEXT INDEX` or `DROP FULLTEXT INDEX`, `ADD FOREIGN KEY` or `DROP FOREIGN KEY` and `CHANGE DATATYPE` queue the writing commands, which indicates sequential processing.
* Parallel execution does not have a significant impact on read commands.
* The sole exception with complex SELECT statements are the commands `ADD FOREIGN KEY` or `DROP FOREIGN KEY`.

Within a wider context we had three different test scenarios:

{% imagecaption blog/blog-online-schema-3.jpg %} Test scenario - wider context {% endimagecaption %}

The first results show this:

{% imagecaption blog/blog-online-schema-4.jpg %} Test results - execution times of DDL commands {% endimagecaption %}

You can see clear improvement from version 5.1 to version 5.5.
But only from the results there's no significant difference between MySQL 5.5 and 5.6.
So why definitely 5.6?
Taking a look at the occurred errors, log entries as well as the runtimes of the user test and the patch makes things clearer:

{% imagecaption blog/blog-online-schema-5.jpg %} Test results - number of errors, log entries and run times - user tests and patch {% endimagecaption %}

In particular, this means:

* Only minimal differences in runtimes of 5.5 to 5.6, both completely and database changes individually.
* Analysis of Selenium tests and log files: clear improvement of error behaviour from 5.5 to 5.6.
* With regards to error behaviour, variants B and C are the best methods in 5.6.
* With regards to run time of Selenium tests, variant C is the best alternative in 5.6.

## Conclusion

With MySQL 5.6 Oracle succeeded in taking a big step forward.
The supported command volume as well as the performance improved significantly.
For some operations still some patches are required, whereas preparatory database changes are executed with an interim patch and real features are activated afterwards.
In order to improve the execution times the DDL commands should be combined.
The initially stated customer requirement to perform maintenance tasks without downtime can be met.
All online shops will be online at all times.

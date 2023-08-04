# 02-Instagram User Analytics
SQL Fundamentals
Difficulty Level:       
## Description:  

User analysis is the process by which we track how users engage and interact with our digital product (software or mobile application) in an attempt to derive business insights for marketing, product & development teams.  
These insights are then used by teams across the business to launch a new marketing campaign, decide on features to build for an app, track the success of the app by measuring user engagement and improve the experience altogether while helping the business grow.  

You are working with the product team of Instagram and the product manager has asked you to provide insights on the questions asked by the management team.

You are required to provide a detailed report answering the questions below :  
1) Marketing: The marketing team wants to launch some campaigns, and they need your help with the following  

(A). Rewarding Most Loyal Users: People who have been using the platform for the longest time.  
     Your Task: Find the 5 oldest users of the Instagram from the database provided  
(B). Remind Inactive Users to Start Posting: By sending them promotional emails to post their 1st photo.  
     Your Task: Find the users who have never posted a single photo on Instagram  
(C). Declaring Contest Winner: The team started a contest and the user who gets the most likes on a single photo will win the contest now they wish       to declare the winner.  
     Your Task: Identify the winner of the contest and provide their details to the team  
(D). Hashtag Researching: A partner brand wants to know, which hashtags to use in the post to reach the most people on the platform.  
     Your Task: Identify and suggest the top 5 most commonly used hashtags on the platform  
(E). Launch AD Campaign: The team wants to know, which day would be the best day to launch ADs.  
     Your Task: What day of the week do most users register on? Provide insights on when to schedule an ad campaign    

2) Investor Metrics: Our investors want to know if Instagram is performing well and is not becoming redundant like Facebook, they want to assess the app on the following grounds  

(A). User Engagement: Are users still as active and post on Instagram or they are making fewer posts  
     Your Task: Provide how many times does average user posts on Instagram. Also, provide the total number of photos on Instagram/total number of        users  
(B). Bots & Fake Accounts: The investors want to know if the platform is crowded with fake and dummy accounts  
     Your Task: Provide data on users (bots) who have liked every single photo on the site (since any normal user would not be able to do this).  


# 03-Operation Analytics and Investigating Metric Spike

Advanced SQL
Difficulty Level:     
Description:
Operation Analytics is the analysis done for the complete end to end operations of a company. With the help of this, the company then finds the areas on which it must improve upon. You work closely with the ops team, support team, marketing team, etc and help them derive insights out of the data they collect.

Being one of the most important parts of a company, this kind of analysis is further used to predict the overall growth or decline of a company’s fortune. It means better automation, better understanding between cross-functional teams, and more effective workflows.

Investigating metric spike is also an important part of operation analytics as being a Data Analyst you must be able to understand or make other teams understand questions like- Why is there a dip in daily engagement? Why have sales taken a dip? Etc. Questions like these must be answered daily and for that its very important to investigate metric spike.

You are working for a company like Microsoft designated as Data Analyst Lead and is provided with different data sets, tables from which you must derive certain insights out of it and answer the questions asked by different departments.

You are required to provide a detailed report for the below two operations mentioning the answers for the related questions:

Case Study 1 (Job Data)
Below is the structure of the table with the definition of each column that you must work on:

Table-1: job_data
job_id: unique identifier of jobs
actor_id: unique identifier of actor
event: decision/skip/transfer
language: language of the content
time_spent: time spent to review the job in seconds
org: organization of the actor
ds: date in the yyyy/mm/dd format. It is stored in the form of text and we use presto to run. no need for date function
Use the dataset attached in the Dataset section below the project images then answer the questions that follows.


Case Study 1 (Job Data)

(1).- Number of jobs reviewed: Amount of jobs reviewed over time.
      Your task: Calculate the number of jobs reviewed per hour per day for November 2020?
    
(2).- Throughput: It is the no. of events happening per second.
      Your task: Let’s say the above metric is called throughput. Calculate 7 day rolling average of throughput? For throughput, do you prefer daily       metric or 7-day rolling and why?
      
(3).- Percentage share of each language: Share of each language for different contents.
      Your task: Calculate the percentage share of each language in the last 30 days? 
      
(4).- Duplicate rows: Rows that have the same value present in them.
      Your task: Let’s say you see some duplicate rows in the data. How will you display duplicates from the table?

Case Study 2 (Investigating metric spike)
The structure of the table with the definition of each column that you must work on is present in the project image

Table-1: users
This table includes one row per user, with descriptive information about that user’s account.

Table-2: events
This table includes one row per event, where an event is an action that a user has taken. These events include login events, messaging events, search events, events logged as users progress through a signup funnel, events around received emails.

Table-3: email_events
This table contains events specific to the sending of emails. It is similar in structure to the events table above.
Use the dataset attached in the Dataset section below the project images then answer the questions that follows

(1).-User Engagement: To measure the activeness of a user. Measuring if the user finds quality in a product/service.
     Your task: Calculate the weekly user engagement?
     
(2).-User Growth: Amount of users growing over time for a product.
     Your task: Calculate the user growth for product?
     
(3).-Weekly Retention: Users getting retained weekly after signing-up for a product.
     Your task: Calculate the weekly retention of users-sign up cohort?
     
(4).-Weekly Engagement: To measure the activeness of a user. Measuring if the user finds quality in a product/service weekly.
     Your task: Calculate the weekly engagement per device?
     
(5).-Email Engagement: Users engaging with the email service.
     Your task: Calculate the email engagement metrics?

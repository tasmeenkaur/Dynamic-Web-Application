# Dynamic Web Application (MySQL, MongoDB, Ruby on Rails)

Data was loaded to MySQL and MongoDB using scripts and queries where fired to compare both databases.

a.What sql framework did you choose and why?

I chose Mysql for its simplicity. As according to project requirements we had to load large data to database, Mysql is a fast sql framework to load large amount of data. Also, it has security features which can help protect the data. It is being used by popular websites such as wikipedia. To store large amounts of data it provides a facility to store it in main memory tables which have high speed. Also it has cache that stores the queries which are frequently used with their respective results.

b. What no sql framework did you choose and why?

I chose Mongodb as it can store large amount of data even if we dont provide its schema to mongodb. It accepts any form of data which we wish to load in it.Some of the websites using Mongodb are The New York Times, Git-Hub- for internal reporting application

c.What server framework did you choose and why?

I chose Ruby on Rails because it has object oriented approach and is a open source framework moreover it is easier to use both Sql and No sql framework with Ruby tasks.Directory in Ruby on Rails is properly managed and understandable; One knows "who is who". One can Create more than 1 tasks under same namespace. Rails is being used by top companies today for example hp, Intel, Nasa, Twitter

d. What aspect of the implementation did you find easy, if any, and why?

It was easy to load data in Mongodb as it is schemaless we need not provide any schema. 

e. What Ubuntu commands are required to deploy and run your server?

1.unzip tkk0823-project-phase2.zip

2.cd tkk0823-project-phase2.zip

3.Please change the mysql username password in /tkk0823-project-phase2/config/info.json file according to your machine. I am using username:root password: root according to my machine

4.bundle install

5.rake project:dataSql 

6.rake project:querySql  

7.rake project:dataNosql   

8.rake project:queryNosql  




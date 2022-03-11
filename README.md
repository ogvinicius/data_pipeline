# Automated Data Ingestion, Transformation and Serving Pipeline

This repository stores the codebase to support the operations around a service that ingests and provide data through a relational database.

## Technical requirements and how they were addressed

### Automated platform to be run on an on-demand basis...

This codebase implements a `Jupyter Notebook` with proper cells that once ran will provide the desired process. The tool for the trade should have been Airflow but unfortunately at the time of the push, I was not successful on deploying it locally on a M1 MacBook Air.

### Storing/grouping trips with similar Origin, Destination and Time

At the time of the push, I was not able to conceive a rapid method to PARTITION a Postgres Database based on GeoLocation and datetime. All methods I've ran through seemed cumbersome and manual. Maybe I need to learn more about the operation of a relational database. 

### Develop a way to inform the user about the status of the Data Ingestion, without using a polling solution

Airflow fits neatly in this case, since the UI signals the user - ALL time - about the status of any ran or running DAG.

### The solution should be scalable to support overloads of huge files (i.e 100 million entries)

Hopefully the implementation of the indexes and the creation of a specific dimension for a 'calendar table' also with proper indexing, will help on allowing for O(log n) complexity operations, given the requirements. 

Unfortunately, I was not able at the time of this push to come up with a way to test proof the solution against a 100 million entries dataset. 

### Use a SQL Database

PostgreSQL was the database chosen for the task, a relational one. 


## Proposed Migration Plan to the Cloud

### Option 1: leveraging the docker environment so dev/prod experiencing are quite similar

Other than developing a proper container to support Airflow, I'd advise on leveraging services like GCP's Cloud run to provide high availability and scalable platforms in which to run the solution, since it would require some "effort" behind the scenes by the PostgreSQL engine. 

### Option 2: Leveraging managed services

This option can be cumbersome at some point but, as long as one can replicate the available version of the software used in this managed services, I'd advise on using something similar to GCP's Cloud Composer (for AirFlow) and Cloud Spanner. 

Based on my experience, deploying such managed services and maintaining them becomes easy with Terraform. 

.
.
.

## Running the Project

To run the project you will need to have both docker and docker-composer installed. 

With this, becomes easy to access the proposed solution and starting interacting with that.

### Deploying it

```
docker-compose up
```

The database will execute some query runs in order to fill the database with proper structures to both accommodate the data to support the thought data model.\

#### Acessing the Notebook

In the prompt you should be able to find "where" the jupyter lab environment is providing access to it. It generally is located at https://localhost:8888, but requires a token. Recommend accessing it from the provided URL.

#### Acessing the Database Management Tool

The datbase management is allowed by the `pgadmin4`. To acess it:

1. go to https://localhost:5050
2. provide the `user@mail.com` username and `superS3cret` password required. 
3. To configure the server, you will need to provide:
    3.1 host: `postgres`
    3.2 port: `5438`
    3.3 database, user, password: `postgres`


There you go, you are all set!

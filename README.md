# README

## General
This Ruby on Rails app was created as part of the interview process for Terrier Technologies and fulfills the requirements as described in the Rails Scheduling Assignment document.

## System Requirements and Installation
* This app was made using Ruby version 2.7.2 and Ruby on Rails version 6.0.3.4
* This app uses a PostgreSQL database, version 13.0
* This app was developed using Windows Subsystem for Linux, but it should hopefully work on other platforms as well.

To install, do the following:
* Make sure the correct versions of Ruby, Ruby on Rails, and PostgreSQL are installed.
* Clone the repo.
* Run ``bundle install`` to install required gems.
* Configure a DB user in Postgres and add their credentials as environemnt variables ``PEST_SCHEDULER_DATABASE_USER`` and ``PEST_SCHEDULER_DATABASE_PASSWORD``. I did this by adding the variables to the end of ``~/.bashrc``, but this could be system dependant.
* Create the db by running ``rake db:create`` and run db migrations by running ``rake db:migrate``.
* Load the CSVs into the DB by running the command described in the next section.
* The app should now hopefully be fully configured and ready to run by typing ``rails start``.


## Loading CSVs
I built a rake task which will ingest a CSV and load it's data into the Rails database. To run this task, type the following in the app's main directory:

```
rake db:import:load_csv_data[model_name,filepath,encoding]
```
* ``model_name`` can be either Location, Technician, or WorkOrder
* ``filepath`` is the full file path
* ``encoding`` is an optional argument describing the file's encoding type. The default value is "bom|utf-8" because that was the encoding of the provided CSVs.

## Challenges of this project
The biggest challenges of this project were two fold. The first was re-familiarizing myself with Ruby on Rails and how to setup the environment and database to suit my needs. This wasn't too bad, however, and after a while it all sort of came back to me. The biggest challenge for the project itself was working with the CSS to be able to display a div on a table structure that has to dynamically scale its height and position based on the order's details. It took a lot of playing around with and there are certainly more potentially elegant solutions out there, but I'm satisfied with the one I came up with for the purposes of this assignemnt.

## Design Approach 
In general, my approach was primarily to illustrate my capabilities of being able to develop in a Rails environment, not necessarily building a fully fleshed out project. I also wanted to keep my code rather conventional, so I avoided using too many gems and other frameworks to accomplish this task. I'm most familiar with Haml for views, for example, but I decided to just use ERB instead because it's the Rails default. I did install Bootstrap with the intention of using it for CSS, but I ended up doing most of the styling without out it.

## Potential Improvements
Due to my design approach, I generally stuck to the project's basic requirements and didn't deviate too much. For example, the table currently displays every work order in the db, and the table isn't capable of displaying certain orders for a given day. This would be pretty easy to add, but I left it out for time's sake. There also isn't much functionality regarding two work orders with conflicting times other than displaying them in red (an unrequired feature I felt was necesssary). Another useful feature would be to add some sort of admin page where you can upload the CSVs on the site itself, rather than having to run a rake task on the application's server.

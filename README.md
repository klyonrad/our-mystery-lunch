# Requirements

- Ruby version 3
- sqlite
- Chrome (for headless browser testing)

# Setting up

- `bundle install`

Run rake tasks:

- `rake db:setup`
- `rake employees:generate_fake`
- `rake lunches:generate_six_months` (optional)

# Running the server

Then run server with `bundle exec rails server`

Upon the first call

# Other rake tasks

- `rake lunches:destroy_all`
- `rake employees:destroy_all`

They do what the say ;-). Destroying the employees before destroying the lunches does not work.

# Notes

## Buggy behaviour

The lunch plan generation can sometimes fail because the randomness is exhausted (NoMethodError on a nil.
Just hitting it again typically works (I didn't want to do this in code to avoid infinite incursion)

## Features omitted

The features *images of employees* and *authentication* are not present.
Did not consider it relevant to show that I can click together `devise` and I don't have infinite time

## Mystery feature

On the employees page you can see the percentage with how much of the current Employees in other departments the employees lunched with already in the last year.
This could be used to fine tune the algorithm (ouf) and generally to observe how the system is working towards its intended goal.

## Design considerations

Generally I tried to keep the controllers "clean" by moving the logic into POROs.
I tried a little bit to avoid the typical polluting of ActiveRecord models with infinite amount of database logic (LunchPlan is meant as a repository).
In the end a lot of stuff ended up in the Employee model since it is not sooo much and I needed to speed up things.

The same sadness applies to mocking and faster unit tests :(

# README

## Introduction - BMCMemberTracker##

This application will be used by the officers of the TAMU Badminton Club

## Requirements ##

This code has been run and tested on:

* Ruby - 3.0.2p107
* Rails - 6.1.4.1
* Ruby Gems - Listed in `Gemfile`
* PostgreSQL - 13.3

## External Deps  ##

* Docker - Download latest version at https://www.docker.com/products/docker-desktop
* Git - Download latest version at https://git-scm.com/book/en/v2/Getting-Started-Installing-Git

## Installation ##

Download this code repository by using git:

 `git clone https://github.com/andres-blanco1785/BMCMemberTracker.git`


## Tests ##

An RSpec test suite is available and can be ran using:

  `rspec spec/`
  
We also used RuboCop to check Syntax
  `rubocop`

## Execute Code ##

Run the following code in Powershell if using windows or the terminal using Linux/Mac

  `cd BCMMemberTracker`

  `docker run --rm -it --volume "$(pwd):/rails_app" -e DATABASE_USER=test_app -e DATABASE_PASSWORD=test_password -p 3000:3000 dmartinez05/ruby_rails_postgresql:latest`

  `cd rails_app`

Install the app

  `bundle install && rails webpacker:install && rails db:create && db:migrate`

Run the app

   `rails server --binding:0.0.0.0`

The application can be seen using a browser and navigating to http://localhost:3000/

## Deployment ##

** Instructions about how to deploy to Heroku
Before we begin, make sure your Git repository has 3 separate branches - main, test, and dev.
1. Create an account with Heroku (https://signup.heroku.com/)
2. Go to your dashboard (https://dashboard.heroku.com/apps)
3. Click the "New" button at the top right corner and select "Create new pipeline".
![Screen Shot 2021-10-04 at 4 31 46 PM](https://user-images.githubusercontent.com/53985591/135927652-a677b370-f1ff-4efa-84bf-daf6d2717504.png)
4. Fill out the form accordingly. 
![Screen Shot 2021-10-04 at 4 40 46 PM](https://user-images.githubusercontent.com/53985591/135928614-3e03f436-025a-49c0-83aa-4b3a6269ed24.png)
5. Click "Enable Review Apps." Be sure not to toggle any of the checkboxes and leave everything as default.![enable-review](https://user-images.githubusercontent.com/53985591/135931428-ca6d1af3-5b4c-41e8-aeaf-01315ea39fde.png)
6. In the Review Apps section, create a new app, and select your "test" branch for deployment.![review-new-app](https://user-images.githubusercontent.com/53985591/135931436-c210f31c-a7c5-4a07-af9a-349dcc07ca60.png)
7. Add an app to staging as well. Enter an appropriate app name
![Screen Shot 2021-10-04 at 5 11 18 PM](https://user-images.githubusercontent.com/53985591/135931711-12c2e75e-a70e-4784-8360-cad9715ba1c9.png)
8. Click on your newly created staging app and go to the Deploy tab. Change your main branch to be used for Automatic Deployment and enable automatic deployment.![Screen Shot 2021-10-04 at 5 13 55 PM](https://user-images.githubusercontent.com/53985591/135931949-df5e5366-8de2-406d-ac72-e3949a2d707e.png)

After commiting changes to your test branch and merge into your main branch. After the merge, Heroku will automatic deployment will occur for the staging app. Open the staging app when it's done building, move the app into production to have the changes. You have now officially deployed your app! ![Screen Shot 2021-10-04 at 5 25 14 PM](https://user-images.githubusercontent.com/53985591/135932952-32d54ebe-735e-40a2-97bb-192d2c6baa9c.png)


## CI/CD ##

For the CI/CD portion of our development, we set a standard that each team member would commit and push changes to their feature branch as frequent as possible so that we wouldn't have huge merge conflicts later on at the end of the sprint. We also set up Branch Protection Rules in our repository so that the person creating a pull request into the main branch cannot merge/complete their own request. The changes that each team member made would be tested and merged into our test branch, which would deploy and test our changes automatically through GitHub Actions. The deployment process was done through Heroku, which would automatically deploy our test/main environments if the build was successful and integrate any updates that we would make to our application.

## Support ##

There are links at the bottom of the application page that redirect you to a help page.

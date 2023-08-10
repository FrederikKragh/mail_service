# README

To get up and running:

* Run `rails s` from root folder
* Open http://localhost:3000 

The database currently includes 200 emails from my own Gmail account (I trust you). If you want to download your own emails instead, you can open http://localhost:3000/emails/new which will allow you to authenticate with your own Google account and download the latest 50 emails from your Gmail.

AFAICT, the Gmail API doesn't have a method for downloading multiple emails at once, hence the strategy is to fetch all of the email ID's and fetch the subject, sender and date from each email separately. This requires a lot of API calls and takes a while, but what can you do?...




Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* ...

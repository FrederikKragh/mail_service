# README

To get up and running:

* Run `rails s` from root folder
* Open http://localhost:3000 

The database setup is a default Rails SQLite3 setup, which should be loaded automatically and can be found in `db/development.sqlite3`.

The database currently includes 200 emails from my own Gmail account (shouldn't be anything interesting in there :P), received between July 19th to August 10th. If you want to download your own emails instead, you can open http://localhost:3000/google/new which will allow you to authenticate with your own Google account and download the latest 200 emails from your Gmail account (this might not currently be possible, since this app has not been through Googles verification process).

AFAICT, the Gmail API doesn't have a method for fetching the content of multiple emails at once, hence the strategy is to fetch all of the email ID's and then fetch the subject, sender and date from each email separately. This requires a lot of API calls and takes a while, but what can you do?...

For the sake of the excercise, the credentials are included in the .env file. Obviously I trust that they wont be missused and I wouldn't do that in a real scenario :)
<a  href="https://www.twilio.com">
<img  src="https://static0.twilio.com/marketing/bundles/marketing/img/logos/wordmark-red.svg"  alt="Twilio"  width="250"  />
</a>
 
# Automated Surveys with Ruby on Rails and Twilio

![](https://github.com/TwilioDevEd/automated-survey-rails/actions/workflows/build.yml/badge.svg)

This application demonstrates how to use Twilio and TwiML to perform automated phone surveys.

[Read the full tutorial here!](https://www.twilio.com/docs/howto/walkthrough/automated-survey/ruby/rails)

## Note: protect your webhooks

Twilio supports HTTP Basic and Digest Authentication. Authentication allows you to password protect your TwiML URLs on your web server so that only you and Twilio can access them.

Learn more about HTTP authentication [here](https://www.twilio.com/docs/usage/security#http-authentication), which includes sample code you can use to secure your web application by validating incoming Twilio requests.

## Local development

This project is built using the [Ruby on Rails](http://rubyonrails.org/) web framework and NodeJS to serve assets through Webpack.

1. First clone this repository and `cd` into it.

   ```bash
   $ git clone git@github.com:TwilioDevEd/automated-survey-rails.git
   $ cd automated-survey-rails
   ```

1. Install Rails dependencies

   ```bash
   $ bundle install
   ```

1. Install Node dependencies

   ```bash
   $ npm install
   ```

1. Create the database and run migrations.

   _Make sure you have installed [PostgreSQL](http://www.postgresql.org/). If on
   a Mac, I recommend [Postgres.app](http://postgresapp.com)_.

   ```bash
   $ bundle exec rails db:setup
   ```

1. Make sure the tests succeed.

   ```bash
   $ bundle exec rspec
   ```

1. Run the server

   ```bash
   $ bundle exec rails s
   ```

1. Expose your application to the wider internet using [ngrok](http://ngrok.com). You can click [here](#expose-the-application-to-the-wider-internet) for more details. This step is important because the application won't work as expected if you run it through localhost.

  ```bash
  $ ngrok http 3000
  ```

  Once ngrok is running, open up your browser and go to your ngrok URL. It will look something like this: `http://9a159ccf.ngrok.io`

1. Configure Twilio to call your webhooks

  You will also need to configure Twilio to call your application when calls or messages are received on your _Twilio Phone Number_.

  The **Voice Request URL** should look something like this:

  ```
  http://<sub-domain>.ngrok.io/surveys/voice
  ```

  The **SMS & MMS Request URL** should look something like this:

  ```
  http://<sub-domain>.ngrok.io/surveys/sms
  ```

That's it!

### How To Demo
_Voice Surveys_. Call your Twilio phone number and follow the instructions.

_SMS Surveys_. Text your Twilio phone number with any text and follow the instructions.

## Meta

* No warranty expressed or implied. Software is as is. Diggity.
* [MIT License](LICENSE)
* Lovingly crafted by Twilio Developer Education.

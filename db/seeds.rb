# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

survey = Survey.create(title: 'Twilio Developer Education')

survey.questions.create(
  [
    {
      body: 'On a scale of 0 to 9 how would you rate this tutorial?',
      type: Question.types[:numeric]
    },
    {
      body: 'On a scale of 0 to 9 how would you rate the design of this tutorial?',
      type: Question.types[:numeric]
    },
    {
      body: 'In your own words please describe your feelings about Twilio right now?',
      type: Question.types[:free]
    },
    {
      body: 'Do you like my voice? Please be honest, I dislike liars.',
      type: Question.types[:yes_no]
    }
  ]
)

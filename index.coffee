Workflowy = require 'workflowy'
schedule = require 'node-schedule'
moment = require 'moment'
FileCookieStore = require 'tough-cookie-filestore'

username = process.env.WORKFLOWY_USERNAME
password = process.env.WORKFLOWY_PASSWORD

unless username and password
  console.error "Workflowy username and password must be provided through environmental variables."
  process.exit 1

workflowy = new Workflowy username, password, new FileCookieStore('cookies.jar')

###
# update all the tasks with today's day of week to instead have a #today tag
###
replaceDayOfWeekTag = ->
  dayOfWeekTag = ///\##{moment().format('dddd').toLowerCase()}\b///

  workflowy
  .find dayOfWeekTag
  .then (nodes) ->
    replacementText = for node in nodes
      node.nm.replace dayOfWeekTag, '#today'
    workflowy.update nodes, replacementText
  .fail (err) ->
    console.error err

###
# anything marked #today that is complete, delete
###
deleteTodayCompleted = ->
  todayTag = /#today\b/

  workflowy
  .find todayTag, true
  .then (nodes) ->
    workflowy.delete nodes, true
  .fail (err) ->
    console.error err

###
# anything marked daily that's complete, mark as not complete
###
resetDaily = ->
  dailyTag = /#daily\b/
  workflowy
  .find dailyTag, true
  .then (nodes) ->
    workflowy.complete nodes, false
  .fail (err) ->
    console.error err

###
# anything that's complete and marked #weekly, mark as not complete
###
resetWeekly = ->
  weeklyTag = /#weekly\b/
  workflowy
  .find weeklyTag, true
  .then (nodes) ->
    workflowy.complete nodes, false
  .fail (err) ->
    console.error err

schedule.scheduleJob
  dayOfWeek: 0
  hour: 4
  minute: 0
  ->
    workflowy.refresh()
    resetWeekly()

schedule.scheduleJob
  hour: 4
  minute: 0
  ->
    workflowy.refresh()
    deleteTodayCompleted()
    replaceDayOfWeekTag()
    resetDaily()

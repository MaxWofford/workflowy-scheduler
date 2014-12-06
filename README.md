Workflowy Scheduler
===================

This is a small script using the [(unofficial) Workflowy API](https://github.com/mikerobe/workflowy) to reset a series of task tags on a daily and weekly schedule

Every day at 4am:

 - completed tasks tagged with `#today` are deleted
 - completed tasks tagged with `#daily` are marked incomplete
 - tasks tagged with the current day of the week

Every week on Sunday at 4am:

 - completed tags tagged with `#weekly` are marked incomplete


## tips, observations, best practices

 - you can assign a task to a particular day of the week and when that day comes, it shows up in your `#today` searches. If you don't complete it on that day, it naturally rolls to the next day's `#today` searches

 - you can tag things arbitrarily with locations or other contextual information for GTD-style task management. For example, `#place:manhattan #friday #buy ginger snaps at trader joes`

 - if you have a recurring task that you want to do multiple times a week, you could create multiple day of week tasks (`#monday yoga`, `#wednesday yoga`, `#friday yoga`) or create a weekly task multiple times (`#weekly yoga`, `#weekly yoga`, `#weekly yoga`)


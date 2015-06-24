# Support Hero App by Piera Damonte
Ruby / Sinatra application for storing and displaying on-duty support staff team schedule
* [Click here to view the full Senior Engineer Homework description here] (https://github.com/Piera/Support-Hero-App/blob/master/New%20Relic%20Coding%20Exercise.pdf)
* The Support Hero application is deployed on heroku: https://supportheroapp.herokuapp.com/

## Introduction:

As a former digital operations director, I can appreciate the importance of internal tools to rapid business expansion. In this role, I proactively created internal facing resources that accelerated internal onboarding, and adoption of practices. I am passionate about serving both internal and external customers and I hope to extend these skills to building internal tools such as this.

Being newer to Software Engineering, and new to Ruby, OOP as well as Ruby frameworks and testing, I was eager to tackle this exercise as a stretch assignment. This product reflects what I can learn and produce within a couple of weeks when starting at the base of the learning curve. I am excited to continue learning OOP best practices and to expand my testing skill sets.

Learn more about me:
* [LinkedIn] (https://www.linkedin.com/in/pieradamonte)
* [Background] (http://www.pieradamonte.com/#About)
* [Resume] (http://www.pieradamonte.com/#Resume)
* [Portfolio] (http://www.pieradamonte.com/#Projects)
 
## Requirements & assumptions:

1. **Required Features** from the Senior Engineer Homework document:
  * Display today’s Support Hero.
  * Display a single user’s schedule showing the days they are assigned to Support
Hero.
  * Display the full schedule for all users in the current month.
  * Users should be able to mark one of their days on duty as undoable
    * The system should reschedule accordingly
    * Should take into account weekends and California’s holidays.
  * Users should be able to swap duty with another user’s specific day

2. I designed this this application with the following **assumptions**:

  1. First and foremost: this application will require expansion of features or capacity as the company grows.  Some examples include:
    1. More than one Support Hero per day
    2. Support Hero subspecialties
    3. Components of this app may be extended as APIs (e.g., team schedule)
    4. Team expansion and/or starting order changes
  2. This application would be built as a part of a larger intranet which may include:
    1. API for state and company dates; company may have some non-standard holidays such as the days in between the winter holidays
    2. More complete information on each team member
    3. Integrated log-ins and authentication services for admin and team users
  3. Team members as provided are unique by first name.
  4. When a new month starts, or the calendar is updated, the starting order continues with the next person in order from where it left off.
  5. All users are in the same time zone.
  6. Once two team members switch, they cannot mark themselves as unavailable.
  7. Once two team members switch, the calendar updates around the switched dates if other team members mark themselves as unavailable.

## Design:

**1. Technologies:**

  * Ruby
  * Sinatra
  * Active Record
  * PostgreSQL
  * HTML & Bootstrap
  
  For the size and limited scope of this application, Sinatra was a good fit.  Having worked briefly with Rails, I also wanted to limit the automated creation of views, and make sure that I have as much knowledge and control of the project as possible. 

  Active Record is a good choice for quickly building a stand-alone application with several related tables, but if this application is part of a larger application suite, a different ORM might be a better fit.

**2. Usage and User Interface:**

  I simplified this application to two views:
  
  1. The home/calendar view shows the current month schedule, and the day’s assigned Support Hero.
  2. A profile view for each team user that shows the assigned dates for a given team user by current month. To view a profile, click through any name on the calendar.
  On the profile view, team users can mark dates unavailable or switch dates.  As part of a larger internal application, edit functionality may be behind a login per each user.


**3. Data Modeling:**

  I split the data models into small related tables that will allow each one to be manipulated separately as needed.  Components such as holidays, starting order, and availability are then aggregated into one master calendar table.

Models include:
  * Hero
  * StartingOrder
  * Unavailable
  * Calendar
  * Holiday

To handle the Support Hero switching, and to preserve switches when calendar is updated due to unavailable heros, I used a flagging system in the calendars table to keep track of dates where heroes have switched.  When updating the calendar, the starting order skips over dates where users have switched.

**4. DateTime:**

  DateTime is a cornerstone component of a calendar application. I had a choice of using Date, DateTime, or Time classes and methods to store dates in the tables.  I chose to use DateTime, so that the application can be expanded upon if both Date and Time need to be stored in order to keep track of Support Hero shifts or hours (if more than one Support Hero were needed per day).

  If all users are in the same time zone, the deployment environment can be set to the correct UTC (for example, pacific time in North America is UTC-8). 
  
**5. Other key considerations** for this project include (pending functionalities):

  1. Adding filters to profile view to limit:
    1. Date switches and marking dates unavailable from for past dates.
    2. Restricting team users from marking more than one date unavailable per month
    3. Days that are not covered by a support hero (i.e. all team members cannot mark the same day unavailable)
  2. Alerts if Holidays are not uploaded for a given year
  3. Ability to switches or availability as needed. (These requirements I would flesh out with the user base and admin users.) 
  4. Lastly, alerts (email or otherwise) as needed.  For example, should an admin get a notice if a team member marks a date as unavailable?  If team members switch?  (These requirements I would flesh out with the user base and admin users.) 

**6. Testing:**

  While it was fairly easy to see when key functionalities of this app are working, this simple application is deceptively complex and can break down in numerous places; and programmatic testing would be critical in a true environment.  At this time, I am learning RSPEC and how to best support a Ruby application through testing, and so that tests can be added.

  Tests should include all Classes and Models, and they should address any edge cases as well as any filters as noted above (e.g., restrictions on how many unavailable dates per month per user, empty calendar dates, etc.)

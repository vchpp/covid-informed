For Change Log see [changelog.md](changelog.md)

# COVID INFORMED

This website is part of a grant awarded to UCSF by the NIH for researching COVID awareness in Asian-American communities around the San Francisco Bay Area

# Website goals
The website will be publicly accessible and will have several goals:
Disseminate up- to- date and timely information around COVID-19,  guidelines on testing and vaccination, and testing / vaccination resources facilities in multiple languages.
Collect randomized controlled trial (RCT) study participants’ engagement data through visits to the website via uniquely generated URLs sent through SMS via Mosio
Gather website usage analytics and feedback  from both RCT study participants and the community (non-participants) via visits to the website in the forms of page-view, ‘like’ ratings and comments made to specific message contents.   From the feedback, research team may improve message contents and gain understanding on views of community members of COVID-19 testing and vaccination related topics to guide future educational programs.
[tentative] Provide an opportunity to non-participant visitors to sign-up for the INFORMED text messaging program through website to get updated information about COVID-19, testing and vaccination.
[to be decided] Provide a hub of resources for Lay Health Worker to enable them to access the latest versions of the materials or information to facilitate their educational sessions/ communications with their participants.

# Website Form
The website must be mobile-first, in that all participants will be surveyed via SMS, therefore it is assumed they will be using their phones to access the website as well.

# Website Functions
The website will have several components.  Each aspect of the website will have different interactive functions depending on the user, and their mode of engagement.  Survey participants will mostly be engaged via SMS on their phones, however, will have a unique URL generated for them for direct engagement on the website.  Administrators/research team will have a back-end access to the survey data via REDCap, along with the ability to configure the survey questions, schedule message delivery,and  analyze visitor engagement.
Component
Description
User Stories
Developer notes
Header showing Pages
Homepage, About, Intervention Messages, Resources
A user will be able to navigate between the 5 main pages
A user should not be allowed to log in anywhere (protected by CF Access?)
A user should be able to view all pages on a mobile-first platform, but also desktops


###About
About page that talks about team and objectives, news (with links to external resources)?
A user should see a link to the different organizations and team members who are involved with this project
Rails g controller about
Homepage
Landing page to route visitors to:
Two new messages and/or Carousel with messaging → rotating messages/ keeping the site fresh
Join the survey → a REDCap survey that UCSF will directly,
find resources on COVID-19 Federal and State Guidelines, testing centers, vaccination centers
Survey participants will be routed to a specific intervention message, generated by a link sent by Moseo, however, a homepage should have the most recent intervention message
‘Join the survey’ link would link to a redcap survey for participation


Need the redcap survey link
Intervention Message Boards
A table of contents will link each message to its own page, where a discussion of comments and likes will be present to track engagement
Should have charts or graphs representing answers from SMS-based surveys which identify data-points, like previous knowledge, engagement, etc
A user can view messages
A user can vote up or down a message

An admin can edit a message, which will increment the version control to track versions of messaging
Divide the 12 messages into 6 bucket subpages
Rails g scaffold message strings
Intervention Message Board Comments
Comments to individual intervention messages should be constructive or allow for feedback
A user can make a comment
A user can edit or delete their own comment, based on the cookie (this is potentially dangerous
An admin can edit or delete a comment to moderate
Rails g scaffold comments strings
Message Upvote
Message Downvote
Separate models to track individual users making message upvotes or downvotes
A user can vote for a message to go up or down
done
Comment Upvote
Comment Downvote
Separate models to track individual users making comment upvotes or downvotes
A user can vote up or down a comment
A user will be tracked when they make comments, or votes, based on their id query string, along with date and time the comment or vote was made
WIP
Lay Health Worker Flip Chart Curriculum
Flipcharts are for a survey participant to view after having a session with a lay-health worker
They may be tied to Weekly Intervention Messages, but not necessarily

### Resources/guidelines to external resources
A list of Federal and State resources such as guidelines, testing centers, vaccination centers, etc, best practices, etc
Testing sites
Vaccination
Stretch goal - Uses Device Location to geo route to an array of closest testing sites
MVP goal - visitor provides zip code and list all testing sites in bay area proximate to that zip

CDC is already translated to Chinese and Vietnamese , so links to their resource sites will be great

https://www.healthwise.org/ is also a potential resource website - see below


### Internationalization


Support for English, Vietnamese, Chinese (Simplified), Chinese (Traditional), Hmong
A user should be able to view the entire website in their native language


### Subscriptions
Users who are actively participating in the surveys will already have text messages delivered from Mosio survey, but should also be enrolled separately within the subscriptions of the website for updates to current
Additional users can opt-in to the Mosio study, and therefore also receive updates


External participants tracked with cookies[:rct] =7xxx
People who sign up need to be assigned a 7xxx cookie
Needs to check if the number has already been added to remove duplicates


### Administration
Admins of the website will have to actively monitor the message comments for abuse
Admins of the website will have the ability to add new, or update any messaging or text/context throughout the campaign
Ability to verify the active links are correct - use a 3rd party scanner and get a report weekly so I can update the website as necessary




Survey participants
Unique ID query string on URL sent to track movements and comments
Anticipate 1000 users


No problem to openly enroll participants
Study participants tracked with cookies[:rct]
External participants tracked with cookies[:rct] = 7xxx
Analytics
Page views, search engine optimization, traffic flows all done by Google Analytics

### HealthWise.org integration
Further Discussion regarding Healthwise cards/resources
A nested Healthwise page under Resources
Perhaps CDC page as well?

### News/Events feed
A feed that contains up-to-date events or information that allows a user to find external resources on /news
A user can view updated news
An admin can add new news events
An admin can change whether this is upcoming or past (bool)
Controller to separate out upcoming and past events
View to arrange in order of updated
Which model fields?


# Installation

## Requirements

* Ruby 3.1.2
* Rails 6.1.6.1
* Yarn
* Webpacker

## Instructions

After installing the dependencies, run

* $ `bundle install`
* $ `npm install --global yarn`
* $ `bin/rails webpacker:install`
* $ `bin/rails action_text:install`
* $ `bin/rails active_storage:install`

# Things I've learned

* I18n
* Scoped routing and custom controller actions
* Pagination
* Set and use cookies to track visitors across the site
* Friendly_ID URLS
* ActiveStorage file uploads
* ActiveText RTF Editing
* Search using Model Scopes
* Export database columns as CSV
* Audit logs for admin actions
* Audio files via HTML5 player
* Consume external JSON API to display content
* Use local caching
* Use Metamagic to add meta data to each view

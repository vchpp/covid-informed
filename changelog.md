https://github.com/vchpp/covid-informed

# TO DO:

### 1-week sprint 1/5 - 1/10

`IN PROGRESS` - Check on Callouts - make sure they show up, and clean up form

`IN PROGRESS` - Research stripping out HTML out of Messages CSV export

Await translations for Additional Resources Filter by County

Audio files for stand-alone audio banner on homepage (new model)

PPT presentations displayed on webpage, image slideshow of PPT as fallback

Google Analytics DataStudio

### Stretch Goals:

`IN PROGRESS` - Refactor Message.images to Message.en_images to reduce code on Messages#Index and Messages#Show

Refactor 'External' model to 'Additional'

Serve GA script from domain instead of 3rd party to prevent adblockers

1 FAQ all button hmong center text in button

2 Messages#show buttons larger from bootstrap source code

3 /about page needs color break - give a few examples

3 Profiles on /about needs background color or anchor

3 Healthwise handouts displayed on individual messages (upload and display PDFs)

3 Messages#show make RTF font size larger for desktop view only

4 Profiles#show text should not wrap

4 Profiles on /about title/name/affiliation to make more dense

4 Research audio playback for illiterate visitors or play audio on Messages#show

LHW as model so they can update flipchart (they will use the flipchart/FAQs)

Do comments have replies?

Do comments have an author, default=anonymous?

https://coronavirus.jhu.edu/map.html Stats

Share page links with social media (Facebook, twitter, email, copy link)

Research: Puny-code URL

Cookie compliance, ie GDPR?

Stretch goal - Resources#external google map with nearby vaccination centers

### For Healthwise:

HealthWise as a resource

Put it on it’s own page under resources, gated as a admin

Upvote and downvote, and comment individual items

Reach out to Marta to get Postman collection

Oauth to get an access token, token lives for 24 hours.  All subsequent calls use access token

Payload is loaded into <head> and <body> tags

Check out patient instructions

Is content dynamic or not?



### For Google Analytics:

#### Things to measure:

Where is the visitor coming from?

What is the URL they’re hitting when they first enter the website, ie Messages/3

What is the path they take after the message?  Internal or External links followed?

How do they interact with the website (clicks, comments)

Trial participants (RCT 1- 9999) Data organized by ID, with timestamp of pages visited

Track visitors based on whether RCT users actually click the link with

Regular visitors total traffic from cities

What locale is used to make comments and upvotes

Overall traffic for each page

Languages being tracked

Download activity as event

Comment activity as event

Like activity as event

External resources and Statistics events (clicks, navigation to external websites)

# CHANGELOG:

### 1-week sprint 1/5 - 1/10

`DONE` - Audio files for the illiterate.  Messages!

`DONE` - Display audit log in /admin/audit-logs or be able to download audit log

`WON'T DO` - Can ActiveStorage URLs be shortened for adhoc sending

`DONE` - Make sure admin page forces locale

### 1-week sprint 12/22 - 1/4/22

`DONE` - Paginate Comments and show 10 most recent

`DONE` - Export Messages to CSV to include `created_at` and `updated_at` with all attributes

`DONE` - Additional Resources - preset filters (search terms) by County - either buttons or dropdown - show example of both

`DONE` - Find way to create access logs either via Logger to expose changes or additions for intervention messaging updates.

### 1-week sprint 12/15

`DONE` - Encode Chinese and Vietnamese characters need encoding pre-CSV export

`DONE` - Check CSV export dates for Comments and Votes to make sure they’re all correct

### 1-week sprint 11/12 - 11/18

`DONE` - Make sure RCT cookie visible in GA reports

`DONE` - Add archive bool for external resources/messages/profiles/anything else

`DONE` - Turn pink color into brown from logo

`DONE` - Surface RCT cookie ID as console log

`DONE` - Overwrite cookie priority to always use query string

`DONE` - Messages#back needs to be colored blue

### 2-week sprint 10/28 - 11/10

`DONE` - External Resources migrate Featured bool `default=false` to raise Featured items to the top (new collection on view)

`DONE` - Copy above onto Statistics

`DONE` - 1 LayHealthWorkers spacing audit

### 1-week sprint 10/20 - 10/28

`DONE` - 1 Translations for profile research titles

`DONE` 1 hmong language is `‘lus hmoob’` for external resources - match `‘hmoob’` so it doesn’t break

`DONE` - 1 vietnamese mission statements on `/about`

`DONE` - 1 add translations for disclaimer at footer on `/about`

### 1-Week Sprint 10/13 - 10/20

`DONE` - 1 - for Message entering comments - the button text "CREATE comments" in Chinese - Zh_TW is: `輸入評論`  or   Simplified (Zh_CH):`输入评论`

`DONE` - 1 `External#index` languages should be separated by pipes FIX

`DONE` - 1 - move Resources (Downloads/LHW/Stats) to (LHW/Downloads/Stats)

`DONE` - 1 Increase font size on additional resources title cards when mobile view

`DONE` - 1 - please fix the "read more" button(s) - some shows black fonts and they are hard  to read

`DONE` - 1- placeholder body for Resources#layhealthworkers

`DONE` - 1 - add funders to homepage - must have links eventually

`DONE` - 1 - Add logos of funding organizations and 3 lines of words to the bottom of the `/about` page

### 1-Week Sprint 10/6 - 10/12

`DONE` - 1 Default back to old font

`DONE` - 1 Chinese homepage mission statement should not wrap, but instead force it to the second line
after the colon

`DONE` - 1 `FAQ/External` search button should be icons instead of words

`DONE` - 1 `FAQ/External` reset button is ‘show all’ or something that is not reset - ie not a button - perhaps a larger button below

`DONE` - 1 `External#index` card gap and connect border to surround

`DONE` - 1 FAQ ideally color blocking header, white background, black text, otherwise back to border, white background, black text

`DONE` - updated project description in English and the 2 Chinese, please update them

`DONE` - Project logos: could you please update the logos again because the SVG files didn't get the spacing right... so attached are the logo PNGs, hope you can use them with no problems

`DONE` - Possible to TAKE OUT "are you human/ verifications) for entering IDs? It takes too long and most participants may have hard for this

`DONE` - For the Resource tab - please use the following Chinese translation:
Lay Health Worker = `社區保健員` (trad CN) `社区保健员`
Statistics = `統計數據` (Trad CN)  `统计数据` (Simp)
Downloads = `下載`  (Trad Chinese) `下载` (Simp)

### 2-Week Sprint 9/22 - 10/6

`DONE`? 1 `/about#profiles` and `/resources#external` when rows of 2 are sharding (clearfix?)

`DONE` - 1 DOWNLOADs in en only - should download in all languages

`DONE` - 1 Downloads admin view

`DONE` - 1 Statistics migrate i18n links

`DONE` - 1 Replace logos on `/about`

### 1-week Sprint 9/15 - 9/22

`DONE` - 4 Review download preview - is it n+1 or local machine dependencies?

`DONE` - 1 `Resources#external` language becomes link to URL in that language

`DONE` - 1 External Hmong External link not saving (param?  Or field incorrect?)

`DONE` - 1 External Resources becomes Additional Resources title yml

`DONE` - 1 `Resources#external` include languages on Index cards

`DONE` - 1 Doublecheck FAQ twitter blue font on first load

`DONE` - 1 Statistics as as Model with i18n similar to External Resources (title, link name, link URL, category)

`DONE` - 1 `External#index` card top is solid with white font

`DONE` - 1 `External#index` card bottom contains en_notes

`DONE` - 1 `Messages#show` `.en_title` remove blank space

`DONE` - 1 FAQ anchors in vaccination category need to be white

`DONE` - 2 Resources tab fragment renames?  (`#fh5co-tab-feature-center1`)

`DONE` - 2 Change dark blue border to purple `#262463` (`Messages#show`)

`DONE` - 1 add link to statistics on admin page

`DONE` - 2 Align CAB members photos on `/about`

`DONE` - 2 Downloads sort by name order by category (fc/ph/tm/o)

`DONE` - 3 `Downloads#form` bootstrap for better UX

`DONE` - 4 Why do downloads only show the `en_file` version? Validate i18n languages for downloads ie not the correct form when switching languages

`DONE` - 2 Downloads get category color border (same as messages/faqs/resources) (participant handouts/flipcharts/training manuals/other)

`DONE` - 2 Admin page to create and show all resources

`DONE` - 4 `Resources#statistics` are links for referrals to external stat websites

### 1-week sprint 9/1 - 9/8

`DONE` - 1 `Messages#show` title first before image

`DONE` - 1 `Messages#show` add margins for RTF on mobile view

`DONE` - 1 Externals index be able to admin/edit

`DONE` - 1 For the main menu on Resources, put FAQ first, then LHW, then "Additional Resources"

`DONE` - 1 Logo and favicon to include full image- less text - square

`DONE` - 1 navbar `t(‘external resources’)` becomes `t(‘additional resources’)`

`DONE` - 2 Profiles - add new type “Lay Health Workers” and put between Research team and CAB members on /about

`DONE` - 2 Strip out twitter blue everywhere - send screenshots of different color variations with light and dark text to get votes

`DONE` - 2 `FAQs/Resources` set fixed categories (general, testing, vaccination, other)

`DONE` - 2 FAQs get category color border

`DONE` - 2 `Resources#external` gets category color border

`DONE` - 2 `Resources#external` order by name ASC

`DONE` - 2 `Resources#external` extend search to include category

`DONE` - 2 `Resources#external` sort and separate into sections by category

### 1-week sprint 8/25 - 9/1

`DONE` - Downloadable PDF files as Download model (this will be powerpoints and action survey after LHW sessions) - for each language? (yes)  Multiple PDFs or just a single? (single)

`DONE` - Downloads viewed as 1st page previews in rows of 2 or 3

`DONE` - External Resources remove ‘view’

`DONE` - Add Category column to Messages, FAQs, Externals to style Resources and FAQs have color-theme (requires DBmigration) to match message image color scheme / FAQ each background colored by category (as new scaffold with many_to_one relation?) or custom CSS elements

`DONE` - External Resources backdrop with card and topic color

`DONE` - External Resources sort by content(category), general first

### 2-week Sprint 8/11 - 8/23

`DONE` - Unhide `User#new_registration`

`DONE` - Assign interns to #admin

`DONE` - Make `Message#action_item` Rich Text

`DONE` - `Messages#new` (`vi_images.attach() if params[:vi_images].present?`)

### 1-week Sprint 8/4 - 8/11

`DONE` - `Message#external_links` to I18n and rich_text

`DONE` - Message -> for_more_info_please_visit delete

`DONE` - Shrink homepage logo and make mission statement denser

`DONE` - Resources navigate immediately to external resource

`DONE` - FAQ collapse filter and search into one accordion; change buttons to icons

`DONE` - Optimize image loading

`DONE` - Statistics becomes LayHealthWorkers -> tabs are Downloads /  LayHealthWorkers/Stats

### 1-week sprint 7/28 - 8/4

`DONE` - Refactor GA on every viewable page

`DONE` - `Messages#show` external_link font size larger and link larger

`DONE` - Callout as model with activeStrorage to use as carousel on `/about`
If missing text then fill image
If  text then small image
Archive toggle to bring in and out of carousel
Link toggle to prevent open in new window

`DONE` - `Message#show` en_content becomes rich_content

`DONE` - FAQ attribute tags as array / search by rich_text body

`DONE` - `Message#show` en_action_item same font as en_title but a little smaller

`DONE` - `Resources#external_resources` do not use cards but profiles

### 1-week sprint 7/22 - 7/28

`DONE` - Sort profiles by Janice first, then the rest in alphabetical by last name

`DONE` - Check FAQ admin edit permissions

### 1-week sprint 7/15 - 7/21

`DONE` - Add logo and favicon onto homepage

`DONE` - Add logo as small icon in corner (title?)

`DONE` - Profile views and integration onto /about / default to /en/ if translation not provided

`DONE` - Stretch goal - searchable FAQs

`DONE` - FAQ form make sure it’s i18n’d

`DONE` - FAQ index for catching i18n

`DONE` - Build out Resources#external view

`DONE` - I18n Resources#form

`DONE` - Build out Resources#show view

`DONE` - Searchable Resources

`DONE` - Make ‘like’ buttons bigger

### 1-week sprint 7/7 - 7/14

`DONE` - Fix row bug for Messages, Profiles, etc

`DONE` - Clickable Message#show links to include RCT ID on dynamically generated link to Redcap survey

`DONE` - FAQs as model (question, answer(s), links[], category[])

`DONE` - Add Message.survey_link field

`DONE` - Resources as dropdown to FAQ and External

`DONE` - Resources as model -  ‘individual’ becomes ‘external links’ and open link in new window

### 2-week sprint 6/26 - 7/6

`DONE` - Make admin new message form better by breaking it out into language tabs so each form replicates the message page view

`DONE` - Add ‘comment#delete’ button to admin

`DONE` - Remove ‘admin#join_the_study’ button

`DONE` - Figure out how to do multi-language images for messages

`DONE` - Additional fields: message content, action items, links to navigate away

`DONE` - Friendly_ID URLs

`DONE` - Profile add Profile.full_name migration for friendlyID slug

`DONE` - order by message_id, not updated_by

`DONE` - Profile add Profile.external_links[] migration

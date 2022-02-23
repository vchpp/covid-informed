https://github.com/vchpp/covid-informed

# TO DO:

### 1-week sprint 2/16-2/22

- [x] gate Callouts to admin for review

- [x] Add vi disclaimer translations

- [x] Add `certifiedDate` to HealthwiseArticles#Show - only on articles

- [x] Add additional language support for callout_links

- [x] Add english title on HealthwiseArticle#Index to card when a language isn't available ie acl4046

- `WON'T DO` How to prevent an article being saved as a topic?  Validation errors?  This causes the website to break due to accessing [] for nil object

- [ ] Investigate HealthwiseArticle#Index language order

- [ ] Healthwise#index has disclaimer/intro

- [ ] Healthwise#show has disclaimer/intro after article but before rich_text

- [ ] Add #refresh method and admin button to HealthwiseArticles to fetch from API instead of relying on #show?

- [ ] Stretch: Paginate Externals, Healthwise, FAQs

- [ ] Highlight or 'active' which page a visitor is on in the navbar


### Feedback from the CAB members:

- [x] Add a disclaimer on the footer of each page

- [x] Filter Messages by category like FAQs or Additional Resources

- [ ] Add search to Messages by adding a hidden field of tags

- [ ] Or Global Search?



### Stretch Goals:

- [ ] `IN PROGRESS` - Refactor Message.images to Message.en_images to reduce code on Messages#Index and Messages#Show

- [ ] Refactor 'External' model to 'Additional'

- [ ] Searching, Liking, Commenting, and Filtering all AJAX requests

- [ ] Super-admin priviledges to self-assign admins?

- [ ] Serve GA script from domain instead of 3rd party to prevent adblockers

- [ ] 1 FAQ all button hmong center text in button

- [ ] 2 Messages#show buttons larger from bootstrap source code

- [ ] 3 Messages#show make RTF font size larger for desktop view only

- [ ] 4 Profiles#show text should not wrap

- [ ] 4 Profiles on /about title/name/affiliation to make more dense

- [ ] https://coronavirus.jhu.edu/map.html Stats

- [ ] Share page links with social media (Facebook, twitter, email, copy link)

- [ ] Research: Puny-code URL

- [ ] Cookie compliance, ie GDPR?

### For Healthwise:

- [x] HealthWise as a resource

- [x] Put it on it’s own page under resources

- [x] Reach out to Marta to get Postman collection

- [x] Oauth to get an access token, token lives for 24 hours.  All subsequent calls use access token

- [x] Payload is loaded into <head> and <body> tags

- [x] Upvote and downvote, and comment individual items

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

### 1-week sprint 2/9-2/16

- [x] Lock down HWID and article_or_topic on edit form

- [x] Switch Hmong and VI on edit form

- [x] Add hmong disclaimer translations

- [x] Change Traditional language on HealthwiseArticle#Index to Simplified Chinese

- [x] Investigate Edit on Healthwise Topic breaking (9 things)

- [x] Add rich_text_form to HealthwiseArticle below content, but above likes - migrate

### 1-week sprint 2/2-2/8

- [x] Healthwise#index has language links like Externals to show what is available

- [x] Healthwise - create a model similar to Externals with healthwise materials embedded,

- [x] On creation of a HWA, have a placeholder for a language that isn't available and redirect to english

- [x] Transpose language box for HWA front end, perform I18n translations on backend for ease-of-use/consistency with Externals

- [x] HWA On expiry of a month, have all languages update, not just the one browsing - perform the check on which are custom

- [x] Add _create_form partial for HWA to prevent user errors on creation

- [x] Integrate with likes and comments

- [x] HWA forms

- [x] HWA frontend

- [x] Include links with language on card on index

- [x] Healthwise categories are: General, testing, vaccination, wellness

- [x] Healthwise model has navigation buttons at the bottom

### 1-week sprint 1/26 - 2/1

`WON'T DO` - PPT presentations displayed on webpage, image slideshow of PPT as fallback OR embed Youtube videos within the website

- [x] Healthwise - store json string payload in db and fetch every 7 days to keep up to date

- [x] Check on Callouts - make sure they show up above mission statement, clean up linkability and clean up form

- [x] Callouts - make only activestorage with link out to external/internal

- [x] disclaimer on footer

- [x] translations for Additional Resources Filter by County

- [x] translation for 'mission'

### 1-week sprint 1/12 - 1/18

- [x] Move /about to the /resources pattern convention

- [x] Automatically redirect root to /about/

- [x] Change 'mission' to 'about'

- [x] Change 'about' to 'mission statement'

- [x] /resources#tab1 (lay health workers) move to profiles for layhealth workers

- [x] break apart /resources/lay health workers / downloads / statistics onto their own pages, with content ie FAQs Statistics Downloads Additional

- [x] Messages filter by category

- [x] Additional resources filter by county shows which county in form when filtering by that county

`WON'T DO` - Audio files for stand-alone audio banner on homepage (new model)

`WON'T DO` - Audit logs diff on report?

### 1-week sprint 1/12 - 1/18

`WON'T DO` - Research stripping out HTML out of Messages CSV export

Google Analytics DataStudio to show direct traffic vs targeted traffic

- [x] Check Message friendlyID if it can be updated and remove Message.name from view

- [x] Move Research team partials to /about/_researchteam _LHW _Advisory board

- [x] check spelling for Community advisory board

### 1-week sprint 1/5 - 1/10

- [x] Audio files for the illiterate.  Messages!

- [x] Display audit log in /admin/audit-logs or be able to download audit log

`WON'T DO` - Can ActiveStorage URLs be shortened for adhoc sending

- [x] Make sure admin page forces locale

### 1-week sprint 12/22 - 1/4/22

- [x] Paginate Comments and show 10 most recent

- [x] Export Messages to CSV to include `created_at` and `updated_at` with all attributes

- [x] Additional Resources - preset filters (search terms) by County - either buttons or dropdown - show example of both

- [x] Find way to create access logs either via Logger to expose changes or additions for intervention messaging updates.

### 1-week sprint 12/15

- [x] Encode Chinese and Vietnamese characters need encoding pre-CSV export

- [x] Check CSV export dates for Comments and Votes to make sure they’re all correct

### 1-week sprint 11/12 - 11/18

- [x] Make sure RCT cookie visible in GA reports

- [x] Add archive bool for external resources/messages/profiles/anything else

- [x] Turn pink color into brown from logo

- [x] Surface RCT cookie ID as console log

- [x] Overwrite cookie priority to always use query string

- [x] Messages#back needs to be colored blue

### 2-week sprint 10/28 - 11/10

- [x] External Resources migrate Featured bool `default=false` to raise Featured items to the top (new collection on view)

- [x] Copy above onto Statistics

- [x] 1 LayHealthWorkers spacing audit

### 1-week sprint 10/20 - 10/28

- [x] 1 Translations for profile research titles

- [x] 1 hmong language is `‘lus hmoob’` for external resources - match `‘hmoob’` so it doesn’t break

- [x] 1 vietnamese mission statements on `/about`

- [x] 1 add translations for disclaimer at footer on `/about`

### 1-Week Sprint 10/13 - 10/20

- [x] 1 - for Message entering comments - the button text "CREATE comments" in Chinese - Zh_TW is: `輸入評論`  or   Simplified (Zh_CH):`输入评论`

- [x] 1 `External#index` languages should be separated by pipes FIX

- [x] 1 - move Resources (Downloads/LHW/Stats) to (LHW/Downloads/Stats)

- [x] 1 Increase font size on additional resources title cards when mobile view

- [x] 1 - please fix the "read more" button(s) - some shows black fonts and they are hard  to read

- [x] 1- placeholder body for Resources#layhealthworkers

- [x] 1 - add funders to homepage - must have links eventually

- [x] 1 - Add logos of funding organizations and 3 lines of words to the bottom of the `/about` page

### 1-Week Sprint 10/6 - 10/12

- [x] 1 Default back to old font

- [x] 1 Chinese homepage mission statement should not wrap, but instead force it to the second line
after the colon

- [x] 1 `FAQ/External` search button should be icons instead of words

- [x] 1 `FAQ/External` reset button is ‘show all’ or something that is not reset - ie not a button - perhaps a larger button below

- [x] 1 `External#index` card gap and connect border to surround

- [x] 1 FAQ ideally color blocking header, white background, black text, otherwise back to border, white background, black text

- [x] updated project description in English and the 2 Chinese, please update them

- [x] Project logos: could you please update the logos again because the SVG files didn't get the spacing right... so attached are the logo PNGs, hope you can use them with no problems

- [x] Possible to TAKE OUT "are you human/ verifications) for entering IDs? It takes too long and most participants may have hard for this

- [x] For the Resource tab - please use the following Chinese translation:
Lay Health Worker = `社區保健員` (trad CN) `社区保健员`
Statistics = `統計數據` (Trad CN)  `统计数据` (Simp)
Downloads = `下載`  (Trad Chinese) `下载` (Simp)

### 2-Week Sprint 9/22 - 10/6

- [x] 1 `/about#profiles` and `/resources#external` when rows of 2 are sharding (clearfix?)

- [x] 1 DOWNLOADs in en only - should download in all languages

- [x] 1 Downloads admin view

- [x] 1 Statistics migrate i18n links

- [x] 1 Replace logos on `/about`

### 1-week Sprint 9/15 - 9/22

- [x] 4 Review download preview - is it n+1 or local machine dependencies?

- [x] 1 `Resources#external` language becomes link to URL in that language

- [x] 1 External Hmong External link not saving (param?  Or field incorrect?)

- [x] 1 External Resources becomes Additional Resources title yml

- [x] 1 `Resources#external` include languages on Index cards

- [x] 1 Doublecheck FAQ twitter blue font on first load

- [x] 1 Statistics as as Model with i18n similar to External Resources (title, link name, link URL, category)

- [x] 1 `External#index` card top is solid with white font

- [x] 1 `External#index` card bottom contains en_notes

- [x] 1 `Messages#show` `.en_title` remove blank space

- [x] 1 FAQ anchors in vaccination category need to be white

- [x] 2 Resources tab fragment renames?  (`#fh5co-tab-feature-center1`)

- [x] 2 Change dark blue border to purple `#262463` (`Messages#show`)

- [x] 1 add link to statistics on admin page

- [x] 2 Align CAB members photos on `/about`

- [x] 2 Downloads sort by name order by category (fc/ph/tm/o)

- [x] 3 `Downloads#form` bootstrap for better UX

- [x] 4 Why do downloads only show the `en_file` version? Validate i18n languages for downloads ie not the correct form when switching languages

- [x] 2 Downloads get category color border (same as messages/faqs/resources) (participant handouts/flipcharts/training manuals/other)

- [x] 2 Admin page to create and show all resources

- [x] 4 `Resources#statistics` are links for referrals to external stat websites

### 1-week sprint 9/1 - 9/8

- [x] 1 `Messages#show` title first before image

- [x] 1 `Messages#show` add margins for RTF on mobile view

- [x] 1 Externals index be able to admin/edit

- [x] 1 For the main menu on Resources, put FAQ first, then LHW, then "Additional Resources"

- [x] 1 Logo and favicon to include full image- less text - square

- [x] 1 navbar `t(‘external resources’)` becomes `t(‘additional resources’)`

- [x] 2 Profiles - add new type “Lay Health Workers” and put between Research team and CAB members on /about

- [x] 2 Strip out twitter blue everywhere - send screenshots of different color variations with light and dark text to get votes

- [x] 2 `FAQs/Resources` set fixed categories (general, testing, vaccination, other)

- [x] 2 FAQs get category color border

- [x] 2 `Resources#external` gets category color border

- [x] 2 `Resources#external` order by name ASC

- [x] 2 `Resources#external` extend search to include category

- [x] 2 `Resources#external` sort and separate into sections by category

### 1-week sprint 8/25 - 9/1

- [x] Downloadable PDF files as Download model (this will be powerpoints and action survey after LHW sessions) - for each language? (yes)  Multiple PDFs or just a single? (single)

- [x] Downloads viewed as 1st page previews in rows of 2 or 3

- [x] External Resources remove ‘view’

- [x] Add Category column to Messages, FAQs, Externals to style Resources and FAQs have color-theme (requires DBmigration) to match message image color scheme / FAQ each background colored by category (as new scaffold with many_to_one relation?) or custom CSS elements

- [x] External Resources backdrop with card and topic color

- [x] External Resources sort by content(category), general first

### 2-week Sprint 8/11 - 8/23

- [x] Unhide `User#new_registration`

- [x] Assign interns to #admin

- [x] Make `Message#action_item` Rich Text

- [x] `Messages#new` (`vi_images.attach() if params[:vi_images].present?`)

### 1-week Sprint 8/4 - 8/11

- [x] `Message#external_links` to I18n and rich_text

- [x] Message -> for_more_info_please_visit delete

- [x] Shrink homepage logo and make mission statement denser

- [x] Resources navigate immediately to external resource

- [x] FAQ collapse filter and search into one accordion; change buttons to icons

- [x] Optimize image loading

- [x] Statistics becomes LayHealthWorkers -> tabs are Downloads /  LayHealthWorkers/Stats

### 1-week sprint 7/28 - 8/4

- [x] Refactor GA on every viewable page

- [x] `Messages#show` external_link font size larger and link larger

- [x] Callout as model with activeStrorage to use as carousel on `/about`
If missing text then fill image
If  text then small image
Archive toggle to bring in and out of carousel
Link toggle to prevent open in new window

- [x] `Message#show` en_content becomes rich_content

- [x] FAQ attribute tags as array / search by rich_text body

- [x] `Message#show` en_action_item same font as en_title but a little smaller

- [x] `Resources#external_resources` do not use cards but profiles

### 1-week sprint 7/22 - 7/28

- [x] Sort profiles by Janice first, then the rest in alphabetical by last name

- [x] Check FAQ admin edit permissions

### 1-week sprint 7/15 - 7/21

- [x] Add logo and favicon onto homepage

- [x] Add logo as small icon in corner (title?)

- [x] Profile views and integration onto /about / default to /en/ if translation not provided

- [x] Stretch goal - searchable FAQs

- [x] FAQ form make sure it’s i18n’d

- [x] FAQ index for catching i18n

- [x] Build out Resources#external view

- [x] I18n Resources#form

- [x] Build out Resources#show view

- [x] Searchable Resources

- [x] Make ‘like’ buttons bigger

### 1-week sprint 7/7 - 7/14

- [x] Fix row bug for Messages, Profiles, etc

- [x] Clickable Message#show links to include RCT ID on dynamically generated link to Redcap survey

- [x] FAQs as model (question, answer(s), links[], category[])

- [x] Add Message.survey_link field

- [x] Resources as dropdown to FAQ and External

- [x] Resources as model -  ‘individual’ becomes ‘external links’ and open link in new window

### 2-week sprint 6/26 - 7/6

- [x] Make admin new message form better by breaking it out into language tabs so each form replicates the message page view

- [x] Add ‘comment#delete’ button to admin

- [x] Remove ‘admin#join_the_study’ button

- [x] Figure out how to do multi-language images for messages

- [x] Additional fields: message content, action items, links to navigate away

- [x] Friendly_ID URLs

- [x] Profile add Profile.full_name migration for friendlyID slug

- [x] order by message_id, not updated_by

- [x] Profile add Profile.external_links[] migration

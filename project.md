##work flow
###config

* Safe
* Regeneration
* Local Server
* Local Server Port
* Base URL
* URL
* Site Destination
* Site Source
* Markdown
* Pyments
* Future
* LSI
* Permalink
* Exclude
* Include
* Limit Posts

###copy assets
###compile js
###compile css
###compile html

use jade

loyout

load config

load matter and data

readDir ./

	exclude dir
	include	dir
compiles:

* .css
* .js
* .jade


readDir _posts

compile posts

####Front Matter

* published
* categories
* tags


####Template Data

Global
***
	site
	page
	content
	paginator
	
Site
***
	site.time
	site.posts
	site.related_posts
	site.categories.CATEGORY
	site.tags.TAG
Page
***
	page.content
	page.title
	page.url
	page.date
	page.id
	page.categories
	page.tags
Paginator
***
	paginator.per_page
	paginator.posts
	paginator.total_posts
	paginator.total_pages
	paginator.page
	paginator.previous_page
	paginator.next_page


site/

post/

1. load config file save to Site object

2. copy include dir

3. load assets file js, css

4. compile and save assets file

5. load pages Pages array , page: object {published, layout, filename, content, title, url, date, id, categories, tags}

6. load posts Posts array , post: object {published, layout, filename, content, title, url, date, id, categories, tags}

7. summary Template Data Site.related_posts Site.categories Site.tags Site.Paginator: object {total_posts}

8. compile and save all html files 
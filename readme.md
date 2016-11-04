# Sitemap Generator
---

A simple Ruby / Sinatra powered web crawler & sitemap generator for a single given domain. The program crawls pages on the given domain but does not follow external links. It quickly validates the domain and returns to the search form if a ping fails.


### To run the program locally
---

Dependencies - [bundler](http://bundler.io/) to install gems, app tested using Ruby v2.2.0

1. `bundle install` to install gems
2. `rspec` to see current tests
3. `rackup` to run the app
4. visit `localhost:9292` in the browser to preview the app


### Testing - TDD
---

RSpec (unit tests) / Capybara (feature tests)
Travis CI

### Initial Design
---

* Strip url
* Ping url
* Crawl url pages
* Crawl url assets
* Print

I designed the app with a few key features - to *process the domain* (which would include validation and a status checker), to *crawl the pages* (to verify the number of pages on the site) and then to *crawl the assets for each page*. Finally, a *print* function would output the crawled information in the desired format.

I attempted to write the program with short, clear methods throughout. Whilst I broke the functionality into two areas - understanding the domain and crawling the domain respectively - I feel that the Crawl class in particular has grown far too big and with more time I would look at moving functionality out - some of the methods could well sit in the Domain class as they deal with stripping / adding prefixes and checking the validity of the domain before storing in the array.




### User Stories
---

```
As a User
So that I can crawl a given website
I want to submit a website for crawling
```
```
As a User
So that I know if I have made a mistake with the website address
I want to receive confirmation that the address works
```
```
As a User
So that I can discover what pages are on a given website
I want to see a sitemap of that website printed out on the page
```
```
As a User
So that I can analyse the performance and dependencies of a site
I want to see all static assets for each page
```
```
As a User
So I can see how long it will take to crawl the sitemap
I would like to see an estimate of how many pages are left to crawl
```


*Future User Stories*
```
As a User
So that I know if I have made a mistake with the website address
I want to see a screenshot of the website
```
```
As a User
So that I crawl the correct site
I want to be notified if the rel="canonical" tag points to another url
```
```
As a User
So that I crawl the correct site
I want to be notified if an HTTPS version of the site exists
```
```
As a User
So that I can see potential problems
I want to be notified if an HTTPS version of the site links to non-HTTPS assets
```
```
As a User
So that I can send information of the sitemap to others
I want to download a PDF of the sitemap
```
```
As a User
So that I can use the sitemap on a website
I want to download an XML version of the sitemap
```
```
As a User
So that I can see potential problems
I want to see which assets are dead links
```
```
As a User
So that I don't see duplicates
I want redirected pages to be removed from the sitemap
```
```
As a User
So that I can see potential problems
I want to see pages that are dead links (404)
```

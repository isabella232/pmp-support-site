# Using the PMP Searcher 

![support_searcher](https://cloud.githubusercontent.com/assets/4427754/11099100/5b401eb4-8877-11e5-8036-f75b78f8ba82.png)
 
The support site searcher (https://support.pmp.io/?advanced=1&profile=story&has=image) was created primarily as a tool for PMP development, but it is a handy tool that can be used by anyone to quickly find content in the PMP.

### Why use the Support Site Searcher? 
Though many of the CMS plugins have PMP search built in, it is often easier to use the support searcher to find what you’re looking for. The support searcher is:
* **Fast.** It's the quickest way to search for content in the PMP. 
* **Easy.** Once you get the hang of it, it’s easy to find the asset you’re looking for and pull it into the CMS you’re using. 
* **Powerful.** With the PMP searcher you can specify exactly what you’re looking for, making use of all of the metadata available to find what you need.

**Important!** *The searcher may have different content permissions than your PMP account, so assets you may find in the searcher may not be available to you.* Example: if your account does not have rights to content to PRI’s *The World*, you will not be able to add content from *The World* to your site even though you can find it in the support searcher.  

## Using the Searcher, Part 1: Text Searches

By default, the searcher returns stories that have an image. We’ll stick with that to perform our first searches. Let’s do a text search. First, enter “star wars” (without quotes) in the search box and hit search.

[It returns over 2,500 stories,](https://support.pmp.io/search?advanced=1&searchsort=date&text=star%20wars&profile=story&has=image) and the first one returned features *Star Trek*’s George Takei. Probably not what we’re looking for. Without quotes, it PMP searches for any occurrences of “star” or “wars” within story text, headlines, teasers and bylines. 

![star_wars_takei](https://cloud.githubusercontent.com/assets/4427754/11099099/5b3ea0ac-8877-11e5-888e-0a30b29f7fed.png)
<br /><br />

 If we put quotes around “star wars” we may be getting a little closer. The [109 stories returned](https://support.pmp.io/search?advanced=1&searchsort=date&text=%22star%20wars%22&profile=story&has=image) do have a mention of “Star Wars” in them. But they’re not really about *Star Wars*:

![star_wars_trump](https://cloud.githubusercontent.com/assets/4427754/11099098/5b3df530-8877-11e5-8912-7a64622d9a7d.png) 
<br /><br />
If we specify where in the stories we want the phrase “star wars” to appear, we may get what we’re after. A search for [`title:"Star Wars" OR teaser:"Star Wars"`](https://support.pmp.io/search?advanced=1&searchsort=date&text=title%3A%22Star%20Wars%22%20OR%20teaser%3A%22Star%20Wars%22%60%20&profile=story&has=image) returns results with photos of Stormtroopers in them. We’re in business: 

![star_wars_title_teaser](https://cloud.githubusercontent.com/assets/4427754/11099097/5b3d3b7c-8877-11e5-8f9e-54bf27051b92.png)
<br /><br />
 
And for fun, one more search before leaving this universe: [`teaser:"Star Trek" OR teaser:"Star Wars"`.](https://support.pmp.io/search?advanced=1&searchsort=date&text=%20teaser%3A%22Star%20Trek%22%20OR%20teaser%3A%22Star%20Wars%22%60&profile=story&has=image)

**So for text searches:**
* Searches story text, title, teaser and byline
* Use quotes for exact phrases
* Tell the PMP where to search (ex: title) to provide better results.
* Use AND or OR for searching for multiple phrases or to search multiple fields.

###Gettin’ GUID

Once you find the story (or asset) you’re looking for, you need to retrieve its GUID to be able to pull it into your CMS and use it in your site or app. A  GUID is a unique identifier that every document in the PMP has, not matter what it is (image, story, audio, etc.) Here’s the GUID of the top story above: [2d36795c-8cec-4545-84f0-bd20404b1f1b.](https://support.pmp.io/search?advanced=1&searchsort=date&guid=2d36795c-8cec-4545-84f0-bd20404b1f1b)
<br /><br />
Getting the GUID is pretty easy: click on the box in the lower right corner of the story’s search result and hit CTRL+C to copy:
![selecting_guid](https://cloud.githubusercontent.com/assets/4427754/11099093/5b359d18-8877-11e5-9846-d78dcadcc04d.png) 
<br /><br />
You can then take that GUID and put it in your CMS. Here’s how it’s done in Core Publisher:
![guid_in_pmp](https://cloud.githubusercontent.com/assets/4427754/11099092/5b33f90e-8877-11e5-8f3f-34a514f04d36.png)
<br /><br />
###Tweaking the Search Results

If you look at the top right of the search results, you’ll see that the default is to return the most recent results:

![results](https://cloud.githubusercontent.com/assets/4427754/11099096/5b37def2-8877-11e5-88b1-62ec72c6c1d2.png)
 <br /><br />
By clicking on one of the other options (Title and Most Relevant), you can reorder the search results in ways that may make more sense. While Most Recent is probably best when searching for a recent news story, ordering results by Title may be better when searching for collections like Properties and Series. Ordering by Most Relevant may be useful when a search yields many results. 

##Using the Searcher, Part 2: Checkboxes 

To get the most out of the support searcher it helps to have a basic understanding of some of the building blocks of the PMP, because those blocks are what the checkboxes on the searcher are. The [PMP terminology guide](https://support.pmp.io/guides#pmp-terminology) explains it all, but below is a quick summary of the ones you need to know.

Note that you need to click the ‘more’ link in the searcher’s Type box to see all of the options listed below. Also know that because of the flexibility built into the PMP, not all content is organized the same. Some content providers make use of Series, for example, while others do not. See a couple of hypothetical ways content in the PMP can be organized [here.](https://support.pmp.io/guides#data-organization)

Here are definitions of some of the less obvious checkboxes/form fields:

**Property**: If the structure of content in the PMP were depicted as a pyramid, Properties would be on top. They are often equivalent to a broadcast program (examples: *The Moth*, *PRI’s The World*), but in some cases they are more akin to a brand (example: Marketplace, which includes all incarnations of Marketplace programming such as *Marketplace*, *Marketplace Morning Report*, etc.). This search by the [GUID of *The Moth* Property](https://support.pmp.io/search?advanced=1&collection=9a5e5095-c9a5-44cc-9788-4093d6390c7e) will return all Stories and items associated with that Property. A similar search using the [Marketplace Property GUID](https://support.pmp.io/search?advanced=1&collection=3e3b6243-31c6-4686-bb88-a8e8446f0c2a) will likewise return all Stories and items associated with that Property, which includes all programs under the Marketplace umbrella.

**Series**: A Collection of related Stories. As opposed to Properties, Series are more loosely defined. In some cases, they may correspond to a broadcast program, but also could be used to collect Episodes of a program or a selection of Stories from multiple Episodes of a program. Examples: [*Marketplace Morning Report*](https://support.pmp.io/search?advanced=1&collection=a9ce9da3-5798-4e99-90ce-43980df38e85), *State of the Re:Union Fall 2013*, *American Routes*, or [MPR News' “On Campus” series.](https://support.pmp.io/search?advanced=1&collection=a5eb210c-1256-4f1a-b597-7c1467a2c846&profile=story) 

**Episode**: An ordered list of stories that are usually the equivalent to a broadcast episode. Example: [*Marketplace Morning Report* for June 8, 2015.](https://support.pmp.io/search?advanced=1&collection=6ec0c8d8-78e1-4004-86ef-4bd5db60c7ed)

**Topics**: The PMP currently has twelve defined Topics for classifying PMP Stories and Episodes by subject matter. Examples: [sports,](https://support.pmp.io/search?advanced=1&searchsort=date&collection=44ed7afc-0dd7-4aa1-8c88-34e74dc0d36b&profile=story) [technology.](https://support.pmp.io/search?advanced=1&collection=3f829119-5310-43b9-acc5-0f36a51aae42&profile=story) Stories and Episodes can be assigned to multiple topics. Topics allow for retrieval of content by similar subject from multiple producers. Here’s the [complete list of topics.](https://support.pmp.io/docs#best-practices-collection-links)

**Tags**: Like Topics, but free-form. Producers can add whatever tags they’d like to an asset. Like many things in the PMP, not everyone uses tags. There are many more [stories in the money topic](https://support.pmp.io/search?advanced=1&searchsort=date&collection=4d0acb4c-7057-4771-987d-97fc21ad0bcc&profile=story) than there are [stories *tagged* with “money.”](https://support.pmp.io/search?advanced=1&searchsort=date&tag=money&profile=story)

**Contributors**: The person largely responsible for a Story – equivalent to a byline. Allows for the return of all Stories credited to an individual. Stories can have multiple Contributors. Example: all Stories in the PMP by [Kai Ryssdal.](https://support.pmp.io/search?advanced=1&collection=ffdef6fe-a061-4f1c-8fd3-a0b688727f36&profile=story)


*Great, so how do I use this? How do I know if something is organized in the PMP as a Series or as a Property?* 

Though Series, Properties and Contributors and other documents can be used to help searching, you can also use the PMP to find these things themselves.
* [Properties](https://support.pmp.io/search?advanced=1&searchsort=date&profile=property) in the PMP
*	[Series](https://support.pmp.io/search?advanced=1&searchsort=date&profile=series) in the PMP
*	[Contributors](https://support.pmp.io/search?advanced=1&searchsort=date&profile=contributor) in the PMP

To do searches like this, make sure that only the thing you’re looking for specifically is checked and hit the search button.   

Here’s what the Contributors search setup looks like, and the top result:
 ![contributor_search](https://cloud.githubusercontent.com/assets/4427754/11099091/5b327c64-8877-11e5-9188-0c2f2943c7d7.png)
<br /><br /> 
Notice that in the lower right corner where you copy the GUID from, it says “Collect.” This means that the GUID is a collection rather than a single document GUID. I can copy that GUID back into search to retrieve all of Melanie’s stories in the PMP. I can also click on “Collect” and the PMP will automatically run a search for that Collection:
![contributer_search_results](https://cloud.githubusercontent.com/assets/4427754/11099095/5b379708-8877-11e5-993a-b869b29c671c.png) 
 <br /><br />
Similarly, if I know the GUID of a particular Property, I can use it to find everything associated with that Property. Here’s a search for *The Takeaway* Property:
![takeaway_property](https://cloud.githubusercontent.com/assets/4427754/11099102/5b43a71e-8877-11e5-968d-d3b6e5ed56ed.png) 
<br /><br />
##Bringing it All Together – Search Combos
Of course these different ways to use the PMP searcher can be combined. Here’s a search for [stories published from *The World* in the last two years with audio and with “religion” in the teaser:](https://support.pmp.io/search?advanced=1&searchsort=date&text=teaser%3Areligion&collection=4d3a942d-91c0-46a5-86df-9338f88c8487&startdate=2014-11-11&enddate=2016-11-11&profile=story&has=audio)
![world_audio_religion](https://cloud.githubusercontent.com/assets/4427754/11099101/5b43152e-8877-11e5-8bd4-d54026a814d0.png) 
<br /><br />
##Advanced – Searching Using Multiple Collections
You can query with multiple collections by putting them all in the collections box. Separating GUIDs with a semicolon is “OR,” and with a comma is “AND.” The PMP also automatically converts Topics into their GUID, so a search for [*Marketplace* stories within the Topic money](https://support.pmp.io/search?advanced=1&searchsort=date&collection=3e3b6243-31c6-4686-bb88-a8e8446f0c2a%2CMusic&profile=story) looks like the following:
![marketplace_music](https://cloud.githubusercontent.com/assets/4427754/11099094/5b367ff8-8877-11e5-8b54-4112bf66c22f.png)
<br /><br />
##And That's a Wrap!

Using the techniques detailed above, you too can become a Support Searcher Pro. You'll find what you're looking for quickly. It looks like a lot, but after you've used it a few times, it will click and become intuitive. If something isn't clicking or doesn't make sense, drop us a line to me, Jeff Nemic ([jeff@publicmediaplatform.org](mailto:jeff@publicmediaplatform.org)) or to [support@publicmediaplatform.org](mailto:support@publicmediaplatform.org) and we'll be happy to help you out!
 




 
 




# PMP Terminology

A guide to some of the terminology you may encounter while using the PMP. This is a guide primarily geared toward users of the PMP who either put content into the PMP or pull it out rather than developers. More technical information on many of these terms is available in the [developer documentation](https://support.pmp.io/docs).   

Note that the PMP is <i>extremely</i> flexible, which is a big part of what makes it so great. But that also means that not every content producer will structure their content in the same way. Some producers may use tags for their content, for example, while others may not. 

Also, be aware that <i>every</i> piece of data in the PMP is referred to as a document. And finally, the PMP doesn’t store any binary files. Photos, audio files and video files are all stored elsewhere – the PMP points to the URLs where those assets are stored. 

Okay, on with the list! (It's not listed alphabetically because many PMP terms require an understanding of other PMP terms to make sense.)
<br /><br />

<b>GUID</b>: A globally unique identifier. In PMP usage, GUIDs can be used to identify an individual story, a series, a property, or a topic. Examples: the GUID for <i>PRI’s The World</i> is 4d3a942d-91c0-46a5-86df-9338f88c8487. The GUID for the NPR story [“Yoink! Dad Nabs Foul Ball While Holding Baby At Cubs Game”](http://www.npr.org/sections/thetwo-way/2015/06/24/417116256/yoink-dad-nabs-foul-ball-while-holding-baby-at-cubs-game?ft=nprml&f=417116256) is 57769e4d-6449-4131-b581-fde4c53cb92c.

<b>Story</b>: The vast majority of the time, stories are what most people will be concerned with when pushing and pulling from the PMP. Stories pull together all of the various elements into a self-contained whole. Stories can include: text, teasers, images, video, and other organizing information (the program the story came from, who created the story, etc.)

<b>Image</b>: pretty self-explanatory, though in the PMP producers can provide links to images in several different crops so the image looks good wherever it appears. All images in the PMP require at minimum a human-readable title, a source URL, and the type of image needs to be defined. Captions and credits are also recommended.  

<b>Audio</b>: Ryan to define?

<b>Video</b>: Ryan to define?
<br /><br />
<b>Collections:</b><br />
Here are some ways related stories are commonly grouped together in the PMP. As opposed to a text search, searching by one of these PMP collections will return only items specifically assigned to the GUID of the collection you searched for. 

1. <b>Property</b>: If the structure of content in the PMP is depicted as a pyramid, Properties are on top. They are often the equivalent to an on-air program (examples: <em>The Moth</em>, <em>PRI's The World</em>), but in some cases they are more akin to a brand (example: Marketplace, which includes all incarnations of Marketplace programming such as <em>Marketplace</em>, <em>Marketplace Morning Report</em>, etc.). A search by the [GUID of <em>The Moth</em> property](https://support.pmp.io/search?advanced=1&collection=9a5e5095-c9a5-44cc-9788-4093d6390c7e) will return all stories and items associated with that property. A similar search using the [Marketplace property GUID](https://support.pmp.io/search?advanced=1&collection=3e3b6243-31c6-4686-bb88-a8e8446f0c2a) will likewise return all stories and items associated with that property, which includes all programs under the Marketplace umbrella.

2. <b>Series</b>: A collection of related stories. As opposed to properties, series are more loosely defined. In some cases, may correspond to an on-air program, but also could be used to collect episodes of a program or a selection of stories from multiple episodes of a program. Examples: [<em>Marketplace Morning Report</em>](https://support.pmp.io/search?advanced=1&collection=a9ce9da3-5798-4e99-90ce-43980df38e85), <em>State of the Re:Union</em> Fall 2013 Series, <em>American Routes</em>, or [MPR News’ “On Campus” series](https://support.pmp.io/search?advanced=1&collection=a5eb210c-1256-4f1a-b597-7c1467a2c846&profile=story). The occasional <em>Morning Edition</em> on-air series [“Crime in the City,”](http://www.npr.org/series/13795507/crime-in-the-city) could also have been collected in the PMP as a series. 

3. <b>Episode</b>: An ordered list of stories that are usually the equivalent to a broadcast episode. Example: [<em>Marketplace Morning Report</em> for June 8, 2015](https://support.pmp.io/search?advanced=1&collection=6ec0c8d8-78e1-4004-86ef-4bd5db60c7ed). 

4. <b>Topic</b>: The PMP has twelve defined topics ([money](https://support.pmp.io/search?advanced=1&collection=4d0acb4c-7057-4771-987d-97fc21ad0bcc&profile=story), [technology](https://support.pmp.io/search?advanced=1&collection=3f829119-5310-43b9-acc5-0f36a51aae42&profile=story), etc.) that stories and episodes can be assigned to. Topics allow for retrieval of content by similar subject from multiple producers. Here’s the complete [list of topics](https://support.pmp.io/docs#best-practices-collection-links).

5. <b>Contributor</b>: The person largely responsible for a story -- equivalent to a byline. Allows for the return of all stories credited to an individual. Stories can have multiple contributors. Example: all the stories in the PMP by [Kai Ryssdal](https://support.pmp.io/search?advanced=1&collection=ffdef6fe-a061-4f1c-8fd3-a0b688727f36&profile=story).
<br />


<b>Tags</b>: Free-form attributes of an item in the PMP. They are human readable, and describe the content itself -- not metadata about the content. Content creators can assign any tags that they’d like for their content. Examples: stories tagged with [“movie,”](https://support.pmp.io/search?advanced=1&tag=Movie&profile=story) and stories tagged with [“money.”](https://support.pmp.io/search?advanced=1&tag=Money&profile=story) Sadly, there are no stories currently tagged with his majesty [Buck Showalter](https://support.pmp.io/search?advanced=1&tag=Buck%20Showalter&profile=story).
<br/><br />
<b>The Wide World of Permissions</b><br />
By default, any story/image/audio/etc. in the PMP is public.  But permissions can be optionally assigned to any document, restricting read access to a list of Groups. Remember that any data in the PMP is a document, so permissions can be assigned to a property, an individual story, or even a photo in a story or a story’s audio. Any User in any of those Groups will be able to see/read the doc. Example: PRI created a Group for <em>PRI’s The World</em>, and to that Group they added Users which are stations corresponding to their broadcast carriage list. Any content from <em>The World</em> that is published to the PMP is available to those Users and only those Users.


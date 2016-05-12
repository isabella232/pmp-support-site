# PMP Terminology

*A guide to some terminology you may encounter while using the PMP.*

This is a guide primarily geared toward users of the PMP rather than developers. More technical information on many of these terms is available in the [developer documentation](https://support.pmp.io/docs).

Note that the PMP is extremely flexible, which is one of its strengths, but that also means that not every content producer will structure their content in the same way. Some producers may use tags for their content, for example, while others may not.

## Documents

**Every** piece of data in the PMP is referred to as a Document. These are generally broken down into the smallest possible components. A piece of audio is a Document. An image is a Document. The HTML providing the context for those images and audio is a Document.

Documents contain text attributes and links to other resources on the internet. Documents **do not** store any binary media assets -- photos, audio and video files are all stored elsewhere. The PMP Documents simply point to the URLs where those assets are stored.

## GUIDs

Documents are identified via a **GUID** (a globally unique identifier). The GUID for [PRI's *The World*](https://support.pmp.io/search?text=guid%3A4d3a942d-91c0-46a5-86df-9338f88c8487) programs is `4d3a942d-91c0-46a5-86df-9338f88c8487`. The GUID for the NPR story ["Yoink! Dad Nabs Foul Ball While Holding Baby At Cubs Game"](http://www.npr.org/sections/thetwo-way/2015/06/24/417116256/yoink-dad-nabs-foul-ball-while-holding-baby-at-cubs-game?ft=nprml&f=417116256) is `57769e4d-6449-4131-b581-fde4c53cb92c`.

You'll often need to find the GUID for a Document in order to use it in your application. The [PMP Support Searcher](https://support.pmp.io/) provides an easy way to find and copy a GUID -- just hover over the numbers/letters in the lower-right corner of any search result.

![select_guid](https://cloud.githubusercontent.com/assets/4427754/8620782/ea07852c-26ef-11e5-8b8e-3b1368552469.png)

## Profiles

Documents come in various flavors or "Profile Types." This allows consumers and producers to differentiate between textual, media, and organizational content. In other words, the PMP metadata around an audio clip will look quite different than the metadata around journalistic series. Profiles give consumers the flexibility to search for and segment PMP content in interesting ways.

Here is a list of some common Document Profile types, what they contain, and how they relate to each other:

### Stories

A Story Document glues together all of the various media/text elements into a self-contained whole. The vast majority of the time, Stories are what people will be concerned with when pushing and pulling from the PMP. Stories can include: text, teasers, Audio, Images, Video, and other organizing information (the program the Story came from, who created the Story, etc.)

### Images

An Image Document represents a single picture, including multiple crops of that image. All images in the PMP require at minimum a human-readable title, a source URL, and at least one crop of the image. Captions and credits are also recommended.

### Audio

Audio Documents are used to represent a certain chunk of audio. They can include multiple file-types/quality of files (mp3, ogg, m3u, etc), and optionally an embeddable player for the audio stream. A human-readable title for the Audio is required, and captions and credits are recommended.

### Video

Unlike other media, Video Documents often don't include a link to a binary source file (like a jpg or mp3 file). Instead, they include an embeddable-player that a PMP consumer can use to play that video from their web or mobile app. Multiple video qualities/resolutions are recommended to support mobile platforms. A human-readable title is required, and captions and credits are recommended.

## Collections

We use the term Collection to refer to the relationship between Documents in the PMP. And (you'll want to remember this one) **every** Document in the PMP is a potential Collection of other Documents. A Story like ["How do you explain the leap second to a 6-year-old?"](https://support.pmp.io/search?advanced=1&guid=fb5ef942-1e1e-4ef0-a188-e188c1ad199f) is a Collection of Audio and Images. A Series like [*State of the Re:Union* Fall 2010 Season](https://support.pmp.io/search?advanced=1&guid=fc55819c-cddc-4b1a-adf8-590b78150cdf) is a Collection of Stories produced during that 2010 season. And a Topic like [Money](https://support.pmp.io/search?advanced=1&guid=4d0acb4c-7057-4771-987d-97fc21ad0bcc) is a Collection of Stories related to finances and banking.

As opposed to a text search, searching by one of these PMP Collections will return only Documents specifically assigned to the GUID of that Collection.

The five primary Collections used in the PMP are:

### Properties

If the structure of content in the PMP is depicted as a pyramid, Properties are on top. They are often the equivalent to a broadcast program (examples: *The Moth*, *PRI's The World*), but in some cases they are more akin to a brand (example: *Marketplace*, which includes all incarnations of Marketplace programming such as *Marketplace*, *Marketplace Morning Report*, etc.).  A search by the [GUID of *The Moth* Property](https://support.pmp.io/search?advanced=1&collection=9a5e5095-c9a5-44cc-9788-4093d6390c7e) will return all Stories and items associated with that Property. A similar search using the [Marketplace Property GUID](https://support.pmp.io/search?advanced=1&collection=3e3b6243-31c6-4686-bb88-a8e8446f0c2a) will likewise return all Stories and items associated with that Property, which includes all programs under the Marketplace umbrella.

### Series

A Collection of related Stories. As opposed to Properties, Series are more loosely defined. In some cases, they may correspond to a broadcast program, but also could be used to collect Episodes of a program or a selection of Stories from multiple Episodes of a program. Examples: [*Marketplace Morning Report*](https://support.pmp.io/search?advanced=1&collection=a9ce9da3-5798-4e99-90ce-43980df38e85), *State of the Re:Union* Fall 2013 Series, *American Routes*, or [MPR News' "On Campus" series](https://support.pmp.io/search?advanced=1&collection=a5eb210c-1256-4f1a-b597-7c1467a2c846&profile=story).  The occasional *Morning Edition* on-air series ["Crime in the City"](http://www.npr.org/series/13795507/crime-in-the-city) could also have been collected in the PMP as a Series.

### Episode

An ordered list of stories that are usually the equivalent to a broadcast episode. Example: [*Marketplace Morning Report* for June 8, 2015](https://support.pmp.io/search?advanced=1&collection=6ec0c8d8-78e1-4004-86ef-4bd5db60c7ed).

### Topics

The PMP currently has twelve defined Topics for classifying PMP Stories and Episodes by subject matter. Examples: [money](https://support.pmp.io/search?advanced=1&collection=4d0acb4c-7057-4771-987d-97fc21ad0bcc&profile=story), [technology](https://support.pmp.io/search?advanced=1&collection=3f829119-5310-43b9-acc5-0f36a51aae42&profile=story). Stories and Episodes can be assigned to multiple topics. Topics allow for retrieval of content by similar subject from multiple producers. Here's the complete [list of topics](https://support.pmp.io/docs#best-practices-collection-links).

### Contributors

The person largely responsible for a Story -- equivalent to a byline. Allows for the return of all Stories credited to an individual. Stories can have multiple Contributors. Example: all the Stories in the PMP by [Kai Ryssdal](https://support.pmp.io/search?advanced=1&collection=ffdef6fe-a061-4f1c-8fd3-a0b688727f36&profile=story).

## Tags

Free-form attributes of a Document in the PMP. They are human readable, and describe the Document itself -- not metadata about the Document. Content creators can assign any tags that they'd like for their content. Examples: Stories tagged with ["movie"](https://support.pmp.io/search?advanced=1&tag=Movie&profile=story) and Stories tagged with ["money"](https://support.pmp.io/search?advanced=1&tag=Money&profile=story). Sadly, there are no Stories currently tagged with his majesty [Buck Showalter](https://support.pmp.io/search?advanced=1&tag=Buck%20Showalter&profile=story).

## Permissions

By default, any Document (Story/Image/Audio/etc.) in the PMP is public. But permissions can be optionally assigned to any Document, restricting read access to a list of Groups.

Remember that any data in the PMP is a document, so permissions can be assigned to a Property, an individual Story, or even a photo within a Story or a Story’s Audio. Any User in any of those Groups will be able to see/read the doc.

Example: PRI created a Group for *PRI's The World*, and to that Group they added Users which are stations corresponding to their broadcast carriage list.  Any content from *The World* that is published to the PMP is available to those Users and only those Users.

And here's a diagram illustrating how permissions can be set in the PMP. Each of the different organizations can be set to have access to different documents:
![how_do_permissions_work](https://cloud.githubusercontent.com/assets/4427754/9914554/650e085c-5c80-11e5-99d7-12410230c747.jpg)

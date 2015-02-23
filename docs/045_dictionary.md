# Dictionary

To help interpret PMP documents, here is a list of some of the common PMP profiles and how they are used.  Keep in mind that all these attributes/links are *in addition to* those defined by the [Collection.doc+JSON standard](#collection-docjson).

## Story

The Story profile is the glue of the PMP!

 * Typically the lead document type to which media assets (images/audio/video) are attached
 * Provides context for those `links.item` assets
 * Organizes itself into collections (topics/series/properties)
 * Identify authors and contributors to the story
 * Use tags to get all Stories for a certain collaboration or event

It is not required to use Story documents, but it is highly suggested to use a Story or a sub-type of a Story when creating a complex document (e.g. one with child assets, such as media docs).

### Story Attributes

Key                 | Value
------------------- | ------------------
`title`             | A human-meaningful title for this story <span class="badge badge-red">required</span>
`byline`            | [Rendered byline](#best-practices-bylines) as suggested by document distributor
`description`       | [Content of this document](#best-practices-story-content) without HTML <span class="badge badge-orange">co-required</span>
`contentencoded`    | [Content](#best-practices-story-content) which can be used literally as HTML-encoded content <span class="badge badge-orange">co-required</span>
`contenttemplated`  | [Content](#best-practices-story-content) which has placeholders for rich-media assets <span class="badge badge-orange">co-required</span>
`teaser`            | A short description, appropriate for showing in small spaces
`tags[]`            | An array of [human-meaningful tags](#best-practices-tags-and-itags) for this story

### Story Links

<div class="alert alert-warning"><b>REMEMBER:</b> as a convenience, any "links.item" set on a doc will automagically be loaded into the top-level `items` array when you fetch that document.</div>

relType      | Key      | Value
------------ | -------- | -----------------------
`item`       | `href`   | Media documents (audio/image/video) associated with this story
             | `rels[]` | Array of [relationship types for this item](#best-practices-item-links)
`collection` | `href`   | Collections (often properties, series, topics) this story is a member of
             | `rels[]` | Array of [relationship types for this collection](#best-practices-collection-links)
`author`     | `href`   | Docs (often contributors, users, organizations) that represent the authors of this story
`alternate`  | `href`   | The url for a web page showing this story on the publisher or producer's site
             | `type`   | Should be `text/html` (since link is not a doc)
`copyright`  | `href`   | The url for a web page showing the copyright terms for this story
             | `type`   | Should be `text/html` (since link is not a doc)
             | `title`  | Text to be displayed for the copyright link

## Episode

An Episode is a sub-type of a Story that indicates the doc is the full episode of a series, general as it might have been produced for broadcast, which will often have within it multiple segments which could be considered stories themselves.

### Episode Links

relType      | Key      | Value
------------ | -------- | -----------------------
`item`       | `href`   | Ordered set of Story documents that make up this episode
             | `rels[]` | Array of [relationship types for this item](#best-practices-item-links)

## Image

The Image profile is used to represent a distinct image with multiple crops.  Each crop (a binary file) is represented by an `enclosure` link, which can be identified either by its `meta.crop` or `meta.height` and `meta.width`.

### Image Attributes

Key                 | Value
------------------- | ------------------
`title`             | Alt: human-meaningful alternate text for the image <span class="badge badge-red">required</span>
`byline`            | Credit: a [rendered byline](#best-practices-bylines) for the image
`description`       | Caption: additional text that explains and/or complements the image

### Image Links

relType      | Key               | Value
------------ | ----------------- | -----------------------
`enclosure`  | `href`            | Url for the binary image file <span class="badge badge-red">required</span>
             | `type`            | The MIME-type of the image file <span class="badge badge-red">required</span>
             | `meta.crop`       | The [semantic crop identifier](#best-practices-image-crops) for this file
             | `meta.height`     | Height in pixels
             | `meta.width`      | Width in pixels
             | `meta.resolution` | Resolution in pixels per inch (ppi)
`copyright`  | `href`            | The url for a web page showing the copyright terms for this image
             | `type`            | Should be `text/html` (since link is not a doc)
             | `title`           | Text to be displayed for the copyright link

## Audio

The Audio profile is used to represent multiple sources/qualities/bitrates of a piece of audio.  These are each encapsulated in their own `enclosure` link, which clients can iterate over to find the one they'd like to use.

### Audio Attributes

Key                 | Value
------------------- | ------------------
`title`             | Alt: human-meaningful alternate text for the audio <span class="badge badge-red">required</span>
`byline`            | Credit: a [rendered byline](#best-practices-bylines) for the audio
`description`       | Caption: additional text that explains and/or complements the audio

### Audio Links

relType      | Key               | Value
------------ | ----------------- | -----------------------
`enclosure`  | `href`            | Url for the binary audio file <span class="badge badge-red">required</span>
             | `type`            | The MIME-type of the audio file <span class="badge badge-red">required</span>
             | `meta.codec`      | Audio codec
             | `meta.format`     | Audio format
             | `meta.duration`   | Audio duration in seconds
`copyright`  | `href`            | The url for a web page showing the copyright terms for this audio
             | `type`            | Should be `text/html` (since link is not a doc)
             | `title`           | Text to be displayed for the copyright link

## Video

The Video profile represents multiple formats/sources of a video.  Each of which should get its own enclosure.

Unlike Images or Audio, it is common for a Video to lack any public link to the original binary file.  This is addressed via [Embeddable Media](#best-practices-embedded-media), a practice which is still evolving.  So stay tuned!

### Video Attributes

Key                 | Value
------------------- | ------------------
`title`             | Alt: human-meaningful alternate text for the video <span class="badge badge-red">required</span>
`byline`            | Credit: a [rendered byline](#best-practices-bylines) for the video
`description`       | Caption: additional text that explains and/or complements the video

### Video Links

relType      | Key               | Value
------------ | ----------------- | -----------------------
`enclosure`  | `href`            | Url for the binary video file <span class="badge badge-red">required</span>
             | `type`            | The MIME-type of the video file <span class="badge badge-red">required</span>
             | `meta.codec`      | Video codec
             | `meta.format`     | Video format
             | `meta.duration`   | Video duration in seconds
`copyright`  | `href`            | The url for a web page showing the copyright terms for this audio
             | `type`            | Should be `text/html` (since link is not a doc)
             | `title`           | Text to be displayed for the copyright link

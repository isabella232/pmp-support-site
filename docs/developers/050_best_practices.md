# Best Practices

Publishers to the PMP are encouraged to follow best practices for how they structure and persist their content.

If a publisher uses idiosyncratic fields, attributes, or profiles, the documents may be very useful to them, but will be less useful (or even discoverable) to consumers attempting to use content from across the PMP.  Below are a set of documented best practices to encourage publishers to post content to the PMP in a standard, useful way that will be consistent with the majority of PMP published content.

## Standard Profiles

The PMP is flexible. It allows a publisher to create their own content profiles and schemas, so that almost any kind of content document could be published.  However, clients of the PMP will find it difficult to discover, display or otherwise use content that does not use or extend the basic content types.

Before creating a new Profile, examine [the existing ones](#profiles-and-schemas-hierarchy) in common use, and see if they can be used.  If not, refer to the [Base Content Profile](https://api.pmp.io/profile/base), and try to extend it for your use case.

Using or extending a standard profile will also help with discoverability via search.  When searching by document profile, the PMP returns not only the documents for that exact profile, but also documents where the profile is extended from that profile.

Use the media types for [images](#dictionary-image), [audio](#dictionary-audio) and [video](#dictionary-video).

Use a [story document](#dictionary-story) to pull together multiple documents and as a default lead document type.

## GUIDs

The PMP API will not save a document without a pre-defined GUID (globally unique document identifier). Each publisher is responsible for generating a properly formatted GUID for a document before saving it to the PMP.

For globally unique document identifiers PMP uses [UUID version 4 identifiers](http://en.wikipedia.org/wiki/Universally_unique_identifier#Version_4_.28random.29) based on [RFC 4122](http://www.ietf.org/rfc/rfc4122.txt), represented as 32 hexadecimal digits with optional dashes after the 8th, 12th, 16th, and 20th digits.

The PMP accepts GUIDs with or without dashes; it normalizes them before validation.

## Bylines

Bylines for documents should be rendered as follows:

1. Single author

    `Firstname [Middlename/Initial] Lastname`

2. Two authors (separated by "and")

    `Firstname Lastname and Someone T Else`

3. Three or more authors (commas and "and" - no [Oxford comma](http://en.wikipedia.org/wiki/Serial_comma))

    `Firstname Mid Lastname, Person One, Someone Else and Finally T Last`

Do **NOT** add a prefix (such as "By") to the byline field.  The logic being that it is far easier to prepend a prefix, rather than remove one.

## Tags and Itags

PMP documents may have two separate sets of free-form tag attributes.

Name                 | Description
-------------------- | ---------------------
`attributes.tags[]`  | An array of human-readable tags or keywords associated with the document
`attributes.itags[]` | An array of internal tags for use by the publisher - often used for external identifiers, publisher-specific labeling systems, etc.

Consider carefully whether or not the tag you are creating is for internal reference (`itags`) or public discoverability (`tags`).

## Story Content

When creating Story documents, set at least one "content" field.  This will be searched by default when using the `?text=foobar` query parameter.

Name               | Description
------------------ | ---------------------
`description`      | Text only version
`contentencoded`   | HTML version, with media assets optionally encoded into the body.
`contenttemplated` | Structured to have related asset docs embedded into the template ([format TBD](https://discuss.pmp.io/t/conventions-around-contenttemplated/67)).

## Item Links

When a document "contains" other documents, you should use `links.item` in the parent doc to claim (and optionally order) the children.

The most common use case for this is in Story docs, when they "contain" associated image/audio/video media.  In this case, you should also set a `rels` key on each `links.item`, to indicate to consumers what type of child item each is.  This example illustrates common/known rels for Story items:

```javascript
itemLink.href = "https://api.pmp.io/docs/<MEDIA_GUID>";
itemLink.rels = ["urn:collectiondoc:image"]; // if href has profile=image
itemLink.rels = ["urn:collectiondoc:audio"]; // ... or audio
itemLink.rels = ["urn:collectiondoc:video"]; // ... or video

// or maybe this is an episode with multiple story-items
itemLink.href = "https://api.pmp.io/docs/<STORY_1_GUID>";
itemLink.rels = ["urn:collectiondoc:story"];
```

## Collection Links

When a document "belongs to" a collection of docs (often described as a parent/child documents), use `links.collection` to indicate that relationship. Note that you **cannot indicate order** using `links.collection`. If you need to enforce order, use `links.item` instead.

This occurs most commonly in Story documents claiming to be part of a Property, Series, Contributor or Topic.  You can set one of the following `rels` on your collection links, to help consumers differentiate between them:

```javascript
collectionLink.href = "https://api.pmp.io/docs/<COLLECTION_GUID>";
collectionLink.rels = ["urn:collectiondoc:collection:property"];    // if href has profile=property
collectionLink.rels = ["urn:collectiondoc:collection:series"];      // ... or series
collectionLink.rels = ["urn:collectiondoc:collection:contributor"]; // ... or contributor
collectionLink.rels = ["urn:collectiondoc:collection:topic"];       // ... or topic
```

### Topic collections

To ensure consistency among PMP publishers, map your documents to one of the standard PMP Topics:

Topic      | Href                                 | Guid
---------- | ------------------------------------ | --------------------------------------
Arts       | https://api.pmp.io/topics/arts       | `89944632-fe7c-47df-bc2c-b2036d823f98`
Culture    | https://api.pmp.io/topics/culture    | `9c3c8f9e-f038-4b7e-9719-f5c4b1404c1a`
Education  | https://api.pmp.io/topics/education  | `7a1c4403-0bce-4866-a9eb-8066da226985`
Food       | https://api.pmp.io/topics/food       | `635bb7a1-9e49-4a5d-bab3-048ff945b5fb`
Health     | https://api.pmp.io/topics/health     | `9bd2ec35-be2f-4eb1-9ef9-54a59405dd85`
Money      | https://api.pmp.io/topics/money      | `4d0acb4c-7057-4771-987d-97fc21ad0bcc`
Music      | https://api.pmp.io/topics/music      | `4993cf23-968a-4182-acb2-4d46a96d0ac8`
News       | https://api.pmp.io/topics/news       | `5c0f1387-024e-4a84-8804-43048779cc37`
Politics   | https://api.pmp.io/topics/politics   | `588eb430-d600-4617-ab8f-f601839436a9`
Science    | https://api.pmp.io/topics/science    | `b6ef8e81-9ad2-4e34-8fbd-22181fe1b0e0`
Sports     | https://api.pmp.io/topics/sports     | `44ed7afc-0dd7-4aa1-8c88-34e74dc0d36b`
Technology | https://api.pmp.io/topics/technology | `3f829119-5310-43b9-acc5-0f36a51aae42`

## Image crops

Enclosures for images include the metadata field `crop`.  For consistency, refer to this set of known "semantic crop identifiers":

Crop      | Description
--------- | ---------------
`primary` | The enclosure that should be used when displaying the full story
`large`   | The largest available crop, suitable for a lightbox
`medium`  | Mid-sized enclosure to use in a teaser panel
`small`   | Smallest crop available for the image
`square`  | Square crop of a primary-or-small width/height

Other crops seen in the wild:

* `standard`
* `wide`
* `enlargement`
* `custom`

## Embedded Media

Sometimes it is not possible to provide URLs to the actual media file.

In that case, the producer can provide HTML code to embed a player for the media in a web page, or a link to a page to access the media file (e.g. a YouTube URL).

A best practice for how to share embedded media has not yet been established, but please reference these [current suggestions](https://discuss.pmp.io/t/best-way-to-handle-embeddable-media/96), which include the use of oembed type links, setting a new attribute on the video doc, or using the `contentencoded` attribute for the HTML to embed.

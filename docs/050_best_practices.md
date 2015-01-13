# Publishing Best Practices

Publishers to the PMP are encouraged to follow best practices for how they structure and persist their content.

If a publisher uses idiosyncratic fields, attributes, or profiles, the documents may be very useful to them, but will be less useful (or even discoverable) to consumers attempting to use content from across the PMP.  Below are a set of documented Best Practices to encourage publishers to post content to PMP in standard, useful ways, consistent with the majority of the content shared on the PMP.

## GUIDs

The PMP API intentionally doesn't save documents without a pre-defined GUID. A publisher is responsible for generating a properly formatted GUID for a document before saving it to the PMP.

For globally unique document identifiers PMP uses [UUID version 4 identifiers](http://en.wikipedia.org/wiki/Universally_unique_identifier#Version_4_.28random.29) based on [RFC 4122](http://www.ietf.org/rfc/rfc4122.txt), represented as 32 hexadecimal digits with optional dashes after the 8th, 12th, 16th, and 20th digits.

The PMP accepts GUIDs with or without dashes; it normalizes them before validation.

## Standard Document Types

The PMP provides incredible flexibility, extensible, and forgiving. It allows a publisher to create their own content profiles and schemas, so that almost any kind of content document could be saved to the PMP.  However, clients of the PMP will find it difficult to discover, display or otherwise use content which does not use or extend the basic content types.

Before creating a new Profile, examine the existing ones in common use, and see if they could be used.
If they cannot, see if one of them, such as the Base Content Profile, could be extended for your purposes.

Using or extending a standard profile will also help with discoverability via search.
When searching by document profile, the PMP returns not only docs for that exact profile, but also docs where the profile is extended from that profile.

Make your docs recursive structures of the Basic Content Type for minimal client compatibility.

Use the media types for images, audio and video.

Use a story document to pull together multiple docs (next section) and as a default lead document type.

## Story Documents

The original PMP partners have standardized on the practice of using a story document to be the the main or lead document type to which assets are attached, such as images, audio, or video, and which are themselves organized into collections.

At the level of organizing Stories, they are put into collections, such as by Topic, Contributor or Property.
Likewise, you might use tags to get all Stories for a certain collaboration or event.

At the level of what is within a Story, you find the text and most metadata about the story are attributes of the Story doc, and then it contains links to items such as images, audio, and video docs.

It is not required to use Story documents, but it is highly suggested to use a Story or a sub-type of a Story when creating a complex document (e.g. one with child assets, such as media docs).

An Episode is a sub-type of a Story that indicates the doc is the full episode of a series, general as it might have been produced for broadcast, which will often have within it multiple segments which could be considered stories themselves.

## Standard and Extended Collections

### Group in your own Series or Property, or with a Contributor
When appropriate, add your docs to Contributor, Series and/or Property.

You do this by adding a link with relation type `collection`.

The `rels` for the link should include one of the following:
Property - `urn:collectiondoc:collection:property`
Series - `urn:collectiondoc:collection:series`
Contributor - `urn:collectiondoc:collection:contributor`

The `href` for the link should be to the PMP doc for the series, property, or contributor.

The `title` is optional, but a useful attribute to quickly hint the collection without having to look it up.

### Use Topic collections

You can also associate your content to one of the standard Topics.

https://github.com/publicmediaplatform/pmpdocs/wiki/Profiles-vs-collection-and-item-links

## Linking Documents

Should you use an array of child links in a parent (has one/many), or use a link to the parent in the child (belongs to)?

The array of child links is most useful when the child is abstract from knowing it is part of a collection, such as a curated playlist, or when the collection requires the children to be ordered.

## Other Links

### Alternate

The `alternate` link relation type should be used to provide the url for a web page showing this story on the publisher or producer's site.

## Searchable Attributes

While you can add any attribute you want to the PMP, only some attributes in a PMP are

## Public and Private Tags

Use (public) tags for setting searchable keywords on an item which will be useful to any person looking at these tags.

Use (private) itags for setting tags only for use by the publisher to organize or label content, such as by setting the id for the content to an external system (e.g. the URL or GUID of the content in the publsher's CMS).

## Content Formats

There are different optional attributes to provide the content in different formats.

`description`: text only version.

`contentencoded`: html version.

`contenttemplated`: structured to have related asset docs embedded into the template (format TBD).

## Metadata for Media

### For Media Docs

Use a link with a rel of `enclosure` with the following attributes possible.
You may have multiple links for the enclosure, such as when there are multiple sizes or encoding of the enclosed file.

`href`: should be a link to the actual asset, though may require redirect
`type`: should be a valid mime type

### For Images

`meta`: use this attribute to specify additional useful attributes about the enclosure
  `width`: in pixels, width of the image
  `height`: in pixels,  height of the image
  `crop`: semantic name of the image crop type (e.g. 'primary', 'thumb', 'medium', 'large')
  `resolution`: resolution of the image in ppi (pixels per inch).

### For Audio or Video

`meta`: use this attribute to specify additional useful attributes about the enclosure
  `codec`: codec of the binary file
  `format`: format of the binary file
  `size`: in bytes, the size of the media resource
  `duration`: for audio and video, the duration in seconds

You should provide a url to a media file for the href value.
It should be a url that can be expected to be played back in a media element in a modern browser.

You may want to use a redirect service such as podtrac to measure each time the link is followed.

### Embedded Media

Sometimes it is not possible to provide urls to the actual media files.

In that case, the producer can provide the html code to be used to embed a player for the media in a web page, or a link to a page to view/hear the media (e.g. a YouTube URL).

A best practice for how to share embeds has not been established.

Current suggestions include use of oembed type links, a new attribute on the video doc, or using the `contentencoded` attribute for the html to embed.

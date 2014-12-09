# Publishing

Publishers to the PMP are encouraged to follow best practices for how they structure and persist their content.

The PMP provides incredible flexibility, extensible, and forgiving. It allows a publisher to create their own content profiles and schemas, so that almost any kind of content document could be saved to the PMP.  However, clients of the PMP will find it difficult to discover, display or otherwise use content which does not follow the currently adopted best practices.

If a publisher uses idiosyncratic fields, attributes, or profiles, the documents may be very useful to them, but will be less useful (or even discoverable) to consumers attempting to use content from across the PMP.


## GUIDs

The PMP API intentionally doesn't save documents without a pre-defined GUID. A publisher is responsible for generating a properly formatted GUID for a document before saving it to the PMP.

For globally unique document identifiers PMP uses [UUID version 4 identifiers](http://en.wikipedia.org/wiki/Universally_unique_identifier#Version_4_.28random.29) based on [RFC 4122](http://www.ietf.org/rfc/rfc4122.txt), represented as 32 hexadecimal digits with optional dashes after the 8th, 12th, 16th, and 20th digits.

The PMP accepts GUIDs with or without dashes; it normalizes them before validation.


## Standard Document Types

The PMP has defined a set of standard document types which

Use or extend the basic content types.  When searching by document profile, the PMP returns not only docs for that exact profile, but also docs where the profile is extended from tha profile.

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

When appropriate, add your docs to Contributor, Series and/or Property.

Also associate your content to one of the standard Topics.

https://github.com/publicmediaplatform/pmpdocs/wiki/Profiles-vs-collection-and-item-links


## Linking Documents

Should you use an array of child links in a parent (has one/many), or use a link to the parent in the child (belongs to)?


## Searchable Attributes

While you can add any attribute you want to the PMP, only some attributes in a PMP are


## Public and Private Tags

Use (public) tags for setting searchable keywords on an item which will be useful to any person looking at these tags.

Use (private) itags for setting tags only for use by the publisher to organize or label content, such as by setting the id for the content to an external system (e.g. the URL or GUID of the content in the publsher's CMS).

## Provide Content in Different Formats

`description` is the text only version.

`contentencoded` is the html version.

`contenttemplated` is structured to have related asset docs embedded into the template (format TBD).


## Direct Links to Media


## Metadata for Images


## Metadata for Media


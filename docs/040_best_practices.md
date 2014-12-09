# Publishing

Publishers to the PMP are encouraged to follow best practices for how they structure and persist their content.

The PMP provides incredible flexibility, extensible, and forgiving. It allows a publisher to create their own content profiles and schemas, so that almost any kind of content document could be saved to the PMP.  However, clients of the PMP will find it difficult to discover, display or otherwise use content which does not follow the currently adopted best practices.

If a publisher uses idiosyncratic fields, attributes, or profiles, the documents may be very useful to them, but will be less useful (or even discoverable) to consumers attempting to use content from across the PMP.


## GUIDs

The PMP API intentionally doesn't save documents without a pre-defined GUID. A publisher is responsible for generating a properly formatted GUID for a document before saving it to the PMP.

For globally unique document identifiers PMP uses [UUID version 4 identifiers](http://en.wikipedia.org/wiki/Universally_unique_identifier#Version_4_.28random.29) based on [RFC 4122](http://www.ietf.org/rfc/rfc4122.txt), represented as 32 hexadecimal digits with optional dashes after the 8th, 12th, 16th, and 20th digits.

The PMP accepts GUIDs with or without dashes; it normalizes them before validation.


## Standard Content Types




## Standard and Extended Collections

## Story Documents

## Searchable Attributes

While you can add any attribute you want to the PMP,
Only some attributes in a PMP are

## Public and Internal Tags

## Provide Content in Different Formats

## Metadata for Images

## Metadata for Media

## Direct Links to Media

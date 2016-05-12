# Profiles and Schemas

While `Collection.doc+JSON` is flexible enough to accommodate most new content types, it is too loosely defined to be sufficient in and of itself. Any specific application will need something that allows tailoring of `Collection.doc+JSON` with additional semantics. In the Hypermedia world, the standard that allows such tailoring is the [Profile link relation type](http://tools.ietf.org/html/draft-wilde-profile-link-04#section-3.1).

## Profile documents

For any PMP document, the `link.profile[0].href` *must* point to a dereferenceable profile=**profile** document.  So for a profile=**story** document, this would be something like `[{href: "https://api.pmp.io/profiles/story"}]`.  Now, if we go fetch [that profile document](https://api.pmp.io/profiles/story), we'll get something like this:

```json
{
  "version": "1.0",
  "href":    "https://api.pmp.io/profiles/story",
  "attributes": {
    "title": "Story Profile"
  },
  "links": {
    "profile": [{
      "href": "https://api.pmp.io/profiles/profile"
    }],
    "extends": [{
      "href": "https://api.pmp.io/profiles/base"
    }],
    "schema": [{
      "href": "https://api.pmp.io/schemas/story",
      "scope": "update"
    }]
  }
}
```

Notice those links on the profile doc:

1. `links.profile` tells us that this story document [is a profile](https://api.pmp.io/profiles/profile).

    This document "type" is important for interpreting the attributes and links of any document.  It also lets us group together similar types of documents, such as **stories** or **audio** or **topics**.

2. `links.extends` gives us a hierarchy of profiles.

    Inheritance is cool!  Now we can group together types of documents in a hierarchical way.  All **story** documents are also **base** documents.  But not all **base** documents are **story** documents.  See the [profile hierarchy tree](#profiles-and-schemas-hierarchy) for more.

3. `links.schema` links to a dereferenceable `profile=schema` document.

    This optional link defines a schema to which all **story** documents must adhere.  It must be a ["profile=schema" document](https://api.pmp.io/profiles/schema).  The schema can require certain attributes and links be present in all "stories", so we can interpret and display them in a consistent fashion.

For a more in-depth look at profiles, check out the [legacy docs](https://github.com/publicmediaplatform/pmpdocs/wiki/Profile-Management).

## Schema documents

To enforce validation of different document types (profiles), the PMP uses **schema** documents.  These are basically a [JSON schema](http://json-schema.org/) definition wrapped inside a `Collection.doc+JSON` document.  For instance, [the "story" schema](https://api.pmp.io/schemas/story) looks something like:

```json
{
  "version": "1.0",
  "href":    "https://api.pmp.io/schemas/story",
  "attributes": {
    "title": "Story Schema",
    "schema": { "a json schema": "goes here" }
  },
  "links": {
    "profile": [{
      "href": "https://api.pmp.io/profiles/schema"
    }]
  }
}
```

The important things to notice are that:

1. `links.profile` tells us that this is a **schema**.
2. `attributes.schema` is a JSON schema object.

For more info on interpreting JSON schemas, check out the [json-schema.org docs](http://json-schema.org/documentation.html), which provides [simple](http://json-schema.org/example1.html) and [advanced](http://json-schema.org/example2.html) examples.

## Hierarchy

The basic PMP profiles can be visually represented through a tree graph:

<object data="//support.pmp.io/profiletree.svg" type="image/svg+xml">
  <img src="//support.pmp.io/profiletree.png"/>
</object>

Here you can see that an **audio** document *is also* a **media** and **base** document.  Since our JSON schema for **base** requires `attributes.title` to be present, that requirement also cascades down to **audio**.

And when we search the PMP for **media** documents, we know that we will also be getting **audio**, **images** and **videos**.

This is by no means an exhaustive list of profiles in the PMP.  (You can also create your own - just go [search for profiles](https://api.pmp.io/profiles) to see them all).  As a best practice, any user-defined profile should extend from these system-defined profiles.

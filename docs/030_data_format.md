# Collection.doc+JSON

Aside from authentication, the responses of the PMP API are exclusively of the media type `Collection.doc+JSON`.  For a real example, go check out the [PMP home document](https://api.pmp.io).  But it is basically a JSON object with the following top-level structure:

```json
{
  "version":    "1.0",
  "href":       "https://api.pmp.io/docs/04224975-e93c-4b17-9df9-96db37d318f3",
  "attributes": {"keys": "values"},
  "links":      {"keys": "values"},
  "errors":     {"keys": "values"}
}
```

Key          | Usage
------------ | --------------
`version`    | The `cdoc` specification [version](http://cdoc.io/spec.html#version) this resource adheres to.
`href`       | A valid URI identifier for this resource... aka the [document permalink](http://cdoc.io/spec.html#href---document-permalink).
`attributes` | A set of properties [describing the state](http://cdoc.io/spec.html#attributes) of this resource.
`links`      | [Hyperlinks](http://cdoc.io/spec.html#links) to the actions and relationships for this resource.
`items`      | A convenience link to cdocs referenced by `links.item`.
`errors`     | Additional information about API errors.

<div class="alert alert-warning">IMPORTANT: Although this structure is defined by the <a href="http://cdoc.io/spec.html">Collection.doc</a> spec, the authoritative PMP implementation can always be found in the <a href="https://api.pmp.io/schemas/core">Core Schema</a>.  Read more about <a>Schemas</a> and <a>Profiles</a> further down.</div>

## Headers

### Content-Type

The primary MIME type used by the PMP is `application/vnd.collection.doc+json`.  You can expect to see this in the `Content-Type` header in responses from the PMP.  And you should be setting the `Content-Type` to this when you're interacting with the PMP.

### Response Sizes

PMP responses include all sorts of boilerplate links.  Clients really only need to get this information once, and can afterwards ignore the information.  To give clients some options for what data they'd like in the response, the PMP utilizes the [HTTP Prefer header](http://tools.ietf.org/html/draft-snell-http-prefer-18).  To assist in caching, variable preferences will also be included in the `Vary` response header.

By default (not specifying a `Prefer` header), you're going to see a response header of `Vary: Prefer, Accept-Encoding`.  And you will get the full set of PMP boilerplate links.

If you want a minimal response, set `Prefer: return=minimal`.  The PMP will include the usual `Vary: Prefer, Accept-Encoding`, plus an additional header to indicate that it did apply your preference: `Preference-Applied: return=minimal`.  This response will NOT include any PMP boilerplate links.

In addition to preferences, you can also get gzipped responses from the PMP by setting `Accept-Encoding: gzip, deflate`.  However, the response will only actually be gzipped if it is large enough that the PMP deems it worthwhile.

### Caching

PMP responses will all set the usual `ETag` and `Last-Modified` headers.

To check for 304-Not-Modified on the client side, send one of these standard HTTP headers:

 * [If-Match](http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.24)
 * [If-Modified-Since](http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.25)
 * [If-None-Match](http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.26)
 * [If-Unmodified-Since](http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.28)

Also be sure to check the `Vary` header - which indicates ways that your response for a resource may be different than another request for the same resource.

## Core Attributes

```json
{
  "attributes": {
    "guid":     "04224975-e93c-4b17-9df9-96db37d318f4",
    "title":    "A PMP Collection Document",
    "created":  "2014-07-04T04:00:44+00:00",
    "modified": "2014-09-08T20:56:59+00:00",
    "valid": {
      "from":   "2013-07-04T04:00:44+00:00",
      "to":     "3013-07-04T04:00:44+00:00"
    },
    "hreflang": "en"
  }
}
```

Document attributes take the form of a `{"attr_key_123": "value"}` hash, where the value may be a string, array, or object.
The following attributes are defined by the [Core Schema](https://api.pmp.io/schemas/core), and common to all PMP documents:

Key        | Usage
---------- | --------------
`guid`     | A [UUIDv4](http://en.wikipedia.org/wiki/Universally_unique_identifier#Version_4_.28random.29) assigned to this document. <span class="badge">readonly</span>
`title`    | A human-meaningful title for this document.
`created`  | Document creation timestamp in [ISO 8601](http://en.wikipedia.org/wiki/ISO_8601) <span class="badge">readonly</span>
`modified` | Document last modified timestamp in [ISO 8601](http://en.wikipedia.org/wiki/ISO_8601) <span class="badge">readonly</span>
`valid`    | Object `{from: "", to: ""}` with two [ISO 8601](http://en.wikipedia.org/wiki/ISO_8601) timestamps between which the document is valid.  Defaults from the doc `created` timestamp + 1000 years.
`hreflang` | Language of this document using [ISO639-1](http://www.iso.org/iso/home/standards/language_codes.htm) code.  Defaults to "en".


## Core Links

```json
{
  "links": {
    "profile": [
      {
        "href": "http://api.pmp.io/profiles/core"
      }
    ],
    "alternate": [
      {
        "href": "http://support.pmp.io/docs#collection-docjson-core-links",
        "title": "Core links html docs"
      },
      {
        "href": "http://cdoc.io/spec.html#links"
      }
    ]
  }
}
```

The links section of the document is a hash of `{"link_relation_ship_type": ["array", "of", "link", "objects"]}`.
The relationship type is a descriptive string of how the current document is related to the linked document(s).
These relationship types are defined by the [Core Schema](https://api.pmp.io/schemas/core), and common to all PMP documents:

Key           | Usage
------------- | -------------
`alternate`   | Links that represent alternate representations of this document.
`auth`        | Links describing how to authorize against the PMP. <span class="badge">readonly</span>
`collection`  | Links that represent collection documents that contain this document.
`creator`     | Auto-generated link representing the user that created this document. <span class="badge">readonly</span>
`distributor` | Links that represent users that can legally distribute this document.
`edit`        | Links that represent URLs for updates to this document. <span class="badge">readonly</span>
`item`        | Links that represent documents that are items of this document.
`navigation`  | Links that represent navigation and pagination for this document. <span class="badge">readonly</span>
`owner`       | Links that represents users that legally own this document. Defaults to `creator`. <span class="badge badge-red">required</span>
`permission`  | Links that represent permission groups associated with this document.
`profile`     | Link that represents the profile of this document. <span class="badge badge-red">required</span>
`query`       | Links that represent templated queries that can run against this document. <span class="badge">readonly</span>

## Link Objects

The link objects contained in the relationship-type array must have, at a minimum, either an `href` or an `href-template`.
If an `href-template` is used, then an `href-vars` object must also be included to describe the variables in that template.
This is the complete structure of a "link" object, as defined by the [Core Schema](https://api.pmp.io/schemas/core).
All keys are optional except for those described previously.

Key             | Usage
--------------- | --------------
`hints`         | Object containing hints about interacting with the link, such as HTTP methods.
`href`          | URL of the linked document. <span class="badge badge-red">required</span>
`href-template` | An [RFC6570](http://tools.ietf.org/html/rfc6570) templated URL. <span class="badge badge-red">required</span>
`href-vars`     | Object of the format `{"varname": "http://descriptive/link"}`, linking `href-template` variables to their documentation. <span class="badge badge-red">required</span>
`hreflang`      | Language of this document using [ISO639-1](http://www.iso.org/iso/home/standards/language_codes.htm) code.
`method`        | Expected HTTP method to use for the link
`pagenum`       | The page number represented by the link
`rels`          | Array of the format `["urn:pmp:something", "urn:collectiondoc:something"]` describing additional relationship types on this link
`title`         | The title of the linked document
`totalitems`    | The total number of items found in the full document represented by the link
`totalpages`    | The total number of pages for the full document represented by the link
`type`          | Mimetype of the linked document

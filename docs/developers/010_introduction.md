* The searcher will look for your query in story text, titles, teasers and bylines# The PMP API

<div class="alert alert-warning media">
  <i class="fa fa-university fa-3x pull-left media-object"></i>
  <div class="media-body">
    <b>First time in the PMP docs?</b><br/>You may want to go read the <a href="/guides">user guides</a> before diving into this developer documentation.
  </div>
</div>

The Public Media Platform [is a Hypermedia API](http://www.infoq.com/articles/hypermedia-api-tutorial-part-one) that is accessible on the web over HTTPS and allows API clients to communicate with the server using the [Collection.doc+JSON](http://cdoc.io/spec.html) media type. `Collection.doc+JSON` is a recursive, generic, JSON hypermedia type optimized for the flexible exchange of structured content by content providers and consumers.

Don't see what you're looking for?  You can also check our [legacy docs](http://docs.pmp.io).

These documents are hosted on Github, so consider [contributing back](https://github.com/publicmediaplatform/support.pmp.io/tree/master/docs) to them!

## Environments

Currently, PMP developers can register accounts in two environments:

Environment                 | Usage
--------------------------- | -------------------
https://api.pmp.io          | Production data only - please do not perform any testing here.
https://api-sandbox.pmp.io  | Integration testing and development - appropriate environment for testing.

Additionally, each environment has a read and write endpoint.  For `GET` requests, [api.pmp.io](https://api.pmp.io) or [api-sandbox.pmp.io](https://api-sandbox.pmp.io) should be used.  For `POST/PUT/DELETE` requests, [publish.pmp.io](https://publish.pmp.io) or [publish-sandbox.pmp.io](https://publish-sandbox.pmp.io) should be used.  Since this is a hypermedia API, the documents themselves will tell you the endpoints to use.  SDK's should not hardcode any URL except for the API home document - follow the links!

The code examples in these docs will use [api.pmp.io]() and [publish.pmp.io](https://publish.pmp.io) - just replace with [api-sandbox.pmp.io](https://api-sandbox.pmp.io) and [publish-sandbox.pmp.io](https://publish-sandbox.pmp.io) to use the testing environment.

## SDKs

API clients are available in multiple languages.  Whenever possible, we encourage you to use and contribute to an existing SDK project rather than roll your own.  Contributions welcome!

Language   | Links
---------- | --------
Javascript | pmp-js-sdk on [github](https://github.com/publicmediaplatform/pmp-js-sdk) / [npm](https://www.npmjs.org/package/pmpsdk)
Perl       | Net::PMP on [github](https://github.com/APMG/pmp-sdk-perl) / [cpan](https://metacpan.org/release/Net-PMP) --- Net::PMP::Profile on [github](https://github.com/APMG/net-pmp-profile-perl) / [cpan](https://metacpan.org/release/Net-PMP-Profile)
PHP        | phpsdk on [github](https://github.com/publicmediaplatform/phpsdk)
Python     | pmp-myriad on [github](https://github.com/pbs/pmp-myriad)
Python     | py3-pmp-wrapper on [github](https://github.com/KPBS/py3-pmp-wrapper)
Ruby       | pmp on [github](https://github.com/PRX/pmp) / [rubygems](https://rubygems.org/gems/pmp)

If you know of another SDK not mentioned here, please [let us know](mailto:support@publicmediaplatform.org)!

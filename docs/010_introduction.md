# Getting Started

The Public Media Platform [is a Hypermedia API](http://www.infoq.com/articles/hypermedia-api-tutorial-part-one) that is accessible over HTTP, on the web and lets API clients communicate using [Collection.doc+JSON](http://cdoc.io/spec.html) media type. `Collection.doc+JSON` is a recursive, generic, JSON hypermedia type optimized for flexible exchange of structured content by content providers and consumers.

These documents are hosted on Github, so consider [contributing back](https://github.com/publicmediaplatform/support.pmp.io/tree/master/docs) to them!

Don't see what you're looking for?  You can also check our [legacy docs](http://docs.pmp.io).

<div class="alert alert-warning media">
  <i class="fa fa-level-down fa-3x pull-left media-object"></i>
  <div class="media-body">
    <b>Quick start!</b><br/>Ready to jump in?  Skip the details and head straight to the <a href="#examples">examples section</a>.
  </div>
</div>

## User Registration

You need to [register an account](http://support.pmp.io/register) for yourself or your organization to get started with the PMP.  Organizations should use a single API user to access the PMP, to ensure that content permissions are applied consistently for their applications.  If you are already a public media subscriber, your user account may already exist, and you just need to [reset your password](http://support.pmp.io/forgot) to start using the PMP.

If you already have an account, you can [log in](http://support.pmp.io/login) to manage your user.

## Environments

Currently, PMP developers can register accounts in 2 environments:

Environment                 | Usage
--------------------------- | -------------------
https://api.pmp.io          | Production data only - please don't create dummy/test data here.
https://api-sandbox.pmp.io  | Integration testing and development - "do whatever".

Additionally, each environment has a read and write endpoint.  For `GET` requests, [api.pmp.io](https://api.pmp.io) or [api-sandbox.pmp.io](https://api-sandbox.pmp.io) should be used.  For `POST/PUT/DELETE` requests, [publish.pmp.io](https://publish.pmp.io) or [publish-sandbox.pmp.io](https://publish-sandbox.pmp.io) should be used.  But... since this is a hypermedia API, the documents themselves will tell you the endpoints to use.  SDK's should not hardcode any URL except for the API home document - follow the links!

The code examples in these docs will use [api.pmp.io]() and [publish.pmp.io](https://publish.pmp.io) - just replace with [api-sandbox.pmp.io](https://api-sandbox.pmp.io) and [publish-sandbox.pmp.io](https://publish-sandbox.pmp.io) to use the sandbox.

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

## Plugins

PMP plugins have been built for several popular CMS's / platforms.  Details forthcoming!

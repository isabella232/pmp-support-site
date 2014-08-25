# Introduction

The Public Media Platform [is a Hypermedia API](http://www.infoq.com/articles/hypermedia-api-tutorial-part-one) that is accessible over HTTP, on the web and lets API clients communicate using [Collection.doc+JSON](http://cdoc.io/spec.html) media type. `Collection.doc+JSON` is a recursive, generic, JSON hypermedia type optimized for flexible exchange of structured content by content providers and consumers.

## User Registration

To request an API user, fill out the [registration form](http://support.pmp.io/register) on the support site.  If you already have an account, you can [log into support](http://support.pmp.io/login) to manage your user.

## Environments

Currently, PMP developers can register accounts in 2 environments.  For testing and development, please use [api-sandbox.pmp.io](https://api-sandbox.pmp.io), and don't worry about what content you put there.  The production [api.pmp.io](https://api.pmp.io) environment should only be used for "real" data.  So don't point your applications there until you're ready for prime time.

Additionally, each API has a read and write endpoint.  For `GET` requests, [api.pmp.io](https://api.pmp.io) or [api-sandbox.pmp.io](https://api-sandbox.pmp.io) should be used.  And for `POST/PUT/DELETE` requests, [publish.pmp.io](https://publish.pmp.io) or [publish-sandbox.pmp.io](https://publish-sandbox.pmp.io) should be used.  But... since this is a hypermedia API, the documents themselves will tell you the endpoints to use, so you really shouldn't be hardcoding these anywhere.

## SDKs

API clients are available in multiple languages.  Whenever possible, we encourage you to use and contribute to an existing SDK project rather than roll your own.

Language   | Links
---------- | --------
Javascript | pmp-js-sdk on [github](https://github.com/publicmediaplatform/pmp-js-sdk)
Perl       | Net::PMP on [github](https://github.com/APMG/pmp-sdk-perl) / [cpan](https://metacpan.org/release/Net-PMP) --- Net::PMP::Profile on [github](https://github.com/APMG/net-pmp-profile-perl) / [cpan](https://metacpan.org/release/Net-PMP-Profile)
PHP        | phpsdk on [github](https://github.com/publicmediaplatform/phpsdk)
Python     | pmpbelt on [github](https://github.com/npr/pmpbelt)
Ruby       | pmp on [github](https://github.com/PRX/pmp) / [rubygems](https://rubygems.org/gems/pmp)

If you know of another SDK not mentioned here, please [let us know](mailto:support@publicmediaplatform.org)!

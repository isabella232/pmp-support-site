# PMP Support Site

[![Build Status](https://travis-ci.org/publicmediaplatform/support.pmp.io.svg?branch=master)](https://travis-ci.org/publicmediaplatform/support.pmp.io.svg?branch=master)

Rails application powering [support.pmp.io](https://support.pmp.io).

The support.pmp.io site provides links and information for getting help with the PMP.

Documentation is parsed from the markdown files in the `docs` directory.  They will be sorted by name before being rendered as the docs page.

## Running

In order to really get this thing cooking, you need to provide several environment variables.  Firstly, you need PMP admin credentials to be able to reset user passwords:

```
export SANDBOX_CLIENT_ID=the-sand-admin-client-id
export SANDBOX_CLIENT_SECRET=the-sand-admin-client-secret
export PRODUCTION_CLIENT_ID=the-prod-admin-client-id
export PRODUCTION_CLIENT_SECRET=the-prod-admin-client-secret
```

Secondly, you'll need some production, `READ-ONLY` credentials for the public API proxy:

```
export PRODUCTION_PUBLIC_ID=some-prod-client-id
export PRODUCTION_PUBLIC_SECRET=some-prod-client-secret
```

## Testing

This app is currently 100% non-recorded integration tests.  So you'll need to provide a PMP login (as if you were a user logging into the site).  Something like this:

```
export PMP_HOST=https://api-sandbox.pmp.io
export PMP_USERNAME=pmpuser94
export PMP_PASSWORD=p&ssw0rd
bundle exec rake
```

Notice that this will skip several tests.  To get a full-run, you'll also need to set "public" credentials, and "admin" credentials for whatever `PMP_HOST` you're using.  (As detailed in the "Running" section above).  Don't have admin access?  Not to worry - Travis CI will do a complete test run.

## Issues and Contributing

Report any bugs or feature-requests via the [main PMP issue tracker](http://github.com/publicmediaplatform/pmp-issues/issues).  Or send me a fax.  Pull requests welcome!  Thanks.

## License

support.pmp.io is free software, and may be redistributed under the MIT-LICENSE.

Thanks for listening!

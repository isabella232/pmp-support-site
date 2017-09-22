# Support Requests
We have migrated to [nprsupport.desk.com](https://nprsupport.desk.com/) for bug reports, enhancement requests, and other issues. Please submit a ticket there if you need assistance.

# PMP Support Site

[![Build Status](https://travis-ci.org/publicmediaplatform/support.pmp.io.svg?branch=master)](https://travis-ci.org/publicmediaplatform/support.pmp.io)

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

## Making updates to support.pmp.io

The process: 
1. Make changes and submit a pull request on GitHub (https://github.com/publicmediaplatform/support.pmp.io). 
2. Please turn on notifications for the repo if you haven’t done so.
3. DS ops will merge the pull request.
4. DS ops will pull the changes down on the server and clear cache/restart service so they take effect.

For the ops folks, the quick and dirty instructions on how to do step 3:

ssh -i /path/to/pmp_key ec2-user@support.pmp.io

# switch to pmpbot
sudo su - pmpbot
cd ~/support.pmp.io
git pull
/opt/rbenv/shims/bundle exec rake tmp:cache:clear

# back to ec2-user to restart service
exit
sudo restart unicorn.support

Notice that this will skip several tests.  To get a full-run, you'll also need to set "public" credentials, and "admin" credentials for whatever `PMP_HOST` you're using.  (As detailed in the "Running" section above).  Don't have admin access?  Not to worry - Travis CI will do a complete test run.

## Issues and Contributing

Report any bugs or feature-requests via this project's [issue tracker](http://github.com/publicmediaplatform/support.pmp.io/issues).  Or send me a fax.  Pull requests welcome!  Thanks.

## License

support.pmp.io is free software, and may be redistributed under the MIT-LICENSE.

Thanks for listening!

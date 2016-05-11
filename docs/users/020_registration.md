# Registration

To access the PMP, your station must have a PMP account with credentials. These credentials allow the PMP API to approve requests to access PMP content, identify who is pulling content, and what content is being pulled by each account. There are a few steps required to complete your PMP API account and credential set up: requesting an account, setting a password, setting proper permissions to the account, and copying your account details to use in your CMS or application.

**Note:** Typically, one account is set up per organization, but under that account individual credentials can be set up for each tool/product/site. So if you're using the PMP for multiple applications, you'll need to set up separate credentials (not accounts) for each.

**Note for developers:** Though you may have the same username for each, PMP sandbox and production accounts are otherwise independent.   

If you already have an account, you can [log in](/login) to manage your user.

## Request An Account

![1final](https://cloud.githubusercontent.com/assets/4427754/7566204/8b689d68-f7c3-11e4-9921-20461c2605d5.png)

**Complete the** [request form](/register) **for a new account.**

* Host: Select api.pmp.io if you intend to use an existing PMP plugin or Core Publisher. Choose api-sandbox.pmp.io if you are a developer and want an account to perform testing in a sandbox environment.

* Contact email: We recommend that stations use a generic email address rather than a personal email account. If there is a change in personnel, you cannot change the email account tied to the API user account.

* Name of organization: Enter your Station call letters.

* What CMS do you use? Select the CMS you currently use, or select 'Other' and provide a description in the field below.

You will receive an email reply to your request within 24 hours.

## Reset Your Password

![2final](https://cloud.githubusercontent.com/assets/4427754/7526208/b7167126-f4dd-11e4-9b35-704a422cfc33.png)

Once you receive the email with your PMP credentials, you will need to set a password for your account.

**Complete the** [reset password form](/forgot).

* Select the Host "api.pmp.io" or "api-sandbox.pmp.io" as appropriate from the dropdown menu.

* Enter the username used to sign up for your PMP account.

* Click "Email reset instructions."

* An email from support@publicmediaplatform.org will be sent to the address associated with your username with further instructions. Click the link in the email to visit the page where you can confirm your username and enter a new password. Once you confirm your new password, a screen alert will let you know that your password has been changed, and you will be redirected to the login page.

## Create Your Credentials

![3final](https://cloud.githubusercontent.com/assets/4427754/7526209/b71a83b0-f4dd-11e4-9707-6369cafb2d7d.png)

Now that you have reset your password and are able to login, you can create unique credentials for your PMP account.

**Go to the** ["Login" page](/login).
* Sign in with your username and password.

* Click the green "New Client" button on the credentials page.

* Select the "write" option from the "Scope" column ("write" scope will allow you to push content into the PMP).

* Type an appropriate identifier for your CMS (Core Publisher, WordPress, Bento, etc.) into the "your-label-here" field, found under the "Label" column.

* Click "Save" in the "Actions" column.

* The "Client ID" and the "Client Secret" columns should now be populated with unique alphanumeric strings. Record the values for your Client ID and Client Secret in a secure place as you will need to include them in your application or CMS plugin to complete the set up process.

## Save Your Credentials

![4final](https://cloud.githubusercontent.com/assets/4427754/7565749/913eeff6-f7c0-11e4-90f1-70c70e1a1d45.png)

Record the values for your Client ID and Client Secret in a secure place as you will need to include them in your application or CMS plugin to complete the set up process.


## Record Your PMP GUID

![5final](https://cloud.githubusercontent.com/assets/4427754/7526211/b71dc868-f4dd-11e4-87eb-797fef0f79ff.png)

The final piece of information you will need to complete your PMP setup is your GUID, or Globally Unique Identifier. You can find this on your PMP account page.

* Return to your [PMP account dashboard](/account).

* Click on your username in the upper right corner of the screen, and select "Manage User".

* On the left-hand side of your screen, you will see a field identified as "GUID". The alphanumeric string is the unique GUID for your account. Record this value in a secure place for future use in your application or CMS plugin.

Congratulations, you have successfully set up credentials for accessing the PMP API! Next, you’ll need to use this information to set up the application you will use to make requests to the PMP. Instructions for that process should be available from the application or plugin provider; NPR member stations using the Core Publisher plugin can find that information on [NPR's Digital Services website.](http://mediad.publicbroadcasting.net/p/newnprdsblog/files/201504/how_to_pull_content_from_the_pmp_into_core_publisher_march_2015.pdf)

NOTE: For additional support or any questions about your PMP user account please contact the PMP directly at support@publicmediaplatform.org.

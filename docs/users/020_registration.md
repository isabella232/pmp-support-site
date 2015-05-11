# Registration

To access the PMP, your station must have credentials. These credentials allow the PMP API to approve requests to access PMP content, identify who is pulling content, and what content is being pulled by each account. Within this first step, there are a series of actions that need to be taken to complete your PMP API account and credential set up: requesting an account, setting a password, setting proper permissions to the account, and copying your account details to use in your CMS or application.

Note: Credentials are tool/product specific. If you need to use the PMP for multiple applications, you'll need to set up separate credentials for each.

If you already have an account, you can [log in](/login) to manage your user.

## Request an account

![1final](https://cloud.githubusercontent.com/assets/4427754/7566204/8b689d68-f7c3-11e4-9921-20461c2605d5.png)

1. Go to the ["Request an API user for the PMP" page](/register) and fill out and submit the Request an Account form.
2. Host – Select api.pmp.io if you intend to use an existing PMP plugin or Core Publisher. Choose api-sandbox.pmp.io if you are a developer and want an account to test with in a sandbox environment.
3. Name – Enter your name.
4. Contact Email - We recommend that stations use a generic email address that isn’t tied to one person’s email account. If there is a change in personnel, you cannot change the email account tied to the API user account.
5. Name of Organization – Use your Station call letters in the “Name of organization” field.
6. What CMS do you use? – Select the CMS your site uses.
7. For what purpose do you intend to use the PMP? Enter a description of how you intend to use the PMP.

Within 24 hours you will receive a reply via email.

## Reset password

![2final](https://cloud.githubusercontent.com/assets/4427754/7526208/b7167126-f4dd-11e4-9b35-704a422cfc33.png)

Once you receive your email, you will need to set a password for your account.

1. Go to the ["Forgot Password" page](/forgot).
2. Enter the Host by selection "api.pmp.io" or "api-sandbox.pmp.io" as appropriate from the dropdown menu.
3. Username field - Enter the username you used to sign up for your PMP account.
4. Click "Email reset instructions."
5. Instructions to reset your password will be emailed to the address associated with this username. You will receive an email from support@publicmediaplatform.org.
6. Click on the link in the password reset email and it will take you to a page where you can confirm your username and enter a new password.
7. After entering your username and confirming your new password, you will  see a confirmation screen alert letting you know your password has been changed and you will be redirected to login.

## Creating your credentials

![3final](https://cloud.githubusercontent.com/assets/4427754/7526209/b71a83b0-f4dd-11e4-9707-6369cafb2d7d.png)

Once you have reset your password and are able to login, you are now able to create unique credentials for your PMP account.

1. Go to the ["Login" page](/login).
2. Enter your username and password and click "Sign In." Once logged in you will see the credentials page.
3. Click the "+New Client" button.
4. Next, you will see "write" and a drop down icon in the "Scope" column. Select the "write" option, which is required if you intend to push content into the PMP.
5. You will see "your-label-here" in the "Label" column. Type an appropriate identifier (Core Publisher, WordPress, Bento, etc.) into the field.
6. You will see "14 days" and a drop down icon in the "Token Expires In" column. You can select any option here as the token will not expire.
7. Finally, in the "Actions" column, click "Save."
8. You will notice that the "Client ID" and the "Client Secret" columns have now been populated with unique alphanumeric strings. Keep this browser window open as you will need to return to this screen later.

## Saving your credentials

![4final](https://cloud.githubusercontent.com/assets/4427754/7565749/913eeff6-f7c0-11e4-90f1-70c70e1a1d45.png)

You will need to copy the credential information you just received in the steps above. You will use them later inside your CMS/plugin/application to complete the PMP set up.

1. Open MS Word or a plain text editor.
2. Go back to your browser with the PMP Client Credentials screen open.
3. Using your mouse, highlight the alphanumeric "Client ID" and Client Secret" strings. Copy the selected information.
4. Go back to MS Word/text editor and paste the credentials into a new document. Save the files to your desktop and keep it open.

## Gathering Your PMP GUID

![5final](https://cloud.githubusercontent.com/assets/4427754/7526211/b71dc868-f4dd-11e4-87eb-797fef0f79ff.png)

The final piece of PMP information you will need to move forward is your GUID, or Globally Unique Identifier. You can find this in your PMP account.

1. Return to your browser window where you are logged into your PMP account. If you've lost the page, you can visit [the Account page](/account).
2. Click on your username in the upper right, and select "Manage User".
3. On the left-hand side of your screen, you will see a field identified as GUID. The alphanumeric string is the unique GUID for your account.
4. Using your cursor, highlight the GUID string and copy the selected area.
5. Open your saved MS Word or text editor document.
6. Paste the collected GUID into your document. Save the file. You will need this later.

Congratulations, you have successfully set up your PMP API account! Next, you’ll need this information to complete setup in whatever application you’re using to access the PMP. Instructions should be available from the application or plugin provider.

NOTE: For additional support or any questions about your PMP user account please contact the PMP directly at support@publicmediaplatform.org.

HT [@NPRDS](https://twitter.com/nprds), whose original instructions these were adapted from.

For listing users' accounts that may exist in the System Preferences Internet Account preferences pane (~/Library/Accounts/Accounts3.sqlite)

The purpose of this is that while you can lockout users from the Internet Account preferences pane, Safari will still prompt users to add these accounts.

You can prevent this through the com.apple.Safari.plist, but if you're like me and didn't know you needed to do this, this EA will identify users that have Internet Accounts configured so you can remove them.

See my script below to go about removing them:

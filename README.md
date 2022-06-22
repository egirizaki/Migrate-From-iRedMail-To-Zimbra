# Migrating Email From IRedMail to Zimbra

Please read the documentation first before start the Migrating.

1. SSH to IRedMail server
2. Edit file dovecot.conf, change line 47 and 57 to be like this

`ssl = yes                     #line 47
disable_plaintext_auth = no   #line 57`

3. Create master user on IRedMail for authentication all user using this master user.
    - `chmod 777 dovecot-master-user`
    - `doveadm pw -s SSHA512`

4. The output is use for password and will be encrypted SSH512.
`{SSHA512}xxxxxxxxx` 

5. Add a user and password that we have generated before on a file docker-master-user.
6. Change access grant on file dovecot-master-user to default.
`chmod 500 dovecot-master-user`

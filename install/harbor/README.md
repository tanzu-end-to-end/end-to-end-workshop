# Installing Harbor

Ensure that you have prepared a **values.yaml** file, by customizing the values-example.yaml file in the root of this repo.

From this directory in the repo, execute:

```
./install-harbor.sh /path/to/my/values.yaml
```

If you wish to change the default password for Harbor, log in after the install is complete, and use the "Change Password" dropdown. Be sure that the password in your **values.yaml** file matches the new password that you set.
# bash-releaser
Some bash scripts that call the Github API (specifically, the releases and assets API)

# Install
- make sure you install curl
- this code requires bash, but some bash-like shells might work too
- make sure you echo out your Github Personal Access Token into the same directory as the `runner` script
```
echo -ne 'ghp_mysupersecrettoken' > token
```

# Running
All scripts are accessible by the `runner` script
```
# Example. To list the releases for this repo, I would use:
./runner list wmerfalen bash-release
```

# Usage screen
To see the Usage/help screen, run:
```
./runner --help
```

# Get a list of releases for `REPO` owned by `USER`
```
./runner list USER REPO       
```


# Create a release based on a tag
```
./runner create USER REPO TAG NAME_OF_RELEASE
```
## Please note: the TAG must already exist in that REPO

# List release assets tied to a specific release ID
```
./runner list-release-assets USER REPO RELEASE_ID
```

# Upload a `.zip` file to a release specified by release ID
```
./runner upload-release-asset USER REPO RELEASE_ID PATH_TO_FILE NAME_OF_ASSET

# Example
./runner upload-release-asset wmerfalen bls 12345678 ~/documents/ubuntu-x86-64-focal.zip ubuntu-x86-64-focal.zip
```

# Upload a `.tar.gz` file to a release specified by release ID
```
./runner upload-targz-release-asset USER REPO RELEASE_ID PATH_TO_FILE NAME_OF_ASSET

# Example
./runner upload-targz-release-asset wmerfalen bls 12345678 ~/documents/ubuntu-x86-64-focal.tar.gz ubuntu-x86-64-focal.tar.gz
```

# Delete release asset by asset ID
```
./runner delete-release-asset USER REPO ASSET_ID

# Example
./runner delete-release-asset wmerfalen bls 12345678
```

# Debugging
Sometimes you might want to pass in arguments to a script without actually calling the `curl` binary. This might be useful for a number of ways. If you'd like this functionality, set an environment variable named `GITHUB_DONT_SEND` to any value and all scripts will exit just prior to calling `curl`.

# License
MIT

# Version
v1.1.0

# Upcoming features


# How versioning works
x - major release
y - minor release
z - build number
```
Example:

v3.0.4 
3 - major
0 - minor
4 - build number
```

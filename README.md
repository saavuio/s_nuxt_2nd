# What is this?

Base template for a Nuxt.js app that runs everything through Docker.

Depends only on Docker and Bash.

The main idea behind this is to provide a consistent set of development tools
across multiple repositories without having to define and configure them again
for each service with a similar structure.

There is also an attempt to provide some future-proofing in this constantly
changing JS-soup by running everything in a containerized environment with
pretty strict versioning of different dependencies. Of course, even this won't
really prevent things from breaking in random ways due to external changes
every now and then.

We use these bases internally to prevent ending up with huge variation of
different kinds of configurations with our services.

## Quick Start

### Create a new base to your current directory

NOTE: this will download a bunch of files to your current directory, so make
sure the directory is empty before doing this:

```sh
mkdir -p s_base/s_nuxt_2nd && wget https://github.com/saavuio/s_nuxt_2nd/raw/v1/init.sh -P s_base/s_nuxt_2nd && chmod +x ./s_base/s_nuxt_2nd/init.sh && ./s_base/s_nuxt_2nd/init.sh
```

### Start a development server

When the build is done, run it with:

```sh
./scripts/dev.sh
```

## Local Development

When making changes to the base, it can be benefitial to skip getting the base
and node_modules from git. To develop the base locally, knowing the following
will help a lot.

### Skip git-clone on init temporarily

Swap comments on lines marked with: "UNCOMMENT FOR LOCAL/REMOTE SETUP" and make
sure path matches your local path to this repository (can also be made absolute
to be easier to handle).

Remember to restore the remote setup on commit.

### Build node_modules_cache for local setup

Run `./update-deps.sh`

Without this, the init will fail with:

```
mv: cannot stat './s_nuxt_2nd/base/node_modules_cache': No such file or directory
```

### Oneliner for local init

NOTE: swap out $LOCAL_PATH with your local path to this repository or export
the variable before running this (for example `export LOCAL_PATH=../../s_nuxt_2nd`).

```
mkdir -p ./s_base/s_nuxt_2nd && cp $LOCAL_PATH/init.sh ./s_base/s_nuxt_2nd/init.sh && ./s_base/s_nuxt_2nd/init.sh
```

### Quick testing withing the container

To do some quickly try some `node_module` updates etc. without rerunning the
whole build process, you can do it faster by making the changes directly from
within the container and copying them out to the base if things work out.

```
# enter the container (also exposing the port of your app to allow testing)
PTO=34481 ./s_nuxt_2nd.sh bash

# This will open up a bash prompt within the container, where you can do basically anything as you would run them locally.
# For example:
# To upgrade a package, you can use: yarn upgrade package-name (or: yarn add nuxt@0.8.1)
# To run the service, you can use: yarn run dev (might need some extra params, see dev.sh)
# To edit files within the container, you can use `vi`

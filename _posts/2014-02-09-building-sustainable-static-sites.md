---
title: "Building an Environmentally Sustainable Static Site"
author: Tamas Nagy
layout: post
tags: [meta, green]
categories: blog
---
The Internet may seem to be a magical, ethereal thing, but behind all the beautiful CSS are racks and racks of servers. The unfortunate reality is that Internet companies and datacenters contribute more than 830 million tons of CO2 to the atmosphere, annually. This is equivalent to the entire aviation industry, at approximately 2% of global emissions. Especially worrisome is the rate of growth, projections suggest that the Internet's contribution will double by 2020 [@itemissions].

This does not have to be the case. [GreenQloud](http://greenqloud.com), an Infrastructure as a Service (IaaS) provider based out of Iceland, offers S3 and EC2 compatible instances powered by 100% renewable, sustainable hydro and geothermal energy for very reasonable prices. They also have a very easy way of hosting static sites: just a simple public-facing S3 bucket. This way we get great performance for cheap. Convinced? Let's get our hands dirty.

## Greening our Cloud
We first need to sign up through GreenQloud's clean and modern interface at <http://my.greenqloud.com>. Regrettably, they do not have trial period so you will need to enter your credit card information to continue. 

Finally, the fun part. Let's start by creating a bucket:

<img class="img-responsive" src="/images/posts/gq_screen3.png"/> 

**Note:** the name of bucket must be unique across all GreenQloud accounts and must match the custom domain. So for <http://example.com> the bucket name would be ```example.com```.

Now let's make sure that everyone knows that this is going to be a website and set the correct permissions:

<img class="img-responsive" src="/images/posts/gq_screen4.png"/> 

## Getting Programmatic Access
Next, we'll need to get programmatic access to StorageQloud. Start by accessing your public and private keys using the API access menu option:

<img class="img-responsive" src="/images/posts/gq_screen1.png"/> 

Then, download the install scripts:

<img class="img-responsive" src="/images/posts/gq_screen2.png"/> 

If you are using CentOS or Ubuntu then you can just run the respective script and you are ready to go on to the next part, but if you are on Mac, like me, then we'll have to take a couple extra steps:

1. Install "s3cmd". If you are using Homebrew then the following will do the trick:

	```bash
	brew install s3cmd
	```

2. Move GreenQloud's S3 Configuration file to the right place:

	```bash
	mv _s3cfg $HOME/.s3cfg
	```

3. And elevate the privileges: 

	```bash
	sudo chmod 600 $HOME/.s3cfg
	```

Next, go to the directory where you are keeping your static site's files. You can either use ``s3cmd`` from command-line or use a quick and dirty script to deploy your files to GreenQloud. I chose the latter:

```bash
#! /bin/bash
# Deployment script to GreenQloud

jekyll build

echo "Deploying changes..."

s3cmd sync --exclude '.DS_Store' --exclude '.git/*' --exclude-from '.gitignore' --delete-removed --acl-public _site/ s3://somebucket
```

Alright. So what is happening? I first run Jekyll to build my static site and then I use ``s3cmd`` to sync the changes to my GreenQloud bucket. I exclude some files[^1]. The ```--delete-removed``` flag removes files on the server that are no longer present locally. The ```--acl-public``` flag sets the access level to public and ```_site/``` is the location of Jekyll's output. ```s3://somebucket``` is where you would place the name of your bucket.

And that's it! Your results should now be viewable at <http://YOUR-BUCKET.w.greencloud.com>. Now you could opt to make your site even better by using git hooks to automate the process further and hooking up your custom domain.

Thanks to the tools offered by GreenQloud, we are now running an environmentally sustainable static site that is both convenient and inexpensive. It may not be much, but every little bit helps. Plus, it's a nifty little weekend project.

## References

[^1]: S3 uses the same style ignore file as git so this could be consolidated.

---
references:
- issue: 1
  page: 485-492
  title: Methodologies for assessing the use-phase power consumption and greenhouse
    gas emissions of telecommunications network services
  volume: 47
  id: itemissions
  issued:
    date-parts:
    - - 2013
  author:
  - given: Chien A.
    family: Chan
  - given: "André F."
    family: Gygax
  - given: Elaine
    family: Wong
  - given: Christopher A.
    family: Leckie
  - given: Ampalavanapillai
    family: Nirmalathas
  - given: Daniel C.
    family: Kilper
  container-title: Environmental Science & Technology
  URL: http://pubs.acs.org/doi/abs/10.1021/es303384y
  type: article-journal
  DOI: 10.1021/es303384y
---
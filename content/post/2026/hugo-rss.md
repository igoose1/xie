---
title: "Include Full Content in RSS with Hugo"
slug: "hugo-rss"
date: 2026-08-21T02:40:28+08:00
tags:
 - 
---

RSS is a web-standard for subscribing to blogs. You, a reader, can enter this web-site's URL into a feed reader program and it'll fetch updates. That's how you subscribe to a blog without social medias and "Algorithms".

I use [hugo][hugo] to build pages into something browsers understand. Hugo supports RSS out-of-the-box but I never validated it. I'd checked it a few times from my phone, noticed that my posts have correct "descriptions" and it was good enough.

[hugo]: https://gohugo.io/

This time I ran a feed validator and looked closer at how posts are sent to my RSS reader ([Feeder][feeder] on Android). First, I fixed hanging fruits marked by the validator. Second, I started to include full content of posts into the feed. I frequently use RSS and I know that the best experience I get are from authors I can read without leaving my RSS reader. An hour ago, this xie blog didn't include the content but it was easy to fix.

[feeder]: https://f-droid.org/packages/com.nononsenseapps.feeder/

To include your blog's content with Hugo, you need to update your `layout/rss.xml`.

Take a copy of the last file:

```sh
curl -L https://raw.githubusercontent.com/gohugoio/hugo/refs/heads/master/tpl/tplimpl/embedded/templates/rss.xml > layouts/rss.xml
```

Declare a "Content Module" namespace:

```diff
 {{- printf "<?xml version=\"1.0\" encoding=\"utf-8\" standalone=\"yes\"?>" | safeHTML }}
-<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
+<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom" xmlns:content="http://purl.org/rss/1.0/modules/content/">
        <channel>
                <title>{{ if eq .Title .Site.Title }}{{ .Site.Title }}{{ else }}{{ with .Title }}{{ . }} on {{ end }}{{ .Site.Title }}{{ end }}</title>
                <link>{{ .Permalink }}</link>
```

Add a content into each item:

```diff
                                {{- with $authorEmail }}<author>{{ . }}{{ with $authorName }} ({{ . }}){{ end }}</author>{{ end }}
                                <guid>{{ .Permalink }}</guid>
                                <description>{{ .Summary | transform.XMLEscape | safeHTML }}</description>
+                               <content:encoded>{{ .Content | transform.XMLEscape | safeHTML }}</content:encoded>
                        </item>
                {{- end }}
        </channel>
```

Now your posts are fully included into your RSS!

This is invalid on relative URLs (e.g. images) and maybe breaks on something else I haven't thought of. Nevertheless, feed readers still can render the rest and it's definitely a better UX than it used to be. And a new "good enough"!

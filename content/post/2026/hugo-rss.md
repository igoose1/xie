---
title: "Include Full Content in RSS with Hugo"
slug: "hugo-rss"
date: 2026-08-21T02:40:28+08:00
tags:
 - 
---

RSS is a web-standard for subscribing to web-blogs. You, as a reader, can enter this web-site's URL into a feed reader program and it'll fetch updates. That's how you can subscribe to the blog without social media and "Algorithms".

I use [hugo][hugo] to generate this blog. RSS is included out-of-the box but I never validated it. I checked it a few times from my phone, noticed it my blogs have a correct "description" to each post and it was good enough.

[hugo]: https://gohugo.io/

I frequently use RSS and I know that the best experience I get from authors who include the whole content into their RSS. I read these blogs without leaving my RSS reader ([Feeder][feeder] on Android). An hour ago, this xie blog didn't include the content but I've just fixed it.

[feeder]: https://f-droid.org/packages/com.nononsenseapps.feeder/

To include your blog's content with Hugo, you need to update your `layout/rss.xml`.

Take a copy of the last file:

```sh
curl -L https://raw.githubusercontent.com/gohugoio/hugo/refs/heads/master/tpl/tplimpl/embedded/templates/rss.xml > layouts/rss.xml
```

Declare a "Content Module" namespace:

```diff
diff --git i/layouts/rss.xml w/layouts/rss.xml
index 2314f42..ee7b2e5 100644
--- i/layouts/rss.xml
+++ w/layouts/rss.xml
@@ -31,7 +31,7 @@
        {{- $pages = $pages | first $limit }}
 {{- end }}
 {{- printf "<?xml version=\"1.0\" encoding=\"utf-8\" standalone=\"yes\"?>" | safeHTML }}
-<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
+<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom" xmlns:content="http://purl.org/rss/1.0/modules/content/">
        <channel>
                <title>{{ if eq .Title .Site.Title }}{{ .Site.Title }}{{ else }}{{ with .Title }}{{ . }} on {{ end }}{{ .Site.Title }}{{ end }}</title>
                <link>{{ .Permalink }}</link>

```

Add a content into each item:

```diff
diff --git i/layouts/rss.xml w/layouts/rss.xml
index ee7b2e5..eaa48bf 100644
--- i/layouts/rss.xml
+++ w/layouts/rss.xml
@@ -61,6 +61,7 @@
                                {{- with $authorEmail }}<author>{{ . }}{{ with $authorName }} ({{ . }}){{ end }}</author>{{ end }}
                                <guid>{{ .Permalink }}</guid>
                                <description>{{ .Summary | transform.XMLEscape | safeHTML }}</description>
+                               <content:encoded>{{ .Content | transform.XMLEscape | safeHTML }}</content:encoded>
                        </item>
                {{- end }}
        </channel>
```

Now your posts are fully included into your RSS!

This would be invalid on relative URLs (e.g. images) and maybe breaks on something I haven't thought of but it's a better UX than it used to be. And a new "good enough"!

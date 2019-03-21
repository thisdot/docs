---
class: post-blog post-detail
type: Blog
$title: Why AMP Caches exist
id: why-amp-caches-exist
author: Paul Bakaus
role:  AMP Developer Advocate, Google
origin: "https://amphtml.wordpress.com/2017/01/13/why-amp-caches-exist/amp/"
excerpt: "The following was posted on Medium by Paul Bakaus, AMP Developer Advocate, Google. Caches are a fundamental piece of the Accelerated Mobile Pages (AMP) Project, yet one of the most misunderstood components. Every day, developers ask us why they can’t just get their AMP pages onto some AMP surfaces (e.g. Google) without linking through the [&#8230;]"
avatar: https://www.gravatar.com/avatar/9a2d68554d8d1655a3fb3e2a50aee909
date_data: 2017-01-13T12:19:43-08:00
$date: January 13, 2017
$parent: /content/latest/list-blog.html

components:
  - social-share
---

<div class="amp-wp-article-content">
<p><em>The following was <a href="https://medium.com/@pbakaus/why-amp-caches-exist-cd7938da2456#.u99e695t5" target="_blank">posted on Medium</a> by Paul Bakaus, AMP Developer Advocate, Google.</em></p>
<p><span style="font-weight:400;">Caches are a fundamental piece of the Accelerated Mobile Pages (AMP) Project, yet one of the most misunderstood components. Every day, developers ask us why they can’t just get their AMP pages onto some AMP surfaces (e.g. Google) without linking through the cache. Some worry about the cache model breaking the origin model of the web, others worry about analytics attribution and canonical link sharing, and even others worry about their pages being hosted on servers out of their control. Let’s look at all of these, and understand why the caches exist.</span></p>
<p><span style="font-weight:400;">While AMP Caches introduce some trade-offs, they do work in the user’s favor to ensure a consistently fast and user-friendly experience. The caches are designed to:</span></p>
<ul>
<li style="font-weight:400;"><span style="font-weight:400;">Ensure that all AMP pages are actually valid AMP.</span></li>
<li style="font-weight:400;"><span style="font-weight:400;">Allow AMP pages to be preloaded efficiently and safely.</span></li>
<li style="font-weight:400;"><span style="font-weight:400;">Do a myriad of additional user-beneficial performance optimizations to content.</span></li>
</ul>
<p><span style="font-weight:400;">But first:</span></p>
<h2><span style="font-weight:400;">The Basics: Analytics attribution and link sharing</span></h2>
<p><span style="font-weight:400;">Even though the AMP Cache model doesn’t follow the </span><a href="https://tools.ietf.org/html/rfc6454"><span style="font-weight:400;">origin model</span></a><span style="font-weight:400;"> (serving your page from your own domain), we attribute all traffic to you, the publisher. Through the </span><a href="https://www.ampproject.org/docs/reference/components/amp-analytics"><span style="font-weight:400;">&lt;amp-analytics&gt;</span></a><span style="font-weight:400;"> tag, AMP supports a growing number of analytics providers (</span><a href="https://www.ampproject.org/docs/reference/components/amp-analytics#analytics-vendors"><span style="font-weight:400;">26 to date</span></a> and growing<span style="font-weight:400;">!), to make sure you can measure your success and the traffic is correctly attributed.</span></p>
<p><span style="font-weight:400;">When I ask users and developers about why they want to “click-through” to the canonical page from a cached AMP result, the answer is often about link sharing. And granted, it’s annoying to copy a google.com URL instead of the canonical URL. However, the issue isn’t as large of a problem as you’d think: Google amends its cached AMP search results with Schema.org and OpenGraph metadata, so posting the link to any platform that honors these should result in the canonical URL being shared. That being said, there are more opportunities to improve the sharing flow. In native web-views, one could share the canonical directly if the app supports it, and, based on users’ feedback, the team at Google is working on enabling easy access to the canonical URL on all its surfaces.</span></p>
<p><span style="font-weight:400;">With these cleared up, let’s dig a little deeper.</span></p>
<h2><span style="font-weight:400;">When the label says AMP, you get AMP</span></h2>
<p><span style="font-weight:400;">The AMP Project consists of an ecosystem that depends on strict validation, ensuring that very high performance and quality bars are met. One version of a validator can be used during development, but the AMP Cache ensures the validity at the last stage, when presenting content to the user.</span></p>
<p><span style="font-weight:400;">When an AMP page is requested from an AMP Cache for the first time, said cache validates the document first, and won’t offer it to the user if it detects problems. Platforms integrating with AMP (e.g. Bing, Pinterest, Google) can choose to send traffic directly to the AMP page on the origin or optionally to an AMP Cache, but validity can only be guaranteed when served from the cache. </span><b>It ensures that when users see the AMP label, they’ll almost always get a fast and user friendly experience</b><span style="font-weight:400;">. (Unless you find a way to make a slow-but-valid AMP page, which is hard, but not impossible… I&#8217;m looking at you, big web fonts).</span></p>
<h2><span style="font-weight:400;">Pre-rendering is a bigger deal than you think</span></h2>
<p><span style="font-weight:400;">If you take anything away from this post, it’s that pre-rendering, especially the variant in AMP, greatly outweighs any speed gains you could theoretically get by hosting directly from an origin server. Even if the origin server is closer to your users, which would shave off a few milliseconds — rare but possible — pre-rendering will almost certainly drive the most impact.</span></p>
<h3><span style="font-weight:400;">Perceived as much faster</span></h3>
<p><span style="font-weight:400;">In fact, pre-rendering can often save you seconds, not milliseconds. The impact of pre-rendering, as opposed to the various other performance optimizations in the AMP JS library, can be pretty dramatic, and contributes largely to the “instant-feel” experience.</span></p>
<h2><img data-attachment-id="919" data-permalink="https://amphtml.wordpress.com/2017/01/13/why-amp-caches-exist/cache_post/" data-orig-file="https://amphtml.files.wordpress.com/2017/01/cache_post.png?w=660" data-orig-size="633,218" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;0&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;0&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;0&quot;,&quot;iso&quot;:&quot;0&quot;,&quot;shutter_speed&quot;:&quot;0&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;0&quot;}" data-image-title="cache_post" data-image-description="" data-medium-file="https://amphtml.files.wordpress.com/2017/01/cache_post.png?w=660?w=300" data-large-file="https://amphtml.files.wordpress.com/2017/01/cache_post.png?w=660?w=633" class="alignnone size-full wp-image-919" src="https://amphtml.files.wordpress.com/2017/01/cache_post.png?w=660" alt="cache_post" srcset="https://amphtml.files.wordpress.com/2017/01/cache_post.png 633w, https://amphtml.files.wordpress.com/2017/01/cache_post.png?w=150 150w, https://amphtml.files.wordpress.com/2017/01/cache_post.png?w=300 300w" sizes="(max-width: 633px) 100vw, 633px"   /></h2>
<h3><span style="font-weight:400;">Very efficient compared to full pre-rendering</span></h3>
<p><span style="font-weight:400;">If that was the whole story, we could just as easily pre-render AMP pages from their origin servers. If we did, we couldn’t guarantee that a page is valid AMP on the origin, and valid AMP is critically important for the custom pre-rendering the AMP JS library provides: Pre-rendering in AMP, as opposed to just pre-rendering an entire page through something like </span><a href="https://en.wikipedia.org/wiki/Link_prefetching"><span style="font-weight:400;">link prefetching</span></a><span style="font-weight:400;">, also limits the use of the users’ bandwidth, CPU and battery!</span></p>
<p><span style="font-weight:400;">Valid AMP documents behave “cooperatively” during the pre-render stage: Only assets in the first viewport get preloaded, and no third-party scripts get executed. This results in a much cheaper, less bandwidth and CPU-intensive preload, allowing platforms to prerender not just the first, but a few of the AMP pages a user will likely click on.</span></p>
<h3><span style="font-weight:400;">Safe to embed</span></h3>
<p><span style="font-weight:400;">Because AMP Caches can’t rely on browser pre-rendering (see the section above), normal navigation from page to page doesn’t work. So in the AMP caching model, a page needs to be opened inline on a platform page. AMP Caches ensure that the requested AMP page can do that safely:</span></p>
<ul>
<li style="font-weight:400;"><span style="font-weight:400;">Validator ensures no </span><a href="https://en.wikipedia.org/wiki/Cross-site_scripting"><span style="font-weight:400;">Cross-Site Scripting</span></a><span style="font-weight:400;"> (XSS) in main document.</span></li>
<li style="font-weight:400;"><span style="font-weight:400;">On top of the validator, the AMP Cache parses and then re-serializes the document in an unambiguous fashion (this means that it does not rely on HTML5 error correction). This ensures that browser parsing bugs and differences cannot lead to XSS.</span></li>
<li style="font-weight:400;"><span style="font-weight:400;">The cache applies a </span><a href="https://developer.chrome.com/extensions/contentSecurityPolicy"><span style="font-weight:400;">Content Security Policy</span></a><span style="font-weight:400;"> (CSP). This provides additional defense-in-depth against XSS attacks.</span></li>
</ul>
<h3><span style="font-weight:400;">Additional privacy</span></h3>
<p><span style="font-weight:400;">In addition, the AMP Caches remove one important potential privacy issue from the pre-render: When you do a search on a content platform preloading AMP pages on the result page, none of the preloaded AMP pages will ever know about the fact that they’ve been preloaded.</span></p>
<p><span style="font-weight:400;">Think about it this way: Say I search for “breakfast burrito”. If you know me well, you know I obviously searched for </span><a href="https://www.youtube.com/watch?v=prPjpwsGiws"><span style="font-weight:400;">Parry Gripp’s song</span></a><span style="font-weight:400;"> with the same name. But the search result page also shows me a couple of AMP search results from fast food chains that sell actual breakfast burritos. For the next month, I wouldn’t want to see actual breakfast burritos everywhere even though I didn’t click on these links (even though&#8230;maybe I do&#8230;mhh..), and an advertiser wouldn’t want to waste dollars on me for pointless re-marketing ads on all the burritos. Since AMP hides the preload from the publisher of the AMP page and related third parties, it’s a win win scenario for users and advertisers.</span></p>
<h2><span style="font-weight:400;">Auto-optimizations that often result in dramatic speed increase</span></h2>
<p><span style="font-weight:400;">The AMP Cache started out with all of the above, but has since added a number of transformative transformations (heh) to its feature roster. Among those optimizations:</span></p>
<ul>
<li style="font-weight:400;"><span style="font-weight:400;">Consistent, fast and free content delivery network for all content (not just big publishers).</span></li>
<li style="font-weight:400;"><span style="font-weight:400;">Optimizes HTML through measures such as bringing scripts into the ideal order, removing duplicate script tags and removing unnecessary quotes and whitespace.</span></li>
<li style="font-weight:400;"><span style="font-weight:400;">Rewrites JavaScript URLs to have infinite cache time.</span></li>
<li style="font-weight:400;"><a href="https://developers.googleblog.com/2017/01/google-amp-cache-amp-lite-and-need-for.html"><span style="font-weight:400;">Optimizes images</span></a><span style="font-weight:400;"> (a 40% average bandwidth improvement!)</span></li>
</ul>
<p><span style="font-weight:400;">On the image compression side alone, Google, through its cache, is doing lossless (without </span><i><span style="font-weight:400;">any</span></i><span style="font-weight:400;"> visual change, e.g. removes EXIF data) and lossy (without </span><i><span style="font-weight:400;">noticeable</span></i><span style="font-weight:400;"> visual change) compression. In addition, it converts images to WebP for browsers that support it and automatically generates srcset attributes (so-called responsive images) if they’re not already available, generating and showing correctly sized images to each device. </span></p>
<h2><span style="font-weight:400;">Isn’t there a better way of doing this?</span></h2>
<p><span style="font-weight:400;">Look, I hear you. The provider of an AMP Cache is mirroring your content. It’s an important role and comes with great responsibility. If the cache provider were to do something truly stupid, like inserting obnoxious ads into every AMP page, AMP would stop being a viable solution for publishers, and thus wither away.</span></p>
<p><span style="font-weight:400;">Remember, AMP has been created together with publishers, as a means to make the mobile web better for publishers, users and platforms. It’s why the AMP team has released </span><a href="https://github.com/ampproject/amphtml/blob/master/spec/amp-cache-guidelines.md"><span style="font-weight:400;">strict guidelines</span></a><span style="font-weight:400;"> for AMP Caches. To give you two interesting excerpts, the guidelines state that your content needs to provide “a faithful visual and UX reproduction of source document”, and cache providers must pledge that they will keep URLs working indefinitely, even after the cache itself may be decommissioned. These, and many more rules, ensure that a cache doesn’t mess with your content.</span></p>
<p><span style="font-weight:400;">Most importantly, there’s plenty of room for more than one AMP Cache – in fact, Cloudflare </span><a href="https://blog.cloudflare.com/accelerated-mobile/"><span style="font-weight:400;">just announced</span></a><span style="font-weight:400;"> their own! With these </span><a href="https://github.com/ampproject/amphtml/blob/master/spec/amp-cache-guidelines.md"><span style="font-weight:400;">AMP Cache guidelines</span></a><span style="font-weight:400;"> released, other infrastructure companies are welcome to create new AMP Caches, as long as they follow the rules. It’s then up to the platform integrating AMP to pick their favorite cache.</span></p>
<h2><span style="font-weight:400;">From cache to web standards?</span></h2>
<p><span style="font-weight:400;">You just read about all the wins and trade-offs the AMP Caches do to provide an instant-feeling, and user friendly mobile web experience. What if we could get to many of the same awesome optimizations without the trade-offs, and without involving a cache at all?</span></p>
<p><span style="font-weight:400;">Personally, I dream of future, still-to-be-invented web standards that would allow us to get there – to move beyond cache models (like a static layout system to know how a page will look like before any assets are loaded). </span></p>
<p><span style="font-weight:400;">In 2016, we’ve done our first baby steps with the </span><a href="https://timkadlec.com/2016/02/a-standardized-alternative-to-amp/"><span style="font-weight:400;">CPP</span></a><span style="font-weight:400;">, which turned into the </span><a href="https://github.com/WICG/feature-policy"><span style="font-weight:400;">Feature Policy</span></a><span style="font-weight:400;">: A way of saying things like “I disallow document.write on my site, and any third parties in any iframes that get loaded”. More advanced concepts like static layouting and safe prerendering require far-fetching changes to the web platform, but hey – just like forward time travel, it’s not impossible, just very, very difficult <img src="https://s0.wp.com/wp-content/mu-plugins/wpcom-smileys/twemoji/2/72x72/1f642.png" alt="🙂" class="wp-smiley" style="height: 1em; max-height: 1em;" /></span></p>
<p><span style="font-weight:400;">Join me in figuring this out by getting in touch on </span><a href="https://twitter.com/pbakaus"><span style="font-weight:400;">Twitter</span></a><span style="font-weight:400;"> or </span><a href="https://docs.google.com/a/google.com/forms/d/e/1FAIpQLSd83J2IZA6cdR6jPwABGsJE8YL4pkypAbKMGgUZZriU7Qu6Tg/viewform?fbzx=4406980310789882877"><span style="font-weight:400;">Slack</span></a><span style="font-weight:400;">, and know that I’ll always have an open ear for your questions, ideas and concerns. Onwards!</span></p>
<p></p><br />  <a rel="nofollow" href="http://feeds.wordpress.com/1.0/gocomments/amphtml.wordpress.com/910/"><img alt="" border="0" src="http://feeds.wordpress.com/1.0/comments/amphtml.wordpress.com/910/" /></a> <img alt="" border="0" src="https://pixel.wp.com/b.gif?host=amphtml.wordpress.com&#038;blog=102788268&#038;post=910&#038;subd=amphtml&#038;ref=&#038;feed=1" width="1" height="1" />
</div>

---
title: bundle CSS corrupt my bookdown site on Netlify 
date: '2018-01-24'
slug: not-bundle-css-on-Netlify
categories: 2018
tags: []
authors: []
---



> Premature optimization is the root of all evil
>
> --- Donald Knuth

My bookdown site on Netlify collapsed. I immediately know CSS is ruined then waste several minutes investigate the problem. 

When I was about to get despaired, I suddenly found the local website works well. According to that, I found the problem results from an optimization option:

```
CSS
  |---- Bundle CSS: Concatenate consecutive CSS files together to reduce HTTP requests.
```

To conclude, don't set `Bundle CSS` on Netlify, at least for `index.html` of bookdown site (I use a relative link for css there).

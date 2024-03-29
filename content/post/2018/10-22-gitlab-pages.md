---
title: project pages -- case study in GitLab 
date: '2018-10-22'
slug: gitlab-pages
categories: 2018
tags: []
authors: []
---



# Beginning

Prof Lu asks me to to build a GitHub pages using custom domain. So I explore whether GitHub project pages can use custom domain.

I guess since the pages of repo `project` lives in `username.github.io/project`, it seems incompatible with `CNAME` record, which points one (sub)domain to another (sub)domain, i.e., the `/project` part is not allowed). 

But GitHub crashes since about 11:30 (Beijing time), after a lot of depression, I decide to try on GitLab. The configuration is more complicated, as GitLab asks you to also set TXT record for verifying your DNS.



# Curve to GitLab

The results quite surprised me. It turns out that for custom domain of project pages is also `dongzhuoer.gitlab.io`, the same as that of user pages. 

For example:

| repo                   | url                               | custom domain                     |
|------------------------|-----------------------------------|-----------------------------------|
| `dongzhuoer.gitlab.io` | <https://dongzhuoer.gitlab.io>    | <http://gitlab.ncrnalab.org/>     |
| `DBA`                  | <http://dongzhuoer.gitlab.io/DBA> | <http://dba.gitlab.ncrnalab.org/> |


Then I can't hesitate to ask a question: what if I create `DBA/index.html` in `dongzhuoer.gitlab.io` repo?

- <https://dongzhuoer.gitlab.io/DBA/> is still homepage of `DBA`
- <http://gitlab.ncrnalab.org/DBA/> displays `DBA/index.html`



# Back to GitHub

In the evening, I can normally use GitHub, but the build for Pages pends. I had no option but to create demo files and wait for result.
Finally GitHub Pages recovers in the next day. 

It turns out the case for GitHub is nearly _identical_ to that of GitLab. Except that after you enable custom domain, <https://dongzhuoer.gitlab.io/DBA/> would automatically jumps to <http://gitlab.ncrnalab.org/>, given that you have _enforced HTTPS_. Thus we lose the chance to ask the above question for GitHub.



# Afterword

The following official posts may be helpful:

- [About supported custom domains](https://help.github.com/articles/about-supported-custom-domains/)
- [Custom domain redirects for GitHub Pages sites](https://help.github.com/articles/custom-domain-redirects-for-github-pages-sites/)
- [User, Organization, and Project Pages](https://help.github.com/articles/user-organization-and-project-pages/)

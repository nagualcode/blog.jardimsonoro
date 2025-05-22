#!/bin/bash

#SETTINGS:
source="content"
destination="../jardimsonoro"
theme="theme"
###########################

#Generate Blog
if [[ ! -d "$destination" ]]; then echo "${destination} not found!"; exit 1; fi
mkdir "${destination}/blog" 2>/dev/null
pelican "$source" -s pelicanconf.py -o "${destination}/blog" -t "$theme"
########################

#Copy IMGs to folder
rsync -a "$source"/img "${destination}/blog"
##########################


#Generate Linktree
mkdir "${destination}/linktree" 2>/dev/null
cp "${destination}/blog/linktree.html" "${destination}/linktree/index.html"
############################


####sitemapfix
grep -v '</urlset>' ../jardimsonoro/blog/sitemap.xml >../jardimsonoro/sitemap.xml
rm ../jardimsonoro/blog/sitemap.xml
cat ../jardimsonoro/indexmap.xml >> ../jardimsonoro/sitemap.xml
####################

echo "Done!"

commit

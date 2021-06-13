#!/bin/bash
cd ~/myblogs
git reset --hard master
git pull
cd /root/www/myHexoBlog/blog/source/_posts
rm -f *.md
cp -r ~/myblogs/*.md .
rm -f README.md
cd /root/www/myHexoBlog/blog
echo "run hexo"
source ~/.bashrc
npm install -g hexo-cli
/root/.nvm/versions/node/v16.3.0/bin/hexo clean
/root/.nvm/versions/node/v16.3.0/bin/hexo g
/root/.nvm/versions/node/v16.3.0/bin/hexo s

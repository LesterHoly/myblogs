#!/bin/bash
echo "run hexo"
source ~/.bashrc
/root/.nvm/versions/node/v16.3.0/bin/hexo clean
/root/.nvm/versions/node/v16.3.0/bin/hexo g
/root/.nvm/versions/node/v16.3.0/bin/hexo s

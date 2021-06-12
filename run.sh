#!/bin/bash
echo "run hexo"
source ~/.bashrc
hexo clean
hexo g
hexo s

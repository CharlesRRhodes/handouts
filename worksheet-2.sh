#!/bin/sh

## Configure git
git config --global user.name CharlesRRhodes
git config --global user.email charlesrrhodes@gmail.com

## Change the "origin" remote URL and push
git remote set-url origin git@github.com:CharlesRRhodes/handouts.git

## Set the SESYNC-CI repository upstream and pull updates
git remote add upstream https://github.com/sesync-ci/handouts.git
git pull upstream master

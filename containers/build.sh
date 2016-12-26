#!/bin/sh

IMAGE=$1

docker build -t astro:$IMAGE ./$IMAGE

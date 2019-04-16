#!/bin/bash
docker build -t jmeter . && docker image ls && docker run jmeter

#!/bin/bash
echo $$ | sha256sum | cut -c1-8  

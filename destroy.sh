#!/bin/sh

read -p "Are you sure you want to destroy all of your Vagrant VMs? [Enter] "

vagrant destroy -f
rm -rf ~/.vagrant.d/boxes/*

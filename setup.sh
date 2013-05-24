#!/bin/sh

# Get start time
START=$(date +%s)

# Max concurrent procs for xargs
MAX_PROCS=4
 
parallel_provision() {
    while read box; do
        echo "Provisioning '$box'. Output will be in: logs/$box.log" 1>&2
        echo $box
    done | xargs -P $MAX_PROCS -I"BOXNAME" \
        sh -c 'vagrant provision BOXNAME > logs/BOXNAME.log 2>&1 || echo "Error Occurred: BOXNAME"'
}

# Remove old log files
rm -f logs/*.log
 
# Start boxes sequentially to avoid vbox explosions
vagrant up --no-provision

# Parse the JSON file to figure out which boxes we need to provision
cat vagrant.json | ruby -e "require 'rubygems'; require 'json'; JSON[STDIN.read]['boxes'].each_pair do |box,options| if options['enabled']: puts box end; end;" | parallel_provision

# Done
END=$(date +%s)
DIFF=$(( $END - $START ))
echo "Servers deployed in $DIFF seconds"

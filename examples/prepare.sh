#!/bin/bash

set -euo pipefail

source env.sh

# Prepare repository
(
	cd repository
	mkdir -pv {incoming,morgue,log,temp}/workshop-testing
	reprepro -vvv createsymlinks
)

echo
echo "Add something like 
--8<-----------------------------------------------------------------
package config;

\$cfg{'workshop'} = {
	method        => 'copy',
	incoming      => '$PWD/repository/incoming/workshop-testing',
	dinstall_runs => 1,
};

1;
----------------------------------------------------------------->8--

to your ~/.dupload.conf"

# Fetch some source code to package
(
	cd packages
	mkdir -p perl
	(
		cd perl
		wget -c https://cpan.metacpan.org/authors/id/M/MS/MSTOCK/App-Scaffolder-0.001000.tar.gz
		wget -c https://cpan.metacpan.org/authors/id/M/MS/MSTOCK/App-Scaffolder-0.002000.tar.gz
	)
)

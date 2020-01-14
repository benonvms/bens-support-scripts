#!/bin/sh
# Author: Benedikt Frenzel <blog@ben-on-vms.com> 
#
# Purpose:
#  Identify all running VMs on the Host, and get the LRO Statistics
#

Switches=`vsish -e ls /net/portsets/ | awk -F\/ '{ print $1}'`
VmWorlds=`esxcli network vm list | egrep '^\s' | awk '{print $1}'`


printf "%-15s %-30s %12s %12s %12s\n" "VM World" "VM Name" "Port ID" "LRO pkts" "LRO bytes";
printf "%s\n" "=====================================================================================";

for world in ${VmWorlds}; do
	VmPorts=`esxcli network vm port list -w ${world} | egrep "Port ID:" | grep -v DV | grep -v Upl | awk '{print $3}'`
	for port in ${VmPorts}; do
		for switch in ${Switches}; do
			pkts=`vsish -e get /net/portsets/${switch}/ports/${port}/vmxnet3/rxSummary 2>/dev/null | grep "LRO pkts" | awk -F\: '{ print $2}'`
			name=`esxcli vm process list | grep -B1 ${world} | head -1`
			if [[ ! -z ${pkts} ]]; then
				bytes=`vsish -e get /net/portsets/${switch}/ports/${port}/vmxnet3/rxSummary 2>/dev/null | grep "LRO bytes" | awk -F\: '{ print $2}'`
				printf "%-15s %-30s %12s %12s %12s\n" ${world} ${name} ${port} ${pkts} ${bytes};
			fi
		done
	done
done

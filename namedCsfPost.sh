#!/bin/bash

#iptables -N DNSTESTRULE
#iptables -I INPUT -p udp --dport 53 -m string --algo bm --hex-string '|0000FF0001|' -j DNSTESTRULE
#iptables -A DNSTESTRULE -j LOG --log-prefix="*** DNSTESTRULE *** "

iptables -N DNSHEXINDROP
iptables -I INPUT -p udp -m string --hex-string "|00000000000103697363036f726700|" --algo bm --to 65535 --dport 53 -j DNSHEXINDROP 
iptables -I INPUT -p udp -m string --hex-string "|0000000000010472697065036e6574|" --algo bm --to 65535 --dport 53 -j DNSHEXINDROP 
iptables -I INPUT -p udp -m string --hex-string "|000000010000ff000100002923280000|" --algo bm --dport 53 -j DNSHEXINDROP
iptables -A DNSHEXINDROP -j LOG --log-prefix="*** DNSHEXINDROP DROPPED *** "
iptables -A DNSHEXINDROP -j DROP

iptables -N ANTIDDOS
iptables -I INPUT -p udp -m hashlimit --hashlimit-srcmask 24 --hashlimit-mode srcip --hashlimit-upto 30/m --hashlimit-burst 10 --hashlimit-name DNSTHROTTLE --dport 53 -j ANTIDDOS
#iptables -A ANTIDDOS -j LOG --log-prefix="*** ANTIDDOS ACCEPT *** "
iptables -A ANTIDDOS -j ACCEPT

iptables -N DNS8105DROP
iptables -I OUTPUT -p udp --sport 53 -m string --algo kmp --from 30 --to 31 --hex-string "|8105|" -j DNS8105DROP
iptables -A DNS8105DROP -j LOG --log-prefix="*** DNS8105DROP DROPPED *** "
iptables -A DNS8105DROP -j DROP

iptables -N DNSANYQUERY
iptables -I INPUT -p udp --dport 53 -m string --algo bm --hex-string '|0000FF0001|' -m recent --set --name dnsanyquery
iptables -I INPUT -p udp --dport 53 -m string --algo bm --hex-string "|0000FF0001|" -m recent --name dnsanyquery --rcheck --seconds 60 --hitcount 4 -j DNSANYQUERY
#iptables -A DNSANYQUERY -j LOG --log-prefix="*** DNSANYQUERY DROPPED *** "
iptables -A DNSANYQUERY -j DROP

# IPV6
ip6tables -N DNSHEXINDROP
ip6tables -I INPUT -p udp -m string --hex-string "|00000000000103697363036f726700|" --algo bm --to 65535 --dport 53 -j DNSHEXINDROP
ip6tables -I INPUT -p udp -m string --hex-string "|0000000000010472697065036e6574|" --algo bm --to 65535 --dport 53 -j DNSHEXINDROP
ip6tables -I INPUT -p udp -m string --hex-string "|000000010000ff000100002923280000|" --algo bm --dport 53 -j DNSHEXINDROP
ip6tables -A DNSHEXINDROP -j LOG --log-prefix="*** DNSHEXINDROP DROPPED *** "
ip6tables -A DNSHEXINDROP -j DROP

ip6tables -N ANTIDDOS
ip6tables -I INPUT -p udp -m hashlimit --hashlimit-srcmask 64 --hashlimit-mode srcip --hashlimit-upto 30/m --hashlimit-burst 10 --hashlimit-name DNSTHROTTLE --dport 53 -j ANTIDDOS
#iptables -A ANTIDDOS -j LOG --log-prefix="*** ANTIDDOS ACCEPT *** "
ip6tables -A ANTIDDOS -j ACCEPT

ip6tables -N DNS8105DROP
ip6tables -I OUTPUT -p udp --sport 53 -m string --algo kmp --from 30 --to 31 --hex-string "|8105|" -j DNS8105DROP
ip6tables -A DNS8105DROP -j LOG --log-prefix="*** DNS8105DROP DROPPED *** "
ip6tables -A DNS8105DROP -j DROP

ip6tables -N DNSANYQUERY
ip6tables -I INPUT -p udp --dport 53 -m string --algo bm --hex-string '|0000FF0001|' -m recent --set --name dnsanyquery
ip6tables -I INPUT -p udp --dport 53 -m string --algo bm --hex-string "|0000FF0001|" -m recent --name dnsanyquery --rcheck --seconds 60 --hitcount 4 -j DNSANYQUERY
#ip6tables -A DNSANYQUERY -j LOG --log-prefix="*** DNSANYQUERY DROPPED *** "
ip6tables -A DNSANYQUERY -j DROP

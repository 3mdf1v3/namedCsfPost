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

iptables -N DNSINVALIDREC
iptables -I INPUT -p udp --dport 53 -m string --algo kmp --from 30 --hex-string "|01000001000000000000|" -j DNSINVALIDREC 
# iptables -A DNSINVALIDREC -j LOG --log-prefix="*** DNSINVALIDREC DROPPED *** "
iptables -A DNSINVALIDREC -j DROP

iptables -N DNS8105DROP
iptables -I INPUT -p udp --dport 53 -m string --algo kmp --from 30 --to 31 --hex-string "|8105|" -j DNS8105DROP
iptables -A DNS8105DROP -j LOG --log-prefix="*** DNS8105DROP DROPPED *** "
iptables -A DNS8105DROP -j DROP

iptables -N DNSANYQUERY
iptables -I INPUT -p udp --dport 53 -m string --algo bm --hex-string '|0000FF0001|' -m recent --set --name dnsanyquery
iptables -I INPUT -p udp --dport 53 -m string --algo bm --hex-string "|0000FF0001|" -m recent --name dnsanyquery --rcheck --seconds 10 --hitcount 5 -j DNSANYQUERY
#iptables -A DNSANYQUERY -j LOG --log-prefix="*** DNSANYQUERY DROPPED *** "
iptables -A DNSANYQUERY -j DROP


ip6tables -N DNSHEXINDROP
ip6tables -I INPUT -p udp -m string --hex-string "|00000000000103697363036f726700|" --algo bm --to 65535 --dport 53 -j DNSHEXINDROP
ip6tables -I INPUT -p udp -m string --hex-string "|0000000000010472697065036e6574|" --algo bm --to 65535 --dport 53 -j DNSHEXINDROP
ip6tables -I INPUT -p udp -m string --hex-string "|000000010000ff000100002923280000|" --algo bm --dport 53 -j DNSHEXINDROP
ip6tables -A DNSHEXINDROP -j LOG --log-prefix="*** DNSHEXINDROP DROPPED *** "
ip6tables -A DNSHEXINDROP -j DROP

ip6tables -N DNSINVALIDREC
ip6tables -I INPUT -p udp --dport 53 -m string --algo kmp --from 30 --hex-string "|01000001000000000000|" -j DNSINVALIDREC
# ip6tables -A DNSINVALIDREC -j LOG --log-prefix="*** DNSINVALIDREC DROPPED *** "
ip6tables -A DNSINVALIDREC -j DROP

ip6tables -N DNS8105DROP
ip6tables -I INPUT -p udp --dport 53 -m string --algo kmp --from 30 --to 31 --hex-string "|8105|" -j DNS8105DROP
ip6tables -A DNS8105DROP -j LOG --log-prefix="*** DNS8105DROP DROPPED *** "
ip6tables -A DNS8105DROP -j DROP

ip6tables -N DNSANYQUERY
ip6tables -I INPUT -p udp --dport 53 -m string --algo bm --hex-string '|0000FF0001|' -m recent --set --name dnsanyquery
ip6tables -I INPUT -p udp --dport 53 -m string --algo bm --hex-string "|0000FF0001|" -m recent --name dnsanyquery --rcheck --seconds 10 --hitcount 3 -j DNSANYQUERY
#ip6tables -A DNSANYQUERY -j LOG --log-prefix="*** DNSANYQUERY DROPPED *** "
ip6tables -A DNSANYQUERY -j DROP

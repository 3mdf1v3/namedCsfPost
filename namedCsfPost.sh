#!/bin/bash
iptables -I INPUT -p udp -m string --hex-string "|00000000000103697363036f726700|" --algo bm --to 65535 --dport 53 -j DROP
ip6tables -I INPUT -p udp -m string --hex-string "|00000000000103697363036f726700|" --algo bm --to 65535 --dport 53 -j DROP

iptables -I INPUT -p udp -m string --hex-string "|0000000000010472697065036e6574|" --algo bm --to 65535 --dport 53 -j DROP
ip6tables -I INPUT -p udp -m string --hex-string "|0000000000010472697065036e6574|" --algo bm --to 65535 --dport 53 -j DROP

# iptables -I INPUT -p udp --dport 53 -m string --from 50 --algo bm --hex-string '|0000FF0001|' -m recent --set --name dnsanyquery
# ip6tables -I INPUT -p udp --dport 53 -m string --from 50 --algo bm --hex-string '|0000FF0001|' -m recent --set --name dnsanyquery

iptables -A INPUT -p udp -m udp --dport 53 -m string --from 50 --algo bm --hex-string '|0000FF0001|' -m recent --set --name dnsanyquery --rsource
ip6tables -A INPUT -p udp -m udp --dport 53 -m string --from 50 --algo bm --hex-string '|0000FF0001|' -m recent --set --name dnsanyquery --rsource

iptables -A INPUT -p udp -m udp --dport 53 -m string --from 50 --algo bm --hex-string "|0000FF0001|" -m recent --name dnsanyquery --rcheck --seconds 10 --hitcount 1 -j DROP
ip6tables -A INPUT -p udp -m udp --dport 53 -m string --from 50 --algo bm --hex-string "|0000FF0001|" -m recent --name dnsanyquery --rcheck --seconds 10 --hitcount 1 -j DROP

iptables -I INPUT -p udp --dport 53 -m string --from 50 --algo bm --hex-string '|0000FF0001|' -m recent --name dnsanyquery --rcheck --seconds 60 --hitcount 4 -j DROP
ip6tables -I INPUT -p udp --dport 53 -m string --from 50 --algo bm --hex-string '|0000FF0001|' -m recent --name dnsanyquery --rcheck --seconds 60 --hitcount 4 -j DROP

iptables -I INPUT -p udp -m hashlimit --hashlimit-srcmask 24 --hashlimit-mode srcip --hashlimit-upto 30/m --hashlimit-burst 10 --hashlimit-name DNSTHROTTLE --dport 53 -j ACCEPT
ip6tables -I INPUT -p udp -m hashlimit --hashlimit-srcmask 64 --hashlimit-mode srcip --hashlimit-upto 30/m --hashlimit-burst 10 --hashlimit-name DNSTHROTTLE --dport 53 -j ACCEPT

iptables -I OUTPUT -p udp --source-port 53 -m string --algo kmp --from 30 --to 31 --hex-string "|8105|" -j DROP
ip6tables -I OUTPUT -p udp --source-port 53 -m string --algo kmp --from 30 --to 31 --hex-string "|8105|" -j DROP

iptables -I INPUT -p udp -m string --hex-string "|000000010000ff000100002923280000|" --algo bm --dport 53 -j DROP
ip6tables -I INPUT -p udp -m string --hex-string "|000000010000ff000100002923280000|" --algo bm --dport 53 -j DROP

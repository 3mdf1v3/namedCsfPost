# namedCsfPost
Custom csf iptables rules for bind traffic 

# Install
cd /root
git clone https://github.com/3mdf1v3/namedCsfPost.git
cd /etc/csf
ln -s /root/namedCsfPost/namedCsfPost.sh ./csfpost.sh
csf -r


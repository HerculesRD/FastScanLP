# FastScanLP
 Fast TCP scan 

 Usage: ./FastScanLP.sh < -H <IP> | -D <DNS> > [-l] [-6]

 Without -l you have a list with an open port in each line. With -l, the list is just numeric and in one line (more "grepeable" i think)

 If you want to scan ONE IPv6 address, you need to specify it by adding -6 somewhere (but you know, also -H <host>).
 IMPORTANT! IPv6 STILL doesnt have parser, so if you write it wrong, doesnt matter for the scanner, and you will have NO errors. Be careful with
 how you write it. Check it twice. With the DNS resolver this wouldnt be a problem.
 
 Thanks for using the Scanner!! Please be free to want stuff

 # How it works?

 This scanner works fast doing TCP requests without retries to the address you need.
 The only information you will have is which ports are open.

 UPDATES:

 ## 13/2/21
 * Translated to english
 * Deleted stupid functions
 * Added the DNS resolver
 * IPv6 support

 # Notes for next updates:

 * IPv6 better support
 * An option to not printing the address
 * An option to format the output
 * I think there is a bug in IP Parser, because it accepts 0.x.x.x addresses. It shouldnt
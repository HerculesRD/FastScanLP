# FastScanLP
 Fast TCP scan 

 Usage: ./FastScanLP.sh < -H <IP> | -D <DNS> > [-l]

 Without -l you have a list with an open port in each line. With -l, the list is just numeric and in one line (more "grepeable" i think)
 
 Thanks for using the Scanner!! Please be free to want stuff

 # How it works?

 This scanner works fast doing TCP requests without retries to the address you need.
 The only information you will have is which ports are open.

 UPDATES:

 ## 13/2/21
 Translated to english
 Deleted stupid functions
 Added the DNS resolver

 # Notes for next updates:

 * An option to not printing the address
 * An option to format the output
 * I think there is a bug in IP Parser, because it accepts 0.x.x.x addresses. It shouldnt
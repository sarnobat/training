(not master copy)

 
# Secure Coding Java Foundation

## Day 1

bradley.e.needham@gmail.com

https://drive.google.com/drive/folders/1XoUAn0SHhO3eBTiSSinDBzNxzTkpcoWs

rest APIs are important in the age of IoT devices
api attacks are more common than UI attacks

attack vectors

what's the resource I need to protect most?
usually the private personal information


Facebook disruption in october - could it have been avoided proactively?s	

java was created with safety in mind

garbage collection secures memory segments by invalidating them

jvm bytecode verification is done because the bytecode can be changed to do things that the compiler doesn't allow.
it could be turned off for server software

Effective Java book
it lleads to natturally secure code (as well as being readable)
has industry best practicces (not necessarily for security)
using good practices is a good firsst step to being secure

a lot of vulnerabilities are from the lilttle thingsg that we've alll done before

sstand on the shoullders of giants

you can access the living room by an open bathroom door, even if the front door is very secure
(so prefer composition over inheritance!!)

authentication can be done at every layer

oauth1 encrypts the token
oauth2 doess not, because it assusmess you are using an encrypted channel

authentication data that is stored for a llong time should be encrypted

CWE - common weakness enumeration, addressed by OWASP
CVE - vulnerabiities for specific instances (e.g. apache commons lang version XYZ), and allso gives suggested resoutions

They are different databases

attacks can be on people

social engineering - giving your house key to your child who attackers duplicate the key from

all denial of service attacks are distributed now (DDoS)

security by obscurity is the worst thing you can do

release notes of bug fixes is a good way for attackers to attack what vulnerabilities are in the field.

security is an afterthought because it's not fun

reverse engineering is fun

but it's not like mulltitasking. It's like learning to use a stick shift instead of automatic. With experience it gets easier.

STRIDE
spoofing
tampering
repudiation
information disclosure
denial of service
elevation of service

OWASP Threat dragon can depict vulnerabillities in a diagram that resembles a data flow

stored as json

threatmap.checkpoint.com

honeypots don't just give insight into attackers, they slow attackers down by wasting their time,

CVEs can get created from them

white hat attackers (researchers) trying to find vulnerabilities non-maliciouosly

audit logging is the best way to find vulnerabilities in your app

web traffic is not so much for browser activity but API traffic

nothing will be secure forever, just infeasibe for current computing powers (apparentlly bitcoin doesn't have this problems)

osld cyrptography algorithms were broken because the algorithm was made publilc
one of the tenets today is that the algorithm was made public

whitelisting is better than bllackllisting because the bllacklist may be incomplete
(fallse positive vs false negative?)

path traversal (slash or slash dot dot in a string)

in a zero trust network, deny by default

building key card better than valet key
but janitor can access everything (this is what happened with the target hvac breach)

protection domain
files.write() should be limited by the restricted user's domain, not the system domain to which the library belongs


doPrivileged - the extra permissions are only temporary

conf/security/java.policy
	should not provide read access to the java.home, because exposing the file system hierarchy is a breach of security
	to use this policy file, you need to add -Djava.security.manager. You'll get AccessControlException if you try to read java.home
	Tomcat has its own policy file
	
protection domains are very different to security realms
realms are more analogous to AWS delete s3 buckets
protection domains are related to classloaders

building your own security manager is usually not worth it

conf/security/java.security
	contains the properties
	
Java security has been stable, it's not evolved as much as language syntax.

JEP 411 Security Manager deprecated, not used either on client or server side that much.
But it won't go away soon. 3-4 years? Java 17 deprecation

System.exit is another thing that should not be allowed in enterprise java

Tomcat is one place that uses SecurityManager
Other mechanisms like Spring Security

JVM will not manage security
Ideally, security should be at every level but in practice it's just a support burden
It's a business reason, not a technically driven decision



Oracle provides a secure coding guidelines document
https://www.oracle.com/java/technologies/javase/seccodeguide.html
	
	
With copy and paste, you have a different vulnerable execution path that is not documented in your vulnerability list

2021-11-18

## Day 2


from Bradley Needham (Guest) to Everyone:    9:21  AM
https://www.youtube.com/watch?v=sIuVbVbjZcw
from Bradley Needham (Guest) to Everyone:    9:22  AM
https://drive.google.com/drive/folders/1XoUAn0SHhO3eBTiSSinDBzNxzTkpcoWs?usp=sharing

from Yoomi Kalenscher (Cisco) to Everyone:    9:55  AM
FYI: Cisco has a Common Security Module called CiscoJ. Here's website - https://cisco.sharepoint.com/Sites/CommonSecurityModules/SitePages/CiscoJ.aspx
from Sridhar Sarnobat (Cisco) to Everyone:    10:59  AM
https://codeshare.io/
from Bradley Needham (Guest) to Everyone:    2:35  PM
https://app.performitiv.com/fv2/cisco/ceoevt/VC00476300

from Bradley Needham (Guest) to Everyone:    4:53  PM
bradley.e.needham@gmail.com
```
/**
 * Komal, Sridhar lab slide ~115
 */
pubic class HelloWorldEncryption {

  public static void main(String[] args) {

    String msgText = "This is a message created by Komal";
    KeyGenerator keyGen = KeyGenerator.getInstance("AES"); 
    keyGen.init(new SecureRandom());
    SecretKey	key = keyGen.generateKey();
    encrypt(msgText);

  }

  byte[] encrypt(String msg, Key key, Cipher cipher) throws Exception { 

    cipher.init(Cipher.ENCRYPT_MODE, key);
    byte[] input = msg.getBytes();
    return cipher.doFinal(input); 
  }
}
```

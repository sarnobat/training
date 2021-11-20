# I used "mypasssword" as the password



rm my_keystore.store
rm my_certificate.cer

# /System/Library/Frameworks/JavaVM.framework/Versions/A/Commands/keytool
keytool -genkey -alias my_key_alias -keystore my_keystore.store -keyalg RSA
cat <<EOF
Sridhars-MacBook-Air Fri 19 November 2021  6:55PM> keytool -genkey -alias my_key_alias -keystore my_keystore.store -keyalg RSA
Enter keystore password:
Re-enter new password:
What is your first and last name?
  [Unknown]:
What is the name of your organizational unit?
  [Unknown]:
What is the name of your organization?
  [Unknown]:
What is the name of your City or Locality?
  [Unknown]:
What is the name of your State or Province?
  [Unknown]:
What is the two-letter country code for this unit?
  [Unknown]:
Is CN=Unknown, OU=Unknown, O=Unknown, L=Unknown, ST=Unknown, C=Unknown correct?
  [no]:  yes

Enter key password for <my_key_alias>
	(RETURN if same as keystore password):

Warning:
The JKS keystore uses a proprietary format. It is recommended to migrate to PKCS12 which is an industry standard format using "keytool -importkeystore -srckeystore my_keystore.store -destkeystore my_keystore.store -deststoretype pkcs12".
EOF


# this generates a file called my_keystore.store and a signed jar file
jarsigner -keystore my_keystore.store -signedjar ./signed_myapp.jar commons-lang3-3.1.jar my_key_alias

cat <<EOF
Sridhars-MacBook-Air Fri 19 November 2021  6:56PM> jarsigner -keystore my_keystore.store -signedjar ./signed_myapp.jar commons-lang3-3.1.jar my_key_alias
Enter Passphrase for keystore:
jar signed.

Warning:
The signer's certificate is self-signed.
EOF

keytool -export -keystore my_keystore.store -alias my_key_alias -file my_certificate.cer

cat <<EOF
Sridhars-MacBook-Air Fri 19 November 2021  6:56PM> keytool -export -keystore my_keystore.store -alias my_key_alias -file my_certificate.cer
Enter keystore password:
Certificate stored in file <my_certificate.cer>

Warning:
The JKS keystore uses a proprietary format. It is recommended to migrate to PKCS12 which is an industry standard format using "keytool -importkeystore -srckeystore my_keystore.store -destkeystore my_keystore.store -deststoretype pkcs12".
EOF

keytool -import -alias my_key_alias -file my_certificate.cer -keystore my_keystore_another.store

cat <<EOF
Sridhars-MacBook-Air Fri 19 November 2021  6:56PM> keytool -import -alias my_key_alias -file my_certificate.cer -keystore my_keystore_another.store
Enter keystore password:
Re-enter new password:
Owner: CN=Unknown, OU=Unknown, O=Unknown, L=Unknown, ST=Unknown, C=Unknown
Issuer: CN=Unknown, OU=Unknown, O=Unknown, L=Unknown, ST=Unknown, C=Unknown
Serial number: 2a530696
Valid from: Fri Nov 19 18:56:37 PST 2021 until: Thu Feb 17 18:56:37 PST 2022
Certificate fingerprints:
	 SHA1: 3D:9A:7A:1A:93:DC:61:AF:62:2E:B0:29:32:37:D0:DF:E2:ED:27:0F
	 SHA256: A7:28:80:27:F6:E2:EC:F3:9F:2E:27:19:B6:E8:6D:2F:D1:A7:30:37:BA:B5:0F:74:0A:A4:A9:9E:4F:5E:3D:54
Signature algorithm name: SHA256withRSA
Subject Public Key Algorithm: 2048-bit RSA key
Version: 3

Extensions:

#1: ObjectId: 2.5.29.14 Criticality=false
SubjectKeyIdentifier [
KeyIdentifier [
0000: 59 0B 07 D3 FB 76 B2 82   4D FC 48 D3 0F AB E4 5C  Y....v..M.H....\
0010: 47 0F E1 A5                                        G...
]
]

Trust this certificate? [no]:  yes
Certificate was added to keystore
EOF


# I can't get this working without an executable jar
java -Djava.security.manager -Djava.security.policy=my.policy -cp acme.jar acme.Message
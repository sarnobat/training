# I used "mypasssword" as the password

# TODO: change alias?
KEY_ALIAS=wile_e_coyote

# /System/Library/Frameworks/JavaVM.framework/Versions/A/Commands/keytool
keytool -genkey -alias $KEY_ALIAS -keystore acme.store -keyalg RSA

# this generates a file called acme.store and a signed jar file
jarsigner -keystore acme.store -signedjar ./signed_myapp.jar /myjar.jar $KEY_ALIAS

keytool -export -keystore acme.store -alias $KEY_ALIAS -file ACME.cer

exit
###

cat <<EOF | tee output.log
sh -x run.sh
+ KEY_ALIAS=wile_e_coyote
+ keytool -genkey -alias wile_e_coyote -keystore acme.store -keyalg RSA
Enter keystore password:
Re-enter new password:
What is your first and last name?
  [Unknown]:  sridhar sarnobat
What is the name of your organizational unit?
  [Unknown]:  iot
What is the name of your organization?
  [Unknown]:  cisco
What is the name of your City or Locality?
  [Unknown]:  san jose
What is the name of your State or Province?
  [Unknown]:  ca
What is the two-letter country code for this unit?
  [Unknown]:  us
Is CN=sridhar sarnobat, OU=iot, O=cisco, L=san jose, ST=ca, C=us correct?
  [no]:  yes

Enter key password for <wile_e_coyote>
	(RETURN if same as keystore password):
Re-enter new password:
They don't match. Try again
Enter key password for <wile_e_coyote>
	(RETURN if same as keystore password):
Re-enter new password:

Warning:
The JKS keystore uses a proprietary format. It is recommended to migrate to PKCS12 which is an industry standard format using "keytool -importkeystore -srckeystore acme.store -destkeystore acme.store -deststoretype pkcs12".
+ jarsigner -keystore acme.store -signedjar ./signed_core-prime-8.62.0-SNAPSHOT.jar /Volumes/Numerous/work/src/iot_controlcenter.git/module/CorePrime/build/libs/core-prime-8.62.0-SNAPSHOT.jar wile_e_coyote
Enter Passphrase for keystore:
jar signed.

Warning:
The signer's certificate is self-signed.
EOF

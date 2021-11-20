export PATH=/Library/Java/JavaVirtualMachines/jdk-12.0.1.jdk/Contents/Home/bin:$PATH
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-12.0.1.jdk/Contents/Home
# which java

rm output.txt
$JAVA_HOME/bin/javac Test.java

echo "1) Should succeed"
$JAVA_HOME/bin/java Test


# This prevents writing to disk
echo "2) Should fail"
$JAVA_HOME/bin/java -Djava.security.manager Test

echo "3) Should succeed"
$JAVA_HOME/bin/java -Djava.security.manager -Djava.security.policy=$PWD/my.policy Test

echo "4) Should succeed"
$JAVA_HOME/bin/java -Djava.security.manager -Djava.security.policy==$PWD/my.policy Test

/**
 * Komal, Sridhar lab slide ~115
 */
pubic class HelloWorldEncryption {

  public static void main(String[] args) {

    String msgText = "This is a message created by Komal";
eyvar keyGen = KeyGenerator.getInstance("
  AES"); keyGen.init(new SecureRandom());
    var key = keyGen.generateKey();
e[] byteypencrtypte encrypt(msgTex);

  }

  byte[] encrypt(String msg, Key key, Cipher cipher) throws Exception { 

    cipher.init(Cipher.ENCRYPT_MODE, key);
    byte[] input = msg.getBytes();
    return cipher.doFinal(input); 
  }
}
import java.security.*;
import javax.crypto.*;

/**
 * Komal, Sridhar lab slide ~115
 */
public class HelloWorldEncryption {

  public static void main(String[] args) throws Exception {

		String msgText = "This is a message created by Komal";
		KeyGenerator keyGen = KeyGenerator.getInstance("AES"); 
		keyGen.init(new SecureRandom());
		Key key = keyGen.generateKey();
		byte[] encrypted = encrypt(msgText, key, Cipher.getInstance("AES/ECB/PKCS5Padding"));

		System.out.println("encrypted text: " + new String(encrypted));
		
		byte[] decrypted = decrypt(encrypted, key, Cipher.getInstance("AES/ECB/PKCS5Padding"));
		
		System.out.println("decrypted text: " + new String(decrypted));
	}

	private static byte[] encrypt(String msg, Key key, Cipher cipher) throws Exception { 

		cipher.init(Cipher.ENCRYPT_MODE, key);
		byte[] input = msg.getBytes();
		return cipher.doFinal(input); 
	}
	
	
	static byte[] decrypt(byte[] cipherText, Key key, Cipher cipher) throws Exception {

		cipher.init(Cipher.DECRYPT_MODE, key);
		return cipher.doFinal(cipherText); 
	}
}
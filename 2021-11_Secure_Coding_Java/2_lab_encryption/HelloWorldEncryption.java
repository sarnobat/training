import java.security.*;
import javax.crypto.*;

/**
 * Komal, Sridhar lab slide ~115
 */
public class HelloWorldEncryption {

  public static void main(String[] args) throws Exception {

		String msgText = "This is a message created by Komal";
		
		symmetric: {
		
			KeyGenerator keyGen = KeyGenerator.getInstance("AES"); 
			keyGen.init(new SecureRandom());
			Key key = keyGen.generateKey();

			byte[] encrypted;
			{
				Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
				cipher.init(Cipher.ENCRYPT_MODE, key);
				byte[] input = msgText.getBytes();
				encrypted = cipher.doFinal(input); 
				System.out.println("encrypted text: " + new String(encrypted));
			}

			{
				Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
				cipher.init(Cipher.DECRYPT_MODE, key);
				byte[] decrypted =  cipher.doFinal(encrypted); 		
				System.out.println("decrypted text: " + new String(decrypted));
			}
		}
		
		asymmetric: {

			KeyPairGenerator keyGen = KeyPairGenerator.getInstance("RSA"); 
			keyGen.initialize(2048);
			KeyPair pair = keyGen.generateKeyPair();
			
			byte[] encrypted;
			{			
				Cipher cipher = Cipher.getInstance("RSA/ECB/PKCS1Padding");
				cipher.init(Cipher.ENCRYPT_MODE, pair.getPrivate());
				byte[] input = msgText.getBytes();
				encrypted = cipher.doFinal(input); 
				System.out.println("encrypted text: " + new String(encrypted));
			}
			{
				Cipher cipher = Cipher.getInstance("RSA/ECB/PKCS1Padding");
				cipher.init(Cipher.DECRYPT_MODE, pair.getPublic());
				byte[] decrypted =  cipher.doFinal(encrypted); 		
				System.out.println("decrypted text: " + new String(decrypted));
			}
		}
	}
}

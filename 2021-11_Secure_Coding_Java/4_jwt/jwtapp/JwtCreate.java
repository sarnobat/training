import java.security.*;
import javax.crypto.*;
import io.jsonwebtoken.*;
import io.jsonwebtoken.security.*;

/**
 */
public class JwtCreate {

	public static void main(String[] args) throws Exception {
		var key = Keys.secretKeyFor(SignatureAlgorithm.HS256);
		String jws = Jwts.builder() .setSubject("Joe").signWith(key) .compact();
	}
}

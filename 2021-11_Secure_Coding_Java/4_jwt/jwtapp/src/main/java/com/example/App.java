package com.example;

import java.security.*;
import javax.crypto.*;
import io.jsonwebtoken.*;
import io.jsonwebtoken.security.*;

/**
 * Hello world!
 *
 */
public class App 
{
    public static void main( String[] args )
    {
		Key key = Keys.secretKeyFor(SignatureAlgorithm.HS256);
		String jws = Jwts.builder() .setSubject("Joe").signWith(key) .compact();
		System.out.println("SRIDHAR: your JWT token is: " + jws);
    }
}

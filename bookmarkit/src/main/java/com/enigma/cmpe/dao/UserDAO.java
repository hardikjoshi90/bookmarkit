package com.enigma.cmpe.dao;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;

import sun.misc.BASE64Encoder;

import java.util.*;

import org.apache.commons.*;

import com.mongodb.*;

public class UserDAO {
	
	private final DBCollection usersCollection;
	private Random random = new SecureRandom();
	
	public UserDAO(final DB projectDB){
		usersCollection = projectDB.getCollection("user");
	}
	
	
	 public boolean addUser(String username, String password, String fname, String lname, String email, String gender) {

	        String passwordHash = makePasswordHash(password, Integer.toString(random.nextInt()));

	        BasicDBObject user = new BasicDBObject();

	        user.append("_id", username).append("password", passwordHash).append("fname", fname).append("lname", lname).append("gender", gender).append("followers", "[]");

	        if (email != null && !email.equals("")) {
	            // the provided email address
	            user.append("email", email);
	        }

	        try {
	            usersCollection.insert(user);
	            return true;
	        } catch (MongoException.DuplicateKey e) {
	            System.out.println("Username already in use: " + username);
	            return false;
	        }
	    }
	
	
	public DBObject validateLogin(String username, String password){
		
		DBObject user;
		
		user = usersCollection.findOne(new BasicDBObject("_id", username));

        if (user == null) {
            System.out.println("User not in database");
            return null;
        }

        String hashedAndSalted = user.get("password").toString();
        
        System.out.println(hashedAndSalted);

        String salt = hashedAndSalted.split(",")[1];
        
        String passwd = makePasswordHash(password, salt);
        
        System.out.println(passwd);

        if (!hashedAndSalted.equals(passwd)) {
            System.out.println("Submitted password is not a match");
            return null;
        }

        return user;
	}
	
	private String makePasswordHash(String password, String salt) {
        try {
            String saltedAndHashed = password + "," + salt;
            MessageDigest digest = MessageDigest.getInstance("MD5");
            digest.update(saltedAndHashed.getBytes());
            BASE64Encoder encoder = new BASE64Encoder();
            byte hashedBytes[] = (new String(digest.digest(), "UTF-8")).getBytes();
            System.out.println(hashedBytes[0]);
            return encoder.encode(hashedBytes) + "," + salt;
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("MD5 is not available", e);
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException("UTF-8 unavailable?  Not a chance", e);
        }
    }

}

package com.enigma.cmpe.dao;

import java.security.SecureRandom;

import com.mongodb.*;
import sun.misc.BASE64Encoder;

public class sessionDAO extends Thread implements Runnable {
	
	 private static DBCollection sessionsCollection;

	    public sessionDAO(final DB projectDB) {
	        sessionsCollection = projectDB.getCollection("session");
	    }
	    
	    public  String startSession(String username) {

	        // get 32 byte random number. that's a lot of bits.
	        SecureRandom generator = new SecureRandom();
	        byte randomBytes[] = new byte[32];
	        generator.nextBytes(randomBytes);

	        BASE64Encoder encoder = new BASE64Encoder();

	        String sessionID = encoder.encode(randomBytes);
	        
	        System.out.println("SessioId: "+ sessionID);

	        // build the BSON object
	        System.out.println("Username"+username);
	        BasicDBObject session = new BasicDBObject("username", username);

	        session.append("_id", sessionID);
	        sessionsCollection.insert(session);

	        return session.getString("_id");
	    }
	    
	    public void endSession(String sessionID) {
	        sessionsCollection.remove(new BasicDBObject("_id", sessionID));
	    }

	    // retrieves the session from the sessions table
	    public DBObject getSession(String sessionID) {
	        return sessionsCollection.findOne(new BasicDBObject("_id", sessionID));
	    }

}

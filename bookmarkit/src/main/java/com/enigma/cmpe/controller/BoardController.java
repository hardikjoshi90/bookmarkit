package com.enigma.cmpe.controller;

import java.io.IOException;
import java.net.UnknownHostException;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.enigma.cmpe.dao.UserDAO;
import com.enigma.cmpe.dao.sessionDAO;
import com.enigma.cmpe.domain.Board;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.MongoClient;
import com.mongodb.ServerAddress;
import com.enigma.cmpe.dao.*;

@Controller
@RequestMapping("")
public class BoardController {

	private static UserDAO userDAO;
	private static sessionDAO sessionDAO;
	private static boardDAO boardDAO;
	private static tackDAO tackDAO;
	private static commentDAO commentDAO;
	
	DBObject session;
	
	DBCollection boardCollection;
	DBCollection tackCollection;
	DBCollection cmntCollection;

	@SuppressWarnings("static-access")
	public BoardController() throws UnknownHostException {
	
		
		
		userDAO = userDAO.getInstance();
		sessionDAO = sessionDAO.getInstance();
		boardDAO = boardDAO.getInstance();
		tackDAO = tackDAO.getInstance();
		commentDAO = commentDAO.getInstance();
		
		boardCollection = boardDAO.getCollection();
		tackCollection = tackDAO.getCollection();
		cmntCollection = commentDAO.getCollection();
		
		session = null;
	}

	@RequestMapping(value = "/{user}/boards", method = RequestMethod.GET)
	public String getUserBoards(Model model,
			@PathVariable("user") String username, HttpServletResponse response)
			throws IOException {
		session = sessionDAO.getSession(username);
		if (session == null)
			response.sendRedirect("/bookmarkit/login");
		model.addAttribute("username", username);

		DBCursor cur = boardCollection.find(new BasicDBObject("uid", username));
		
		while(cur.hasNext())
			System.out.println(cur.next());

		return "welcome";
	}
	
	@RequestMapping(value = "/{user}/boards", method = RequestMethod.POST)
	public String createBoard(Model model,
			@PathVariable("user") String username, HttpServletResponse response)
			throws IOException {
		session = sessionDAO.getSession(username);
		if (session == null)
			response.sendRedirect("/bookmarkit/login");
		model.addAttribute("username", username);
		Board board = new Board();
		
		board.setUid(username);
		board.setCategory("Education");
		board.setDesc("Test");
		board.setIsPrivate(true);
		board.setName("First board");
		
		DBCursor boardcur = boardCollection.find(new BasicDBObject("name",board.getName()));
		
		if(boardcur.count()>0){
			System.out.println("This board already exists");
		}
		
		else{
			DBObject insertQuery = new BasicDBObject("name",board.getName()).append("desc", board.getDesc()).append("category", board.getCategory()).append("isPrivate", board.getIsPrivate()).append("uid", board.getUid()).append("followers", board.getFollowers());
			boardCollection.insert(insertQuery);
		}
		

		return "welcome";
	}
	
	
	@RequestMapping(value = "/{user}/boards/{bname}", method = RequestMethod.DELETE)
	public String deleteBoard(Model model,
			@PathVariable("user") String username,
			@PathVariable("bname") String bname, HttpServletResponse response)
			throws IOException {
		session = sessionDAO.getSession(username);
		if (session == null)
			response.sendRedirect("/bookmarkit/login");
		model.addAttribute("username", username);
		DBCursor boardcur = boardCollection.find(new BasicDBObject("name",bname));
		DBObject doc = boardcur.next();
		DBCursor tackcur = tackCollection.find(new BasicDBObject("bid", doc.get("_id").toString()));
		if (tackcur.count() == 0){
			while(tackcur.hasNext()){
				DBObject tackdoc = tackcur.next();
				tackCollection.remove(new BasicDBObject("bid", tackdoc.get("_id").toString()));
			}
		}
		boardCollection.remove(new BasicDBObject("name",bname));
		
		return "welcome";
	}
	
	@RequestMapping(value = "/{user}/boards/{bname}", method = RequestMethod.PUT)
	public String updateBoard(Model model,
			@PathVariable("user") String username,
			@PathVariable("bname") String bname, HttpServletResponse response)
			throws IOException {
		session = sessionDAO.getSession(username);
		if (session == null)
			response.sendRedirect("/bookmarkit/login");
		model.addAttribute("username", username);
		DBCursor boardcur = boardCollection.find(new BasicDBObject("name",bname));
		DBObject doc = boardcur.next();
		
		Board board = new Board();
		
		board.setName("test");
		board.setCategory("Education");
		board.setIsPrivate(true);
		board.setUid(username);
		board.setDesc("Test");
		
		
		
		boardCollection.update(new BasicDBObject("name",bname), new BasicDBObject("name",board.getName()).append("desc", board.getDesc()).append("category", board.getCategory()).append("isPrivate", board.getIsPrivate()).append("uid", board.getUid()).append("followers", board.getFollowers()));
		
		return "welcome";
	}
	
}

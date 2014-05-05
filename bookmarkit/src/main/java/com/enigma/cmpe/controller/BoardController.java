package com.enigma.cmpe.controller;

import java.io.IOException;
import java.net.UnknownHostException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.enigma.cmpe.dao.UserDAO;
import com.enigma.cmpe.dao.sessionDAO;
import com.enigma.cmpe.domain.Board;
import com.google.gson.Gson;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.MongoClient;
import com.mongodb.ServerAddress;

@Controller
@RequestMapping("")
public class BoardController {

	private final UserDAO userDAO;
	// HashMap<String, String> sessionState = new HashMap<String, String>();
	private final sessionDAO sessionDAO;

	final DB blogDatabase;

	public BoardController() throws UnknownHostException {
		MongoClient mongoClient = new MongoClient(new ServerAddress(
				"localhost", 27017));
		// final MongoClient mongoClient = new MongoClient(new
		// MongoClientURI(mongoURIString));
		blogDatabase = mongoClient.getDB("bookmarkit");

		// blogPostDAO = new BlogPostDAO(blogDatabase);
		userDAO = new UserDAO(blogDatabase);
		sessionDAO = new sessionDAO(blogDatabase);
	}

	@RequestMapping(value = "/{user}/boards", method = RequestMethod.GET)
	public String getUserBoards(Model model,
			@PathVariable("user") String username, HttpServletResponse response)
			throws IOException {

		return "welcome";
	}
	
	@RequestMapping(value = "/{user}/boards/details", method = RequestMethod.GET)
	public @ResponseBody String getUserBoardsDetails(Model model,
			@PathVariable("user") String username, HttpServletResponse response)
			throws IOException {
		DBObject session = sessionDAO.getSession(username);
		if (session == null)
			response.sendRedirect("/bookmarkit/login");
		model.addAttribute("username", username);
		DBCollection boardCollection = blogDatabase.getCollection("board");

		DBCursor cur = boardCollection.find(new BasicDBObject("uid", username));
		
		Gson gson = new Gson();
		
		ArrayList<Board> boards = new ArrayList<Board>();
		
		
		while(cur.hasNext()){
			Board b = new Board();
			DBObject doc = cur.next();
			System.out.println(doc);
			String secret = doc.get("isPrivate").toString();
			if(secret.equals("true"))
				b.setIsPrivate(true);
			else
				b.setIsPrivate(false);
			b.setName(doc.get("name").toString());
			boards.add(b);
		}
			
		model.addAttribute("boards",boards);

		String jsonString = gson.toJson(boards);
		
		return jsonString;
	}
	
	@RequestMapping(value = "/{user}/boards", method = RequestMethod.POST)
	public String createBoard(Model model,
			@PathVariable("user") String username, HttpServletResponse response, HttpServletRequest request)
			throws IOException {
		DBObject session = sessionDAO.getSession(username);
		if (session == null)
			response.sendRedirect("/bookmarkit/login");
		model.addAttribute("username", username);
		DBCollection boardCollection = blogDatabase.getCollection("board");
		Board board = new Board();
		
		board.setUid(username);
		board.setCategory(request.getParameter("category"));
		board.setDesc(request.getParameter("bdescription"));
		String secret = request.getParameter("secret");
		if(secret.equals("true"))
			board.setIsPrivate(true);
		else
			board.setIsPrivate(false);
		board.setName(request.getParameter("bname"));
		
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
		DBObject session = sessionDAO.getSession(username);
		if (session == null)
			response.sendRedirect("/bookmarkit/login");
		model.addAttribute("username", username);
		DBCollection boardCollection = blogDatabase.getCollection("board");
		DBCollection tackCollection = blogDatabase.getCollection("tack");
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
		DBObject session = sessionDAO.getSession(username);
		if (session == null)
			response.sendRedirect("/bookmarkit/login");
		model.addAttribute("username", username);
		DBCollection boardCollection = blogDatabase.getCollection("board");
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

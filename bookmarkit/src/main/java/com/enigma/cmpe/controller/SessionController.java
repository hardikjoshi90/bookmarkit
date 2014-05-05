package com.enigma.cmpe.controller;

import java.io.IOException;
import java.net.UnknownHostException;
import java.util.HashMap;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.enigma.cmpe.dao.UserDAO;
import com.enigma.cmpe.dao.sessionDAO;
import com.enigma.cmpe.domain.login;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.MongoClient;
import com.mongodb.ServerAddress;

@Controller
@RequestMapping("")

public class SessionController extends HttpServlet {

	private final UserDAO userDAO;
	// HashMap<String, String> sessionState = new HashMap<String, String>();
	private final sessionDAO sessionDAO;
	
	final DB blogDatabase;

	public SessionController() throws UnknownHostException {
		MongoClient mongoClient = new MongoClient(new ServerAddress(
				"localhost", 27017));
		// final MongoClient mongoClient = new MongoClient(new
		// MongoClientURI(mongoURIString));
		blogDatabase = mongoClient.getDB("bookmarkit");

		// blogPostDAO = new BlogPostDAO(blogDatabase);
		userDAO = new UserDAO(blogDatabase);
		sessionDAO = new sessionDAO(blogDatabase);
	}

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String loginGet(Model model) {
		HashMap<String, String> root = new HashMap<String, String>();

		root.put("username", "");
		root.put("login_error", "");
		return "login";
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String loginPost(Model model, HttpServletResponse response,
			HttpServletRequest request) throws IOException {

		String username = request.getParameter("username");
		String password = request.getParameter("password");

		System.out.println("Username: " + username + " password: " + password);
		DBObject user = userDAO.validateLogin(username, password);

		if (user != null) {

			// valid user, let's log them in
			String sessionID = sessionDAO.startSession(user.get("_id").toString());
			System.out.println("SessionID: " + sessionID);
			if (sessionID == null) {
				response.sendRedirect("/bookmarkit/error");
			} else {
				response.sendRedirect("/bookmarkit/" + username);
			}

		}
		return "error";

	}

	@RequestMapping(value = "/logout", method = RequestMethod.POST)
	public String logoutGet(HttpServletRequest request,
			HttpServletResponse response,
			@ModelAttribute("login") login loginObj) throws IOException {
		String username = request.getParameter("username");
		if (username == null) {
			// no session to end
			response.sendRedirect("/bookmarkit/login");
		} else {
			// deletes from session table
			sessionDAO.endSession(username);
			return "login";
		}

		return "login";
	}

	@RequestMapping(value = "/{user}", method = RequestMethod.GET)
	public String welcome(Model model, @PathVariable("user") String username,
			HttpServletResponse response) throws IOException {
			DBObject session = sessionDAO.getSession(username);
			if (session == null)
				response.sendRedirect("/bookmarkit/login");
			model.addAttribute("username", username);
		return "welcome";
	}
	

	@RequestMapping(value = "/fb", method = RequestMethod.GET)
	public String fblogin(Model model) throws IOException {
		return "FacebookLogin";
	}

}

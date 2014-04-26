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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.enigma.cmpe.dao.UserDAO;
import com.enigma.cmpe.dao.sessionDAO;
import com.enigma.cmpe.domain.login;
import com.mongodb.DB;
import com.mongodb.DBObject;
import com.mongodb.MongoClient;
import com.mongodb.ServerAddress;

@Controller
@RequestMapping("")
public class SessionController extends HttpServlet {

	private final UserDAO userDAO;
	// HashMap<String, String> sessionState = new HashMap<String, String>();
	private final sessionDAO sessionDAO;

	public SessionController() throws UnknownHostException {
		MongoClient mongoClient = new MongoClient(new ServerAddress(
				"localhost", 27017));
		// final MongoClient mongoClient = new MongoClient(new
		// MongoClientURI(mongoURIString));
		final DB blogDatabase = mongoClient.getDB("bookmarkit");

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
	public String loginPost(@ModelAttribute("login") login loginObj,
			Model model, HttpServletResponse response,
			HttpServletRequest request) throws IOException {

		String username = loginObj.getUsername();
		String password = loginObj.getPassword();

		System.out.println("Username: " + username + " password: " + password);
		DBObject user = userDAO.validateLogin(username, password);

		if (user != null) {

			// valid user, let's log them in
			String sessionID = sessionDAO.startSession(user.get("_id")
					.toString());
			System.out.println("SessionID: " + sessionID);
			if (sessionID == null) {
				response.sendRedirect("/doit/error");
			} else {
				response.sendRedirect("/doit/welcome?token=" + sessionID);
			}

		}
		return "error";

	}

	@RequestMapping(value = "/logout", method = RequestMethod.POST)
	public String logoutGet(HttpServletRequest request,
			HttpServletResponse response,
			@ModelAttribute("login") login loginObj) throws IOException {
		String token = loginObj.getToken();
		System.out.println("logout token is:" + token);
		if (token == null) {
			// no session to end
			response.sendRedirect("/doit/login");
		} else {
			// deletes from session table
			sessionDAO.endSession(token);
			return "login";
		}

		return "login";
	}

	@RequestMapping(value = "/welcome", method = RequestMethod.GET)
	public String welcome(Model model, @RequestParam("token") String token,
			HttpServletResponse response) throws IOException {

		if (!token.equals(null) && !token.equals("")) {
			System.out.println("Generated token is:" + token.length());
			DBObject session = sessionDAO.getSession(token);
			if (session == null)
				response.sendRedirect("/doit/login");
			model.addAttribute("token", token);
		} else
			response.sendRedirect("/doit/login");
		return "welcome";
	}
	
	
	@RequestMapping(value = "/fb", method = RequestMethod.GET)
	public String fblogin(Model model) throws IOException {
		return "FacebookLogin";
	}
	

}

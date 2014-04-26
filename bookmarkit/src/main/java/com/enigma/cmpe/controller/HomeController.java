package com.enigma.cmpe.controller;

import java.io.IOException;
import java.net.UnknownHostException;
import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.junit.runner.Request;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.HttpServerErrorException;

import com.mongodb.*;
import com.enigma.cmpe.dao.sessionDAO;
import com.enigma.cmpe.dao.UserDAO;
import com.enigma.cmpe.domain.signUp;


/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("")
public class HomeController extends HttpServlet {

	// private final BlogPostDAO blogPostDAO;
	private final UserDAO userDAO;
	// HashMap<String, String> sessionState = new HashMap<String, String>();
	private final sessionDAO sessionDAO;

	public HomeController() throws UnknownHostException {
		MongoClient mongoClient = new MongoClient(new ServerAddress(
				"localhost", 27017));
		// final MongoClient mongoClient = new MongoClient(new
		// MongoClientURI(mongoURIString));
		final DB blogDatabase = mongoClient.getDB("bookmarkit");

		// blogPostDAO = new BlogPostDAO(blogDatabase);
		userDAO = new UserDAO(blogDatabase);
		sessionDAO = new sessionDAO(blogDatabase);
		// sessionState.put("session","0");
	}

	private static final Logger logger = LoggerFactory
			.getLogger(HomeController.class);

	/**
	 * Simply selects the home view to render by returning its name.
	 * 
	 * @throws IOException
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model, HttpServletResponse response)
			throws IOException {
		logger.info("Welcome home! The client locale is {}.", locale);

		// String sessionID = sessionState.get("session");
		/*
		 * if (sessionID.equals("0")) { // no session to end
		 * response.sendRedirect("/doit/login"); }
		 */
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG,
				DateFormat.LONG, locale);

		String formattedDate = dateFormat.format(date);

		model.addAttribute("serverTime", formattedDate);

		return "home";
	}


	

	@RequestMapping(value = "/signUp", method = RequestMethod.GET)
	public String signUpGet(Model model) {
		return "signUp";
	}

	@RequestMapping(value = "/error", method = RequestMethod.GET)
	public String errorGet(Model model) {
		return "error";
	}

	@RequestMapping(value = "/signUp", method = RequestMethod.POST)
	public @ResponseBody
	String signUpPost(@ModelAttribute("login") signUp signUp, Model model,
			HttpServletResponse response) throws IOException {
		String username = signUp.getUsername();
		String password = signUp.getPassword();
		String verify = signUp.getVerifiedPassword();
		String email = signUp.getEmail();
		String fname = signUp.getFname();
		String lname = signUp.getLname();
		String gender = signUp.getGender();
		HashMap<String, String> root = new HashMap<String, String>();

		root.put("username", username);
		root.put("email", password);

		if (validateSignup(username, password, verify, email, root)) {
			// good user
			System.out.println("Signup: Creating user with: " + username + " "
					+ password);
			if (!userDAO.addUser(username, password, fname,lname, email, gender)) {
				// duplicate user
				root.put("username_error",
						"Username already in use, Please choose another");
				return "signUp";
			} else {
				response.sendRedirect("/bookmarkit/login");
			}
		}

		return "login";
	}

	

	public boolean validateSignup(String username, String password,
			String verify, String email, HashMap<String, String> errors) {
		String USER_RE = "^[a-zA-Z0-9_-]{3,20}$";
		String PASS_RE = "^.{3,20}$";
		String EMAIL_RE = "^[\\S]+@[\\S]+\\.[\\S]+$";

		errors.put("username_error", "");
		errors.put("password_error", "");
		errors.put("verify_error", "");
		errors.put("email_error", "");

		if (!username.matches(USER_RE)) {
			errors.put("username_error",
					"invalid username. try just letters and numbers");
			return false;
		}

		if (!password.matches(PASS_RE)) {
			errors.put("password_error", "invalid password.");
			return false;
		}

		if (!password.equals(verify)) {
			errors.put("verify_error", "password must match");
			return false;
		}

		if (!email.equals("")) {
			if (!email.matches(EMAIL_RE)) {
				errors.put("email_error", "Invalid Email Address");
				return false;
			}
		}

		return true;
	}

}

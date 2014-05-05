package com.enigma.cmpe.controller;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.net.UnknownHostException;
import java.util.ArrayList;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.bson.types.ObjectId;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.enigma.cmpe.dao.UserDAO;
import com.enigma.cmpe.dao.sessionDAO;
import com.enigma.cmpe.domain.Tack;
import com.google.gson.Gson;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.MongoClient;
import com.mongodb.ServerAddress;
import com.mongodb.gridfs.GridFS;
import com.mongodb.gridfs.GridFSInputFile;

@Controller
@RequestMapping("")
public class TackController {

	private final UserDAO userDAO;
	// HashMap<String, String> sessionState = new HashMap<String, String>();
	private final sessionDAO sessionDAO;

	final DB blogDatabase;

	public TackController() throws UnknownHostException {
		MongoClient mongoClient = new MongoClient(new ServerAddress(
				"localhost", 27017));
		// final MongoClient mongoClient = new MongoClient(new
		// MongoClientURI(mongoURIString));
		blogDatabase = mongoClient.getDB("bookmarkit");

		// blogPostDAO = new BlogPostDAO(blogDatabase);
		userDAO = new UserDAO(blogDatabase);
		sessionDAO = new sessionDAO(blogDatabase);
	}

	@RequestMapping(value = "/{user}/boards/{bname}", method = RequestMethod.GET)
	public String getBoardInfo(Model model,
			@PathVariable("user") String username,
			@PathVariable("bname") String bname, HttpServletResponse response)
			throws IOException {
		DBObject session = sessionDAO.getSession(username);
		if (session == null)
			response.sendRedirect("/bookmarkit/login");
		model.addAttribute("username", username);
		DBCollection boardCollection = blogDatabase.getCollection("board");
		DBCollection tackCollection = blogDatabase.getCollection("tack");

		DBCursor boardcur = boardCollection.find(new BasicDBObject("name",
				bname));
		DBObject doc = boardcur.next();
		System.out.println(doc.get("_id"));
		DBCursor tackcur = tackCollection.find(new BasicDBObject("bid", doc
				.get("_id").toString()));
		if (tackcur.count() == 0)
			System.out.println("Empty Board");
		else {
			while (tackcur.hasNext())
				System.out.println(tackcur.next());
		}

		return "createdboard";
	}

	@RequestMapping(value = "/{user}/boards/{bname}/tacks", method = RequestMethod.GET)
	public @ResponseBody
	String getBoardTacks(Model model, @PathVariable("user") String username,
			@PathVariable("bname") String bname, HttpServletResponse response)
			throws IOException {
		DBObject session = sessionDAO.getSession(username);
		if (session == null)
			response.sendRedirect("/bookmarkit/login");
		model.addAttribute("username", username);
		DBCollection boardCollection = blogDatabase.getCollection("board");
		DBCollection tackCollection = blogDatabase.getCollection("tack");
		DBCollection commentCollection = blogDatabase.getCollection("comment");

		Gson gson = new Gson();
		ArrayList<Tack> tacks = new ArrayList<Tack>();

		DBCursor boardcur = boardCollection.find(new BasicDBObject("name",
				bname));
		DBObject doc = boardcur.next();
		System.out.println(doc.get("_id"));
		DBCursor tackcur = tackCollection.find(new BasicDBObject("bid", doc
				.get("_id").toString()));
		if (tackcur.count() == 0)
			System.out.println("Empty Board");
		else {
			while (tackcur.hasNext()) {
				DBObject tackDoc = tackcur.next();
				Tack t = new Tack();
				t.setImageUrl(tackDoc.get("imageUrl").toString());
				t.setTid(doc.get("_id").toString());
				System.out.println(tackDoc);
				tacks.add(t);
			}
		}

			String jsonString = gson.toJson(tacks);
			return jsonString;
		
	}

	@RequestMapping(value = "/{user}/boards/{bname}", method = RequestMethod.POST)
	public String createTack(Model model,
			@PathVariable("user") String username,
			@PathVariable("bname") String bname, HttpServletResponse response,  HttpServletRequest request,
            @RequestParam("file") MultipartFile file)
			throws IOException {
		DBObject session = sessionDAO.getSession(username);
		if (session == null)
			response.sendRedirect("/bookmarkit/login");
		model.addAttribute("username", username);
		DBCollection boardCollection = blogDatabase.getCollection("board");
		DBCollection tackCollection = blogDatabase.getCollection("tack");
System.out.println(bname);
		DBCursor boardcur = boardCollection.find(new BasicDBObject("name",
				bname));
		DBObject doc = boardcur.next();
		System.out.println(doc.get("_id"));

		String path = "C:\\Users\\Maulik\\Desktop\\203\\bookmarkit\\src\\main\\webapp\\resources\\images\\"+file.getOriginalFilename()+".jpg";
		if (!file.isEmpty()) {
            try {
                byte[] bytes = file.getBytes();
                
                BufferedImage img = ImageIO.read(new ByteArrayInputStream(bytes));
                //Toolkit.getDefaultToolkit().createImage(img.getSource());
               
                File outputfile = new File(path);
                ImageIO.write(img, "jpg", outputfile);
                System.out.println("You successfully uploaded file");
                //return "createdboard";
            } catch (Exception e) {
                System.out.println("You failed to upload " + "=> " + e.getMessage());
            }
        } else {
            System.out.println("You failed to upload because the file was empty.");
        }
		
		Tack tack = new Tack();

		tack.setBid(doc.get("_id").toString());
		tack.setImageUrl("http://d2yhexj5rb8c94.cloudfront.net/sites/default/files/mediaimages/gallery/2014/Apr/titanic_modi-sarkar_0.jpg");
		tack.setLikeCount("0");
		tack.setUid(username);

		DBObject insertQuery = new BasicDBObject("bid", tack.getBid())
				.append("uid", tack.getUid())
				.append("imageUrl", tack.getImageUrl())
				.append("likecount", tack.getLikeCount());

		tackCollection.insert(insertQuery);

		return "welcome";
	}

	@RequestMapping(value = "/{user}/boards/{bname}/{tid}", method = RequestMethod.PUT)
	public String updateTack(Model model,
			@PathVariable("user") String username,
			@PathVariable("bname") String bname,
			@PathVariable("tid") ObjectId tid, HttpServletResponse response)
			throws IOException {
		DBObject session = sessionDAO.getSession(username);
		if (session == null)
			response.sendRedirect("/bookmarkit/login");
		model.addAttribute("username", username);
		DBCollection boardCollection = blogDatabase.getCollection("board");
		DBCollection tackCollection = blogDatabase.getCollection("tack");
		DBCollection cmntCollection = blogDatabase.getCollection("comment");

		DBCursor boardcur = boardCollection.find(new BasicDBObject("name",
				bname));
		DBObject doc = boardcur.next();
		System.out.println(doc.get("_id"));

		Tack tack = new Tack();

		tack.setBid(doc.get("_id").toString());
		tack.setImageUrl("http://d2yhexj5rb8c94.cloudfront.net/sites/default/files/mediaimages/gallery/2014/Apr/titanic_modi-sarkar_0.jpg");
		tack.setLikeCount("0");
		tack.setUid(username);
		tack.setComment("This is amazing!");

		System.out.println(tid);

		DBObject updateQuery = new BasicDBObject("bid", tack.getBid())
				.append("uid", tack.getUid())
				.append("imageUrl", tack.getImageUrl())
				.append("likecount", tack.getLikeCount());

		tackCollection.update(new BasicDBObject("_id", tid), updateQuery);

		if (!(tack.getComment() == null || tack.getComment().equals(""))) {
			cmntCollection.insert(new BasicDBObject("tid", tid.toString())
					.append("body", tack.getComment()));
		}

		return "welcome";
	}

	@RequestMapping(value = "/{user}/boards/{bname}/{tid}", method = RequestMethod.DELETE)
	public String deleteTack(Model model,
			@PathVariable("user") String username,
			@PathVariable("bname") String bname,
			@PathVariable("tid") ObjectId tid, HttpServletResponse response)
			throws IOException {
		DBObject session = sessionDAO.getSession(username);
		if (session == null)
			response.sendRedirect("/bookmarkit/login");
		model.addAttribute("username", username);
		DBCollection boardCollection = blogDatabase.getCollection("board");
		DBCollection tackCollection = blogDatabase.getCollection("tack");
		DBCollection cmntCollection = blogDatabase.getCollection("comment");

		DBCursor boardcur = boardCollection.find(new BasicDBObject("name",
				bname));
		DBObject doc = boardcur.next();
		System.out.println(doc.get("_id"));

		tackCollection.remove(new BasicDBObject("_id", tid));
		cmntCollection.remove(new BasicDBObject("tid", tid.toString()));

		return "welcome";
	}

	@RequestMapping(value = "/image", method = RequestMethod.GET)
	public String uploadImage(Model model, HttpServletResponse response)
			throws IOException {
		GridFS gfsPhoto = new GridFS(blogDatabase, "tack");
		DBCursor cursor = gfsPhoto.getFileList();
		while (cursor.hasNext()) {
			System.out.println(cursor.next());
		}
		return "createdboard";
	}

	@RequestMapping(value = "/image", method = RequestMethod.POST)
	public String postImage(Model model, HttpServletResponse response)
			throws IOException {
		System.out.println("Uploading...");
		String newFileName = "mkyong-java-image";
		File imageFile = new File(
				"C:\\Users\\hardik\\Pictures\\Backgrounds Wallpapers HD\\2982.jpg");
		GridFS gfsPhoto = new GridFS(blogDatabase, "tack");
		GridFSInputFile gfsFile = gfsPhoto.createFile(imageFile);
		gfsFile.setFilename(newFileName);
		gfsFile.save();
		return "createdboard";
	}
}


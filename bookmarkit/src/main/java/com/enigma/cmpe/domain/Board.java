package com.enigma.cmpe.domain;

import java.util.ArrayList;

public class Board {
	
	private String name;
	private String desc;
	private String category;
	private boolean isPrivate;
	private String uid;
	private ArrayList<String> followers = new ArrayList<String>();
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public boolean getIsPrivate() {
		return isPrivate;
	}
	public void setIsPrivate(boolean isPrivate) {
		this.isPrivate = isPrivate;
	}
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public ArrayList<String> getFollowers() {
		return followers;
	}
	public void setFollowers(ArrayList<String> followers) {
		this.followers = followers;
	}

	
	
	
}

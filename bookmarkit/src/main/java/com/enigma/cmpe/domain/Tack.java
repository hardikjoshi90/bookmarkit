package com.enigma.cmpe.domain;

public class Tack {
	private String bid;
	private String uid;
	private String imageUrl;
	private String comment;
	private String tid;
	public String getTid() {
		return tid;
	}
	public void setTid(String tid) {
		this.tid = tid;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public String getBid() {
		return bid;
	}
	public void setBid(String bid) {
		this.bid = bid;
	}
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getImageUrl() {
		return imageUrl;
	}
	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}
	public String getLikeCount() {
		return likeCount;
	}
	public void setLikeCount(String likeCount) {
		this.likeCount = likeCount;
	}
	private String likeCount;
}

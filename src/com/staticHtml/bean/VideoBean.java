package com.staticHtml.bean;

public class VideoBean {

	private String videoName;
	private String videoPath;
	private String videoImg;
	public String getVideoName() {
		return videoName;
	}
	public void setVideoName(String videoName) {
		this.videoName = videoName;
	}
	public String getVideoPath() {
		return videoPath;
	}
	public void setVideoPath(String videoPath) {
		this.videoPath = videoPath;
	}
	public String getVideoImg() {
		return videoImg;
	}
	public void setVideoImg(String videoImg) {
		this.videoImg = videoImg;
	}
	public VideoBean(String videoName, String videoPath, String videoImg) {
		super();
		this.videoName = videoName;
		this.videoPath = videoPath;
		this.videoImg = videoImg;
	}
	
	
}

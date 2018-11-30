package com.staticHtml.bean;

public class DuoweiBean {

	private String filePath;
	private String info;
	private String mode;
	private String name;
	private String img;
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public DuoweiBean(String filePath, String info, String mode, String name,
			String img) {
		super();
		this.filePath = filePath;
		this.info = info;
		this.mode = mode;
		this.name = name;
		this.img = img;
	}
	
	
	
	
}

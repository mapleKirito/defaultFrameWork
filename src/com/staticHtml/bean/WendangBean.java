package com.staticHtml.bean;

public class WendangBean {

	String FilePath;
	int FileLength;
	String FileName;
	public String getFilePath() {
		return FilePath;
	}
	public void setFilePath(String filePath) {
		FilePath = filePath;
	}
	public int getFileLength() {
		return FileLength;
	}
	public void setFileLength(int fileLength) {
		FileLength = fileLength;
	}
	public String getFileName() {
		return FileName;
	}
	public void setFileName(String fileName) {
		FileName = fileName;
	}
	public WendangBean(String filePath, int fileLength, String fileName) {
		super();
		FilePath = filePath;
		FileLength = fileLength;
		FileName = fileName;
	}
	
	
	
}

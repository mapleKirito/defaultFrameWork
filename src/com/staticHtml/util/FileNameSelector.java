package com.staticHtml.util;

import java.io.File;
import java.io.FilenameFilter;

public class FileNameSelector implements FilenameFilter {
	String extension=".";
	
	public FileNameSelector(String fileExtensionNoDot) {
		extension+=fileExtensionNoDot;
	}

	@Override
	public boolean accept(File dir, String name) {
		// TODO Auto-generated method stub
		return name.endsWith(extension);
	}

}

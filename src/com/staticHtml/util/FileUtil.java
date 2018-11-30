package com.staticHtml.util;

import java.io.File;

public class FileUtil {
	public static int CountImg(File f){
		return f.listFiles(new FileNameSelector("jpg")).length;
	}
}

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ow.framework.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.Reader;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.Method;
import java.security.AccessController;
import java.security.PrivilegedAction;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.FileCleanerCleanup;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileCleaningTracker;
import org.apache.commons.io.FilenameUtils;

import jxl.Cell;
import jxl.Workbook;

/**
 * 
 */
public class FileHelper {

	/**
	 * 创建文件夹
	 * 
	 * @param filePath
	 *            文件夹路径
	 * @throws IOException
	 */
	public static void createFolder(String filePath) {
		File file = new File(filePath);
		if (!file.exists()) {
			file.mkdirs();
		}
	}
	
	/**
	 * ppt为例 用于资源类型为  “参考资源”时
	 * 
	 * @param filePath 文件夹路径
	 * 
	 * @throws IOException
	 */
	public static void createFolderBysnNum(String filePath,String docusnNO) {
		File file = new File(filePath);
		if (!file.exists()) {
			createFolder(filePath + "/1000");
		}else{
			createFolder(filePath + "/" + docusnNO);
		}
	}
	
	/**
	 * 判断文件类型的类，
	 * 
	 * @param filePath
	 * @return 1 Text文本类型
	 * @return 2 Excel表格类型
	 */
	public static int judgeFileType(String filePath) {
		if (filePath.endsWith("text") || filePath.endsWith("txt")) {
			return 1;
		}
		if (filePath.endsWith("xls")) {
			return 2;
		}
		return 0;
	}

	public static boolean zip(String inputFileName,String zipFileName) throws Exception { 
		ZipOutputStream out = new ZipOutputStream(new FileOutputStream(zipFileName));
		boolean refer = zip(out, new File(inputFileName), "");
		out.close();
		return refer;
	}
	
	private static boolean zip(ZipOutputStream out, File f, String base){
		boolean refer = true;
		if (f.isDirectory()) {
			File[] fl = f.listFiles();
			try {
				out.putNextEntry(new ZipEntry(base + "/"));
				base = base.length() == 0 ? "" : base + "/";
				for (int i = 0; i < fl.length; i++) {
					System.out.println(fl[i]);
					zip(out, fl[i], base + fl[i].getName());
				}
			} catch (Exception e) {
				refer = false;
			}			
		} else {
			try {
				out.putNextEntry(new ZipEntry(base));
				FileInputStream in = new FileInputStream(f);
				int b;
				while ((b = in.read()) != -1) {
					out.write(b);
				}
				in.close();
			} catch (Exception e) {
				refer = false;
			}			
		}
		return refer;
	}
	
	/**
	 * 返回映射文件.config的内容 fieldContent 为对应的字段内容 fieldDescription 为对应的字段的描述信息
	 * 
	 * @param mappingFile
	 * @return
	 */
	public static List<HashMap<String, String>> getMappingFile(
			String mappingFile) {
		try {
			BufferedReader br = new BufferedReader(new InputStreamReader(
					new FileInputStream(mappingFile), "UTF-8"));
			String[] fileContent = null;
			List<HashMap<String, String>> arrayList = new ArrayList<HashMap<String, String>>();
			String str = br.readLine();
			while (str != null) {
				fileContent = str.split(":");
				HashMap<String, String> hm = new HashMap<String, String>();
				if (fileContent.length >= 1) {
					hm.put("fieldContent", fileContent[0]);
					hm.put("fieldDescription", fileContent[1]);
					arrayList.add(hm);
					str = br.readLine();
				} else {
					continue;
				}
			}
			return arrayList;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 得到文件首行的字段内容，相对模块客户导入与积分导入模块 传回的List为封装多个HashMap。
	 * HashMap中contentPosition字段封装位置； HashMap中contentLine字段封装该位置对应的位置；
	 */
	public static List<HashMap<String, String>> getFileLineContent(
			String uploadFile) {
		if (judgeFileType(uploadFile) == 1) {
			try {
				BufferedReader br = new BufferedReader(new InputStreamReader(
						new FileInputStream(uploadFile), "GB2312"));
				List<HashMap<String, String>> arrayList = new ArrayList<HashMap<String, String>>();
				String[] strFirLine = br.readLine().split(",");
				for (int j = 0; j < strFirLine.length; j++) {
					HashMap<String, String> contentMap = new HashMap<String, String>();
					contentMap.put("contentPosition", "position_" + j);
					contentMap.put("contentLine", strFirLine[j]);
					arrayList.add(contentMap);
				}
				return arrayList;
			} catch (Exception e) {
				e.printStackTrace();
				return null;
			}
		} else if (judgeFileType(uploadFile) == 2) {
			List<HashMap<String, String>> arrayList = new ArrayList<HashMap<String, String>>();
			try {
				// 打开上传的表格
				InputStream is = new FileInputStream(uploadFile);
				// 得到工作表里的内容
				jxl.Workbook rwb = Workbook.getWorkbook(is);
				// 读取第一个工作表的数据
				jxl.Sheet rs = rwb.getSheet(0);
				// 这里涉及到内容的回显,以及数据库字段的映射所以这里只取第一行
				int num = 0;
				// 得到第i行的数据..返回cell数组
				Cell[] cell = rs.getRow(num);
				for (int i = 0; i < cell.length; i++) {
					HashMap<String, String> contentMap = new HashMap<String, String>();
					contentMap.put("contentPosition", "position_" + i);
					contentMap.put("contentLine", cell[i].getContents());
					arrayList.add(contentMap);
				}
				return arrayList;
			} catch (Exception e) {
				e.printStackTrace();
				return null;
			}
		}
		return null;
	}

	/**
	 * 此方法只作为内容的写入，不做任务逻辑操作
	 * 
	 * @param filePath
	 *            写入的文本的路径
	 * @param contentSrc
	 *            需要写入的内容，格式已经在调用该方法前处理好，
	 * @return 成功 or 失败
	 */
	public static boolean writeFile(String filePath, String contentSrc) {
		FileWriter fileWriter = null;
		try {
			fileWriter = new FileWriter(filePath, true);
			if (fileWriter != null) {
				fileWriter.write(contentSrc);
				fileWriter.flush();
				fileWriter.close();
				return true;
			} else {
				return false;
			}
		} catch (IOException e2) {
			if (fileWriter != null) {
				try {
					fileWriter.flush();
					fileWriter.close();
				} catch (IOException e1) {
					e1.printStackTrace();
				}
			}
			System.out.println(e2.getMessage());
			return false;
		}
	}
	
	/**
	 * 此方法只作为内容的写入，不做任务逻辑操作
	 * 
	 * @param filePath
	 *            写入的文本的路径
	 * @param contentSrc
	 *            需要写入的内容，格式已经在调用该方法前处理好，
	 * @param isNew
	 *            是否需要重写文件
	 * @return 成功 or 失败
	 */
	public static boolean writeFile(String filePath, String contentSrc, boolean isNew) {
		if(isNew) {
			File file = new File(filePath) ;
			if(file.exists()) {
				file.delete() ;
			}
		}
		return writeFile(filePath, contentSrc) ;
	}

	/**
	 * 复制单个文件
	 * 
	 * @param srcFileName
	 *            待复制的文件名
	 * @param descFileName
	 *            目标文件名
	 * @param overlay
	 *            如果目标文件存在，是否覆盖
	 * @return 如果复制成功返回true，否则返回false
	 */
	public static boolean copyFile(String srcFileName, String destFileName, boolean overlay) {
		File srcFile = new File(srcFileName);

	
		// 判断目标文件是否存在
		File destFile = new File(destFileName);
		
		createFolder(destFile.getParent());

		// 复制文件
		int byteread = 0; // 读取的字节数
		InputStream in = null;
		OutputStream out = null;

		try {
			in = new FileInputStream(srcFile);
			out = new FileOutputStream(destFile);
			byte[] buffer = new byte[1024];

			while ((byteread = in.read(buffer)) != -1) {
				out.write(buffer, 0, byteread);
			}
			return true;
		} catch (FileNotFoundException e) {
			return false;
		} catch (IOException e) {
			return false;
		} finally {
			try {
				if (out != null)
					out.close();
				if (in != null)
					in.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	
	/**
	 * 
	 * @param filePath
	 *            存储文件
	 * @param uploadFile
	 *            上传文件
	 * @param fileName
	 *            文件名称
	 * @return
	 */
	public static boolean writeFile(File filePath, File uploadFile) {
		FileOutputStream fos = null;
		FileInputStream fis = null;
		try {

			fos = new FileOutputStream(filePath);
			fis = new FileInputStream(uploadFile);
			byte[] buffer = new byte[1024];
			int len = 0;
			while ((len = fis.read(buffer)) > 0) {
				fos.write(buffer, 0, len);
			}

			if (fos != null) {
				fos.close();
			}

			if (fis != null) {
				fos.close();
			}

		} catch (Exception e) {
			if (fos != null) {
				try {
					fos.close();
				} catch (IOException e1) {
					e1.printStackTrace();
					return false;
				}

			}
			if (fis != null) {
				try {
					fis.close();
				} catch (IOException e1) {
					e1.printStackTrace();
					return false;
				}

			}
			e.printStackTrace();
			return false;
		}

		return true;
	}

	/**
	 * 
	 * @param path
	 *            文件所在路径
	 * @param fileName
	 *            文件名称
	 * @return
	 */
	public static boolean deleteFile(String path, String fileName) {
		try {
			File f = new File(path + File.separator + fileName);
			if (f.exists()) {
				f.delete();
			}

		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}

		return true;
	}

	/**
	 * 单独传入完整路径删除相关文件信息
	 * 
	 * @param path
	 * @return
	 */
	public static boolean deleteFile(String path) {
		try {
			File f = new File(path);
			if (f.exists()) {
				f.delete();
			}

		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}

		return true;
	}
	
	/**
	 * 
	 * 得到文件夹下最大文件夹名称
	 * 
	 * */
	public static int getMax_2(int[] arr) {
		int max = 0;
		for (int x = 1; x < arr.length; x++) {
			if (arr[x] > arr[max])
				max = x;
		}
		return arr[max];
	}

	/**
	 * 
	 * 得到文件夹名称
	 * 
	 * */
	public static int[] refreshFileList(String strPath) {
		File dir = new File(strPath);
		File[] files = dir.listFiles();
		int l[] = new int[files.length];
		for (int i = 0; i < files.length; i++) {
			if (files[i].isDirectory()) {
				refreshFileList(files[i].getAbsolutePath());
				l[i] = Integer.parseInt(files[i].getName());
			} 
		}
		return l;
	}
	
	/**
	 * 描述：比较两个数据，找出不一样的数据，组成一个数组并返回 <br/>
	 * 
	 * @return String[]
	 */
	 public static String[] compareArrStrFindDiff(String target[], String source[]){
	        StringBuffer sb = new StringBuffer();
	        Integer index = 0;
	        for (int i = 0; i < source.length; i++) {
	            boolean flag = true;
	            for (int j = 0; j < target.length; j++) {
	                if(source[i].equals(target[j])){
	                    flag = false;
	                    break;
	                }
	            }
	            if(flag){
	                sb.append(index == 0 ? source[i] : "," + source[i]);
	                index++;
	            }
	        }
	        if(sb.length() > 0)
	            return sb.toString().split(",");
	            return null;
	        }
	
	
	/**
	 * 
	 * 清空缓冲
	 * 
	 * @param buffer
	 */

	@SuppressWarnings("unchecked")
	public static void unmap(final Object buffer) {
		AccessController.doPrivileged(new PrivilegedAction() {
			public Object run() {
				try {
					Method getCleanerMethod = buffer.getClass().getMethod("cleaner", new Class[0]);
					getCleanerMethod.setAccessible(true);
					sun.misc.Cleaner cleaner = (sun.misc.Cleaner) getCleanerMethod.invoke(buffer, new Object[0]);
					cleaner.clean();
				} catch (Exception e) {
					e.printStackTrace();
				}
				return null;
			}
		});
	}
	
	
	/**
	 * 
	 * 获取文件夹下文件数目
	 * 
	 * @param 文件夹路径
	 * 
	 * 
	 */
	public static int foldNum(String path){
		int fileCount = 0;
		int folderCount = 0; 
		File d = new File(path);
		File list[] = d.listFiles();
		if(list!=null){
			for(int i = 0; i < list.length; i++){
				if(list[i].isFile()){
					fileCount++;
				}else{
					folderCount++;
				}
			}
		}
		return (fileCount + folderCount);
	}
	

	
    /**
     * 删除目录（文件夹）以及目录下的文件
     * @param   sPath 被删除目录的文件路径
     * @return  目录删除成功返回true，否则返回false
     */
    public static boolean deleteDirectory(String sPath) {
    	boolean flag = false;
        //如果sPath不以文件分隔符结尾，自动添加文件分隔符
        if (!sPath.endsWith(File.separator)) {
            sPath = sPath + File.separator;
        }
        File dirFile = new File(sPath);
        //如果dir对应的文件不存在，或者不是一个目录，则退出
        if (!dirFile.exists() || !dirFile.isDirectory()) {
            return false;
        }
        flag = true;
        //删除文件夹下的所有文件(包括子目录)
        File[] files = dirFile.listFiles();
        for (int i = 0; i < files.length; i++) {
            //删除子文件
            if (files[i].isFile()) {
                flag = deleteFile(files[i].getAbsolutePath());
                if (!flag) break;
            } //删除子目录
            else {
                flag = deleteDirectory(files[i].getAbsolutePath());
                if (!flag) break;
            }
        }
        if (!flag) return false;
        //删除当前目录
        if (dirFile.delete()) {
            return true;
        } else {
            return false;
        }
    }

	/**
	 * 上传文件
	 * 上传顺序：1-资源   2-预览图片（可以为空）
	 * @param context
	 * @param request
	 * @return
	 */
	public static HashMap<String,String> uploadBigFile(ServletContext context, HttpServletRequest request){
		HashMap<String,String> paramMap = new HashMap<String,String>() ;
		String filePath = context.getRealPath("/") ;
		String resUploadPath = "upload/" + DateUtil.getCurrentDateString("yyyyMMdd") + "/" ;
        // Check that we have a file upload request  
        boolean isMultipart = ServletFileUpload.isMultipartContent(request);  
        if (!isMultipart) {  
            return paramMap;  
        }  
        File file1 = new File(filePath + "/" + resUploadPath) ;
        if(!file1.exists()) {
        	file1.mkdirs() ;
        }
        FileItemFactory factory = newDiskFileItemFactory(context, file1);  
        
        // Create a new file upload handler  
        ServletFileUpload upload = new ServletFileUpload(factory);  
        upload.setHeaderEncoding("UTF-8");  
        /* FileItem */  
        List<FileItem> items = null;  
        try {  
            // Parse the request  
            items = (List<FileItem>) upload.parseRequest(request);  
            String fileName = null;  
            // upload下的路径
			
            String[] fileNames = new String[items.size()] ;
            int i = 0 ;
            for (FileItem fileItem : items) {  
                if (!fileItem.isFormField()){//file  
                	String fileDateName = DateUtil.sDateFormat() ;
                	String oldFileName = FilenameUtils.getName(fileItem.getName()); 
                    if(null != oldFileName && !"".equals(oldFileName)){
                    	fileName = fileDateName + oldFileName.substring(oldFileName.lastIndexOf("."));
	                    File file = new File(filePath + "/" + resUploadPath + fileName) ;
	                    fileItem.write(file);
	                    if(i == 0) {
	                    	paramMap.put("oldUploadFileName", oldFileName) ;
	                    	paramMap.put("resUpload", resUploadPath + fileName) ;
	                    }else {
	                    	paramMap.put("resThumbnail", resUploadPath + fileName) ;
	                    	paramMap.put("oldThumbnailFileName", oldFileName) ;
	                    }
	                    i ++ ;
                    }
                }else {
                	String fieldName =  fileItem.getFieldName().replaceAll("paramMap.", "") ;
                	String fieldVale = fileItem.getString("UTF-8") ;
                	if(paramMap.get(fieldName) != null){
                		fieldVale = paramMap.get(fieldName) + "," + fieldVale ;
                	}
                	paramMap.put(fieldName, fieldVale) ;
                }
               
            }  
        } catch (Exception e) {  
        	e.printStackTrace() ;
        }
        return paramMap ;
	}
	
	public static DiskFileItemFactory newDiskFileItemFactory(  
            ServletContext context, File repository) {  
        FileCleaningTracker fileCleaningTracker = FileCleanerCleanup  
                .getFileCleaningTracker(context);  
        DiskFileItemFactory factory = new DiskFileItemFactory(  
                DiskFileItemFactory.DEFAULT_SIZE_THRESHOLD, repository);  
        factory.setFileCleaningTracker(fileCleaningTracker);  
        return factory;  
    }
	
	/**
	 * 修改文件名称
	 * @param newFilePath 新文件绝对路径
	 * @param filePath	原文件绝对路径
	 */
	public static void reName(String newFilePath, String filePath) {
		File file = new File(filePath) ;
		String tempPath = newFilePath.substring(0, newFilePath.lastIndexOf("/")) ;
		createFolder(tempPath);
		if(file.exists()) {
			file.renameTo(new File(newFilePath)) ;
		}
	}
	
	public static void moveFile(String newFilePath, String filePath) {
		
	}
	
	
	/** 对多文件上传的路径处理方法 */
	public static List<String> getTempPath(String str, int length) {
		String fileSplit = "/";
		List<String> returnList = new ArrayList<String>();
		/** 当隐藏域没有配置 */
		if (str == null) {
			for (int i = 0; i < length; i++) {
				returnList.add(fileSplit);
			}
			return returnList;
		} else {
			/** 当上传多文件的时候两种情况 */
			String strs[] = str.split("&");
			if (strs.length > 0 && strs.length < length) {
				for (int i = 0; i < strs.length; i++) {
					returnList.add(strs[i] + fileSplit);
				}
				for (int j = 0; j < length - strs.length; j++) {
					returnList.add(fileSplit);
				}
				return returnList;
			} else {
				returnList.add(str);
				for (int i = 0; i < length - 1; i++) {
					returnList.add(fileSplit);
				}
				return returnList;
			}
		}
	}
	
	/**
	 * 读取文件，将每行数据放到集合中
	 * @param file
	 * @return
	 */
	public static List<String> readFileToList(File file) {
		List<String> list = new ArrayList<String>() ;
		FileReader fr = null;
		BufferedReader br = null;
		try {
			fr = new FileReader(file);// 建立FileReader对象，并实例化为fr
			br = new BufferedReader(fr);// 建立BufferedReader对象，并实例化为br
			String Line = br.readLine();// 从文件读取一行字符串
			// 判断读取到的字符串是否不为空
			while (Line != null) {
				list.add(Line) ;
				Line = br.readLine();// 从文件中继续读取一行数据
			}
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (br != null)
					br.close();// 关闭BufferedReader对象
				if (fr != null)
					fr.close();// 关闭文件
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
    
        return list ;
	}
	
	public static String[] emptyArray(String aa[]) {
	    StringBuffer sb = new StringBuffer();
	    for (int i = 0; i < aa.length; i++) {
	    	if ("".equals(aa[i].trim().replace("  ", "").replace("   ", ""))) {
	            continue;
	        }
	        sb.append(aa[i]);
	        if (i != aa.length - 1) {
	            sb.append(";");
	        }
	    }
	    aa = sb.toString().split(";");
	    return aa;
	}
	
	public static String testA(String[] s) {  
        String [] str = s;  
        List<String> list = new ArrayList<String>();  
        for (int i=0; i<str.length; i++) {  
            if(!list.contains(str[i].replace(" ", ""))) {  
                list.add(str[i].replace(" ", ""));  
            }  
        }  
        String[] newStr =  list.toArray(new String[1]);
        String val = "";
        for (String elementB:newStr ) {
			val += elementB + ",";
		}
        if(s!=null && s.length>0){
        	val = val.substring(0,val.lastIndexOf(","));
        }
        return val;
    }  
	
	 public static boolean isChinese(char c) {
		    Character.UnicodeBlock ub = Character.UnicodeBlock.of(c);
		    if (ub == Character.UnicodeBlock.CJK_UNIFIED_IDEOGRAPHS
		        || ub == Character.UnicodeBlock.CJK_COMPATIBILITY_IDEOGRAPHS
		        || ub == Character.UnicodeBlock.CJK_UNIFIED_IDEOGRAPHS_EXTENSION_A
		        || ub == Character.UnicodeBlock.GENERAL_PUNCTUATION
		        || ub == Character.UnicodeBlock.CJK_SYMBOLS_AND_PUNCTUATION
		        || ub == Character.UnicodeBlock.HALFWIDTH_AND_FULLWIDTH_FORMS) {
		      return true;
		    }
		    return false;
	  }

	  public static boolean isMessyCode(String str) {
		 	byte b[];
			try {
				b = str.getBytes("ISO8859_1");
				for (int i = 0; i < b.length; i++) {
					byte b1 = b[i];
					if (b1 == 63)
						break; 
					else if (b1 > 0)
						continue;
					else if (b1 < 0) {
						return true;
					}
				}
			} catch (UnsupportedEncodingException e) {
				return true;
			}
			return false;
		  
		    /*Pattern p = Pattern.compile("\\s*|\t*|\r*|\n*");
		    Matcher m = p.matcher(strName);
		    String after = m.replaceAll("");
		    String temp = after.replaceAll("\\p{P}", "");
		    char[] ch = temp.trim().toCharArray();
		    float chLength = ch.length;
		    float count = 0;
		    for (int i = 0; i < ch.length; i++) {
		      char c = ch[i];
		      if (!Character.isLetterOrDigit(c)) {

		        if (!isChinese(c)) {
		          count = count + 1;
		        }
		      }
		    }
		    float result = count / chLength;
		    if (result > 0.4) {
		      return true;
		    } else {
		      return false;
		    }
*/
		  }
		
}

package com.ow.module.event.sysmgr.laboratory;

import java.awt.Image;
import java.awt.Rectangle;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.RandomAccessFile;
import java.net.URLEncoder;
import java.nio.ByteBuffer;
import java.nio.channels.FileChannel;
import java.util.Arrays;
import java.util.HashMap;

import com.ambow.base.grm.common.ConstantI;
import com.ambow.base.grm.onlineread.business.FileConvertBusiness;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.util.DBUtil;
import com.ow.framework.util.FileHelper;
import com.ow.framework.util.StringUtil;
import com.ow.framework.util.ToPicReferenceUtil;
import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGEncodeParam;
import com.sun.image.codec.jpeg.JPEGImageEncoder;
import com.sun.pdfview.PDFFile;
import com.sun.pdfview.PDFPage;

public class LaboratoryUploadHelp {
	
	private static String filename = "";
	
	private static String repeatTypeto = "";
	
	public static void laboratoryHandlePptDocPdf(String fileRealPath, String upload, String savepath, String resType, String[] fileObject, int fileindex, HashMap paramMap,String referfolder) throws Exception{
		
		laboratoryHandlePptDocPdf(fileRealPath, upload, savepath, resType, paramMap,referfolder);
		
		fileObject[fileindex] = getFilename();
		
	}
	
	public static void laboratoryHandlePptDocPdf(String fileRealPath, String upload, String savepath, String resType, HashMap paramMap,String referfolder) throws Exception {
		
		fileRealPath = fileRealPath.replace("\\", "/");
		
		upload = upload.replace("\\", "/"); 
		
		String filePath = fileRealPath + "/" + upload ;
		
		String fileRealName =  filePath.substring(filePath.lastIndexOf("/")+1);
		
		String fileType = fileRealName.substring(fileRealName.lastIndexOf("."));
		
		String fileTempName =  URLEncoder.encode(fileRealName.replace(fileType, ""));
		
		String fileFolder = filePath.substring(0,filePath.lastIndexOf("/"));
		
		String convertPDFName = fileTempName + ".pdf";
		
		String convertSWFName = fileTempName + ".swf";
		
		FileConvertBusiness fCBusiness= new FileConvertBusiness();
		
		boolean convertPDFFlag = fCBusiness.docToPdf(new File(filePath), new File(fileFolder+File.separator+convertPDFName),ConstantI.PDFJARPATH_KEY,ConstantI.TRANSFORTYPEFLAG_KEY);
		
		if(fileType.toLowerCase().indexOf("pdf") > -1){
			convertPDFFlag = true;
		}
		
		boolean convertSWFFlag = false;
		if(convertPDFFlag){//pdf 是否转化完成
			convertSWFFlag = fCBusiness.PdfToSwf(new File(fileFolder+File.separator+convertPDFName),new File(fileFolder+File.separator+convertSWFName), ConstantI.SWFTOOLSPATH_KEY);
			//paramMap.put(StringUtil.reResAbbreviated(resType)+"FileSwfPath", (fileFolder+File.separator+convertSWFName).substring((fileFolder+File.separator+convertSWFName).indexOf(savepath)).trim().replace("\\","/")) ;
		}
		
		LaboratoryUploadHelp.laboratoryHandlepdftopic(new File(fileFolder+File.separator+convertPDFName), fileType, fileFolder, savepath, resType, paramMap,referfolder);
		
		/*String path = filePath;
		path = path.substring(path.lastIndexOf("\\")+1,path.lastIndexOf("."));
		path = path.substring(path.length()-4);
		
		FileHelper.writeFile(new File(fileFolder+File.separator+path+File.separator+convertPDFName), new File(fileFolder+File.separator+convertPDFName));
		FileHelper.deleteFile(fileFolder+File.separator+convertPDFName) ;
		
		FileHelper.writeFile(new File(fileFolder+File.separator+path+File.separator+fileRealName), new File(fileFolder+File.separator+fileRealName));
		FileHelper.deleteFile(fileFolder+File.separator+fileRealName) ;*/
			
	}

	public static void laboratoryHandlepdftopic(File file, String referfalg, String fileFolder, String savepath, String resType, HashMap paramMap,String referfolder) throws Exception {
		
		RandomAccessFile raf;
		
		
		
		
		PDFFile pdffile = null;
		
	//	try {
		
			raf = new RandomAccessFile(file, "r");
			
			FileChannel channel = raf.getChannel();
			
			ByteBuffer buf = channel.map(FileChannel.MapMode.READ_ONLY, 0, channel.size());
			
			pdffile = new PDFFile(buf);
			
			String path = file.getPath();
			
			String referismodi = paramMap.get("referismodi") == null ? "" : (String)paramMap.get("referismodi") ;
			String RoomType = paramMap.get(StringUtil.reResAbbreviated(resType) + "Type") == null ? "" : (String)paramMap.get(StringUtil.reResAbbreviated(resType) + "Type");
			String referResLen = paramMap.get("referResLen") == null ? "0" : (String)paramMap.get("referResLen") ;
			if(!referResLen.equals("0")){
				RoomType= "4044";
			}
			if((RoomType.equals("4044"))){
				
				path = referfalg.replace(".", "").trim();
				
			}else{
		
				path = path.substring(path.lastIndexOf("\\")+1,path.lastIndexOf("."));
				
				path = path.substring(path.length()-4);
		
				FileHelper.createFolder(fileFolder + "/" + path + "/mainfile");
			}
			
			String getPdfFilePath = fileFolder + "/" + path;
			
			if((RoomType.equals("4044"))){
				
				getPdfFilePath += "/" + referfolder;
				
				if(getPdfFilePath.indexOf("auxilifile") > -1){
					
					FileHelper.createFolder(getPdfFilePath);
				
				}else{
					
					String roomno = paramMap.get(StringUtil.reResAbbreviated(resType) + "NO") == null ? "" : (String)paramMap.get(StringUtil.reResAbbreviated(resType) + "NO");
					roomno = roomno.substring(roomno.length()-4);
					FileHelper.createFolder(fileFolder + "/" + roomno + "/" + "mainfile");
					getPdfFilePath = fileFolder + "/" + roomno + "/" + "mainfile";
				}
				
				
			}else{
				
				getPdfFilePath += "/mainfile";
			
			}
			
			for (int i = 1; i <= pdffile.getNumPages(); i++) {
			
				PDFPage page = pdffile.getPage(i);
				
				Rectangle rect = new Rectangle(0, 0, (int) page.getBBox().getWidth(), (int) page.getBBox().getHeight());
				
				Image img = page.getImage(rect.width, rect.height, rect, null, true, true);
				
				BufferedImage tag = new BufferedImage(rect.width, rect.height, BufferedImage.TYPE_INT_RGB);
				
				tag.getGraphics().drawImage(img, 0, 0, rect.width, rect.height,null);
				
				FileOutputStream out = new FileOutputStream(getPdfFilePath + "//" + i + ".jpg");
				
				System.out.println("成功保存图片到:" + getPdfFilePath + "//" + i + ".jpg");
				
				JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
				
				JPEGEncodeParam param2 = encoder.getDefaultJPEGEncodeParam(tag);
				
				param2.setQuality(1f, false);
				
				encoder.setJPEGEncodeParam(param2);
				
				encoder.encode(tag);
				
				out.close();
				
				
				
			}
			
			channel.close();

			raf.close();
			
			FileHelper.unmap(buf);
			
			String a =getPdfFilePath.substring(getPdfFilePath.indexOf(savepath)); 
			
			String s = file.getPath().substring(file.getPath().lastIndexOf(savepath),file.getPath().lastIndexOf(".")) + referfalg;
			
			String s1 = file.getPath().substring(file.getPath().lastIndexOf(savepath),file.getPath().lastIndexOf(".")) + ".swf";
			
			if((RoomType.equals("4044"))){
				
				filename = path;
				
				if(getPdfFilePath.indexOf("auxilifile") > -1){

					String ReferLocation = paramMap.get(StringUtil.reResAbbreviated(resType)+"ReferLocation") == null ? "" : (String)paramMap.get(StringUtil.reResAbbreviated(resType)+"ReferLocation");
					
					a = ReferLocation + a;
					
					paramMap.put(StringUtil.reResAbbreviated(resType)+"ReferLocation", a.replace("//", "/").trim() + ",") ;
					
					String ReferRealLocation = paramMap.get(StringUtil.reResAbbreviated(resType)+"ReferRealLocation") == null ? "" : (String)paramMap.get(StringUtil.reResAbbreviated(resType)+"ReferRealLocation");
					
					s = ReferRealLocation + s;
					
					paramMap.put(StringUtil.reResAbbreviated(resType)+"ReferRealLocation", s.trim().replace("\\", "/") + ",");
					
					String ReferRealLocationSwfPath = paramMap.get(StringUtil.reResAbbreviated(resType)+"ReferRealLocationSwfPath") == null ? "" : (String)paramMap.get(StringUtil.reResAbbreviated(resType)+"ReferRealLocationSwfPath");
					
					s1 = ReferRealLocationSwfPath + s1;
					
					paramMap.put(StringUtil.reResAbbreviated(resType)+"ReferRealLocationSwfPath", s1.trim().replace("\\", "/") + ",");
					
				}else{
					
					paramMap.put(StringUtil.reResAbbreviated(resType)+"FileSwf", getPdfFilePath.substring(getPdfFilePath.indexOf(savepath)).trim()) ;
					
				}
			
			}else{
			
				paramMap.put(StringUtil.reResAbbreviated(resType)+"FileSwf", a) ;
		
			}
		//maple	
	/*	} catch (FileNotFoundException e) {
	
			e.printStackTrace();
	
		} catch (IOException e) {
			
			e.printStackTrace();
		}*/
	}

public static void laboratoryHandlepdftopicTwo(File file, String referfalg, String fileFolder, String savepath, String resType, HashMap paramMap) throws Exception {
		
		RandomAccessFile raf;
		
		PDFFile pdffile = null;
		
		//try {
		
			raf = new RandomAccessFile(file, "r");
			
			FileChannel channel = raf.getChannel();
			
			ByteBuffer buf = channel.map(FileChannel.MapMode.READ_ONLY, 0, channel.size());
			
			pdffile = new PDFFile(buf);
			
			String path = file.getParent();
			
			String getPdfFilePath = path + "/" + fileFolder;
			
			for (int i = 1; i <= pdffile.getNumPages(); i++) {
			
				PDFPage page = pdffile.getPage(i);
				
				Rectangle rect = new Rectangle(0, 0, (int) page.getBBox().getWidth(), (int) page.getBBox().getHeight());
				
				Image img = page.getImage(rect.width, rect.height, rect, null, true, true);
				
				BufferedImage tag = new BufferedImage(rect.width, rect.height, BufferedImage.TYPE_INT_RGB);
				
				tag.getGraphics().drawImage(img, 0, 0, rect.width, rect.height,null);
				
				FileOutputStream out = new FileOutputStream(getPdfFilePath + "//" + i + ".jpg");
				
				System.out.println("成功保存图片到:" + getPdfFilePath + "//" + i + ".jpg");
				
				JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
				
				JPEGEncodeParam param2 = encoder.getDefaultJPEGEncodeParam(tag);
				
				param2.setQuality(1f, false);
				
				encoder.setJPEGEncodeParam(param2);
				
				encoder.encode(tag);
				
				out.close();
				
			}
			
			channel.close();

			raf.close();
			
			FileHelper.unmap(buf);
			
		//} 
		//maple
		/*catch (FileNotFoundException e) {
	
			e.printStackTrace();
	
		} catch (IOException e) {
			
			e.printStackTrace();
		}*/
	}
	
	public static String laboratoryHandleReference(String pfoldpath,String ppath,File[] files,int i, String upload,String oldFileName,String pfileRealPath,String puppath){
		
		FileHelper.createFolder(pfoldpath);
		
		laboratoryHandleOn(ppath,files,i); 
		
		String namebeforepath = upload.substring(upload.lastIndexOf("/")+1,upload.lastIndexOf(".")) + oldFileName.substring(oldFileName.lastIndexOf("."));
		
		FileHelper.deleteFile(pfileRealPath + puppath + "/" + namebeforepath) ;
		
		FileHelper.reName(pfileRealPath + puppath + "/" + namebeforepath,ppath) ;
		
		upload = puppath + "/" + namebeforepath;
	
		return upload;
	}

	public static ResultData laboratoryHandleOn(String ppath,File[] files,int i){
		
		ResultData resultData = new ResultData();
		
		if (!FileHelper.writeFile(new File(ppath), files[i])) {
		
			resultData.setIntResult(-1);
	
			return resultData;
		}
		
		return resultData;
	}
	
	public static void  laboratoryHandleFileDocumentReference(String filep, String snNO1, String fileRealPath ,String realrefeFoldername,String resType,String savepath,HashMap paramMap,String dsname){
		
		File file = new File(filep);				
		
		File[] files = file.listFiles(); // 获取文件夹下面的所有文件
		
		String[] fileArray = new String[files.length];
		
		int[] docusnNo = new int[]{1000,1000,1000};
		
		String happenArray[] = new String[3];
		
		String[] bs=new String[files.length];
		String referDirs="";
		String referSwfPath="";
		
		for (int i=0;i<files.length;i++) {
		
			boolean happenFalg = false;
			
			if(!files[i].isDirectory()){
				
				String pathfile = files[i].getAbsolutePath();
				
				String a = pathfile.substring(0,pathfile.lastIndexOf("\\"));
				
				String b = pathfile.substring(pathfile.lastIndexOf("_"));
				bs[i]=b;
				
				String c = a + "/" + snNO1 + b;
				
				String bh = b.substring(b.lastIndexOf(".")).replace(".", "").trim();
				
				for(int d = 0;d < 3; d++){
					if(happenArray[d]==null){happenArray[d] = "";}
					//System.out.println(happenArray[d] + " -- " + happenArray[d].equals(bh));
					if(happenArray[d].equals(bh)){
						happenFalg = true;
					}
				}
				
				if(happenFalg){
					
					if(bh.equalsIgnoreCase("doc")){
						docusnNo[0]++;
					} 
						
					if(bh.equalsIgnoreCase("ppt")){
						docusnNo[1]++;
					}
					
					if(bh.equalsIgnoreCase("pdf")){
						docusnNo[2]++;
					} 
					
				}else{
					int in = 0;
					for(int s=0;s<happenArray.length;s++){
						if(happenArray[s] == ""){
							in = s;
							break;
						}
						
					}
					
					happenArray[in] = bh;
				
				}
				
				
				FileHelper.deleteFile(c) ;
				
				FileHelper.reName(c, pathfile) ;
				
				String refilename = pathfile.substring(pathfile.lastIndexOf(".")).replace(".", "").trim();
				
				if(!refilename.equalsIgnoreCase(".db")){	
				
					String repeatType = "";
					if(bh.equalsIgnoreCase("doc")){
						repeatType = (docusnNo[0]+"").trim();
						fileArray[i]="doc";
					} 
						
					if(bh.equalsIgnoreCase("ppt")){
						repeatType = (docusnNo[1]+"").trim();
						fileArray[i]="ppt";
					}
					
					if(bh.equalsIgnoreCase("pdf")){
						repeatType = (docusnNo[2]+"").trim();
						fileArray[i]="pdf";
					} 
					
					
					repeatTypeto = repeatType;
					
					String referDir=fileRealPath + realrefeFoldername + "/" + refilename + "/" + repeatType;
					referSwfPath+=realrefeFoldername + "/" + snNO1 + b+",";
					referDirs+=referDir.substring(referDir.indexOf("upload"))+",";
					
					FileHelper.deleteDirectory(referDir);
					
					FileHelper.createFolder(referDir);
					
					//maple
						/*try {
							LaboratoryUploadHelp.laboratoryHandlePptDocPdf(fileRealPath, realrefeFoldername + "/" + snNO1 + b, savepath, resType, fileArray, i, paramMap);
						} catch (Exception e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}*/
									
				}		
				
				
			
			}
			
			paramMap.put(StringUtil.reResAbbreviated(resType)+"ReferRealLocationSwfPath", referSwfPath);
			paramMap.put(StringUtil.reResAbbreviated(resType)+"ReferLocation", referDirs);
			
			ToPicReferenceUtil toPic=new ToPicReferenceUtil(fileRealPath, realrefeFoldername + "/" + snNO1 + bs[i], savepath, resType, fileArray, i, paramMap,dsname,repeatTypeto);
			Thread temp_t=new Thread(toPic);
			temp_t.start();
			
			
			
		}
		
		paramMap.put(StringUtil.reResAbbreviated(resType)+"ReferType", Arrays.toString(DBUtil.dictinctArray(fileArray)).replace("[", "").replace("]", "").replace(" ", "").trim());
	
		paramMap.put(StringUtil.reResAbbreviated(resType)+"HelpReferType",Arrays.toString(DBUtil.removeArraynull(fileArray)).replace("[", "").replace("]", "").replace(" ", "").trim());
		
		paramMap.remove("snNO"); paramMap.remove("realrefeFoldername");
	}
	
	public static void laboratoryHandleFileFCKeditorSwf(){
		
	}
	
	
	
	public static String getFilename() { return filename; }

	public static String getRepeatTypeto() { return repeatTypeto; }
	
}

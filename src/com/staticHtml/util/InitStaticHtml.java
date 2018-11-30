package com.staticHtml.util;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.ambow.base.grm.common.ConstantI;
import com.ow.framework.data.dao.SessionFactory;
import com.staticHtml.bean.DuoweiBean;
import com.staticHtml.bean.ImgBean;
import com.staticHtml.bean.PageInfoBean;
import com.staticHtml.bean.VideoBean;
import com.staticHtml.bean.WendangBean;

public class InitStaticHtml implements Runnable {

	private String dsname;
	private String resName;
	private String content;
	private PageInfoBean pib;
	private String code;
	
	

/**
 * 
 * @param dsname 数据源
 * @param resName 资源名称
 * @param content 小故事
 * @param pib	页面信息
 * @param code 编号
 */
	public InitStaticHtml(String dsname, String resName, String content,
			PageInfoBean pib, String code) {
		super();
		this.dsname = dsname;
		this.resName = resName;
		this.content = content;
		this.pib = pib;
		this.code = code;
	}











	@Override
	public void run() {
		// TODO Auto-generated method stub
		System.out.println("静态化初始化测试");
		System.out.println("资源名称为:"+resName);
		System.out.println("dsname:"+dsname);
		System.out.println("content:"+content);
		
		if(!(content!=null&&!content.equals(""))){
			System.out.println("没有小故事，跳过");
			return ;
		}
		pib.setName(resName);
		HashMap paramMap = new HashMap<Object, Object>();
		
		paramMap.put("keyword", resName);
		paramMap.put("name", resName);
		//paramMap.put("name", "鹅");
		SqlSession sqlsession;
		try {
			sqlsession = SessionFactory.getInstance().getSQLSession(dsname);
			List<HashMap<String, Object>> list7 = sqlsession.selectList("relate.select_name_keyword", paramMap);
			List<String> relateexhibition = new ArrayList();
			List<String> relateobservation = new ArrayList();
			List<String> relatelaboratory = new ArrayList();
			List<String> relateprojection = new ArrayList();
			List<String> relatelovely = new ArrayList();
			List<HashMap> relateimg = new ArrayList<HashMap>();
			List<HashMap> relatevideo = new ArrayList<HashMap>();
			List<HashMap> relateppt = new ArrayList<HashMap>();
			List<HashMap> relatepdf = new ArrayList<HashMap>();
			List<HashMap> relateword = new ArrayList<HashMap>();
			List<HashMap> relateduowei = new ArrayList<HashMap>();
			List<HashMap> relatesanwei = new ArrayList<HashMap>();
			List<HashMap> relatexuni = new ArrayList<HashMap>();
	 		for(HashMap<String, Object> res : list7) {
				HashMap<String, Object> map3 = new HashMap<String, Object>() ;
				HashMap<String, Object> map4 = new HashMap<String, Object>() ;
				String rrRoom=(String) res.get("rrBroom");
				String rrId=(String) res.get("rrBid");
				if("exhibition".equals(rrRoom)){
					relateexhibition.add(rrId);
				}else if("observation".equals(rrRoom)){
					relateobservation.add(rrId);
				}else if("laboratory".equals(rrRoom)){
					relatelaboratory.add(rrId);
				}else if("projection".equals(rrRoom)){
					relateprojection.add(rrId);
				}else if("lovely".equals(rrRoom)){
					relatelovely.add(rrId);
				}			
			}
	 		for(int i=0;i<relateexhibition.size();i++){
	 			Map exhibitionMap = new HashMap();
	 			exhibitionMap.put("erID", relateexhibition.get(i));		 			
	 			HashMap<String, Object> objE = (HashMap<String, Object>)sqlsession.selectOne("exhibition.select_by_id",exhibitionMap );
	 			HashMap<String, Object> map3 = new HashMap<String, Object>() ;
				map3.put("id", objE.get("erID")) ;
				map3.put("fileType", objE.get("erType")) ;
				map3.put("resType", "exhibition") ; 
				if(map3.get("fileType").toString().equals("1011")){
					relateimg.add(map3);
				}				
	 		}
	 		for(int i=0;i<relateobservation.size();i++){
	 			Map observationMap = new HashMap();
	 			observationMap.put("orID", relateobservation.get(i));		 			
	 			HashMap<String, Object> objE = (HashMap<String, Object>)sqlsession.selectOne("observation.select_by_id",observationMap );
	 			HashMap<String, Object> map3 = new HashMap<String, Object>() ;
				map3.put("id", objE.get("orID")) ;
				map3.put("fileType", objE.get("orType")) ;
				map3.put("resType", "observation") ;
				if(map3.get("fileType").toString().equals("1011")){
					relateimg.add(map3);
				}
				else if(map3.get("fileType").toString().equals("1084")){
					relatevideo.add(map3);
				}
				else if(map3.get("fileType").toString().equals("4033")){
					relateduowei.add(map3);
				}				
	 		}
	 		for(int i=0;i<relatelaboratory.size();i++){
	 			Map laboratoryMap = new HashMap();
	 			laboratoryMap.put("lrID", relatelaboratory.get(i));		 			
	 			HashMap<String, Object> objE = (HashMap<String, Object>)sqlsession.selectOne("laboratory.select_by_id",laboratoryMap );
	 			HashMap<String, Object> map2 = new HashMap<String, Object>() ;
				map2.put("id", objE.get("lrID")) ;
				map2.put("fileType", objE.get("lrType")) ;
				map2.put("resType", "laboratory") ;
				if(map2.get("fileType").toString().equals("1011")){
					relateimg.add(map2);
				}
				else if(map2.get("fileType").toString().equals("1084")){
					relatevideo.add(map2);
				}
				else if(map2.get("fileType").toString().equals("2033")){
					relateword.add(map2);
				}	
				else if(map2.get("fileType").toString().equals("2041")){
					relateppt.add(map2);
				}	
				else if(map2.get("fileType").toString().equals("2055")){
					relatepdf.add(map2);
				}	
	 		}
	 		for(int i=0;i<relateprojection.size();i++){
	 			Map projectionMap = new HashMap();
	 			projectionMap.put("prID", relateprojection.get(i));		 			
	 			HashMap<String, Object> objE = (HashMap<String, Object>)sqlsession.selectOne("projection.select_by_id",projectionMap );
	 			HashMap<String, Object> map3 = new HashMap<String, Object>() ;
				map3.put("id", objE.get("prID")) ;
				map3.put("fileType", objE.get("prType")) ;
				map3.put("resType", "projection") ;
				if(map3.get("fileType").toString().equals("1084")){
					relatevideo.add(map3);
				}			
	 		}
	 		for(int i=0;i<relatelovely.size();i++){
	 			Map lovelyMap = new HashMap();
	 			lovelyMap.put("crID", relatelovely.get(i));		 			
	 			HashMap<String, Object> objE = (HashMap<String, Object>)sqlsession.selectOne("lovely.select_by_id",lovelyMap );
	 			HashMap<String, Object> map4 = new HashMap<String, Object>() ;
				
				map4.put("id", objE.get("crID")) ;
				map4.put("fileType", objE.get("crType")) ;
				map4.put("resType", "lovely") ;
				if(map4.get("fileType").toString().equals("1011")){
					relateimg.add(map4);
				}
				else if(map4.get("fileType").toString().equals("1084")){
					relatevideo.add(map4);
				}
				else if(map4.get("fileType").toString().equals("2033")){
					relateword.add(map4);
				}	
				else if(map4.get("fileType").toString().equals("2041")){
					relateppt.add(map4);
				}	
				else if(map4.get("fileType").toString().equals("2055")){
					relatepdf.add(map4);
				}	
				else if(map4.get("fileType").toString().equals("1084")){
					relatevideo.add(map4);
				}	
	 		}
			
			List<String> pageList=new ArrayList<String>();
			if(pib.getResType().equals("pic")){
				System.out.println("========================");
				System.out.println("scanner");
				List impScannerList=sqlsession.selectList("res.select_static_imglist_scanner", paramMap);
				List<ImgBean> scannerList=new ArrayList<ImgBean>();
				for (Object map : impScannerList) {
					System.out.println(((HashMap)map).get("rrThumbnail").toString());
					scannerList.add(new ImgBean(((HashMap)map).get("rrThumbnail").toString(),((HashMap)map).get("rrInThum").toString()));
				}
				pib.setImgScannerList(scannerList);
			}
			pageList.add("scanner");
			
			
			List templist=sqlsession.selectList("res.select_static_imglist", paramMap);
			System.out.println("========================");
			System.out.println("pic");
			if(relateimg.size()>0||templist.size()>0){
				pageList.add("pic");
			}
			List<ImgBean> list2=new ArrayList<ImgBean>();
			for (Object map : templist) {
				System.out.println(((HashMap)map).get("rrThumbnail").toString());
				list2.add(new ImgBean(((HashMap)map).get("rrThumbnail").toString(),((HashMap)map).get("rrInThum").toString()));
			}
			
			
			for (HashMap map : relateimg) {
				System.out.println(map.get("id")+"=="+map.get("resType"));
				HashMap<String, Object> objE = (HashMap<String, Object>)sqlsession.selectOne("res.select_static_img",map );
				System.out.println(((HashMap)objE).get("rrThumbnail").toString());
				list2.add(new ImgBean(((HashMap)objE).get("rrThumbnail").toString(),((HashMap)objE).get("rrInThum").toString()));
			}
			pib.setImgList(list2);
			
			if(!content.equals("")&&content.lastIndexOf(".")>0){
				content=content.substring(0,content.lastIndexOf("."))+".doc";
			}else{
				content="";
			}
			
			//视频
			List<VideoBean> list3=new ArrayList<VideoBean>();
			templist=sqlsession.selectList("res.select_static_videolist", paramMap);
			System.out.println("========================");
			System.out.println("video");
			if(relatevideo.size()>0||templist.size()>0){
				pageList.add("video");
			}
			
			for (Object map : templist) {
				System.out.println(((HashMap)map).get("rrName").toString());
				String tmp=((HashMap)map).get("rrUpload").toString();
				tmp=tmp.substring(0,tmp.lastIndexOf("."))+".mp4";
				list3.add(new VideoBean(((HashMap)map).get("rrName").toString(), tmp,((HashMap)map).get("rrThumbnail").toString()));
			}
			for (HashMap map : relatevideo) {
				System.out.println(map.get("id")+"=="+map.get("resType"));
				HashMap<String, Object> objE = (HashMap<String, Object>)sqlsession.selectOne("res.select_static_video",map );
				System.out.println(((HashMap)objE).get("rrName").toString());
				String tmp=((HashMap)objE).get("rrUpload").toString();
				tmp=tmp.substring(0,tmp.lastIndexOf("."))+".mp4";
				list3.add(new VideoBean(((HashMap)objE).get("rrName").toString(), tmp,((HashMap)objE).get("rrThumbnail").toString()));
			}
			
			
			//三围
			List<VideoBean> list3Sanwei=new ArrayList<VideoBean>();
			templist=sqlsession.selectList("observation.select_static_videolist", paramMap);
			System.out.println("========================");
			System.out.println("sanwei");
			if(templist.size()>0||templist.size()>0){
				pageList.add("sanwei");
			}
			for (Object map : templist) {
				System.out.println(((HashMap)map).get("orName").toString());
				String tmp=((HashMap)map).get("orUpload").toString();
				tmp=tmp.substring(0,tmp.lastIndexOf("."))+".mp4";
				list3Sanwei.add(new VideoBean(((HashMap)map).get("orName").toString(), tmp,((HashMap)map).get("orThumbnail").toString()));
			}
			
			//文档
			List<WendangBean> list4ppt =new ArrayList<WendangBean>();
			templist=sqlsession.selectList("res.select_static_pptlist", paramMap);
			System.out.println("========================");
			System.out.println("ppt");
			if(relateppt.size()>0||templist.size()>0){
				pageList.add("ppt");
			}
			
			for (Object map : templist) {
				System.out.println(((HashMap)map).get("rrName").toString());
				String tmp=((HashMap)map).get("rrFileSwf").toString();
				int count=FileUtil.CountImg(new File(ConstantI.UPLOADPATH_KEY.substring(0, ConstantI.UPLOADPATH_KEY.lastIndexOf("\\"))+ConstantI.UPLOADPATH_KEY.substring(ConstantI.UPLOADPATH_KEY.lastIndexOf("\\")).replace("upload", "")+tmp));
				list4ppt.add(new WendangBean(tmp+"/", count, ((HashMap)map).get("rrName").toString()));
			}
			for (Object map : relateppt) {
				HashMap<String, Object> objE = (HashMap<String, Object>)sqlsession.selectOne("res.select_static_ppt",map );
				System.out.println(((HashMap)objE).get("rrName").toString());
				String tmp=((HashMap)objE).get("rrFileSwf").toString();
				int count=FileUtil.CountImg(new File(ConstantI.UPLOADPATH_KEY.substring(0, ConstantI.UPLOADPATH_KEY.lastIndexOf("\\"))+ConstantI.UPLOADPATH_KEY.substring(ConstantI.UPLOADPATH_KEY.lastIndexOf("\\")).replace("upload", "")+tmp));
				list4ppt.add(new WendangBean(tmp+"/", count, ((HashMap)objE).get("rrName").toString()));
			}
			
			List<WendangBean> list4pdf =new ArrayList<WendangBean>();
			templist=sqlsession.selectList("res.select_static_pdflist", paramMap);
			System.out.println("========================");
			System.out.println("pdf");
			if(relatepdf.size()>0||templist.size()>0){
				pageList.add("pdf");
			}
			
			for (Object map : templist) {
				System.out.println(((HashMap)map).get("rrName").toString());
				String tmp=((HashMap)map).get("rrFileSwf").toString();
				int count=FileUtil.CountImg(new File(ConstantI.UPLOADPATH_KEY.substring(0, ConstantI.UPLOADPATH_KEY.lastIndexOf("\\"))+ConstantI.UPLOADPATH_KEY.substring(ConstantI.UPLOADPATH_KEY.lastIndexOf("\\")).replace("upload", "")+tmp));
				list4pdf.add(new WendangBean(tmp+"/", count, ((HashMap)map).get("rrName").toString()));
			}
			for (Object map : relatepdf) {
				HashMap<String, Object> objE = (HashMap<String, Object>)sqlsession.selectOne("res.select_static_pdf",map );
				System.out.println(((HashMap)objE).get("rrName").toString());
				String tmp=((HashMap)objE).get("rrFileSwf").toString();
				int count=FileUtil.CountImg(new File(ConstantI.UPLOADPATH_KEY.substring(0, ConstantI.UPLOADPATH_KEY.lastIndexOf("\\"))+ConstantI.UPLOADPATH_KEY.substring(ConstantI.UPLOADPATH_KEY.lastIndexOf("\\")).replace("upload", "")+tmp));
				list4pdf.add(new WendangBean(tmp+"/", count, ((HashMap)objE).get("rrName").toString()));
			}
			
			List<WendangBean> list4doc =new ArrayList<WendangBean>();
			templist=sqlsession.selectList("res.select_static_doclist", paramMap);
			System.out.println("========================");
			System.out.println("doc");
			if(relateword.size()>0||templist.size()>0){
				pageList.add("doc");
			}
			
			for (Object map : templist) {
				System.out.println(((HashMap)map).get("rrName").toString());
				String tmp=((HashMap)map).get("rrFileSwf").toString();
				int count=FileUtil.CountImg(new File(ConstantI.UPLOADPATH_KEY.substring(0, ConstantI.UPLOADPATH_KEY.lastIndexOf("\\"))+ConstantI.UPLOADPATH_KEY.substring(ConstantI.UPLOADPATH_KEY.lastIndexOf("\\")).replace("upload", "")+tmp));
				list4doc.add(new WendangBean(tmp+"/", count, ((HashMap)map).get("rrName").toString()));
			}
			for (Object map : relateword) {
				HashMap<String, Object> objE = (HashMap<String, Object>)sqlsession.selectOne("res.select_static_doc",map );
				System.out.println(((HashMap)objE).get("rrName").toString());
				String tmp=((HashMap)objE).get("rrFileSwf").toString();
				int count=FileUtil.CountImg(new File(ConstantI.UPLOADPATH_KEY.substring(0, ConstantI.UPLOADPATH_KEY.lastIndexOf("\\"))+ConstantI.UPLOADPATH_KEY.substring(ConstantI.UPLOADPATH_KEY.lastIndexOf("\\")).replace("upload", "")+tmp));
				list4doc.add(new WendangBean(tmp+"/", count, ((HashMap)objE).get("rrName").toString()));
			}
			
			//多维
			List<DuoweiBean> list6=new ArrayList<DuoweiBean>();
			templist=sqlsession.selectList("res.select_static_duoweilist", paramMap);
			System.out.println("========================");
			System.out.println("duowei");
			if(relateduowei.size()>0||templist.size()>0){
				pageList.add("duowei");
			}
			
			for (Object map : templist) {
				System.out.println(((HashMap)map).get("rrName").toString());
				String tmp=((HashMap)map).get("rrFileSwf").toString();
				list6.add(new DuoweiBean(tmp, ((HashMap)map).get("rrZip").toString(),((HashMap)map).get("rrModel").toString(), ((HashMap)map).get("rrName").toString(),((HashMap)map).get("rrThumbnail").toString()));
			}
			for (Object map : relateduowei) {
				HashMap<String, Object> objE = (HashMap<String, Object>)sqlsession.selectOne("res.select_static_duowei",map );
				System.out.println(((HashMap)objE).get("rrName").toString());
				String tmp=((HashMap)objE).get("rrFileSwf").toString();
				list6.add(new DuoweiBean(tmp, ((HashMap)objE).get("rrZip").toString(),((HashMap)objE).get("rrModel").toString(), ((HashMap)objE).get("rrName").toString(),((HashMap)objE).get("rrThumbnail").toString()));
			}
			System.out.println("========================");
			
			pib.setPageList(pageList);
			String docContent="";
			if(content!=null&&!content.equals("")){
				docContent=ToHtmlByOpenOffice.toHtmlString(new File(ConstantI.UPLOADPATH_KEY.substring(0, ConstantI.UPLOADPATH_KEY.lastIndexOf("\\"))+ConstantI.UPLOADPATH_KEY.substring(ConstantI.UPLOADPATH_KEY.lastIndexOf("\\")).replace("upload", "")+content), GetProjectPath.getRootPath()+"/page/scanner/"+code+"/");
			}
			To_Html.test_to_html_scanner(docContent,pib, "scanner",code);
			
			
			//图片
			if(pib.getPageList().contains("pic")){
				To_Html.test_to_html_pic(pib, "pic", code);
			}
			//视频
			if(list3.size()>0){
				pib.setVideoPath(list3.get(0).getVideoPath());
				pib.setVideoList(list3);
			}
			if(pib.getPageList().contains("video")){
				To_Html.test_to_html_video(pib, "video", code);
			}
			
			if(list3Sanwei.size()>0){
				pib.setVideoPath(list3Sanwei.get(0).getVideoPath());
				pib.setVideoList(list3Sanwei);
			}
			if(pib.getPageList().contains("sanwei")){
				To_Html.test_to_html_video(pib, "sanwei", code);
			}
			//To_Html.test_to_html_video(pib, "video", code);
			
			//文档
			if(pib.getPageList().contains("ppt")){
				pib.setWendangList(list4ppt);
				pib.setListIcon("ppt");
				To_Html.test_to_html_wendang(pib, "ppt", code);
			}
			
			
			if(pib.getPageList().contains("pdf")){
				pib.setWendangList(list4pdf);
				pib.setListIcon("pdf");
				To_Html.test_to_html_wendang(pib, "pdf", code);
			}
			
			
			if(pib.getPageList().contains("doc")){
				pib.setWendangList(list4doc);
				pib.setListIcon("doc");
				To_Html.test_to_html_wendang(pib, "doc", code);
			}
			
			//多维
			if(pib.getPageList().contains("duowei")){
				pib.setDuoweiList(list6);
				To_Html.test_to_html_duowei(pib, "duowei",code);
			}
			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
}

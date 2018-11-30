
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.ow.framework.util;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
/**
 *
 * @author romance
 */
public class TxtHandler extends AbstractFile{

    private static TxtHandler txtHandler = null;
    private TxtHandler(){
    }
    
    public static synchronized TxtHandler getInstance(){
        if(txtHandler == null)
            txtHandler = new TxtHandler();
        return txtHandler;
    }
    
    public int writeTxtFile(String title, String path, String name, List src, Object[] head, Object[] cols) {
        int count = 0;
        File file = super.createFile(path, name);
        if (file == null)
        	return 0;
        FileWriter fileWriter = null;
        try
        {
        	fileWriter = new FileWriter(path + File.separator + name,true);
            StringBuffer content = new StringBuffer("");
            if(head != null){
                for(int k = 0; k < head.length; k++){
                	content.append(head[k] == null? "" : head[k].toString() + "		");
                }
            }
            content.append("\r\n");
            if(src != null){
                for(int i = 0; i < src.size(); i++){
                    Object obj = src.get(i);
                    if(obj instanceof HashMap){
                        content.append(i + 1).append("		");
                        for(int j = 0; j < cols.length; j ++){
                            content.append(((HashMap)obj).get(cols[j]) == null? "" :((HashMap)obj).get(cols[j]).toString() + "		");
                        }
                        content.append("\r\n");
                    }
                }
            }
        	if (fileWriter != null)
        	{
        		fileWriter.write(content.toString() + "\r\n");
        		count = 1;
	        	fileWriter.flush();
	        	fileWriter.close();	        	
        	}
        }
        catch (IOException e2)
        {
        	if (fileWriter != null)
        	{
	        	try {
					fileWriter.flush();
					fileWriter.close();
				} catch (IOException e1) {
					e1.printStackTrace();
				}
        	}        	
            System.out.println(e2.getMessage());
        }           
        return count;
    }
    
    
    public int writeExcelFile(String title, String path, String name, List src, Object[] head, Object[] cols) {
        return 0;
    }

}

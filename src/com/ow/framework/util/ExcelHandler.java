package com.ow.framework.util;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;

import jxl.Workbook;
import jxl.write.Label;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;


public class ExcelHandler extends AbstractFile {

    private static ExcelHandler excelHandler = null;

    private ExcelHandler() {

    }

    public static synchronized ExcelHandler getInstance() {
        if (excelHandler == null)
            excelHandler = new ExcelHandler();
        return excelHandler;
    }


    @SuppressWarnings("finally")
	public int writeExcelFile(String title,String path, String name, List src, Object[] head, Object[] cols) {
        int count = 0;
        /**
         * 只能通过API提供的工厂方法来创建Workbook，而不能使用WritableWorkbook的构造函数，
         * 因为类WritableWorkbook的构造函数为protected类型
         * method(1)直接从目标文件中读取WritableWorkbook wwb = Workbook.createWorkbook(new File(targetfile));
         * method(2)如下实例所示 将WritableWorkbook直接写入到输出流
         */
        File file = super.createFile(path, name);
        if (file == null)
            return -1;
        OutputStream os = null;
        try {
            os = new FileOutputStream(file);
        } catch (FileNotFoundException ex1) {
            return -1;
        }
        WritableWorkbook wwb = null;
        try {
            wwb = Workbook.createWorkbook(os);
        } catch (IOException ex) {
            return -1;
        }
        try {
            //创建Excel工作表 指定名称和位置
        	int sheetIndex = 0;
            WritableSheet ws = wwb.createSheet(title, sheetIndex);
            int row = 0;
            if (head != null)
            {
	            for (int k = 0; k < head.length; k++) {
	            	String content = head[k] == null ? "" : head[k].toString();
	                Label labelcf = new Label(k, 0, content);
	                ws.addCell(labelcf);
	            }
            }
            if (head.length > 0)
                row = 1;
            if (src != null)
            {
	            for (int i = 0; i < src.size(); i++) {
	            	if(i!=0&&i%65534==0){
	            		ws =  wwb.createSheet(title, ++sheetIndex);
	            		
	            	}
	                Object obj = src.get(i);
	                if (obj instanceof HashMap) {
	                    Label labelcf0 = new Label(0, row, String.valueOf(i +  1));
	                    ws.addCell(labelcf0);
	                	for (int j=0; j<cols.length; j++)
	                	{
		                    Label labelcf1 = new Label(j + 1, row, ((HashMap)obj).get(cols[j]) == null ? "" :  ((HashMap)obj).get(cols[j]).toString());
		                    ws.addCell(labelcf1);
	                	}
	                	row++;
	                }
	            }
            }
            count = 1;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                wwb.write();
                wwb.close();
            } catch (final Exception e) {
            }
            return count;
        }
    }

    public int writeTxtFile(String title,String path, String name, List src, Object[] head, Object[] cols) {
        return 0;
    }
}

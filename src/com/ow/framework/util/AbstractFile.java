package com.ow.framework.util;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.List;

public abstract class AbstractFile {

    /**
     * 用随机数生成文件名称
     * @param srcFileName String
     * @return String
     */
    public String createFileName(String srcFileName) {
        String fielName = null;
        try {
            if (srcFileName == null || srcFileName.equals(""))
                return "";
            int index = srcFileName.lastIndexOf(".");
            if (index != -1) {
                long timeMillis = System.currentTimeMillis();
                String randomNum = CreateRandom.generateRandom();
                srcFileName = String.valueOf(timeMillis)
                              + randomNum
                              + srcFileName.substring(index, srcFileName.length());
                fielName = srcFileName;
            } else {
                srcFileName = "";
            }
        } catch (Exception e) {
            srcFileName = "";
        }
        return fielName;
    }

    /**
     * 创建文件
     * @param path String
     * @param name String
     * @return File
     */
    public File createFile(String path, String name)
    {
        try {
            java.io.File m_file = new java.io.File(path);
            if (!m_file.exists()) { //判断文件路径是否存在...
                m_file.mkdirs();
            }
            java.io.File m_old_file = new java.io.File(path + File.separator + name);
            if (m_old_file.exists()) //判断要生成的文件是否存在...
                m_old_file.delete();
            java.io.File fileWrite = null;
            try {
                fileWrite = new java.io.File(path + File.separator + name);
                if (fileWrite.createNewFile()) {
                    return fileWrite;
                }
            } catch (FileNotFoundException e) {
                e.printStackTrace();
            }
        } catch (Exception e) {
            return null;
        }
        return null;
    }

    /**
     * 删除文件
     * @param path String
     * @param fileName String
     */
    public void deleteFile(String path, String fileName) {
        try {
            File f = new File(path + File.separator + fileName);
            if (f.exists())
                f.delete();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    public abstract int writeExcelFile(String title,String path,String name, List src, Object head[],Object cols[]);
    public abstract int writeTxtFile(String title,String path,String name, List src, Object head[],Object cols[]);
}

package com.ow.framework.controller.action;

import com.ambow.base.grm.common.ConstantI;
import com.ow.framework.listener.event.Executor;
import com.ow.framework.listener.event.ExecutorResult;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;
import javax.servlet.ServletContext;
import org.apache.struts2.ServletActionContext;

public class DownloadAction2 extends DownloadAction
{
  private static final long serialVersionUID = 3320504748360944068L;
  private String inputPath;
  private String report;
  private String downloadFileName;

  public String subExecute()
  {
    ExecutorResult executorResult = this.eventExecutor.generalEventExecutor();
    if ((executorResult.getResult() != null) && (executorResult.getResult().equals("1"))) {
      return "success";
    }
    return "input";
  }

  public String getInputPath() {
    return this.inputPath;
  }
  public void setInputPath(String inputPath) {
    this.inputPath = inputPath;
  }
  public String getReport() {
    return this.report;
  }
  public void setReport(String report) {
    this.report = report;
  }
  public String getDownloadFileName() {
    return this.downloadFileName;
  }
  public void setDownloadFileName(String downloadFileName) {
    this.downloadFileName = downloadFileName;
  }

  public InputStream getTargetFile2() throws Exception {
    InputStream ins = null;
    try {
      ins = ServletActionContext.getServletContext().getResourceAsStream(this.inputPath);
    }
    catch (Exception e)
    {
      e.printStackTrace();
    }
    return ins;
  }

  public InputStream getTargetFile() throws Exception
  {
    InputStream ins = null;
    try {
      URL url = new URL("http://"+ConstantI.ADDRESS_KEY+":8086/CacheServer/GetPicInfo?src=" + this.inputPath);

      URLConnection uc = url.openConnection();

      ins = uc.getInputStream();
    }
    catch (Exception e)
    {
      e.printStackTrace();
    }
    return ins;
  }
}
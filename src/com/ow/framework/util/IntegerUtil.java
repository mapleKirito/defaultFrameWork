/*
 * 项目名称：金融行业积分系统
 * 开发公司: 东方般若公司
 * 创建时间: 2009-3-26
 */
package com.ow.framework.util;

/**
 *
 * @author 刘满军
 */
public class IntegerUtil {

    public static Integer objectToInteger(Object obj) {
        Integer result = 0;
        try {
            if (obj != null) {
                result = Integer.parseInt(obj.toString().trim());
            }
        } catch (Exception e) {

        }
        return result;
    }
}

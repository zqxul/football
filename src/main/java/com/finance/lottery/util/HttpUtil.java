package com.finance.lottery.util;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.ResponseHandler;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @Author: xuzhiqing
 * @Description:
 * @Date: 2018/6/1 10:42
 */
public class HttpUtil {

    /**
     * @param url 请求URL
     * @Author: xuzhiqing
     * @Date: 2018/6/5 18:58
     * @Description: Http get请求
     */
    public static String get(String url) {
        String responseText = null;
        CloseableHttpClient httpclient = HttpClients.createDefault();
        try {
            HttpGet httpget = new HttpGet(url);
            ResponseHandler<String> responseHandler = new ResponseHandler<String>() {
                @Override
                public String handleResponse(
                        final HttpResponse response) throws ClientProtocolException, IOException {
                    int status = response.getStatusLine().getStatusCode();
                    if (status >= 200 && status < 300) {
                        HttpEntity entity = response.getEntity();
                        return entity != null ? EntityUtils.toString(entity) : null;
                    } else {
                        return null;
                    }
                }

            };
            responseText = httpclient.execute(httpget, responseHandler);
        } catch (ClientProtocolException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                httpclient.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return responseText;
    }

    /**
     * @param url       请求URL
     * @param paramsMap post请求参数
     * @Author: xuzhiqing
     * @Date: 2018/6/5 18:59
     * @Description: Http post请求
     */
    public static String post(String url, Map<String, String> paramsMap) {
        String responseText = null;
        CloseableHttpClient httpclient = HttpClients.createDefault();
        try {
            HttpPost httpPost = new HttpPost(url);
            if (paramsMap != null && paramsMap.size() > 0) {
                List<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();
                for (String key : paramsMap.keySet()) {
                    nameValuePairs.add(new BasicNameValuePair(key, paramsMap.get(key)));
                }
                httpPost.setEntity(new UrlEncodedFormEntity(nameValuePairs));
            }
            ResponseHandler<String> responseHandler = new ResponseHandler<String>() {
                @Override
                public String handleResponse(
                        final HttpResponse response) throws ClientProtocolException, IOException {
                    int status = response.getStatusLine().getStatusCode();
                    if (status >= 200 && status < 300) {
                        HttpEntity entity = response.getEntity();
                        return entity != null ? EntityUtils.toString(entity) : null;
                    } else {
                        return null;
                    }
                }

            };
            responseText = httpclient.execute(httpPost, responseHandler);
        } catch (ClientProtocolException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                httpclient.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return responseText;
    }
}

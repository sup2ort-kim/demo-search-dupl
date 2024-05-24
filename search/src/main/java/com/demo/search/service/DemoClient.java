package com.demo.search.service;

import java.security.KeyManagementException;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import org.apache.hc.client5.http.auth.AuthScope;
import org.apache.hc.client5.http.auth.UsernamePasswordCredentials;
import org.apache.hc.client5.http.impl.auth.BasicCredentialsProvider;
import org.apache.hc.client5.http.impl.nio.PoolingAsyncClientConnectionManager;
import org.apache.hc.client5.http.impl.nio.PoolingAsyncClientConnectionManagerBuilder;
import org.apache.hc.core5.http.HttpHost;
import org.opensearch.client.opensearch.OpenSearchClient;
import org.opensearch.client.transport.httpclient5.ApacheHttpClient5Transport;
import org.opensearch.client.transport.httpclient5.ApacheHttpClient5TransportBuilder;

public class DemoClient {
	public static OpenSearchClient create() throws NoSuchAlgorithmException, KeyStoreException, KeyManagementException {
		
	    final HttpHost host = new HttpHost("http", "192.168.0.202", 13023);
	    final BasicCredentialsProvider credentialsProvider = new BasicCredentialsProvider();
	    // Only for demo purposes. Don't specify your credentials in code.
	    credentialsProvider.setCredentials(new AuthScope(host), new UsernamePasswordCredentials("admin", "flxmflqj1!".toCharArray()));

	    final ApacheHttpClient5TransportBuilder builder = ApacheHttpClient5TransportBuilder.builder(host);
	    builder.setHttpClientConfigCallback(httpClientBuilder -> {
	    	
	      final PoolingAsyncClientConnectionManager connectionManager = PoolingAsyncClientConnectionManagerBuilder
	        .create()
	        .build();

	      return httpClientBuilder
	        .setDefaultCredentialsProvider(credentialsProvider)
	        .setConnectionManager(connectionManager);
	    });
	    
	    final ApacheHttpClient5Transport transport = ApacheHttpClient5TransportBuilder.builder(host).build();
	    OpenSearchClient client = new OpenSearchClient(transport);
	   
        return client;
	}
	
}

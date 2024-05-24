package com.demo.search.service;

import java.security.KeyManagementException;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;

import org.apache.http.HttpHost;
import org.apache.http.auth.AuthScope;
import org.apache.http.auth.UsernamePasswordCredentials;
import org.apache.http.impl.client.BasicCredentialsProvider;
import org.apache.http.impl.nio.client.HttpAsyncClientBuilder;
import org.opensearch.client.RestClient;
import org.opensearch.client.RestClientBuilder;
import org.opensearch.client.json.jackson.JacksonJsonpMapper;
import org.opensearch.client.opensearch.OpenSearchClient;
import org.opensearch.client.transport.OpenSearchTransport;
import org.opensearch.client.transport.rest_client.RestClientTransport;

public class DemoClient {
	public static OpenSearchClient create() throws NoSuchAlgorithmException, KeyStoreException, KeyManagementException {
		// System.setProperty("javax.net.ssl.trustStore", "/full/path/to/keystore");
		// System.setProperty("javax.net.ssl.trustStorePassword", "password-to-keystore");

		final HttpHost host = new HttpHost("192.168.0.202", 9200, "http");
		final BasicCredentialsProvider credentialsProvider = new BasicCredentialsProvider();
		// Only for demo purposes. Don't specify your credentials in code.
		UsernamePasswordCredentials credentials = new UsernamePasswordCredentials("admin", "flxmflqj1!");
		credentialsProvider.setCredentials(AuthScope.ANY, credentials);

		// Initialize the client with SSL and TLS enabled
		final RestClient restClient = RestClient.builder(host)
				.setHttpClientConfigCallback(new RestClientBuilder.HttpClientConfigCallback() {
					@Override
					public HttpAsyncClientBuilder customizeHttpClient(HttpAsyncClientBuilder httpClientBuilder) {
						return httpClientBuilder.setDefaultCredentialsProvider(credentialsProvider);
					}
				}).build();

		final OpenSearchTransport transport = new RestClientTransport(restClient, new JacksonJsonpMapper());
		final OpenSearchClient client = new OpenSearchClient(transport);
		
		return client;
	}
}

/*
 * SPDX-License-Identifier: Apache-2.0
 *
 * The OpenSearch Contributors require contributions made to
 * this file be licensed under the Apache-2.0 license or a
 * compatible open source license.
 */

package com.demo.search.web;

import java.io.IOException;
import java.security.KeyManagementException;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.opensearch.client.opensearch.OpenSearchClient;
import org.opensearch.client.opensearch._types.OpenSearchException;
import org.opensearch.client.opensearch._types.Refresh;
import org.opensearch.client.opensearch._types.analysis.Analyzer;
import org.opensearch.client.opensearch._types.analysis.CustomAnalyzer;
import org.opensearch.client.opensearch._types.analysis.ShingleTokenFilter;
import org.opensearch.client.opensearch._types.analysis.TokenFilter;
import org.opensearch.client.opensearch._types.analysis.TokenFilterDefinition;
import org.opensearch.client.opensearch._types.mapping.Property;
import org.opensearch.client.opensearch._types.mapping.TextProperty;
import org.opensearch.client.opensearch._types.mapping.TypeMapping;
import org.opensearch.client.opensearch.core.SearchRequest;
import org.opensearch.client.opensearch.core.SearchResponse;
import org.opensearch.client.opensearch.core.search.CompletionSuggester;
import org.opensearch.client.opensearch.core.search.FieldSuggester;
import org.opensearch.client.opensearch.core.search.FieldSuggesterBuilders;
import org.opensearch.client.opensearch.core.search.Hit;
import org.opensearch.client.opensearch.core.search.PhraseSuggester;
import org.opensearch.client.opensearch.core.search.Suggest;
import org.opensearch.client.opensearch.core.search.Suggester;
import org.opensearch.client.opensearch.core.search.TermSuggester;
import org.opensearch.client.opensearch.indices.DeleteIndexRequest;
import org.opensearch.client.opensearch.indices.IndexSettings;
import org.opensearch.client.opensearch.indices.IndexSettingsAnalysis;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.demo.search.service.DemoClient;
import com.demo.search.util.AppData;
import com.demo.search.util.IndexData;

@Controller
public class DemoSearchController {
    private static final Logger LOGGER = LoggerFactory.getLogger(DemoSearchController.class);

    private static OpenSearchClient client;

    @RequestMapping(value = "/searchEngine.do")
    public String searchEngine(@RequestParam HashMap<String, Object> searchMap, ModelMap model, HttpServletRequest request, HttpSession session) throws OpenSearchException, IOException {
		
    	final String indexName = "tb_book_index";
    	ArrayList<IndexData> resultList = new ArrayList<IndexData>();
    	
    	try {
			client = DemoClient.create();
			
	    	SearchResponse<IndexData> searchResponse = client.search(s -> s.index(indexName), IndexData.class);
	        for (Hit<IndexData> hit : searchResponse.hits().hits()) {
	            LOGGER.debug("Found {} with score {}", hit.source(), hit.score());
	            System.out.println("Found {} with score {} " + hit.source() + " " + hit.score());
	        }
	        
	        // 실제 검색으로 추정, FieldValue.of("검색어")
	        SearchRequest searchRequest = new SearchRequest.Builder().query(
	        		 q -> q.multiMatch(
    			        m -> m.fields("title","title_choseong","title_hantoeng").query(searchMap.get("searchKeyword").toString())
    			    )
//	            q -> q.multiMatch(m -> m.fields("title").query(FieldValue.of(searchMap.get("searchKeyword").toString())))
	        ).build();

	        searchResponse = client.search(searchRequest, IndexData.class);
	        for (Hit<IndexData> hit : searchResponse.hits().hits()) {
	            LOGGER.debug("Found {} with score {}", hit.source(), hit.score());
	            resultList.add(hit.source());
	        }

//	        searchRequest = new SearchRequest.Builder().query(q -> q.match(m -> m.field("title").query(FieldValue.of(searchMap.get("searchKeyword").toString()))))
//	            .aggregations("title", new Aggregation.Builder().terms(t -> t.field("title")).build())
//	            .build();
//
//	        searchResponse = client.search(searchRequest, IndexData.class);
//	        for (Map.Entry<String, Aggregate> entry : searchResponse.aggregations().entrySet()) {
//	            LOGGER.debug("Agg - {}", entry.getKey());
//	            entry.getValue().sterms().buckets().array().forEach(b -> LOGGER.debug("{} : {}", b.key(), b.docCount()));
//	        }
	        
	        // 서울대 소스처럼 model에 담아서 표출
	        // 의미검색은 bertResult로 해서 따로 담아야 할 것 같음
	        // 메신저상 본부장님 지시: 상단에 키워드 검색, 하단에 의미 검색
	        model.addAttribute("searchResult", resultList);
		} catch (KeyManagementException | NoSuchAlgorithmException | KeyStoreException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	
		model.addAttribute("searchMap", searchMap);
    	
    	return "/searchEngine";
    }
    
    @RequestMapping(value = "/searchSuggester.do")
    public ArrayList<String> searchWithCompletionSuggester(@RequestParam HashMap<String, Object> searchMap, ModelMap model, HttpServletRequest request, HttpSession session) {
    	
		// 여기에다 값을 담을 것임
		ArrayList<String> autoResultList = new ArrayList<String>();
		
		String index = "tb_book_index";
		
        try {
            String suggesterName = "msgSuggester";

            CompletionSuggester completionSuggester = FieldSuggesterBuilders.completion().field("msg").size(1).build();
            FieldSuggester fieldSuggester = new FieldSuggester.Builder().prefix("foo").completion(completionSuggester).build();
            Suggester suggester = new Suggester.Builder().suggesters(Collections.singletonMap(suggesterName, fieldSuggester)).build();
            SearchRequest searchRequest = new SearchRequest.Builder().index(index).suggest(suggester).build();

            SearchResponse<AppData> searchResponse = client.search(searchRequest, AppData.class);
            List<Suggest<AppData>> suggestions = searchResponse.suggest().get(suggesterName);
            
            for (int o = 0; o < suggestions.size(); o++) {
            	if (suggestions.get(o) != null) {
            		autoResultList.add(suggestions.get(o).toString());
            	}
            }
            LOGGER.debug("Suggester response size {}", searchResponse.suggest().get(suggesterName).size());

            // client.indices().delete(new DeleteIndexRequest.Builder().index(index).build());
        } catch (Exception e) {
            LOGGER.error("Unexpected exception", e);
        }
        
        return autoResultList;
    }

    // 2024.05.27
    // 샘플 코드 그대로임 (수정X)
    // 백업용
    public static void searchWithTermSuggester() {
        try {
            String index = "term-suggester";

            // term suggester does not require a special mapping
            client.indices().create(c -> c.index(index));

            AppData appData = new AppData();
            appData.setIntValue(1337);
            appData.setMsg("foo");

            client.index(b -> b.index(index).id("1").document(appData).refresh(Refresh.True));

            appData.setIntValue(1338);
            appData.setMsg("foobar");

            client.index(b -> b.index(index).id("2").document(appData).refresh(Refresh.True));

            String suggesterName = "msgSuggester";

            TermSuggester termSuggester = FieldSuggesterBuilders.term().field("msg").size(1).build();
            FieldSuggester fieldSuggester = new FieldSuggester.Builder().text("fool").term(termSuggester).build();
            Suggester suggester = new Suggester.Builder().suggesters(Collections.singletonMap(suggesterName, fieldSuggester)).build();
            SearchRequest searchRequest = new SearchRequest.Builder().index(index).suggest(suggester).build();

            SearchResponse<AppData> searchResponse = client.search(searchRequest, AppData.class);
            LOGGER.debug("Suggester response size {}", searchResponse.suggest().get(suggesterName).size());

            client.indices().delete(new DeleteIndexRequest.Builder().index(index).build());
        } catch (Exception e) {
            LOGGER.error("Unexpected exception", e);
        }
    }

    // 2024.05.27
    // 샘플 코드 그대로임 (수정X)
    // 백업용
    public static void searchWithPhraseSuggester() {
        try {
            String index = "test-phrase-suggester";

            ShingleTokenFilter shingleTokenFilter = new ShingleTokenFilter.Builder().minShingleSize("2").maxShingleSize("3").build();

            Analyzer analyzer = new Analyzer.Builder().custom(
                new CustomAnalyzer.Builder().tokenizer("standard").filter(Arrays.asList("lowercase", "shingle")).build()
            ).build();

            TokenFilter tokenFilter = new TokenFilter.Builder().definition(
                new TokenFilterDefinition.Builder().shingle(shingleTokenFilter).build()
            ).build();

            IndexSettingsAnalysis indexSettingsAnalysis = new IndexSettingsAnalysis.Builder().analyzer("trigram", analyzer)
                .filter("shingle", tokenFilter)
                .build();

            IndexSettings settings = new IndexSettings.Builder().analysis(indexSettingsAnalysis).build();

            TypeMapping mapping = new TypeMapping.Builder().properties(
                "msg",
                new Property.Builder().text(
                    new TextProperty.Builder().fields(
                        "trigram",
                        new Property.Builder().text(new TextProperty.Builder().analyzer("trigram").build()).build()
                    ).build()
                ).build()
            ).build();

            client.indices().create(c -> c.index(index).settings(settings).mappings(mapping));

            AppData appData = new AppData();
            appData.setIntValue(1337);
            appData.setMsg("Design Patterns");

            client.index(b -> b.index(index).id("1").document(appData).refresh(Refresh.True));

            appData.setIntValue(1338);
            appData.setMsg("Software Architecture Patterns Explained");

            client.index(b -> b.index(index).id("2").document(appData).refresh(Refresh.True));

            String suggesterName = "msgSuggester";

            PhraseSuggester phraseSuggester = FieldSuggesterBuilders.phrase().field("msg.trigram").build();
            FieldSuggester fieldSuggester = new FieldSuggester.Builder().text("design paterns").phrase(phraseSuggester).build();
            Suggester suggester = new Suggester.Builder().suggesters(Collections.singletonMap(suggesterName, fieldSuggester)).build();
            SearchRequest searchRequest = new SearchRequest.Builder().index(index).suggest(suggester).build();

            SearchResponse<AppData> searchResponse = client.search(searchRequest, AppData.class);
            LOGGER.debug("Suggester response size {}", searchResponse.suggest().get(suggesterName).size());

            client.indices().delete(new DeleteIndexRequest.Builder().index(index).build());
        } catch (Exception e) {
            LOGGER.error("Unexpected exception", e);
        }
    }
    
}
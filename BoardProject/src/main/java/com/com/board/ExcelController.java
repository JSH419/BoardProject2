package com.com.board;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.inject.Inject;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ExcelController {
	
	@Inject
	public BoardService service;
	
	@Inject
	public SqlSessionTemplate sqlSession;
	
	@RequestMapping("exceldown")
	public String excelDownload (@RequestParam Map<String, Object> paramMap, Model model) {
		System.out.println("paramMap :" + paramMap);
		
		// 게시판 초기 데이터 설정
		if(paramMap.isEmpty()) {
			paramMap.put("pageNo", 1);
			paramMap.put("listSize", 10);	
		}
		
		// 게시글 목록 조회
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		list = service.list(paramMap);
		System.out.println("리스트 :" + list);
		
		// 페이징 
		int count = service.pageMap(paramMap);
		int curPage = Integer.parseInt(paramMap.get("pageNo").toString());
		BoardPage pageVO = new BoardPage(count, curPage);
		System.out.println("글개수 :" + count);
		System.out.println("현재 페이지 :" + curPage);
		System.out.println("pageVO :" + pageVO);
		
		// 모델에 추가
		model.addAttribute("list", list);
		model.addAttribute("paramMap", paramMap);
		model.addAttribute("pageVO", pageVO);
		return "excel";
	}
}


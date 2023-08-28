package com.com.board;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class BoardController {
	
	@Inject
	public BoardService service;
	
	@Inject
	public SqlSessionTemplate sqlSession;
	
	// 게시글 목록 
	@RequestMapping("/list")
	public String list(@RequestParam Map<String, Object> paramMap, Model model, HttpSession session) {
			
			// 게시글 목록 조회
			List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
			list = service.list(paramMap);
			
			// 페이징 
			Map<String, Object> pageMap = service.pageMap(paramMap);
			
			// 모델에 추가
			model.addAttribute("list", list);
			model.addAttribute("paramMap", paramMap);
			model.addAttribute("pageMap", pageMap);
			
			//session 사용, 검색어 입력 유지
			String keyword = (String) paramMap.get("keyword");
		    if (keyword != null) {
		        session.setAttribute("searchKeyword", keyword);
		    }
		    
		    //session 사용, 옵션 선택 유지
		    String searchType = (String) paramMap.get("searchType");
		    if (searchType != null) {
		        session.setAttribute("searchType", searchType);
		    }
		    
			return "list2";
	}
	
	// 글쓰기 페이지 이동
	@RequestMapping("/write")
	public String write() {
		return "write"; 
	}
	
	// 글쓰기 
	@RequestMapping("/insert")
	public String insert(@RequestParam Map<String, Object> map, HttpServletRequest request) {
		
		int insert = service.insert(map);
		
		return "redirect:list";
	}
	
	// 상세 페이지 이동
	@RequestMapping("/detail")
	public String detail(int seq, Model model, @ModelAttribute BoardDto dto) {
		
		Map<String, Object> detail = sqlSession.selectOne("mapper.detail", seq);
		model.addAttribute("detail", detail);
		
		return "write";
	}	
	
	// 수정하기	
	@RequestMapping("/update")
	public String update(@ModelAttribute BoardDto boardDto, HttpServletRequest request) {

		int updt = service.update(boardDto);
		
		return "redirect:list";
	}
	
	// 삭제하기 
	@RequestMapping("/delete")
	public String delete(Integer[] chk) {
		
		int delete = sqlSession.delete("mapper.delete",chk);
		
		return "redirect:list";
	}
}
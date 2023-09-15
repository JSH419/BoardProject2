package com.com.board;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Controller
public class BoardController {
	
	@Inject
	public BoardService service;
	
	@Inject
	public SqlSessionTemplate sqlSession;
	
	// 게시글 목록 
	@RequestMapping("list") 
	public String list(@RequestParam Map<String, Object> paramMap, Model model) {
			
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
			
			return "list2";
	}
	
	// 검색, 페이징
	@RequestMapping("searchList")
//	@ResponseBody
	public String searchList(@RequestParam Map<String, Object> paramMap, Model model) {
		System.out.println("paramMap : " + paramMap);
		
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		list = service.list(paramMap);
		model.addAttribute("list", list);
		
		// 페이징 
		int count = service.pageMap(paramMap);
		int curPage = Integer.parseInt(paramMap.get("pageNo").toString());
		BoardPage pageVO = new BoardPage(count, curPage);
		
		// 모델에 추가
		model.addAttribute("paramMap", paramMap);
		model.addAttribute("pageVO", pageVO);
		
		return "searchList";
	}
	
	// 글쓰기 페이지 이동
	@RequestMapping("write")
	public String write() {
		return "write"; 
	}
	
	private static final String SAVE_PATH = "C:/Users/tmdgh/Desktop/img/";
	// 글쓰기 
	@RequestMapping("insert")
	public String insert(@RequestParam Map<String, Object> map, HttpServletRequest request, 
			MultipartHttpServletRequest mReq) throws IllegalStateException, IOException {
		
		int listSeq = sqlSession.selectOne("mapper.listSeq"); //  게시글 최신 번호를 가져온다.
		map.put("seq", listSeq);	// seq 값을 최신화 한다.
		int insert = service.insert(map); // 게시글을 저장한다. 

		int fileSeq = sqlSession.selectOne("mapper.fileSeq"); // 초기 값
		int currentFileSeq = fileSeq;
		
		Iterator<String> itr = mReq.getFileNames(); // 단일 여러개
		while (itr.hasNext()) {
		    MultipartFile mFile = mReq.getFile(itr.next());
		    
		    String realName = mFile.getOriginalFilename();
		    String saveName = System.currentTimeMillis() + "_" + realName;
		    
		    mFile.transferTo(new File(SAVE_PATH + saveName));
		    
		    Map<String, Object> fileMap = new HashMap<String, Object>();
		    fileMap.put("fileSeq", currentFileSeq); // 각 파일에 대해 동일한 값을 사용
		    fileMap.put("realName", realName);
		    fileMap.put("saveName", saveName);
		    fileMap.put("SAVE_PATH", SAVE_PATH);
		    fileMap.put("listSeq", listSeq);
		    
		    int fileinsert = service.fileinsert(fileMap); 
		    
		    // file_Seq 값을 다음 번호로 업데이트
		    currentFileSeq++;
		}	
		return "redirect:list";
	}
	
	// 상세 페이지 이동
	@RequestMapping("detail")
	public String detail(int seq, Model model, @ModelAttribute BoardDto dto) {
		
		Map<String, Object> detail = sqlSession.selectOne("mapper.detail", seq);
		model.addAttribute("detail", detail);
			
		//파일 목록 가져와서 List에 담기
		List<Map<String, Object>> fileList = service.selectFileList(seq);
		model.addAttribute("file", fileList);
		
		return "write";
	}	
	
	//파일 다운로드 
	@RequestMapping("fileDown")
	public void fileDown(@RequestParam Map<String, Object> map, HttpServletResponse response) throws Exception{
		Map<String, Object> resultMap = service.selectFileInfo(map);
		String storedFileName = (String) resultMap.get("SAVE_NAME");
		String originalFileName = (String) resultMap.get("REAL_NAME");
		
		// 파일을 저장했던 위치에서 첨부파일을 읽어 byte[]형식으로 변환한다.
		byte fileByte[] = org.apache.commons.io.FileUtils.readFileToByteArray(new File("C:/Users/tmdgh/Desktop/img/"+storedFileName));
		
		response.setContentType("application/octet-stream");
		response.setContentLength(fileByte.length); 
		response.setHeader("Content-Disposition",  "attachment; fileName=\""+URLEncoder.encode(originalFileName, "UTF-8")+"\";");
		response.getOutputStream().write(fileByte); 
		response.getOutputStream().flush();
		response.getOutputStream().close();
	}
	
	// 수정하기	
	@RequestMapping("update")
	public String update(@ModelAttribute BoardDto boardDto, HttpServletRequest request) {
		
		int updt = service.update(boardDto);
		
		return "redirect:list";
	}
	
	// 삭제하기 
	@RequestMapping("delete")
	public String delete(Integer[] chk) {
		
		//파일을 먼저 삭제한다? 
		
		int delete = sqlSession.delete("mapper.delete",chk);
		
		return "redirect:list";
	}
}
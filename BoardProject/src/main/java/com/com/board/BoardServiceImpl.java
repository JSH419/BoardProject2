package com.com.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.inject.Inject;
import org.springframework.stereotype.Service;

@Service("service")
public class BoardServiceImpl implements BoardService{
	
	@Inject
	public BoardDao dao;
	
	@Override	
	public List<Map<String, Object>> list(Map<String, Object> paramMap) {
		int curPage=0;
		int pageScale=0;
		
		if(paramMap.isEmpty()) {
			curPage = 1;
			pageScale = 10;
		}else {
			curPage = Integer.parseInt(paramMap.get("curPage").toString());
			pageScale = Integer.parseInt(paramMap.get("pageScale").toString());
		}
		
		int pageBegin = (curPage - 1) * pageScale + 1;
		int pageEnd = pageBegin+pageScale - 1;
		
		paramMap.put("pageBegin", pageBegin);
		paramMap.put("pageEnd", pageEnd);
		
		return dao.list(paramMap);
	}

	@Override
	public Map<String, Object> pageMap(Map<String, Object> paramMap) {
		int count = dao.pageMap(paramMap); // 총 게시글 수
		int pageScale = 10; 			   // 페이지당 게시글 수
		int blockScale = 5;				   // 페이징 번호 5개 출력
		int curPage = paramMap.get("curPage") == null ? 1 : Integer.parseInt(paramMap.get("curPage").toString());
		int totPage = (int) Math.ceil(count * 1.0 / pageScale);
		int totBlock = (int) Math.ceil(totPage / blockScale);
		
		// *현재 페이지가 몇번째 페이지 블록에 속하는지 계산
		int curBlock = (int) Math.ceil((curPage - 1) / blockScale) + 1;
		
		// *현재 페이지 블록의 시작, 끝 번호 계산
		int blockBegin = (curBlock-1) * blockScale + 1;

		// 페이지 블록의 끝번호
		int blockEnd = blockBegin + blockScale - 1;
		
		// *마지막 블록이 범위를 초과하지 않도록 계산
		if(blockEnd > totPage) blockEnd = totPage;
		
		// *이전을 눌렀을 때 이동할 페이지 번호
		int prevPage = (curPage == 1) ? 1:(curBlock-1) * blockScale;

		// *다음을 눌렀을 때 이동할 페이지 번호
		int nextPage = curBlock > totBlock ? (curBlock * blockScale) : (curBlock * blockScale) + 1;

		// 마지막 페이지가 범위를 초과하지 않도록 처리
		if(nextPage >= totPage) nextPage = totPage;

		Map<String, Object> pageMap = new HashMap<String, Object>();
		pageMap.put("curBlock", curBlock); 
		pageMap.put("prevPage", prevPage);
		pageMap.put("blockBegin", blockBegin); 
		pageMap.put("blockEnd", blockEnd);
		pageMap.put("curPage", curPage);
		pageMap.put("totBlock", totBlock);
		pageMap.put("nextPage", nextPage); 
		pageMap.put("totPage", totPage);

		return pageMap;
	}
	
	@Override
	public int insert(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return dao.insert(map);
	}
	
	@Override
	public int delete(int seq) {
		// TODO Auto-generated method stub
		return dao.delete(seq);
	}

	@Override
	public int update(BoardDto boardDto) {
		// TODO Auto-generated method stub
		return dao.update(boardDto);
	}
}

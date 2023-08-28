package com.com.board;

import java.util.List;
import java.util.Map;

public interface BoardDao {
	List<Map<String, Object>> list(Map<String, Object> paramMap);
	int pageMap(Map<String, Object> paramMap);
	int insert(Map<String, Object> map);
	//int update(Map<String, Object> map);
	int delete(int seq);
	int update(BoardDto boardDto);
	//List<Map<String, Object>> selectBoard(PagingVO vo);

}

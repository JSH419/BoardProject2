package com.com.board;

import java.util.List;
import java.util.Map;

public interface BoardService {
	List<Map<String, Object>> list(Map<String, Object> paramMap);
	Map<String, Object> pageMap(Map<String, Object> paramMap);
	int insert(Map<String, Object> map);
	int delete(int seq);
	int update(BoardDto boardDto);
}

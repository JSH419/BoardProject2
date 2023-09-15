package com.com.board;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public interface BoardDao {
	List<Map<String, Object>> list(Map<String, Object> paramMap);
	int pageMap(Map<String, Object> paramMap);
	int insert(Map<String, Object> map);
	int delete(int seq);
	int update(BoardDto boardDto);
	int fileinsert(Map<String, Object> fileMap);
	int selectSeq(Map<String, Object> paramMap);
	List<Map<String, Object>> selectFileList(int listSeq);
	Map<String, Object> selectFileInfo(Map<String, Object> map);
}


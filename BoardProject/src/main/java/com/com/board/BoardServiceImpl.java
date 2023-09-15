package com.com.board;

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
		
		return dao.list(paramMap);
	}
	
	@Override
	public int pageMap(Map<String, Object> paramMap) {
		
		return dao.pageMap(paramMap);
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

	@Override
	public int fileinsert(Map<String, Object> fileMap) {
		// TODO Auto-generated method stub
		return dao.fileinsert(fileMap);
	}

	@Override
	public int selectSeq(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return dao.selectSeq(paramMap);
	}

	@Override
	public List<Map<String, Object>> selectFileList(int listSeq) {
		// TODO Auto-generated method stub
		return dao.selectFileList(listSeq);
	}

	@Override
	public Map<String, Object> selectFileInfo(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return dao.selectFileInfo(map);
	}
	
}

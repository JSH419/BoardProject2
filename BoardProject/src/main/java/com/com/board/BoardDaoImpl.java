package com.com.board;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
	
@Repository("dao")
public class BoardDaoImpl implements BoardDao{
		
	@Inject
	public SqlSessionTemplate sqlSession;
	
	@Override
	public List<Map<String, Object>> list(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.list", paramMap);
	}
	
	@Override
	public int pageMap(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.total", paramMap);
	}
	
	@Override
	public int insert(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.insert("mapper.insert", map);
	}
	
	@Override
	public int delete(int seq) {
		// TODO Auto-generated method stub
		return sqlSession.delete("mapper.delete", seq);
	}
	
	@Override
	public int update(BoardDto boardDto) {
		// TODO Auto-generated method stub
		return sqlSession.update("mapper.update", boardDto);
	}
	
	@Override
	public int fileinsert(Map<String, Object> fileMap) {
		// TODO Auto-generated method stub
		return sqlSession.insert("mapper.fileinsert", fileMap);
	}
	
	@Override
	public int selectSeq(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.selectSeq", paramMap);
	}
}

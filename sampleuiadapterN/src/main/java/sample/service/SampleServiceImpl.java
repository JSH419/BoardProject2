package sample.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import sample.dao.SampleDAO;
import sample.vo.SampleVO;
import sample.vo.SearchConditionVO;

// Service를 인식시켜주기 위한 설정
@Service("sampleService")
public class SampleServiceImpl implements SampleService {

  // SampleDAO 로 연결을 하기 위한 선언
  @Autowired
  private SampleDAO sampleDao;

  // Controller에서 받아온 selectSampleList의 메소드를 SampleDAO의 selectSampleList 메소드 전달
  // 결과로 얻은 반환값을 return을 통해 다시 Controller로 전달
  @Override
  public List<SampleVO> selectSampleList(SearchConditionVO searchVO) {
    return sampleDao.selectSampleList(searchVO);
  }

}
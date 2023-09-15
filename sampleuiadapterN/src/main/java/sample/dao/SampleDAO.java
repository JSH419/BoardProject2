package sample.dao;

import java.util.List;

import sample.vo.SampleVO;
import sample.vo.SearchConditionVO;

public interface SampleDAO {

  // ServiceImpl에서 인자와 함께 전달된 메소드
  List<SampleVO> selectSampleList(SearchConditionVO searchVO);

}
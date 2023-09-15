package sample.service;

import java.util.List;

import sample.vo.SampleVO;
import sample.vo.SearchConditionVO;

public interface SampleService {

	List<SampleVO> selectSampleList(SearchConditionVO searchVO);
	
}

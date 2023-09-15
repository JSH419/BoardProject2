package sample.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.nexacro.uiadapter.spring.core.annotation.ParamDataSet;
import com.nexacro.uiadapter.spring.core.data.NexacroResult;

import sample.service.SampleService;
import sample.vo.SampleVO;
import sample.vo.SearchConditionVO;

@Controller
public class SampleController {

  @Autowired
  private SampleService sampleService;

  // URL로 selectSampleList.do가 호출되면 해당 메소드 실행
  @RequestMapping(value = "/selectSampleList.do")
  // Nexacro에서 inData로 받아온 데이터셋을 SearchConditionVO에 대입
  public NexacroResult selectSampleList(@ParamDataSet(name = "input1") SearchConditionVO searchVO) {

    // SampleService에 searchVO 인자와 함께 전달
    // 가져온 결과를 userList에 대입
    List<SampleVO> userList = sampleService.selectSampleList(searchVO);

    // NexacroResult 생성
    NexacroResult result = new NexacroResult();

    // userList를 outData인 output1에 DataSet 저장
    result.addDataSet("output1", userList);

    return result;
  }
}
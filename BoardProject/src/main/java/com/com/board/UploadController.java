//package com.com.board;
//
//import java.io.File;
//import java.io.IOException;
//import java.util.List;
//import java.util.UUID;
//
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.PostMapping;
//import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.multipart.MultipartFile;
//import org.springframework.web.multipart.MultipartHttpServletRequest;
//
//@Controller
//public class UploadController {
//	
//	@GetMapping("/upload")
//	public String form() {
//		return "uploadForm";
//	}
//	
//	@PostMapping("/upload_ok1")
//	public String upload(@RequestParam("file") MultipartFile file) {
//		String fileRealName = file.getOriginalFilename(); //파일명을 얻어낼 수 있는 메서드
//		long size = file.getSize(); //파일 사이즈
//		
//		System.out.println("파일명 : "  + fileRealName);
//		System.out.println("용량크기(byte) : " + size);
//		
//		//서버에 저장할 파일이름 fileextension으로 .jsp이런식의  확장자 명을 구함
//		String fileExtension = fileRealName.substring(fileRealName.lastIndexOf("."),fileRealName.length());
//		String uploadFolder = "C:\\Users\\tmdgh\\Desktop\\이미지업로드용";
//		
//		UUID uuid = UUID.randomUUID();
//		System.out.println(uuid.toString());
//		String[] uuids = uuid.toString().split("-");
//		
//		String uniqueName = uuids[0];
//		System.out.println("생성된 고유문자열" + uniqueName);
//		System.out.println("확장자명" + fileExtension);
//		
//		// File saveFile = new File(uploadFolder+"\\"+fileRealName); uuid 적용 전
//		
//		File saveFile = new File(uploadFolder+"\\"+uniqueName + fileExtension);  // 적용 후
//		try {
//			file.transferTo(saveFile); // 실제 파일 저장메서드(filewriter 작업을 손쉽게 한방에 처리해준다.)
//		} catch (IllegalStateException e) {
//			e.printStackTrace();
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
//		return "redirect:upload";
//	}
//							
//	@PostMapping("/upload_ok2")
//	public String upload2(MultipartHttpServletRequest files) {
//		// 서버에 저장할 경로
//	    String uploadFolder = "C:\\Users\\tmdgh\\Desktop\\이미지업로드용";
//	    List<MultipartFile> list = files.getFiles("files");
//	    
//	    for (int i = 0; i < list.size(); i++) {
//	        String fileRealName = list.get(i).getOriginalFilename();
//	        long size = list.get(i).getSize();
//	        
//	        System.out.println("파일명 :" + fileRealName);
//	        System.out.println("사이즈" + size);
//	        
//	        // UUID를 사용하여 고유한 파일 이름 생성
//	        UUID uuid = UUID.randomUUID();
//	        String[] uuids = uuid.toString().split("-");
//	        String uniqueName = uuids[0];
//	        	
//	        // 파일 확장자를 얻습니다.
//	        String fileExtension = fileRealName.substring(fileRealName.lastIndexOf("."),fileRealName.length());
//	        	
//	        // UUID와 원래 파일 확장자를 사용하여 새 파일 이름을 생성합니다.
//	        String newFilename = uniqueName + fileExtension;
//	        
//	        File saveFile = new File(uploadFolder + "\\" + newFilename);
//	        try {
//	            list.get(i).transferTo(saveFile);
//	        } catch (IllegalStateException e) {
//	            e.printStackTrace();
//	        } catch (IOException e) {
//	            e.printStackTrace();
//	        }
//	    }
//	    
//	    return "redirect:upload";
//	}
//}
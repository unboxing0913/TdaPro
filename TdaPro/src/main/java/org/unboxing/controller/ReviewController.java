package org.unboxing.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.unboxing.domain.Criteria;
import org.unboxing.domain.PageDTO;
import org.unboxing.domain.ReviewAttachVO;
import org.unboxing.domain.ReviewVO;
import org.unboxing.service.ReviewService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@RequestMapping("/review/*")
@Log4j
@AllArgsConstructor
public class ReviewController {
	
	private ReviewService service;
	
	/*
	@GetMapping("/list")
	public void list(Model model) {
		log.info("list page");
		model.addAttribute("list",service.getList());
	}
	*/
	
	//페이징처리 클래스인 Criteria를 매개변수로 받아주게 수정
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		log.info("list page + 페이징처리 "+cri);
		model.addAttribute("list",service.getList(cri));
		//model.addAttribute("pageMaker",new PageDTO(cri,123)); 임시 전체데이터수 123
		int total = service.getTotal(cri);
		log.info("전체 데이터 수 : "+total);
		model.addAttribute("pageMaker",new PageDTO(cri,total));
	}
	
	//화면에서 확인하기위해 get방식 매핑 적용	
	@GetMapping("/register")
	public void register() {
		
	}
	
	
	@PostMapping("/register")
	public String register(ReviewVO board, RedirectAttributes rttr) {
		//RedirectAttributes의 addFlashAttribute경우 일회성데이터를 전달하기때문에 중복처리하기 좋음
		log.info("register : "+board);
		
		//input의 hidden타입의 정보를 잘받아왔는지 확인
		log.info("test-----------------------------------------------");
		if(board.getAttachList() != null) {
			board.getAttachList().forEach(attach -> log.info(attach));
		}
		log.info("test-----------------------------------------------");
		
		service.register(board);
		rttr.addFlashAttribute("result",board.getBno()); 
		
		//등록 작업이후 다시 목록화면으로 이동
		return "redirect:/review/list";
	}
	
	
	//화면에서 확인하기위해 get방식 매핑적용 modify는 조회페이지(get)과 같기때문
	@GetMapping({"/get","/modify"})
	public void get(@RequestParam("bno") Long bno,Model model,@ModelAttribute("cri") Criteria cri) {
		log.info("get page , modify page");
		model.addAttribute("board",service.get(bno));
	}
	
	/*
	 * UriComponentsBuilder 사용해 redirect 코드를 간단히 하기위해 주석
	 * 
	@PostMapping("/modify")
	public String modify(ReviewVO board,RedirectAttributes rttr,@ModelAttribute("cri") Criteria cri) {
		log.info("modify : "+board);
		if(service.modify(board)) {
			rttr.addFlashAttribute("result","success");
		}
		
		//페이징처리
		rttr.addAttribute("pageNum",cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		
		//검색처리
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		//수정 작업이후 다시 목록화면으로 이동
		return "redirect:/review/list";
	}
	*/
	@PostMapping("/modify")
	public String modify(ReviewVO board,RedirectAttributes rttr,Criteria cri) {
		log.info("modify : "+board);
		if(service.modify(board)) {
			rttr.addFlashAttribute("result","success");
		}
		
		
		//수정 작업이후 다시 목록화면으로 이동
		// Criteria 클래스의 getListLink()메서드를 가지고 UriComponentsBuilder 기능으로 url 처리
		return "redirect:/review/list"+cri.getListLink();
	}
	
	
	
	/*
	 * UriComponentsBuilder 사용해 redirect 코드를 간단히 하기위해 주석
	 * 
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno,RedirectAttributes rttr,@ModelAttribute("cri") Criteria cri) {
		log.info("remove Bno : " +bno);
		if(service.remove(bno)) {
			rttr.addFlashAttribute("result","success");
		}
		
		//페이징처리
		rttr.addAttribute("pageNum",cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		
		//검색처리
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		//삭제 작업이후 다시 목록화면으로 이동
		return "redirect:/review/list";
	}
	*/
	
	/* uploadAjax.jsp 로 테스트시 사용
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno,RedirectAttributes rttr,Criteria cri) {
		log.info("remove Bno : " +bno);
		if(service.remove(bno)) {
			rttr.addFlashAttribute("result","success");
		}
		
		//삭제 작업이후 다시 목록화면으로 이동
		// Criteria 클래스의 getListLink()메서드를 가지고 UriComponentsBuilder 기능으로 url 처리
		return "redirect:/review/list"+cri.getListLink();
	}
	*/
	
	//게시글 삭제
	//삭제전 첨부파일 목록확보 후 게시물 과 첨부파일데이터 삭제 -> 삭제성공후 실제파일의 삭제
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno,@ModelAttribute("cri")Criteria cri , RedirectAttributes rttr, String writer) {
		log.info("remove..."+bno);
		
		List<ReviewAttachVO> attachList = service.getAttachList(bno); //첨부파일 목록 확보
		
		if(service.remove(bno)) {
			
			//delete Attach Files
			deleteFiles(attachList);
			
			rttr.addFlashAttribute("result","success");
		}
		/*
		 * rttr.addAttribute("pageNum",cri.getPageNum());
		 * rttr.addAttribute("amount",cri.getAmount());
		 * rttr.addAttribute("type",cri.getType());
		 * rttr.addAttribute("keyword",cri.getKeyword());
		 */
		return "redirect:/review/list"+cri.getListLink();
	}
	
	//게시글 삭제시 첨부파일데이터 삭제
	private void deleteFiles(List<ReviewAttachVO> attachList) {
		if(attachList == null || attachList.size() == 0 ) {
			return;
		}
		log.info("delete attach files");
		log.info(attachList);
		
		attachList.forEach(attach -> {
			
			
			try {
				Path file = Paths.get("C:\\upload\\review\\"+attach.getUploadPath()+"\\"+attach.getUuid()+"_"+attach.getFileName());
				Files.deleteIfExists(file);
				if(Files.probeContentType(file).startsWith("image")) {
					Path thumbNail = Paths.get("C:\\upload\\review\\"+attach.getUploadPath()+"\\s_"+attach.getUuid()+"_"+attach.getFileName());
					Files.delete(thumbNail);
				}
			}catch (IOException e) {
				log.error("delete file error"+e.getMessage());
			}
		});
	}
	
	
	/*Review게시판 파일 업로드 관련 매핑클래스 와 설정클래스 */
	
	//파일 업로드 view로 가는 매핑
	@GetMapping("/uploadAjax")
	public void uploadAjax() {
		log.info("upload ajax");
	}
	
	//업로드 폴더 날짜별 처리
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		return str.replace("-", File.separator);
	}
	
	//특정 파일이 이미지타입인지 검사하는 메서드
	private boolean checkImageType(File file) {
			
			try {	
				String contentType = Files.probeContentType(file.toPath());
				return contentType.startsWith("image");
			} catch (IOException e) {
				e.printStackTrace();
			}
			return false;
	}
	
	/*
	//파일 업로드시 매핑
	@PostMapping("/uploadAjaxAction")
	public void uploadAjaxPost(MultipartFile[] uploadFile) {
		log.info("update ajax post");
		
		String uploadFolder = "C:\\upload\\review";
		
		//업로드 폴더 날짜별 처리
		File uploadPath = new File(uploadFolder,getFolder());
		log.info("upload path ---> " +uploadPath);
		
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		
		for(MultipartFile multipartFile : uploadFile) {
				log.info("업로드 파일명 ----> " +multipartFile);
				log.info("업로드 파일 사이즈 --> "+multipartFile.getSize());
				
				String uploadFileName = multipartFile.getOriginalFilename();
				
				
				// IE의 경우 전체파일 경로가 전송되기때문에 마지막 부분을 기준으로 잘라낸 문자열을 실제파일의 이름으로
				uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1);
				log.info("파일 이름 "+uploadFileName);
				
				UUID uuid = UUID.randomUUID();
				
				uploadFileName = uuid.toString()+"_"+uploadFileName; // 원래이름을 확인할수있기위한 ( _ ) 문자열 추가
				
				
				try {
					File saveFile = new File(uploadPath,uploadFileName); // 폴더날짜별 처리인 uploadPath 위치로
					multipartFile.transferTo(saveFile);
					
					//섬네일 만들기전 파일타입 검사
					if(checkImageType(saveFile)) {
						FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath,"s_"+uploadFileName)); //섬네일은 파일앞에 s_ 로시작
						Thumbnailator.createThumbnail(multipartFile.getInputStream(),thumbnail,100,100); //섬네일크기 
					    thumbnail.close();
					}
					
				} catch (IllegalStateException e) {
					log.error(e.getMessage());
				} catch (IOException e) {
					log.error(e.getMessage());
				}
		}
	}
	*/
	
	//파일 업로드시 매핑 + 업로드된 파일 반환하기위한 구조변경
	@PostMapping(value="/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<ReviewAttachVO>> uploadAjaxPost(MultipartFile[] uploadFile) {
		
		List<ReviewAttachVO> list = new ArrayList<>(); // 추가된 구조 (추가하기위한 리스트생성)
		String uploadFolder = "C:\\upload\\review";
		
		String uploadFolderPath = getFolder(); // 추가된 구조 (dto안에 uploadpath에 담을 값을 만듬)
		
		//업로드 폴더 날짜별 처리
		File uploadPath = new File(uploadFolder, getFolder());
		log.info("upload path ---> " + uploadPath);

		if (uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		for(MultipartFile multipartFile : uploadFile) {
			log.info("업로드 파일명 ----> " +multipartFile);
			log.info("업로드 파일 사이즈 --> "+multipartFile.getSize());
			
			ReviewAttachVO attachDTO = new ReviewAttachVO();// 추가된 구조 (전달해줄 dto생성)
			
			String uploadFileName = multipartFile.getOriginalFilename();
			
			// IE의 경우 전체파일 경로가 전송되기때문에 마지막 부분을 기준으로 잘라낸 문자열을 실제파일의 이름으로
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1);
			log.info("파일 이름 "+uploadFileName);
			
			attachDTO.setFileName(uploadFileName);// 추가된 구조(dto안에 filename을 담기)
			
			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString()+"_"+uploadFileName; // 원래이름을 확인할수있기위한 ( _ ) 문자열 추가
			
			try {
				File saveFile = new File(uploadPath,uploadFileName); // 폴더날짜별 처리인 uploadPath 위치로
				multipartFile.transferTo(saveFile);
				
				attachDTO.setUuid(uuid.toString()); //dto 안에 uuid값 담기
				attachDTO.setUploadPath(uploadFolderPath); //dto 안에 uploadpath 구해놓은 값 담기
				
				//섬네일 만들기전 파일타입 검사
				if(checkImageType(saveFile)) {
					attachDTO.setFileType(true); //dto안에 이미지 존재여부 true  //test시에는 setImage 현재는 setFileType
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath,"s_"+uploadFileName)); //섬네일은 파일앞에 s_ 로시작
					Thumbnailator.createThumbnail(multipartFile.getInputStream(),thumbnail,100,100); //섬네일크기 
				    thumbnail.close();
				}
				
				/*
				log.info("확인 bno"+attachDTO.getBno());
				log.info("확인 uuid"+attachDTO.getUuid());
				log.info("확인 uploadPath"+attachDTO.getUploadPath());
				log.info("확인 filename"+attachDTO.getFileName());
				log.info("확인"+attachDTO.isFileType());
				*/	
				
				
				list.add(attachDTO); // dto값을 list에 담아줌 
				
			} catch (IllegalStateException e) {
				log.error(e.getMessage());
			} catch (IOException e) {
				log.error(e.getMessage());
			}
			
		}
		return new ResponseEntity<>(list,HttpStatus.OK);
	}
	
	//파일의 이름을 받아 이미지 데이터를 화면에 전송
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName){
		log.info("fileName:"+fileName);
		
		File file = new File("c:\\upload\\review\\"+fileName);
		log.info("file ---> "+file);
		
		ResponseEntity<byte[]> result = null;
		
		
		try {
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file),header,HttpStatus.OK);
		} catch (IOException e) {
			e.printStackTrace();
		}		
		return result;
	}
	
	//첨부파일 다운로드 (디바이스 정보를 알수있는 User-Agent)정보를 파라미터로 수집
	@GetMapping(value = "/download",produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(String fileName, @RequestHeader("User-Agent") String userAgent){
		log.info("다운로드 파일 ---> " +fileName);
		
		
		Resource resource = new FileSystemResource("c:\\upload\\review\\"+fileName);
				
		log.info("resource : " + resource);
		
		if(resource.exists() == false) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		
		String resourceName = resource.getFilename(); 
		
		//UUID 지운 본래의 파일명 (브라우저 문제해결하면서 downlaodName을 적용할때 사용)
		String resourceOriginalName = resourceName.substring(resourceName.indexOf("_")+1);
		log.info("resourceName -->" +resourceName);
		log.info("resourceOriginalName -->" +resourceOriginalName);
		HttpHeaders headers = new HttpHeaders();
		
		try {			
			String downloadName = null;
		  
			// IE,Edge 브라우저 문제해결
			if(userAgent.contains("Trident")) {
				log.info("IE browser");
				downloadName = URLEncoder.encode(resourceOriginalName,"UTF-8").replaceAll("\\", "");
			}else if(userAgent.contains("Edge")) {
				log.info("Edge browser");
				downloadName = URLEncoder.encode(resourceOriginalName,"UTF-8");
				log.info("Edge name : "+downloadName);
			}else {
				log.info("Chrome browser");
				downloadName = new String(resourceOriginalName.getBytes("UTF-8"),"ISO-8859-1");
			}
			
			headers.add("Content-Disposition", "attachment; filename="+downloadName);
			
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return new ResponseEntity<Resource>(resource,headers,HttpStatus.OK);
	}
	
	//(등록시)첨부파일 삭제
	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deletFiles(String fileName, String type) {
		log.info("삭제 파일 ---> " + fileName);
		
		File file;

		try {
			file = new File("c:\\upload\\review\\" + URLDecoder.decode(fileName, "UTF-8"));
			file.delete();
			if (type.equals("image")) {
				String largeFileName = file.getAbsolutePath().replace("s_", "");
				log.info("largeFileName:" + largeFileName);
				file = new File(largeFileName);
				file.delete();
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}
	
	
	// 특정 게시글번호로 첨부파일 관련된 데이터를 JSON형태로 반환
	@GetMapping(value="/getAttachList",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<ReviewAttachVO>> getAttachList(Long bno){
		log.info("게시글 번호 ---> "+bno);
		return new ResponseEntity<>(service.getAttachList(bno),HttpStatus.OK);
	}
	
	@GetMapping("/test")
	public void test() {
		
	}
	
	@GetMapping("/test2")
	public void test2() {
		
	}

}

package com.project.hot.chatting.config;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.Date;
import java.text.SimpleDateFormat;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.project.hot.chatting.model.dto.HotTalkAtt;
import com.project.hot.chatting.model.service.HotTalkService;
import com.project.hot.common.exception.ChattingException;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/hottalk")
@Slf4j
@RequiredArgsConstructor
public class HotTalkController {

	private final HotTalkService service;

	@PostMapping("/upload")
	public @ResponseBody HotTalkAtt insertHotTalkAtt(@RequestParam(name="hotTalkNo") int hotTalkNo,
								 @RequestParam(name="hotTalkAttSender") int hotTalkAttSender,
								 @RequestParam(name="file") MultipartFile file, HttpSession session) {
		HotTalkAtt hotTalkAtt = new HotTalkAtt();
		String path = session.getServletContext().getRealPath("/upload/hottalk");
		System.out.println(path);
		if(file != null) {
			hotTalkAtt.setHotTalkNo(hotTalkNo);
			hotTalkAtt.setHotTalkOriginalFilename(file.getOriginalFilename());
			// OriginalFilename에서 확장자명 가져오기
			String ext = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
			Date now = new Date(System.currentTimeMillis());
			int rndNum = (int)(Math.random()*10000+1);
			// RenamedFilename 만들기
			String rename = "HOT_"+file.getOriginalFilename().substring(0,file.getOriginalFilename().indexOf("."))+"_"+(new SimpleDateFormat("yyyyMMdd_HHmmssSSS").format(now))+"_"+rndNum+ext;
			hotTalkAtt.setHotTalkRenamedFilename(rename);
			hotTalkAtt.setHotTalkAttSender(hotTalkAttSender);
			// 경로 만들기
			File dir = new File(path);
			if(!dir.exists()) dir.mkdirs();
			// 경로로 rename 된 이름으로 저장하기
			try {
				file.transferTo(new File(path, rename));
			} catch(IOException e) {
				log.debug(hotTalkNo+"번 방 HotTalk File Upload 실패");
			}
		}
		int result = 0;
		try {
			// DB HOT_TALK_ATT Table에 저장하기
			result = service.insertHotTalkAtt(hotTalkAtt);
		} catch(ChattingException e) {
			File delFile = new File(path+"/"+hotTalkAtt.getHotTalkRenamedFilename());
			delFile.delete();
		}
		return hotTalkAtt;
	}

	@GetMapping("/download")
	public void filedownload(String hotTalkOriginalFilename, String hotTalkRenamedFilename, OutputStream out,
			HttpServletResponse response, HttpSession session) {
		String path = session.getServletContext().getRealPath("/upload/hottalk/");
		File downloadFile = new File(path+hotTalkRenamedFilename);
		try(FileInputStream fis = new FileInputStream(downloadFile);
			BufferedInputStream bis = new BufferedInputStream(fis);
			BufferedOutputStream bos = new BufferedOutputStream(out)) {

			String encoding = new String(hotTalkOriginalFilename.getBytes("UTF-8"), "ISO-8859-1");

			response.setContentType("application/octet-stream;charset=utf-8");
			response.setHeader("Content-disposition", "attachment;filename=\""+encoding+"\"");

			int data=1;
			while((data=bis.read())!=1) {
				bos.write(data);
			}
		} catch(IOException e) {
			e.printStackTrace();
		}
	}
}

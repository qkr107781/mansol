package com.happy.prj;

import java.io.UnsupportedEncodingException;

import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HappyMailController {

	private Logger logger = LoggerFactory.getLogger(HappyMailController.class);
	
	@Autowired
	private JavaMailSender mailSender;
	
	@RequestMapping(value="/mail.do", method=RequestMethod.GET)
	public String mail() {
		logger.info("MailController mail");
		return "mailForm";
	}
	
	@RequestMapping(value="/mailSending.do", method=RequestMethod.POST)
	public String mailSending(String toMail, String title, String content) {
		String setFrom = "info.happy0612@gmail.com"; // 보내는 사람
		// toMail : 받는 사람 메일
		// title : 메일 제목
		// content : 메일 내용
		
		
		try {
			MimeMessage message = mailSender.createMimeMessage(); // 메일을 보내는 객체
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			
			messageHelper.setFrom(setFrom); // 보내는 사람 주소를 생략하거나 입력 하지 않으면 작동 안됨
			messageHelper.setTo(toMail); // 받는 사람의 주소
			messageHelper.setSubject(title); // 제목 생략해도 됨
//			messageHelper.setText(content); // 메일 전송 내용 // setText(content, "UTF-8", "html")
			messageHelper.setText(content, true); // setText(content, boolean); boolean : HTML 사용 여부
			
			DataSource dataSource = new FileDataSource("D:\\공연\\공연들\\17.6.30 기흥동 주민센터\\KakaoTalk_20170630_232553247.jpg");
			try {
				messageHelper.addAttachment(MimeUtility.encodeText("장석영.jpg", "UTF-8", "B"), dataSource); // B : Base64 라는 인코딩 타입
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			} 
			
			// setCC(String), setCC(String[]) : 참조 메일 주소
			// setBCC(String), setBCC(String[]) : 숨은 참조 메일 주소
			// setSentDate(Date) : 예약 메일
			
			mailSender.send(message);
			
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		
		return "redirect:/memberList.do";
	}
	
}

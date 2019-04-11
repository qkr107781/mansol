package com.happy.prj;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.happy.prj.dtos.Answerboard_DTO;
import com.happy.prj.dtos.RowNum_DTO;
import com.happy.prj.model.AnswerBoard_IService;

//@Controller
public class AnswerBoardTest_Ctrl {

	@Autowired
	private AnswerBoard_IService service;
	
	@RequestMapping(value="/writeBoard.do", method=RequestMethod.GET)
	public String writeBoard(Answerboard_DTO dto) {
		boolean isc = service.writeBoard(dto);
		System.out.println(isc+"$$$$$$$$$$$$$$$$$$");
		return null;
	}
	
	@RequestMapping(value="/reply.do", method=RequestMethod.GET)
	public String reply(Answerboard_DTO dto) {
		boolean isc = service.reply(dto);
		System.out.println(isc+"$$$$$$$$$$$$$$$$$$");
		return null;
	}
	
	@RequestMapping(value="/getOneBoard.do", method=RequestMethod.GET)
	public String getOneBoard(String seq) {
		Answerboard_DTO dto = service.getOneBoard(seq);
		System.out.println(dto+"$$$$$$$$$$$$$$$$$$");
		return null;
	}
	
	@RequestMapping(value="/readcountBoard.do", method=RequestMethod.GET)
	public String readcountBoard(String seq) {
		boolean isc = service.readcountBoard(seq);
		System.out.println(isc+"$$$$$$$$$$$$$$$$$$");
		return null;
	}
	
	@RequestMapping(value="/modifyBoard.do", method=RequestMethod.GET)
	public String modifyBoard(Answerboard_DTO dto) {
		boolean isc = service.modifyBoard(dto);
		System.out.println(isc+"$$$$$$$$$$$$$$$$$$");
		return null;
	}
	
	@RequestMapping(value="/delflagBoard.do", method=RequestMethod.GET)
	public String delflagBoard(String[] seq) {
		Map<String, String[]> map = new HashMap<String, String[]>();
		map.put("seq_", seq);
		boolean isc = service.delflagBoard(map);
		System.out.println(isc+"$$$$$$$$$$$$$$$$$$");
		return null;
	}
	
	@RequestMapping(value="/deleteBoardSel.do", method=RequestMethod.GET)
	public String deleteBoardSel(String seq) {
		List<Answerboard_DTO> lists = service.deleteBoardSel(seq);
		System.out.println(lists.size()+"$$$$$$$$$$$$$$$$$$");
		System.out.println(lists+"$$$$$$$$$$$$$$$$$$");
		return null;
	}
	
	@RequestMapping(value="/deleteBoard.do", method=RequestMethod.GET)
	public String deleteBoard(String[] seq) {
		Map<String, String[]> map = new HashMap<String, String[]>();
		map.put("seq_", seq);
		boolean isc = service.deleteBoard(map);
		System.out.println(isc+"$$$$$$$$$$$$$$$$$$");
		return null;
	}
	
	@RequestMapping(value="/userBoardListTotal.do", method=RequestMethod.GET)
	public String userBoardListTotal() {
		int n = service.userBoardListTotal();
		System.out.println(n+"$$$$$$$$$$$$$$$$$$");
		return null;
	}

	@RequestMapping(value="/adminBoardListTotal.do", method=RequestMethod.GET)
	public String adminBoardListTotal() {
		int n = service.adminBoardListTotal();
		System.out.println(n+"$$$$$$$$$$$$$$$$$$");
		return null;
	}
	
	@RequestMapping(value="/userBoardListRow.do", method=RequestMethod.GET)
	public String userBoardListRow() {
		RowNum_DTO rdto = new RowNum_DTO();
		int total = service.userBoardListTotal();
		rdto.setTotal(total);
		
		List<Answerboard_DTO> lists = service.userBoardListRow(rdto);
		System.out.println(lists.size()+"$$$$$$$$$$$$$$$$$$");
		System.out.println(lists+"$$$$$$$$$$$$$$$$$$");
		return null;
	}
	
	@RequestMapping(value="/adminBoardListRow.do", method=RequestMethod.GET)
	public String adminBoardListRow() {
		RowNum_DTO rdto = new RowNum_DTO();
		int total = service.adminBoardListTotal();
		rdto.setTotal(total);
		
		List<Answerboard_DTO> lists = service.adminBoardListRow(rdto);
		System.out.println(lists.size()+"$$$$$$$$$$$$$$$$$$");
		System.out.println(lists+"$$$$$$$$$$$$$$$$$$");
		return null;
	}
}

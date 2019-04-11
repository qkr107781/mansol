package com.happy.prj.model;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.happy.prj.dtos.Answerboard_DTO;
import com.happy.prj.dtos.RowNum_DTO;

@Service
public class AnswerBoard_Service implements AnswerBoard_IService{

	private Logger logger = LoggerFactory.getLogger(AnswerBoard_Service.class);
	
	@Autowired
	private AnswerBoard_Interface answerBoard_Interface;
	
	@Override
	public boolean writeBoard(Answerboard_DTO dto) {
		logger.info("새 글 작성 writeBoard {}", dto);
		return answerBoard_Interface.writeBoard(dto);
	}

	@Override
	public boolean reply(Answerboard_DTO dto) {
		logger.info("답글 reply {}", dto);
		boolean isc = answerBoard_Interface.replyBoardUp(dto); // 답글이 없는 글에는 업데이트를 못해서 false
		isc = answerBoard_Interface.replyBoardIn(dto); // 답글 입력은 위 상황일 때도 되어야 하기 때문에 true
		return isc;
	}

	@Override
	public Answerboard_DTO getOneBoard(String seq) {
		logger.info("하나 조회 getOneBoard {}", seq);
		return answerBoard_Interface.getOneBoard(seq);
	}

	@Override
	public boolean readcountBoard(String seq) {
		logger.info("조회수 증가 readcountBoard {}", seq);
		return answerBoard_Interface.readcountBoard(seq);
	}

	@Override
	public boolean modifyBoard(Answerboard_DTO dto) {
		logger.info("글 수정 modifyBoard {}", dto);
		return answerBoard_Interface.modifyBoard(dto);
	}

	@Override
	public boolean delflagBoard(Map<String, String[]> map) {
		logger.info("delflag 변경 delflagBoard {}", map);
		return answerBoard_Interface.delflagBoard(map);
	}

	@Override
	public List<Answerboard_DTO> deleteBoardSel(String seq) {
		logger.info("하위 삭제 글 확인 deleteBoardSel {}", seq);
		return answerBoard_Interface.deleteBoardSel(seq);
	}

	@Override
	public boolean deleteBoard(Map<String, String[]> map) {
		logger.info("진짜 삭제 deleteBoard {}", map);
		return answerBoard_Interface.deleteBoard(map);
	}

	@Override
	public List<Answerboard_DTO> userBoardList() {
		logger.info("전체 글 조회 사용자 userBoardList");
		return answerBoard_Interface.userBoardList();
	}

	@Override
	public List<Answerboard_DTO> adminBoardList() {
		logger.info("전체 글 조회 관리자 adminBoardList");
		return answerBoard_Interface.adminBoardList();
	}

	@Override
	public List<Answerboard_DTO> userBoardListRow(RowNum_DTO dto) {
		logger.info("전체 글 조회 사용자 (페이징) userBoardListRow {}", dto); 
		return answerBoard_Interface.userBoardListRow(dto);
	}

	@Override
	public List<Answerboard_DTO> adminBoardListRow(RowNum_DTO dto) {
		logger.info("전체 글 조회 관리자 (페이징) adminBoardListRow {}", dto); 
		return answerBoard_Interface.adminBoardListRow(dto);
	}

	@Override
	public int userBoardListTotal() {
		logger.info("전체 글 숫자 사용자 userBoardListTotal");
		return answerBoard_Interface.userBoardListTotal();
	}

	@Override
	public int adminBoardListTotal() {
		logger.info("전체 글 숫자 관리자 adminBoardListTotal");
		return answerBoard_Interface.adminBoardListTotal();
	}

}

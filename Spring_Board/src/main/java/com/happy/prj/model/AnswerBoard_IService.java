package com.happy.prj.model;

import java.util.List;
import java.util.Map;

import com.happy.prj.dtos.Answerboard_DTO;
import com.happy.prj.dtos.RowNum_DTO;

public interface AnswerBoard_IService {

	// 글입력
	public boolean writeBoard(Answerboard_DTO dto);

	// 답글 입력(Dao에서 update와 insert를 조합해 사용)
	public boolean reply(Answerboard_DTO dto);
	
	// 상세글 입력
	public Answerboard_DTO getOneBoard(String seq);
	
	// 조회수 증가
	public boolean readcountBoard(String seq);

	// 글 수정
	public boolean modifyBoard(Answerboard_DTO dto);
	
	// 글 삭제
	public boolean delflagBoard(Map<String, String[]> map);
	
	// 삭제글 찾기
	public List<Answerboard_DTO> deleteBoardSel(String seq);
	
	// 글 삭제 (DB삭제)
	public boolean deleteBoard(Map<String, String[]> map);
	
	// 글 조회 (전체-사용자)
	public List<Answerboard_DTO> userBoardList();

	// 글 조회 (전체-관리자)
	public List<Answerboard_DTO> adminBoardList();
	
	// 글 조회 (전체-페이징-사용자)
	public List<Answerboard_DTO> userBoardListRow(RowNum_DTO dto);
	
	// 글 조회 (전체-페이징-관리자)
	public List<Answerboard_DTO> adminBoardListRow(RowNum_DTO dto);
	
	// 글 개수(전체-사용자)
	public int userBoardListTotal();
	
	// 글 개수(전체-관리자)
	public int adminBoardListTotal();

}

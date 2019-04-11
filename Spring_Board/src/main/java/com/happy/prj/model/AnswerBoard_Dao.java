package com.happy.prj.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.happy.prj.dtos.Answerboard_DTO;
import com.happy.prj.dtos.RowNum_DTO;

@Repository
public class AnswerBoard_Dao implements AnswerBoard_Interface {

	private Logger logger = LoggerFactory.getLogger(AnswerBoard_Dao.class);
	private final String NS = "com.happy.prj.Statement_Answerboard.";
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public boolean writeBoard(Answerboard_DTO dto) {
		int n = sqlSession.insert(NS+"writeBoard", dto);
		return n>0?true:false;
	}

	@Override
	public boolean replyBoardUp(Answerboard_DTO dto) {
		int n = sqlSession.update(NS+"replyBoardUp", dto);
		return n>0?true:false;
	}

	@Override
	public boolean replyBoardIn(Answerboard_DTO dto) {
		int n = sqlSession.insert(NS+"replyBoardIn", dto);
		return n>0?true:false;
	}

	@Override
	public Answerboard_DTO getOneBoard(String seq) {
		return sqlSession.selectOne(NS+"getOneBoard", seq);
	}

	@Override
	public boolean readcountBoard(String seq) {
		int n = sqlSession.update(NS+"readcountBoard", seq);
		return n>0?true:false;
	}

	@Override
	public boolean modifyBoard(Answerboard_DTO dto) {
		int n = sqlSession.update(NS+"modifyBoard", dto);
		return n>0?true:false;
	}

	@Override
	public boolean delflagBoard(Map<String, String[]> map) {
		int n = sqlSession.update(NS+"delflagBoard", map);
		return n>0?true:false;
	}

	@Override
	public List<Answerboard_DTO> deleteBoardSel(String seq) {
		return sqlSession.selectList(NS+"deleteBoardSel", seq);
	}

	@Override
	public boolean deleteBoard(Map<String, String[]> map) {
		int n = sqlSession.delete(NS+"deleteBoard", map);
		return n>0?true:false;
	}

	@Override
	public List<Answerboard_DTO> userBoardList() {
		return sqlSession.selectList(NS+"userBoardList");
	}

	@Override
	public List<Answerboard_DTO> adminBoardList() {
		return sqlSession.selectList(NS+"adminBoardList");
	}

	@Override
	public List<Answerboard_DTO> userBoardListRow(RowNum_DTO dto) {
		return sqlSession.selectList(NS+"userBoardListRow", dto);
	}

	@Override
	public List<Answerboard_DTO> adminBoardListRow(RowNum_DTO dto) {
		return sqlSession.selectList(NS+"adminBoardListRow", dto);
	}

	@Override
	public int userBoardListTotal() {
		return sqlSession.selectOne(NS+"userBoardListTotal");
	}

	@Override
	public int adminBoardListTotal() {
		return sqlSession.selectOne(NS+"adminBoardListTotal");
	}

}

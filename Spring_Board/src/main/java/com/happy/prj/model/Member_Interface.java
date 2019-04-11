package com.happy.prj.model;

import java.util.List;

import com.happy.prj.dtos.Member_DTO;

public interface Member_Interface {

//	memberList : 전체 회원 조회
	public List<Member_DTO> memberList();
	
//	signupmember : 회원 가입
	public boolean signupmember(Member_DTO dto);
	
//	idduplicatecheck : 아이디 중복체크
	public boolean idduplicatecheck(String id);
	
//	loginMember : 로그인
	public Member_DTO loginMember(Member_DTO dto); 
}

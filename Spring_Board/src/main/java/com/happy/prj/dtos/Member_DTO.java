package com.happy.prj.dtos;

public class Member_DTO {

	private String id       ;
	private String pw       ;
	private String name     ;
	private String auth     ;
	private String delflag  ;
	private String regdate  ;
	
	public Member_DTO() {
	}

	public Member_DTO(String id, String pw, String name, String auth, String delflag, String regdate) {
		super();
		this.id = id;
		this.pw = pw;
		this.name = name;
		this.auth = auth;
		this.delflag = delflag;
		this.regdate = regdate;
	}

	public Member_DTO(String id, String pw) {
		super();
		this.id = id;
		this.pw = pw;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAuth() {
		return auth;
	}

	public void setAuth(String auth) {
		this.auth = auth;
	}

	public String getDelflag() {
		return delflag;
	}

	public void setDelflag(String delflag) {
		this.delflag = delflag;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	@Override
	public String toString() {
		return "Member_DTO [id=" + id + ", pw=" + pw + ", name=" + name + ", auth=" + auth + ", delflag=" + delflag
				+ ", regdate=" + regdate + "]";
	}

	
	
}
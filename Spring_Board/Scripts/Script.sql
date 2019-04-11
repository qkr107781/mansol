DROP TABLE ANSWERBOARD2;

CREATE TABLE ANSWERBOARD2(
	SEQ NUMBER NOT NULL,
	ID VARCHAR2(10) NOT NULL,
	TITLE VARCHAR2(50) NOT NULL,
	CONTENT VARCHAR2(2000) NOT NULL,
	REFER NUMBER NOT NULL,
	STEP NUMBER NOT NULL,
	DEPTH NUMBER NOT NULL,
	READCOUNT NUMBER NOT NULL,
	DELFLAG CHAR(1) NOT NULL,
	REGDATE DATE NOT NULL,
	CONSTRAINT ANSWERBOARD2_PK PRIMARY KEY(SEQ)
);

CREATE SEQUENCE ANSWERBOARD2_SEQ START WITH 1 INCREMENT BY 1;

CREATE TABLE MEMBERS(
	ID VARCHAR2(10) NOT NULL,
	PW VARCHAR2(25) NOT NULL,
	NAME VARCHAR2(20) NOT NULL,
	AUTH CHAR(1) NOT NULL,
	DELFLAG CHAR(1) NOT NULL,
	REGDATE DATE NOT NULL,
	CONSTRAINT MEMBERS_CK CHECK (AUTH IN ('A','U')),
	CONSTRAINT MEMBERS_PK PRIMARY KEY (ID)
);

ALTER TABLE ANSWERBOARD2 ADD CONSTRAINT ANSWERBOARD2_FK FOREIGN KEY (ID) REFERENCES MEMBERS(ID);

INSERT INTO MEMBERS
(ID, PW, NAME, AUTH, DELFLAG, REGDATE)
VALUES('TEST002', 'TEST002', 'TEST', 'A', 'N', SYSDATE);


-- **MEMBER
-- boardselect
SELECT ID, PW, NAME, AUTH, DELFLAG, REGDATE FROM MEMBERS ORDER BY AUTH, REGDATE;

-- signupmember
INSERT INTO MEMBERS
(ID, PW, NAME, AUTH, DELFLAG, REGDATE)
VALUES('TEST002', 'TEST002', 'TEST', 'U', 'N', SYSDATE);

-- idduplicatecheck
SELECT COUNT(ID) ID FROM MEMBERS WHERE ID = 'TEST001';

-- loginMember
SELECT ID, PW, AUTH, NAME FROM MEMBERS WHERE ID='TEST001' AND PW='TEST001';


-- **ANSWERBOARD2
--writeBoard
INSERT INTO ANSWERBOARD2
(SEQ, ID, TITLE, CONTENT, 
REFER, STEP, "DEPTH", READCOUNT, REGDATE, DELFLAG)
VALUES(ANSWERBOARD2_SEQ.NEXTVAL, 'TEST002', '글 제목2', '테스트 글 작성2', 
(SELECT NVL(MAX(REFER),0)+1 FROM ANSWERBOARD2), 0, 0, 0, SYSDATE, 'N');

-- replyBoardUp
UPDATE ANSWERBOARD2 SET STEP = STEP+1
	WHERE STEP > (SELECT STEP FROM ANSWERBOARD2 WHERE SEQ = '14')
	AND REFER = (SELECT REFER FROM ANSWERBOARD2 WHERE SEQ = '14');

-- replyBoardIn
INSERT INTO ANSWERBOARD2
(SEQ, ID, TITLE, CONTENT, 
REFER, STEP, "DEPTH", READCOUNT, REGDATE, DELFLAG)
VALUES (ANSWERBOARD2_SEQ.NEXTVAL, 'TEST001', '답글', '답글입니다~',
(SELECT REFER FROM ANSWERBOARD2 WHERE SEQ = '14'), (SELECT STEP+1 FROM ANSWERBOARD2 WHERE SEQ = '14'),
(SELECT DEPTH+1 FROM ANSWERBOARD2 WHERE SEQ='14'), 0, SYSDATE, 'N');

--getOneBoard
SELECT SEQ, ID, TITLE, CONTENT, REFER, STEP, "DEPTH", READCOUNT, REGDATE, DELFLAG FROM ANSWERBOARD2
	WHERE SEQ = '14';

--readcountBoard
UPDATE ANSWERBOARD2 SET READCOUNT = READCOUNT + 1 WHERE SEQ = '';

--modifyBoard
UPDATE ANSWERBOARD2 SET TITLE = '', CONTENT = '' WHERE SEQ = '';

--delflagBoard
UPDATE ANSWERBOARD2 SET DELFLAG = 'Y' WHERE DELFLAG = 'N' AND SEQ IN(,,);

--deleteBoardSel
SELECT SEQ, ID, TITLE, CONTENT, REFER, STEP, "DEPTH", READCOUNT, REGDATE, DELFLAG FROM ANSWERBOARD2
	WHERE REFER = (SELECT REFER FROM ANSWERBOARD2 WHERE SEQ='')
	AND STEP >= (SELECT STEP FROM ANSWERBOARD2 WHERE SEQ='')
	AND DEPTH >= (SELECT DEPTH FROM ANSWERBOARD2 WHERE SEQ='')
	ORDER BY REFER DESC, STEP;
	
-- deleteBoard
DELETE FROM ANSWERBOARD2 WHERE SEQ IN(,);

--userBoardList
SELECT SEQ, ID, TITLE, CONTENT, REFER, STEP, "DEPTH", READCOUNT, REGDATE, DELFLAG FROM ANSWERBOARD2
WHERE DELFLAG = 'N'
ORDER BY REFER DESC, STEP;

--adminBoardList
SELECT SEQ, ID, TITLE, CONTENT, REFER, STEP, "DEPTH", READCOUNT, REGDATE, DELFLAG FROM ANSWERBOARD2
ORDER BY REFER DESC, STEP;

--userBoardListRow
SELECT SEQ, ID, TITLE, CONTENT, REFER, STEP, "DEPTH", READCOUNT, REGDATE, DELFLAG 
FROM(
	SELECT ROWNUM RNUM, SEQ, ID, TITLE, CONTENT, REFER, STEP, "DEPTH", READCOUNT, REGDATE, DELFLAG  
		FROM
		(SELECT SEQ, ID, TITLE, CONTENT, REFER, STEP, "DEPTH", READCOUNT, REGDATE, DELFLAG 
			FROM ANSWERBOARD2
				WHERE DELFLAG = 'N'
				ORDER BY REFER DESC, STEP)
	)
WHERE RNUM BETWEEN 1 AND 10;

--userBoardListTotal
SELECT COUNT(*) FROM ANSWERBOARD2 WHERE DELFLAG = 'N';

--adminBoardListRow
SELECT SEQ, ID, TITLE, CONTENT, REFER, STEP, "DEPTH", READCOUNT, REGDATE, DELFLAG 
FROM(
	SELECT ROWNUM RNUM, SEQ, ID, TITLE, CONTENT, REFER, STEP, "DEPTH", READCOUNT, REGDATE, DELFLAG  
		FROM
		(SELECT SEQ, ID, TITLE, CONTENT, REFER, STEP, "DEPTH", READCOUNT, REGDATE, DELFLAG 
			FROM ANSWERBOARD2
				ORDER BY REFER DESC, STEP)
	)
WHERE RNUM BETWEEN 1 AND 10;

--adminBoardListTotal
SELECT COUNT(*) FROM ANSWERBOARD2;


INSERT INTO ANSWERBOARD2
(SEQ, ID, TITLE, CONTENT, 
REFER, STEP, "DEPTH", READCOUNT, REGDATE, DELFLAG)
VALUES(ANSWERBOARD2_SEQ.NEXTVAL, 'gold99', 'db공부10', '내용입니다~', 
(SELECT NVL(MAX(REFER),0)+1 FROM ANSWERBOARD2), 0, 0, 0, SYSDATE, 'N');
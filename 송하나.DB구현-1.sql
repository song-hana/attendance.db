-- drop user
drop user attendance cascade;

-- create user
create user attendance identified by attendance;

-- grant
grant connect, resource to attendance;

--create table

-- companys
create table attendance.companys(
company_id varchar2(12) constraint com_comid_pk primary key,
com_pw varchar2(15) constraint com_compw_nn not null,
com_name varchar2(20) constraint com_comname_nn not null,
com_regno number(10) constraint com_comregno_nn not null 
                    constraint com_comregno_uk unique,
com_addr varchar2(50) constraint com_comaddr_nn not null,
com_detailaddr varchar2(40) constraint com_comdetailaddr_nn not null,
com_postcode number(5) constraint com_compostcode_nn not null,
com_ph varchar2(11) constraint com_comph_nn not null,
com_email varchar2(30) constraint com_comemail_nn not null,
president varchar2(24) constraint com_president_nn not null);

-- employees
create table attendance.employees(
employee_no number(6) constraint emp_empno_pk primary key,
emp_id varchar2(12) constraint emp_empid_nn not null
                    constraint emp_empid_uk unique,
emp_pw varchar2(15) constraint emp_emppw_nn not null,
emp_name varchar2(10) constraint emp_empname_nn not null,
emp_addr varchar2(50) constraint emp_empaddr_nn not null,
emp_detailaddr varchar2(40) constraint emp_empdetailaddr_nn not null,
emp_postcode number(5) constraint emp_emppostcode_nn not null,
emp_ph varchar2(11) constraint emp_empph_nn not null,
emp_email varchar2(30) constraint emp_empemail_nn not null,
hire_date date constraint emp_hiredate_nn not null,
emp_position varchar2(12),
emp_pino number(13) constraint emp_emppino_nn not null,
profile_name varchar2(50),
company_id varchar2(12) constraint emp_comid_fk references attendance.companys(company_id) on delete cascade);

-- works
create table attendance.works(
work_no number(5) constraint work_workno_pk primary key,
start_time date constraint work_starttime_nn not null,
end_time date,
employee_no number(6) constraint work_empno_fk references attendance.employees(employee_no) on delete cascade);

-- holidays
create table attendance.holidays(
holiday_no number(5) constraint hol_holno_pk primary key,
hol_date date constraint hol_holdate_nn not null,
hol_content varchar2(30) constraint hol_holcontent_nn not null,
employee_no number(6) constraint hol_empno_fk references attendance.employees(employee_no) on delete cascade);

-- plans
create table attendance.plans(
plan_no number(5) constraint plan_planno_pk primary key,
plan_title varchar2(20) constraint plan_plantitle_nn not null,
plan_date date constraint plan_plandate_nn not null,
plan_content varchar2(30) constraint plan_plancontent_nn not null,
company_id varchar2(12) constraint plan_comid_fk references attendance.companys(company_id) on delete cascade);

-- company_notices
create table attendance.company_notices(
company_notice_no number(5) constraint comntc_comntcno_pk primary key,
comntc_title varchar2(60) constraint comntc_comntctitle_nn not null,
comntc_content varchar2(600) constraint comntc_comntccontent_nn not null,
comntc_date date constraint comntc_comntcdate_nn not null,
company_id varchar2(12) constraint comntc_comid_fk references attendance.companys(company_id) on delete cascade);

-- public_notices
create table attendance.public_notices(
public_notice_no number(5) constraint pubntc_pubntcno_pk primary key,
pubntc_title varchar2(60) constraint pubntc_pubntctitle_nn not null,
pubntc_content varchar2(600) constraint pubntc_pubntccontent_nn not null,
pubntc_date date constraint pubntc_pubntcdate_nn not null);

-- asks
create table attendance.asks(
ask_no number(5) constraint ask_askno_pk primary key,
ask_title varchar2(60) constraint ask_asktitle_nn not null,
ask_name varchar2(20) constraint ask_askname_nn not null,
ask_content varchar2(600) constraint ask_askcontent_nn not null,
answer_content varchar2(600),
ask_date date constraint ask_askdate_nn not null,
answer_date date);

-- admins
create table attendance.admins(
admin_id varchar2(5) constraint admin_adminid_pk primary key,
admin_pw varchar2(5) constraint admin_adminpw_nn not null);

-- create sequence
create sequence attendance.emp_empno_seq
    start with 1
    increment by 1
    maxvalue 999999
    nocache
    nocycle;

create sequence attendance.comntc_comntcno_seq
    start with 1
    increment by 1
    maxvalue 99999
    nocache
    nocycle;
    
create sequence attendance.pubntc_pubntcno_seq
    start with 1
    increment by 1
    maxvalue 99999
    nocache
    nocycle;

create sequence attendance.ask_askno_seq
    start with 1
    increment by 1
    maxvalue 99999
    nocache
    nocycle;

create sequence attendance.work_workno_seq
    start with 1
    increment by 1
    maxvalue 99999
    nocache
    nocycle;
    
create sequence attendance.hol_holno_seq
    start with 1
    increment by 1
    maxvalue 99999
    nocache
    nocycle;

create sequence attendance.plan_planno_seq
    start with 1
    increment by 1
    maxvalue 99999
    nocache
    nocycle;

-- insert into users
-- companys
insert into attendance.companys values('company', 'company', '하나웍스', 1234567891, '서울시 영등포구 신풍로 101',
'601호', 12554, '0228465678', 'java123@naver.com','김소피아');
insert into attendance.companys values('company2', 'company2', '하나제약', 1234554321, '서울시 관악구 신림로 201',
'401호', 12555, '0228465688', 'java123@naver.com','마르소');

-- employees
insert into attendance.employees values(attendance.emp_empno_seq.nextval, 'user', 'user',
    '송하나', '서울시 관악구 신림로 340', '601호', 34502, '01012345678', 'java123@naver.com',
    '2022-04-01', '팀장', '9510012011111', null, 'company');
insert into attendance.employees values(attendance.emp_empno_seq.nextval, 'user2', 'user2',
    '김민형', '서울시 영등포구 신풍로 340', '601호', 34503, '01038521234', 'java22@naver.com',
    '2022-12-05', '사원', '9709161022222', null, 'company');
insert into attendance.employees values(attendance.emp_empno_seq.nextval, 'user3', 'user3',
    '최서영', '서울시 관악구 신림로 102', '301호', 34504, '01018754315', 'java13@naver.com',
    '2020-03-29', '주임', '9707212033333', null, 'company');
insert into attendance.employees values(attendance.emp_empno_seq.nextval, 'user4', 'user4',
    '이선재', '서울시 관악구 신림로 103', '103호', 34505, '01056891245', 'java44@naver.com',
    '2010-03-01', '과장', '9211051055555', null, 'company2');
insert into attendance.employees values(attendance.emp_empno_seq.nextval, 'user5', 'user5',
    '오진성', '서울시 관악구 신림로 104', '104호', 34506, '01045678451', 'java55@naver.com',
    '2005-03-01', '부장', '9303021066666', null, 'company2');

-- plans
insert into attendance.plans values(attendance.plan_planno_seq.nextval, '회식', '2023-04-03', '이젠 삼겹살 16:00', 'company');
insert into attendance.plans values(attendance.plan_planno_seq.nextval, '산악회', '2023-04-16', '관악산', 'company2');

-- holidays

insert into attendance.holidays values(attendance.hol_holno_seq.nextval, '2023-03-27', '개인사유', 2);
insert into attendance.holidays values(attendance.hol_holno_seq.nextval, '2023-04-08', '개인사유', 4);
insert into attendance.holidays values(attendance.hol_holno_seq.nextval, '2023-04-14', '개인사유', 5);
insert into attendance.holidays values(attendance.hol_holno_seq.nextval, '2023-04-16', '개인사유', 5);
insert into attendance.holidays values(attendance.hol_holno_seq.nextval, '2023-04-20', '개인사유', 3);
insert into attendance.holidays values(attendance.hol_holno_seq.nextval, '2023-04-27', '개인사유', 2);
insert into attendance.holidays values(attendance.hol_holno_seq.nextval, '2023-05-04', '개인사유', 3);
insert into attendance.holidays values(attendance.hol_holno_seq.nextval, '2023-05-10', '개인사유', 4);
insert into attendance.holidays values(attendance.hol_holno_seq.nextval, '2023-05-14', '개인사유', 5);
insert into attendance.holidays values(attendance.hol_holno_seq.nextval, '2023-05-16', '개인사유', 5);
insert into attendance.holidays values(attendance.hol_holno_seq.nextval, '2023-05-20', '개인사유', 3);

-- admins
insert into attendance.admins values('admin', 'admin');

commit;
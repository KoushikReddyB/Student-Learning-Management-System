BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "django_migrations" (
	"id"	integer NOT NULL,
	"app"	varchar(255) NOT NULL,
	"name"	varchar(255) NOT NULL,
	"applied"	datetime NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "django_content_type" (
	"id"	integer NOT NULL,
	"app_label"	varchar(100) NOT NULL,
	"model"	varchar(100) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_group_permissions" (
	"id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_permission" (
	"id"	integer NOT NULL,
	"content_type_id"	integer NOT NULL,
	"codename"	varchar(100) NOT NULL,
	"name"	varchar(255) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_group" (
	"id"	integer NOT NULL,
	"name"	varchar(150) NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "custom_user_table" (
	"id"	integer NOT NULL,
	"password"	varchar(128) NOT NULL,
	"last_login"	datetime,
	"is_superuser"	bool NOT NULL,
	"username"	varchar(150) NOT NULL UNIQUE,
	"first_name"	varchar(150) NOT NULL,
	"last_name"	varchar(150) NOT NULL,
	"email"	varchar(254) NOT NULL,
	"is_staff"	bool NOT NULL,
	"is_active"	bool NOT NULL,
	"date_joined"	datetime NOT NULL,
	"user_type"	varchar(50) NOT NULL,
	"profile_pic"	varchar(100) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "custom_user_table_groups" (
	"id"	integer NOT NULL,
	"customuser_id"	bigint NOT NULL,
	"group_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("customuser_id") REFERENCES "custom_user_table"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "custom_user_table_user_permissions" (
	"id"	integer NOT NULL,
	"customuser_id"	bigint NOT NULL,
	"permission_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("customuser_id") REFERENCES "custom_user_table"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "program_table" (
	"id"	integer NOT NULL,
	"name"	varchar(100) NOT NULL,
	"created_at"	datetime NOT NULL,
	"updated_at"	datetime NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "session_year_table" (
	"id"	integer NOT NULL,
	"session_start"	varchar(100) NOT NULL,
	"session_end"	varchar(100) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "student_table" (
	"id"	integer NOT NULL,
	"address"	text NOT NULL,
	"gender"	varchar(100) NOT NULL,
	"created_at"	datetime NOT NULL,
	"updated_at"	datetime NOT NULL,
	"admin_id"	bigint NOT NULL UNIQUE,
	"program_id_id"	bigint NOT NULL,
	"session_year_id_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("admin_id") REFERENCES "custom_user_table"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("session_year_id_id") REFERENCES "session_year_table"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("program_id_id") REFERENCES "program_table"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "staff_table" (
	"id"	integer NOT NULL,
	"address"	text NOT NULL,
	"gender"	varchar(100) NOT NULL,
	"desgination"	varchar(100) NOT NULL,
	"created_at"	datetime NOT NULL,
	"updated_at"	datetime NOT NULL,
	"admin_id"	bigint NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("admin_id") REFERENCES "custom_user_table"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "course_table" (
	"id"	integer NOT NULL,
	"course_code"	varchar(20) NOT NULL,
	"course_title"	varchar(100) NOT NULL,
	"created_at"	datetime NOT NULL,
	"updated_at"	datetime NOT NULL,
	"program_id"	bigint NOT NULL,
	"staff_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("program_id") REFERENCES "program_table"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("staff_id") REFERENCES "staff_table"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "django_admin_log" (
	"id"	integer NOT NULL,
	"object_id"	text,
	"object_repr"	varchar(200) NOT NULL,
	"action_flag"	smallint unsigned NOT NULL CHECK("action_flag" >= 0),
	"change_message"	text NOT NULL,
	"content_type_id"	integer,
	"user_id"	bigint NOT NULL,
	"action_time"	datetime NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "custom_user_table"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "django_session" (
	"session_key"	varchar(40) NOT NULL,
	"session_data"	text NOT NULL,
	"expire_date"	datetime NOT NULL,
	PRIMARY KEY("session_key")
);
CREATE TABLE IF NOT EXISTS "staff_notification_table" (
	"id"	integer NOT NULL,
	"message"	text NOT NULL,
	"created_at"	datetime NOT NULL,
	"staff_id_id"	bigint NOT NULL,
	"status"	integer,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("staff_id_id") REFERENCES "staff_table"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "staff_leave_table" (
	"id"	integer NOT NULL,
	"message"	text NOT NULL,
	"status"	integer NOT NULL,
	"created_at"	datetime NOT NULL,
	"updated_at"	datetime NOT NULL,
	"staff_id_id"	bigint NOT NULL,
	"date"	varchar(50) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("staff_id_id") REFERENCES "staff_table"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "staff_feedback_table" (
	"id"	integer NOT NULL,
	"feedback"	text NOT NULL,
	"feedback_reply"	text NOT NULL,
	"created_at"	datetime NOT NULL,
	"updated_at"	datetime NOT NULL,
	"staff_id_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("staff_id_id") REFERENCES "staff_table"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "student_notification_table" (
	"id"	integer NOT NULL,
	"message"	text NOT NULL,
	"status"	integer,
	"created_at"	datetime NOT NULL,
	"student_id_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("student_id_id") REFERENCES "student_table"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "student_feedback_table" (
	"id"	integer NOT NULL,
	"feedback"	text NOT NULL,
	"feedback_reply"	text NOT NULL,
	"created_at"	datetime NOT NULL,
	"updated_at"	datetime NOT NULL,
	"student_id_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("student_id_id") REFERENCES "student_table"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "student_leave_table" (
	"id"	integer NOT NULL,
	"date"	varchar(50) NOT NULL,
	"message"	text NOT NULL,
	"status"	integer NOT NULL,
	"created_at"	datetime NOT NULL,
	"updated_at"	datetime NOT NULL,
	"student_id_id"	bigint NOT NULL,
	FOREIGN KEY("student_id_id") REFERENCES "student_table"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "attendance_table" (
	"id"	integer NOT NULL,
	"attendance_date"	date NOT NULL,
	"created_at"	datetime NOT NULL,
	"updated_at"	datetime NOT NULL,
	"course_id_id"	bigint NOT NULL,
	"session_year_id_id"	bigint NOT NULL,
	FOREIGN KEY("session_year_id_id") REFERENCES "session_year_table"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("course_id_id") REFERENCES "course_table"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "attendance_report_table" (
	"id"	integer NOT NULL,
	"created_at"	datetime NOT NULL,
	"updated_at"	datetime NOT NULL,
	"attendance_id_id"	bigint NOT NULL,
	"student_id_id"	bigint NOT NULL,
	FOREIGN KEY("attendance_id_id") REFERENCES "attendance_table"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("student_id_id") REFERENCES "student_table"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (1,'contenttypes','0001_initial','2023-10-05 04:02:07.984885'),
 (2,'contenttypes','0002_remove_content_type_name','2023-10-05 04:02:08.002595'),
 (3,'auth','0001_initial','2023-10-05 04:02:08.027201'),
 (4,'auth','0002_alter_permission_name_max_length','2023-10-05 04:02:08.043221'),
 (5,'auth','0003_alter_user_email_max_length','2023-10-05 04:02:08.051304'),
 (6,'auth','0004_alter_user_username_opts','2023-10-05 04:02:08.064820'),
 (7,'auth','0005_alter_user_last_login_null','2023-10-05 04:02:08.070317'),
 (8,'auth','0006_require_contenttypes_0002','2023-10-05 04:02:08.087766'),
 (9,'auth','0007_alter_validators_add_error_messages','2023-10-05 04:02:08.095969'),
 (10,'auth','0008_alter_user_username_max_length','2023-10-05 04:02:08.112114'),
 (11,'auth','0009_alter_user_last_name_max_length','2023-10-05 04:02:08.144499'),
 (12,'auth','0010_alter_group_name_max_length','2023-10-05 04:02:08.166092'),
 (13,'auth','0011_update_proxy_permissions','2023-10-05 04:02:08.177695'),
 (14,'auth','0012_alter_user_first_name_max_length','2023-10-05 04:02:08.185721'),
 (15,'app','0001_initial','2023-10-05 04:02:08.252228'),
 (16,'admin','0001_initial','2023-10-05 04:02:08.276089'),
 (17,'admin','0002_logentry_remove_auto_add','2023-10-05 04:02:08.308773'),
 (18,'admin','0003_logentry_add_action_flag_choices','2023-10-05 04:02:08.325210'),
 (19,'sessions','0001_initial','2023-10-05 04:02:08.337001'),
 (20,'app','0002_staff_notifications','2023-10-07 16:06:51.369373'),
 (21,'app','0003_staff_notifications_status','2023-10-08 04:21:49.915425'),
 (22,'app','0004_staff_leave','2023-10-08 15:01:40.396083'),
 (23,'app','0005_rename_data_staff_leave_date','2023-10-08 15:18:23.450833'),
 (24,'app','0006_alter_staff_leave_date','2023-10-08 15:20:52.299443'),
 (25,'app','0007_staff_feedback','2023-10-10 02:53:43.204478'),
 (26,'app','0008_student_notifications','2023-10-14 20:21:00.510339'),
 (27,'app','0009_student_feedback','2023-10-14 20:55:05.723410'),
 (28,'app','0010_student_leave','2023-10-14 21:24:32.347111'),
 (29,'app','0011_attendance_attendance_report','2023-10-14 21:41:38.153056');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (1,'admin','logentry'),
 (2,'auth','permission'),
 (3,'auth','group'),
 (4,'contenttypes','contenttype'),
 (5,'sessions','session'),
 (6,'app','customuser'),
 (7,'app','program'),
 (8,'app','session_year'),
 (9,'app','student'),
 (10,'app','staff'),
 (11,'app','course'),
 (12,'app','staff_notifications'),
 (13,'app','staff_leave'),
 (14,'app','staff_feedback'),
 (15,'app','student_notifications'),
 (16,'app','student_feedback'),
 (17,'app','student_leave'),
 (18,'app','attendance'),
 (19,'app','attendance_report');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (1,1,'add_logentry','Can add log entry'),
 (2,1,'change_logentry','Can change log entry'),
 (3,1,'delete_logentry','Can delete log entry'),
 (4,1,'view_logentry','Can view log entry'),
 (5,2,'add_permission','Can add permission'),
 (6,2,'change_permission','Can change permission'),
 (7,2,'delete_permission','Can delete permission'),
 (8,2,'view_permission','Can view permission'),
 (9,3,'add_group','Can add group'),
 (10,3,'change_group','Can change group'),
 (11,3,'delete_group','Can delete group'),
 (12,3,'view_group','Can view group'),
 (13,4,'add_contenttype','Can add content type'),
 (14,4,'change_contenttype','Can change content type'),
 (15,4,'delete_contenttype','Can delete content type'),
 (16,4,'view_contenttype','Can view content type'),
 (17,5,'add_session','Can add session'),
 (18,5,'change_session','Can change session'),
 (19,5,'delete_session','Can delete session'),
 (20,5,'view_session','Can view session'),
 (21,6,'add_customuser','Can add custom user'),
 (22,6,'change_customuser','Can change custom user'),
 (23,6,'delete_customuser','Can delete custom user'),
 (24,6,'view_customuser','Can view custom user'),
 (25,7,'add_program','Can add program'),
 (26,7,'change_program','Can change program'),
 (27,7,'delete_program','Can delete program'),
 (28,7,'view_program','Can view program'),
 (29,8,'add_session_year','Can add session_ year'),
 (30,8,'change_session_year','Can change session_ year'),
 (31,8,'delete_session_year','Can delete session_ year'),
 (32,8,'view_session_year','Can view session_ year'),
 (33,9,'add_student','Can add student'),
 (34,9,'change_student','Can change student'),
 (35,9,'delete_student','Can delete student'),
 (36,9,'view_student','Can view student'),
 (37,10,'add_staff','Can add staff'),
 (38,10,'change_staff','Can change staff'),
 (39,10,'delete_staff','Can delete staff'),
 (40,10,'view_staff','Can view staff'),
 (41,11,'add_course','Can add course'),
 (42,11,'change_course','Can change course'),
 (43,11,'delete_course','Can delete course'),
 (44,11,'view_course','Can view course'),
 (45,12,'add_staff_notifications','Can add staff_ notifications'),
 (46,12,'change_staff_notifications','Can change staff_ notifications'),
 (47,12,'delete_staff_notifications','Can delete staff_ notifications'),
 (48,12,'view_staff_notifications','Can view staff_ notifications'),
 (49,13,'add_staff_leave','Can add staff_ leave'),
 (50,13,'change_staff_leave','Can change staff_ leave'),
 (51,13,'delete_staff_leave','Can delete staff_ leave'),
 (52,13,'view_staff_leave','Can view staff_ leave'),
 (53,14,'add_staff_feedback','Can add staff_ feedback'),
 (54,14,'change_staff_feedback','Can change staff_ feedback'),
 (55,14,'delete_staff_feedback','Can delete staff_ feedback'),
 (56,14,'view_staff_feedback','Can view staff_ feedback'),
 (57,15,'add_student_notifications','Can add student_ notifications'),
 (58,15,'change_student_notifications','Can change student_ notifications'),
 (59,15,'delete_student_notifications','Can delete student_ notifications'),
 (60,15,'view_student_notifications','Can view student_ notifications'),
 (61,16,'add_student_feedback','Can add student_ feedback'),
 (62,16,'change_student_feedback','Can change student_ feedback'),
 (63,16,'delete_student_feedback','Can delete student_ feedback'),
 (64,16,'view_student_feedback','Can view student_ feedback'),
 (65,17,'add_student_leave','Can add student_ leave'),
 (66,17,'change_student_leave','Can change student_ leave'),
 (67,17,'delete_student_leave','Can delete student_ leave'),
 (68,17,'view_student_leave','Can view student_ leave'),
 (69,18,'add_attendance','Can add attendance'),
 (70,18,'change_attendance','Can change attendance'),
 (71,18,'delete_attendance','Can delete attendance'),
 (72,18,'view_attendance','Can view attendance'),
 (73,19,'add_attendance_report','Can add attendance_ report'),
 (74,19,'change_attendance_report','Can change attendance_ report'),
 (75,19,'delete_attendance_report','Can delete attendance_ report'),
 (76,19,'view_attendance_report','Can view attendance_ report');
INSERT INTO "custom_user_table" ("id","password","last_login","is_superuser","username","first_name","last_name","email","is_staff","is_active","date_joined","user_type","profile_pic") VALUES (1,'pbkdf2_sha256$600000$b6KAovecsumSNwoTj0M1U2$sovPMuEfdKiWhVqPmEAeniN614iS6MpBptJP2h8fPlw=','2023-10-15 06:23:03.993425',1,'admin','Zap','Zura','admin@sdp18.in',1,1,'2023-10-05 04:02:30.650989','1','media/profile_pics/wallpaperflare.com_wallpaper.jpg'),
 (2,'pbkdf2_sha256$600000$hhfOofE1uLYPAWF9o2iDn2$9g3IVUL0IXJzQeBjfl3wXWXn9nxhms9Mfcc+An6J834=','2023-10-15 06:07:52.967511',0,'S001_Harshith_N','Harshith','N','S001@sdp18.in',0,1,'2023-10-05 04:32:27.720710','2','media/profile_pics/Male.jpg'),
 (3,'pbkdf2_sha256$600000$aPoPuXsWTxSiUBP2AbSyD0$HF9H7/wLhP2778Ra62JuQzhDqGCyKah7YEcKnVp2oio=',NULL,0,'S002_Akhila_K','Akhila','K','S002@spd18.in',0,1,'2023-10-05 04:34:44.782703','2','media/profile_pics/female.png'),
 (4,'pbkdf2_sha256$600000$69ltjhoKbzGemTfYuky5JK$Gn0ma5DL3pwtpL5c2wQpfZXnJrn5nIFhq3FL6nutYls=','2023-10-15 06:09:13.464334',0,'0001_Asmathunnisa_Begum','Asmathunnisa','Begum','0001@sdp18.in',0,1,'2023-10-05 04:37:59.622537','3','media/profile_pics/female_hjorHxZ.png'),
 (5,'pbkdf2_sha256$600000$LndU0qif6JowspiutYmp3B$GwHKjjv1UkHCr87LLb5+B/RvvBozjvRZCVC3nFwHC9Y=',NULL,0,'0002_Rahul_Kumar_S','Rahul ','Kumar S','0002@sdp18.in',0,1,'2023-10-05 04:41:41.055815','3','media/profile_pics/Apeksha.png'),
 (6,'pbkdf2_sha256$600000$UUj2FS7pikMeVk7hp4Xw9m$AokgeFsyDtH/kK2/socmm8mXED8e+yxJU5Z3rky3q0I=',NULL,0,'0003_Pathan_Vasiya','Vasiya','Pathan','0003@sdp18.in',0,1,'2023-10-05 04:42:32.861668','3','media/profile_pics/female_SWrXfpN.png'),
 (7,'pbkdf2_sha256$600000$G4mZdMbQW0RZLJ2WvIJyrQ$niYaYKKNBgKmmGOJX6wpiQWUTuVqWeuBtnPWLvR3hGI=',NULL,0,'0004_RJ_Honey','RJ','Honey','0004@sdp18.in',0,1,'2023-10-05 04:43:19.706113','3','media/profile_pics/female_cKfMZGV.png'),
 (8,'pbkdf2_sha256$600000$gsQJ1cAZYMuaqVid8hsLR5$NTpDT9iwnVYabapTS/OKYgoN+tGULTLdUzqOAanzIAk=',NULL,0,'0006_Hema_Pushpa','Hema','Pushpa ','0006@sdp18.in',0,1,'2023-10-05 04:44:25.211205','3','media/profile_pics/female_VZVK1Rt.png'),
 (9,'pbkdf2_sha256$600000$xElfuH83vUaS79df8naYPF$NgaFTyzK3hNyWClflhuOGcfeFEn61BnhAnLY9Un00tU=',NULL,0,'0007_Jyosthna_Y','Jyosthna','Y','0007@sdp18.in',0,1,'2023-10-05 04:45:33.880182','3','media/profile_pics/female_H8MRyXg.png');
INSERT INTO "program_table" ("id","name","created_at","updated_at") VALUES (1,'B. Tech','2023-10-05 04:27:38.795655','2023-10-05 04:27:38.795655'),
 (2,'M. Tech','2023-10-05 04:27:44.013351','2023-10-05 04:27:44.013351'),
 (3,'BBA','2023-10-05 04:27:46.894566','2023-10-05 04:27:46.894566'),
 (4,'BCA','2023-10-05 04:27:49.766540','2023-10-05 04:27:49.766540'),
 (5,'Arts','2023-10-05 04:27:54.281309','2023-10-05 04:27:54.281309'),
 (6,'BCom','2023-10-05 04:27:58.628163','2023-10-05 04:27:58.628163'),
 (7,'BSE','2023-10-05 04:28:04.564843','2023-10-05 04:28:04.564843');
INSERT INTO "session_year_table" ("id","session_start","session_end") VALUES (1,'2019','2023'),
 (2,'2020','2024'),
 (3,'2021','2025'),
 (4,'2022','2026'),
 (5,'2023','2027');
INSERT INTO "student_table" ("id","address","gender","created_at","updated_at","admin_id","program_id_id","session_year_id_id") VALUES (1,'NTR Circle, Guntur','Female','2023-10-05 04:38:00.691282','2023-10-05 04:38:00.691282',4,1,4),
 (2,'Kanuru, Vijayawada
','Male','2023-10-05 04:41:42.053968','2023-10-05 04:41:42.053968',5,1,1),
 (3,'Tenali','Female','2023-10-05 04:42:33.939142','2023-10-05 04:42:33.939142',6,1,4),
 (4,'KL Radio','Female','2023-10-05 04:43:20.670313','2023-10-05 04:43:20.670313',7,1,4),
 (5,'Bus Stand, Guntur','Female','2023-10-05 04:44:26.204003','2023-10-05 04:44:26.204003',8,1,5),
 (6,'Labbipet, Vijaywada','Female','2023-10-05 04:45:34.868436','2023-10-05 04:45:34.868436',9,1,5);
INSERT INTO "staff_table" ("id","address","gender","desgination","created_at","updated_at","admin_id") VALUES (1,'Batman''s Back House ','Male','Professor of Valorant','2023-10-05 04:32:28.691305','2023-10-05 04:32:28.691305',2),
 (2,'Headquarters ','Female','Professor ','2023-10-05 04:34:45.738175','2023-10-05 04:34:45.738175',3);
INSERT INTO "course_table" ("id","course_code","course_title","created_at","updated_at","program_id","staff_id") VALUES (1,'23GM8920','Basics of Valorant','2023-10-05 04:33:10.463974','2023-10-05 04:33:10.463974',1,1),
 (2,'21EC2210','Computer Networks and Security','2023-10-05 04:35:17.018779','2023-10-05 04:35:17.018779',1,2),
 (3,'22EC2210A','Network Protocols and Security','2023-10-05 04:35:47.220088','2023-10-05 04:35:47.220088',1,2),
 (4,'22EC2210R','Network Protocols and Security ( R ) ','2023-10-05 04:36:14.831640','2023-10-05 04:36:14.831640',1,2),
 (5,'22EC2210P','Network Protocols and Security ( P )','2023-10-05 04:36:41.959519','2023-10-05 04:36:41.959519',1,2);
INSERT INTO "django_admin_log" ("id","object_id","object_repr","action_flag","change_message","content_type_id","user_id","action_time") VALUES (1,'1','Harshith',2,'[]',12,1,'2023-10-08 04:34:10.641008'),
 (2,'2','Akhila',2,'[]',12,1,'2023-10-08 04:34:13.098987'),
 (3,'2','Akhila',2,'[{"changed": {"fields": ["Status"]}}]',12,1,'2023-10-08 04:35:23.188683'),
 (4,'2','Akhila',2,'[{"changed": {"fields": ["Status"]}}]',12,1,'2023-10-08 04:35:34.345487'),
 (5,'1','Harshith',2,'[{"changed": {"fields": ["Status"]}}]',12,1,'2023-10-08 08:24:22.642904'),
 (6,'1','Harshith',2,'[{"changed": {"fields": ["Status"]}}]',12,1,'2023-10-08 08:26:34.231548'),
 (7,'1','Harshith',2,'[{"changed": {"fields": ["Status"]}}]',12,1,'2023-10-08 08:28:03.037611'),
 (8,'1','Harshith',2,'[{"changed": {"fields": ["Status"]}}]',12,1,'2023-10-08 08:30:51.092223'),
 (9,'1','Harshith',2,'[{"changed": {"fields": ["Status"]}}]',12,1,'2023-10-08 09:44:11.923439'),
 (10,'1','HarshithN',3,'',13,1,'2023-10-09 01:42:29.884033'),
 (11,'2','HarshithN',2,'[]',13,1,'2023-10-09 01:42:40.146916'),
 (12,'2','HarshithN',2,'[{"changed": {"fields": ["Status"]}}]',13,1,'2023-10-09 14:06:41.502571'),
 (13,'2','HarshithN',2,'[{"changed": {"fields": ["Status"]}}]',13,1,'2023-10-09 14:06:51.516232'),
 (14,'2','HarshithN',2,'[{"changed": {"fields": ["Status"]}}]',13,1,'2023-10-09 14:07:38.539106'),
 (15,'2','HarshithN',2,'[{"changed": {"fields": ["Status"]}}]',13,1,'2023-10-09 14:20:32.694318'),
 (16,'2','HarshithN',2,'[{"changed": {"fields": ["Status"]}}]',13,1,'2023-10-09 14:20:47.777957'),
 (17,'2','HarshithN',2,'[{"changed": {"fields": ["Status"]}}]',13,1,'2023-10-09 14:51:35.123888'),
 (18,'2','HarshithN',2,'[{"changed": {"fields": ["Status"]}}]',13,1,'2023-10-09 14:52:09.683714'),
 (19,'3','Harshith',3,'',12,1,'2023-10-10 03:15:01.038516'),
 (20,'3','HarshithN',3,'',13,1,'2023-10-10 03:15:16.087526'),
 (21,'1','S001_Harshith_N',3,'',14,1,'2023-10-10 03:19:25.984427'),
 (22,'2','S001_Harshith_N',2,'[{"changed": {"fields": ["Feedback reply"]}}]',14,1,'2023-10-12 04:39:57.137785'),
 (23,'2','S001_Harshith_N',2,'[{"changed": {"fields": ["Feedback reply"]}}]',14,1,'2023-10-12 04:48:22.548696'),
 (24,'2','HarshithN',2,'[{"changed": {"fields": ["Status"]}}]',13,1,'2023-10-12 04:55:01.754790'),
 (25,'2','HarshithN',2,'[{"changed": {"fields": ["Status"]}}]',13,1,'2023-10-12 04:56:35.391582'),
 (26,'2','HarshithN',2,'[{"changed": {"fields": ["Status"]}}]',13,1,'2023-10-12 04:56:54.892012'),
 (27,'3','S001_Harshith_N',3,'',14,1,'2023-10-12 04:57:22.612580');
INSERT INTO "django_session" ("session_key","session_data","expire_date") VALUES ('huktct4q09iv2dccpfwlrw5j2j27rj7y','.eJxVjEEOwiAQRe_C2hCGUgou3fcMBGamUjWQlHZlvLsh6UK3_7333yLEY8_haLyFlcRVgLj8binik0sH9IjlXiXWsm9rkl2RJ21yrsSv2-n-HeTYcq-NB0ICMmRM1AhakbUJFmURjVODZe_Q2DHFQaNTCyM4GCY_MaN2o_h8AefiN8s:1qoGA5:YNAx1N5eP__FfbJKeOZ2BxezRn0YqzFtzmIVrApdhZ4','2023-10-19 04:40:33.528160'),
 ('f7lakp25c36hkgufc6g4tfj0027agtu8','.eJxVjEEOwiAQRe_C2hCGUgou3fcMBGamUjWQlHZlvLsh6UK3_7333yLEY8_haLyFlcRVgLj8binik0sH9IjlXiXWsm9rkl2RJ21yrsSv2-n-HeTYcq-NB0ICMmRM1AhakbUJFmURjVODZe_Q2DHFQaNTCyM4GCY_MaN2o_h8AefiN8s:1qoQZa:abSROdaOY-u1-Z5l5R29G_TVCYcnQaSX-bA-r2DLgs0','2023-10-19 15:47:34.425394'),
 ('hrux4zd0in3vowc0s0gtch75zusga2lz','.eJxVjDsOwyAQBe9CHaHlZ0PK9D4DWlgITiKQjF1FuXuE5CJp38y8N_N47MUfPW1-JXZlkl1-t4DxmeoA9MB6bzy2um9r4EPhJ-18aZRet9P9OyjYy6jNHJMQWUMwzoEAO2srHUw2qGwQMk1BK62M1VnJKMkRQBAOMFKKaNjnC7_WN2U:1qoxh5:kSPq0rwSNdvQBTsdBEolS6AUztcm6ur54pfqf17qDYM','2023-10-21 03:09:31.457061'),
 ('cdtjtnfuufk3hp6fzmy2cth218aknaxa','.eJxVjEEOwiAQRe_C2hCGUgou3fcMBGamUjWQlHZlvLsh6UK3_7333yLEY8_haLyFlcRVgLj8binik0sH9IjlXiXWsm9rkl2RJ21yrsSv2-n-HeTYcq-NB0ICMmRM1AhakbUJFmURjVODZe_Q2DHFQaNTCyM4GCY_MaN2o_h8AefiN8s:1qp9ux:71Ddw1NOpmkT4Sqoih4tY3k5PIGulluQ4EdPj__jiLw','2023-10-21 16:12:39.101519'),
 ('8itadotk40fgih2xeuxl9wkhhp1k7678','.eJxVjDsOwyAQBe9CHaHlZ0PK9D4DWlgITiKQjF1FuXuE5CJp38y8N_N47MUfPW1-JXZlkl1-t4DxmeoA9MB6bzy2um9r4EPhJ-18aZRet9P9OyjYy6jNHJMQWUMwzoEAO2srHUw2qGwQMk1BK62M1VnJKMkRQBAOMFKKaNjnC7_WN2U:1qpLdO:13HZ_4-gZYtXesv9wJDKh0pvWkJK6gpadpFFl2i5Sto','2023-10-22 04:43:18.413264'),
 ('cw26ep8cnr6zj63bflsexl5uj9fn1q02','.eJxVjDsOwyAQBe9CHaHlZ0PK9D4DWlgITiKQjF1FuXuE5CJp38y8N_N47MUfPW1-JXZlkl1-t4DxmeoA9MB6bzy2um9r4EPhJ-18aZRet9P9OyjYy6jNHJMQWUMwzoEAO2srHUw2qGwQMk1BK62M1VnJKMkRQBAOMFKKaNjnC7_WN2U:1qpWF2:M_socDrclvvR7H6G8iw2VCjzv93jFosulMvXXk5sLAU','2023-10-22 16:02:52.205007'),
 ('0jpo82yhypdgfvqm2ho03srdap3mhv0d','.eJxVjEEOwiAQRe_C2hCGUgou3fcMBGamUjWQlHZlvLsh6UK3_7333yLEY8_haLyFlcRVgLj8binik0sH9IjlXiXWsm9rkl2RJ21yrsSv2-n-HeTYcq-NB0ICMmRM1AhakbUJFmURjVODZe_Q2DHFQaNTCyM4GCY_MaN2o_h8AefiN8s:1qpn00:YbY8IxYZp64QI0YkTYwvOacWoOvuCkJOFEoFp7xhcFc','2023-10-23 09:56:28.195310'),
 ('ftjskh4jiesgng2t1qf7cg38qw1vxu2p','.eJxVjDsOwyAQBe9CHaHlZ0PK9D4DWlgITiKQjF1FuXuE5CJp38y8N_N47MUfPW1-JXZlkl1-t4DxmeoA9MB6bzy2um9r4EPhJ-18aZRet9P9OyjYy6jNHJMQWUMwzoEAO2srHUw2qGwQMk1BK62M1VnJKMkRQBAOMFKKaNjnC7_WN2U:1qprcY:1mq4wGkkW1sDoirbhKYse4lsuePeY-gqhwLYuiuhBQA','2023-10-23 14:52:34.609820'),
 ('mzzw3uwtzxdupzce7pqd2w1b2phsezol','.eJxVjDsOwyAQBe9CHaHlZ0PK9D4DWlgITiKQjF1FuXuE5CJp38y8N_N47MUfPW1-JXZlkl1-t4DxmeoA9MB6bzy2um9r4EPhJ-18aZRet9P9OyjYy6jNHJMQWUMwzoEAO2srHUw2qGwQMk1BK62M1VnJKMkRQBAOMFKKaNjnC7_WN2U:1qq3HU:WIzigdIdEwT_RMgtydKfnOR7IH8OSfCmbNyISRMMcwI','2023-10-24 03:19:36.668528'),
 ('4fy2pcpfk3g8gxiesyyd89f3cw7brp1n','.eJxVjEEOwiAQRe_C2hCGUgou3fcMBGamUjWQlHZlvLsh6UK3_7333yLEY8_haLyFlcRVgLj8binik0sH9IjlXiXWsm9rkl2RJ21yrsSv2-n-HeTYcq-NB0ICMmRM1AhakbUJFmURjVODZe_Q2DHFQaNTCyM4GCY_MaN2o_h8AefiN8s:1qq6qJ:EHnYHUoObGtuaOHh2RorKGHnNqg9sghA8DSHZ6i2h9E','2023-10-24 07:07:47.432417'),
 ('rcwov4f2f99e3fdtz4ffd7hwet6zgg91','.eJxVjEEOwiAQRe_C2hCGUgou3fcMBGamUjWQlHZlvLsh6UK3_7333yLEY8_haLyFlcRVgLj8binik0sH9IjlXiXWsm9rkl2RJ21yrsSv2-n-HeTYcq-NB0ICMmRM1AhakbUJFmURjVODZe_Q2DHFQaNTCyM4GCY_MaN2o_h8AefiN8s:1qqUmo:0ZVrH8CMDuON0183IOA9FVwL5n6PZTwO5Bu7v8d0fJ8','2023-10-25 08:41:46.799448'),
 ('x42p8e9tmahyyov3qk49bqhdvh7k4gqh','.eJxVjEEOwiAQRe_C2hCGUgou3fcMBGamUjWQlHZlvLsh6UK3_7333yLEY8_haLyFlcRVgLj8binik0sH9IjlXiXWsm9rkl2RJ21yrsSv2-n-HeTYcq-NB0ICMmRM1AhakbUJFmURjVODZe_Q2DHFQaNTCyM4GCY_MaN2o_h8AefiN8s:1qqndu:5fr_1RPOfMbKJNVSeOzCK5NiEolaLK-2GLBD8cuC2JY','2023-10-26 04:49:50.890216'),
 ('iahmpjms6x1542ef23p42bfqsb8ibjj7','.eJxVjMsOwiAQRf-FtSHlDS7d-w1kGBipGkhKuzL-uzbpQrf3nHNfLMK21riNssQ5szPT7PS7JcBHaTvId2i3zrG3dZkT3xV-0MGvPZfn5XD_DiqM-q2RpEtCG-Otl1YQGBJAgcxkCZJGjc5mJVFkVRyRCskHp4qQwdnJlczeH-dxN-0:1qrpAL:lRmpZgT1jHgk78UaF7sQ2MCogdMaoPfIT_jUetEIb2E','2023-10-29 00:39:33.046500'),
 ('m1wdt7pgt651vi6j43n2g9h1xlw9of3v','.eJxVjEEOwiAQRe_C2hCGUgou3fcMBGamUjWQlHZlvLsh6UK3_7333yLEY8_haLyFlcRVgLj8binik0sH9IjlXiXWsm9rkl2RJ21yrsSv2-n-HeTYcq-NB0ICMmRM1AhakbUJFmURjVODZe_Q2DHFQaNTCyM4GCY_MaN2o_h8AefiN8s:1qrq8u:AQhH06z6S15zWZNhrD65FcF_f3ZxvdWcSpq8H3mMYkw','2023-10-29 01:42:08.716906'),
 ('do0v6g5xsofixsnv542ifvdnnfc7hx6k','.eJxVjEEOwiAQRe_C2hCGUgou3fcMBGamUjWQlHZlvLsh6UK3_7333yLEY8_haLyFlcRVgLj8binik0sH9IjlXiXWsm9rkl2RJ21yrsSv2-n-HeTYcq-NB0ICMmRM1AhakbUJFmURjVODZe_Q2DHFQaNTCyM4GCY_MaN2o_h8AefiN8s:1qruWl:96biuFXb60DT0XpkaBMfo6sQFal2hiqPcpGPQkDQBXg','2023-10-29 06:23:03.732672');
INSERT INTO "staff_notification_table" ("id","message","created_at","staff_id_id","status") VALUES (1,'Meet me in the cabin','2023-10-08 04:11:15.973730',1,1),
 (2,'Submit the reports by next week','2023-10-08 04:13:55.398471',2,0),
 (4,'Submit your copies in Office','2023-10-15 06:24:34.142209',2,0);
INSERT INTO "staff_leave_table" ("id","message","status","created_at","updated_at","staff_id_id","date") VALUES (2,'Depression',2,'2023-10-08 16:25:48.229063','2023-10-08 16:25:48.229063',1,'2023-10-08');
INSERT INTO "staff_feedback_table" ("id","feedback","feedback_reply","created_at","updated_at","staff_id_id") VALUES (2,'I am Pro in Valorant','NO_REP','2023-10-10 03:19:50.857037','2023-10-10 03:19:50.857037',1);
INSERT INTO "student_notification_table" ("id","message","status","created_at","student_id_id") VALUES (1,'Submit your Certificates in Office',1,'2023-10-14 20:41:13.552324',1);
INSERT INTO "student_feedback_table" ("id","feedback","feedback_reply","created_at","updated_at","student_id_id") VALUES (1,'Increase Internet Speed','','2023-10-14 21:01:13.215764','2023-10-14 21:01:13.215764',1);
INSERT INTO "student_leave_table" ("id","date","message","status","created_at","updated_at","student_id_id") VALUES (1,'2500-06-11','Not feeling well',1,'2023-10-14 21:28:10.073979','2023-10-14 21:28:10.073979',1);
CREATE UNIQUE INDEX IF NOT EXISTS "django_content_type_app_label_model_76bd3d3b_uniq" ON "django_content_type" (
	"app_label",
	"model"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_group_permissions_group_id_permission_id_0cd325b0_uniq" ON "auth_group_permissions" (
	"group_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_group_id_b120cbf9" ON "auth_group_permissions" (
	"group_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_permission_id_84c5c92e" ON "auth_group_permissions" (
	"permission_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_permission_content_type_id_codename_01ab375a_uniq" ON "auth_permission" (
	"content_type_id",
	"codename"
);
CREATE INDEX IF NOT EXISTS "auth_permission_content_type_id_2f476e4b" ON "auth_permission" (
	"content_type_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "custom_user_table_groups_customuser_id_group_id_52cd8478_uniq" ON "custom_user_table_groups" (
	"customuser_id",
	"group_id"
);
CREATE INDEX IF NOT EXISTS "custom_user_table_groups_customuser_id_3888e02f" ON "custom_user_table_groups" (
	"customuser_id"
);
CREATE INDEX IF NOT EXISTS "custom_user_table_groups_group_id_d4c02639" ON "custom_user_table_groups" (
	"group_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "custom_user_table_user_permissions_customuser_id_permission_id_629da279_uniq" ON "custom_user_table_user_permissions" (
	"customuser_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "custom_user_table_user_permissions_customuser_id_d9d5e9b4" ON "custom_user_table_user_permissions" (
	"customuser_id"
);
CREATE INDEX IF NOT EXISTS "custom_user_table_user_permissions_permission_id_72a2c1b9" ON "custom_user_table_user_permissions" (
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "student_table_program_id_id_4520cab5" ON "student_table" (
	"program_id_id"
);
CREATE INDEX IF NOT EXISTS "student_table_session_year_id_id_784addc9" ON "student_table" (
	"session_year_id_id"
);
CREATE INDEX IF NOT EXISTS "course_table_program_id_0da13d80" ON "course_table" (
	"program_id"
);
CREATE INDEX IF NOT EXISTS "course_table_staff_id_3bba360e" ON "course_table" (
	"staff_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_content_type_id_c4bce8eb" ON "django_admin_log" (
	"content_type_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_user_id_c564eba6" ON "django_admin_log" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "django_session_expire_date_a5c62663" ON "django_session" (
	"expire_date"
);
CREATE INDEX IF NOT EXISTS "staff_notification_table_staff_id_id_49597632" ON "staff_notification_table" (
	"staff_id_id"
);
CREATE INDEX IF NOT EXISTS "staff_leave_table_staff_id_id_2629f880" ON "staff_leave_table" (
	"staff_id_id"
);
CREATE INDEX IF NOT EXISTS "staff_feedback_table_staff_id_id_fd6a6227" ON "staff_feedback_table" (
	"staff_id_id"
);
CREATE INDEX IF NOT EXISTS "student_notification_table_student_id_id_bed236a3" ON "student_notification_table" (
	"student_id_id"
);
CREATE INDEX IF NOT EXISTS "student_feedback_table_student_id_id_47c43f5d" ON "student_feedback_table" (
	"student_id_id"
);
CREATE INDEX IF NOT EXISTS "student_leave_table_student_id_id_588323a0" ON "student_leave_table" (
	"student_id_id"
);
CREATE INDEX IF NOT EXISTS "attendance_table_course_id_id_98e03699" ON "attendance_table" (
	"course_id_id"
);
CREATE INDEX IF NOT EXISTS "attendance_table_session_year_id_id_3a0ac569" ON "attendance_table" (
	"session_year_id_id"
);
CREATE INDEX IF NOT EXISTS "attendance_report_table_attendance_id_id_bce52551" ON "attendance_report_table" (
	"attendance_id_id"
);
CREATE INDEX IF NOT EXISTS "attendance_report_table_student_id_id_3d43f4ae" ON "attendance_report_table" (
	"student_id_id"
);
COMMIT;

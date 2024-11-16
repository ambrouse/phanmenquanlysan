create database test_app_android_quanlysan_16
go
use test_app_android_quanlysan_16

go
create table user_(
	id_ varchar(60) primary key,
	name_ nvarchar(255),
	mail_ nvarchar (255),
	phone_ varchar(10),
	password_ nvarchar(255),
	status_delete_ tinyint,
	day_delete_ datetime
)

go
create table admin_(
	id_ varchar(60) primary key,
	name_ nvarchar(255),
	mail_ nvarchar(255),
	phone_ nvarchar(255),
	password_ nvarchar(255),
	status_delete_ tinyint,
	day_delete_ datetime,
	id_role_ varchar(60)
)

go
create table role_(
	id_ varchar(60) primary key,
	day_delete_ datetime,
	id_role_ varchar(60),
	name_ nvarchar(255)
)

go 
create table yard_(
	id_ varchar(60) primary key,
	name_ varchar(255),
	address_ nvarchar(255),
	status_ nvarchar(60),
	day_delete_ datetime,
	id_role_ varchar(60)
)

go
create table rent_yard_(
	id_ varchar(60) primary key,
	id_user_ varchar(60),
	id_yard_ varchar(60),
	start_day_ datetime,
	end_day_ datetime,
	status_ nvarchar(60),
	day_delete_ datetime,
	id_role_ varchar(60)
)

go
create table payment_income_(
	id_ varchar(60) primary key,
	id_rent_yard_ varchar(60),
	id_user_ varchar(60),
	payment_day_ datetime,
	day_delete_ datetime,
	id_role_ varchar(60)
)

go
create table complain_(
	id_ varchar(60) primary key,
	id_user_ varchar(60),
	content_ text,
	status_ nvarchar(255),
	day_delete_ datetime,
	id_role_ varchar(60)
)

go
create table notification_admin_(
	id_ varchar(60) primary key,
	id_admin_ varchar(60),
	id_user_ varchar(60),
	content_ text,
	day_delete_ datetime,
	id_role_ varchar(60)
)

go
create table notification_user_(
	id_ varchar(60) primary key,
	id_notification_admin_ varchar(60),
	id_user_ varchar(60),
	content_ text,
	day_delete_ datetime,
	id_role_ varchar(60)
)


go
ALTER TABLE admin_ ADD FOREIGN KEY (id_role_) REFERENCES role_(id_);

go
ALTER TABLE rent_yard_ ADD FOREIGN KEY (id_yard_) REFERENCES yard_(id_);

go
ALTER TABLE rent_yard_ ADD FOREIGN KEY (id_user_) REFERENCES user_(id_);

go
ALTER TABLE payment_income_ ADD FOREIGN KEY (id_rent_yard_) REFERENCES rent_yard_(id_);

go
ALTER TABLE payment_income_ ADD FOREIGN KEY (id_user_) REFERENCES user_(id_);

go
ALTER TABLE complain_ ADD FOREIGN KEY (id_user_) REFERENCES user_(id_); 

go
ALTER TABLE notification_admin_ ADD FOREIGN KEY (id_admin_) REFERENCES admin_(id_);

go
ALTER TABLE notification_admin_ ADD FOREIGN KEY (id_user_) REFERENCES user_(id_);

go
ALTER TABLE notification_user_ ADD FOREIGN KEY (id_notification_admin_) REFERENCES notification_admin_(id_);

go
ALTER TABLE notification_user_ ADD FOREIGN KEY (id_user_) REFERENCES user_(id_);



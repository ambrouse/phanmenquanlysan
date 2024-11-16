CREATE TABLE [user_] (
  [id_] varchar(60) PRIMARY KEY,
  [name_] nvarchar(255),
  [mail_] nvarchar(255),
  [phone_] varchar(10),
  [password_] nvarchar(255),
  [status_delete_] tinyint,
  [day_delete_] datetime
)
GO

CREATE TABLE [admin_] (
  [id_] varchar(60) PRIMARY KEY,
  [name_] nvarchar(255),
  [mail_] nvarchar(255),
  [phone_] nvarchar(255),
  [password_] nvarchar(255),
  [status_delete_] tinyint,
  [day_delete_] datetime,
  [id_role_] varchar(60)
)
GO

CREATE TABLE [role_] (
  [id_] varchar(60) PRIMARY KEY,
  [day_delete_] datetime,
  [id_role_] varchar(60),
  [status_delete_] tinyint,
  [name_] nvarchar(255)
)
GO

CREATE TABLE [yard_] (
  [id_] varchar(60) PRIMARY KEY,
  [name_] varchar(255),
  [id_address_] varchar(60),
  [status_] nvarchar(60),
  [status_delete_] tinyint,
  [day_delete_] datetime
)
GO

CREATE TABLE [rent_yard_] (
  [id_] varchar(60) PRIMARY KEY,
  [id_user_] varchar(60),
  [id_yard_] varchar(60),
  [start_day_] datetime,
  [end_day_] datetime,
  [status_] nvarchar(60),
  [status_delete_] tinyint,
  [day_delete_] datetime
)
GO

CREATE TABLE [complain_] (
  [id_] varchar(60) PRIMARY KEY,
  [id_user_] varchar(60),
  [content_] text,
  [status_] nvarchar(255),
  [status_delete_] tinyint,
  [day_delete_] datetime
)
GO

CREATE TABLE [notification_user_] (
  [id_] varchar(60) PRIMARY KEY,
  [id_admin_] varchar(60),
  [id_user_] varchar(60),
  [content_] text,
  [status_delete_] tinyint,
  [day_delete_] datetime
)
GO

CREATE TABLE [equipment_] (
  [id_] varchar(60) PRIMARY KEY,
  [name_] nvarchar(255),
  [id_address_] varchar(60),
  [desription_] text,
  [status_delete_] tinyint,
  [day_delete_] datetime
)
GO

CREATE TABLE [address_yard_] (
  [id_] varchar(60) PRIMARY KEY,
  [name_] nvarchar(255),
  [status_delete_] tinyint,
  [day_delete_] datetime
)
GO

CREATE TABLE [payment_income_] (
  [id_] varchar(60) PRIMARY KEY,
  [desription_] text,
  [id_rent_yard_] varchar(60),
  [total_] decimal,
  [day_income_] datetime,
  [status_delete_] tinyint,
  [day_delete_] datetime
)
GO

CREATE TABLE [repair_equipment_] (
  [id_] varchar(60) PRIMARY KEY,
  [id_equipment_] varchar(60),
  [total_] decimal,
  [desription_] text,
  [status_delete_] tinyint,
  [day_delete_] datetime
)
GO

ALTER TABLE [admin_] ADD FOREIGN KEY ([id_role_]) REFERENCES [role_] ([id_])
GO

ALTER TABLE [rent_yard_] ADD FOREIGN KEY ([id_yard_]) REFERENCES [yard_] ([id_])
GO

ALTER TABLE [rent_yard_] ADD FOREIGN KEY ([id_user_]) REFERENCES [user_] ([id_])
GO

ALTER TABLE [complain_] ADD FOREIGN KEY ([id_user_]) REFERENCES [user_] ([id_])
GO

ALTER TABLE [notification_user_] ADD FOREIGN KEY ([id_user_]) REFERENCES [user_] ([id_])
GO

ALTER TABLE [notification_user_] ADD FOREIGN KEY ([id_admin_]) REFERENCES [admin_] ([id_])
GO

ALTER TABLE [yard_] ADD FOREIGN KEY ([id_address_]) REFERENCES [address_yard_] ([id_])
GO

ALTER TABLE [equipment_] ADD FOREIGN KEY ([id_address_]) REFERENCES [address_yard_] ([id_])
GO

ALTER TABLE [payment_income_] ADD FOREIGN KEY ([id_rent_yard_]) REFERENCES [rent_yard_] ([id_])
GO

ALTER TABLE [repair_equipment_] ADD FOREIGN KEY ([id_equipment_]) REFERENCES [equipment_] ([id_])
GO

USE ODS

GO

DROP VIEW IF EXISTS StudentPerformance
DROP TABLE IF EXISTS uci.StudentPerformance
DROP SCHEMA IF EXISTS uci



GO

CREATE SCHEMA uci

GO

DROP TABLE IF EXISTS uci.StudentPerformance
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TABLE uci.StudentPerformance(
[ETLKey] [uniqueidentifier] NOT NULL,
school VARCHAR(255),
sex VARCHAR(255),
age VARCHAR(255),
address VARCHAR(255),
famsize VARCHAR(255),
Pstatus VARCHAR(255),
Medu VARCHAR(255),
Fedu VARCHAR(255),
Mjob VARCHAR(255),
Fjob VARCHAR(255),
reason VARCHAR(255),
guardian VARCHAR(255),
traveltime VARCHAR(255),
studytime VARCHAR(255),
failures VARCHAR(255),
schoolsup VARCHAR(255),
famsup VARCHAR(255),
paid VARCHAR(255),
activities VARCHAR(255),
nursery VARCHAR(255),
higher VARCHAR(255),
internet VARCHAR(255),
romantic VARCHAR(255),
famrel VARCHAR(255),
freetime VARCHAR(255),
goout VARCHAR(255),
Dalc VARCHAR(255),
Walc VARCHAR(255),
health VARCHAR(255),
absences VARCHAR(255),
G1 VARCHAR(255),
G2 VARCHAR(255),
G3 VARCHAR(255),
[UniqueDims] [varbinary](35) NULL,
[UniqueRows] [varbinary](16) NULL,
[SourceSystem] [nvarchar](255) NULL,
[Cleansed] [bit] NULL,
[ErrorRecord] [bit] NULL,
[ErrorReason] [nvarchar](255) NULL,
[Processed] [bit] NULL,
[RunDate] [datetime] NULL,
 CONSTRAINT [PK_StudentPerformance] PRIMARY KEY CLUSTERED 
(
       [ETLKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [uci].[StudentPerformance] ADD  CONSTRAINT [DF_StudentPerformance_ETLKey]  DEFAULT (newid()) FOR [ETLKey]
GO

ALTER TABLE [uci].[StudentPerformance] ADD  CONSTRAINT [DF_StudentPerformance_SourceSystem]  DEFAULT (N'uci') FOR [SourceSystem]
GO

ALTER TABLE [uci].[StudentPerformance] ADD  CONSTRAINT [DF_StudentPerformance_Cleansed]  DEFAULT ((0)) FOR [Cleansed]
GO

ALTER TABLE [uci].[StudentPerformance] ADD  CONSTRAINT [DF_StudentPerformance_ErrorRecord]  DEFAULT ((0)) FOR [ErrorRecord]
GO

ALTER TABLE [uci].[StudentPerformance] ADD  CONSTRAINT [DF_StudentPerformance_Processed]  DEFAULT ((0)) FOR [Processed]
GO

ALTER TABLE [uci].[StudentPerformance] ADD  CONSTRAINT [DF_StudentPerformance_RunDate]  DEFAULT (getdate()) FOR [RunDate]
GO

CREATE VIEW StudentPerformance AS 

SELECT
school,
sex,
age,
address,
famsize,
Pstatus,
Medu,
Fedu,
Mjob,
Fjob,
reason,
guardian,
traveltime,
studytime,
failures,
schoolsup,
famsup,
paid,
activities,
nursery,
higher,
internet,
romantic,
famrel,
freetime,
goout,
Dalc,
Walc,
health,
absences,
G1,
G2,
G3
FROM uci.StudentPerformance
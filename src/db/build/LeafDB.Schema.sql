-- Copyright (c) 2021, UW Medicine Research IT, University of Washington
-- Developed by Nic Dobbins and Cliff Spital, CRIO Sean Mooney
-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at http://mozilla.org/MPL/2.0/.
USE [LeafDB]
GO
/****** Object:  Schema [adm]    Script Date: ******/
CREATE SCHEMA [adm]
GO
/****** Object:  Schema [app]    Script Date: ******/
CREATE SCHEMA [app]
GO
/****** Object:  Schema [auth]    Script Date: ******/
CREATE SCHEMA [auth]
GO
/****** Object:  Schema [network]    Script Date: ******/
CREATE SCHEMA [network]
GO
/****** Object:  Schema [ref]    Script Date: ******/
CREATE SCHEMA [ref]
GO
/****** Object:  Schema [rela]    Script Date: ******/
CREATE SCHEMA [rela]
GO
/****** Object:  UserDefinedDataType [app].[DatasetQuerySqlStatement]    Script Date: ******/
CREATE TYPE [app].[DatasetQuerySqlStatement] FROM [nvarchar](4000) NOT NULL
GO
/****** Object:  UserDefinedDataType [app].[QueryDefinitionJson]    Script Date: ******/
CREATE TYPE [app].[QueryDefinitionJson] FROM [nvarchar](max) NOT NULL
GO
/****** Object:  UserDefinedDataType [app].[UniversalId]    Script Date: ******/
CREATE TYPE [app].[UniversalId] FROM [nvarchar](200) NOT NULL
GO
/****** Object:  UserDefinedDataType [auth].[SessionType]    Script Date: ******/
CREATE TYPE [auth].[SessionType] FROM [int] NOT NULL
GO
/****** Object:  UserDefinedDataType [auth].[User]    Script Date: ******/
CREATE TYPE [auth].[User] FROM [nvarchar](1000) NOT NULL
GO
/****** Object:  UserDefinedDataType [network].[Issuer]    Script Date: ******/
CREATE TYPE [network].[Issuer] FROM [nvarchar](200) NOT NULL
GO
/****** Object:  UserDefinedTableType [app].[ConceptPatientCountTable]    Script Date: ******/
CREATE TYPE [app].[ConceptPatientCountTable] AS TABLE(
	[Id] [uniqueidentifier] NULL,
	[PatientCount] [int] NULL
)
GO
/****** Object:  UserDefinedTableType [app].[ConceptPreflightTable]    Script Date: ******/
CREATE TYPE [app].[ConceptPreflightTable] AS TABLE(
	[Id] [uniqueidentifier] NULL,
	[UniversalId] [nvarchar](200) NULL,
	[IsPresent] [bit] NULL,
	[IsAuthorized] [bit] NULL
)
GO
/****** Object:  UserDefinedTableType [app].[DatasetQueryTagTable]    Script Date: ******/
CREATE TYPE [app].[DatasetQueryTagTable] AS TABLE(
	[Tag] [nvarchar](100) NOT NULL
)
GO
/****** Object:  UserDefinedTableType [app].[HydratedConceptTable]    Script Date: ******/
CREATE TYPE [app].[HydratedConceptTable] AS TABLE(
	[Id] [uniqueidentifier] NOT NULL,
	[ParentId] [uniqueidentifier] NULL,
	[RootId] [uniqueidentifier] NULL,
	[ExternalId] [nvarchar](200) NULL,
	[ExternalParentId] [nvarchar](200) NULL,
	[UniversalId] [nvarchar](200) NULL,
	[IsNumeric] [bit] NULL,
	[IsEventBased] [bit] NULL,
	[IsParent] [bit] NULL,
	[IsEncounterBased] [bit] NULL,
	[IsPatientCountAutoCalculated] [bit] NULL,
	[IsDropdown] [bit] NULL,
	[SqlSetFrom] [nvarchar](4000) NULL,
	[SqlSetWhere] [nvarchar](1000) NULL,
	[SqlFieldDate] [nvarchar](1000) NULL,
	[SqlFieldNumeric] [nvarchar](1000) NULL,
	[SqlFieldEventId] [nvarchar](400) NULL,
	[UiDisplayName] [nvarchar](400) NULL,
	[UiDisplayText] [nvarchar](1000) NULL,
	[UiDisplayUnits] [nvarchar](50) NULL,
	[UiDisplayTooltip] [nvarchar](max) NULL,
	[UiDisplayPatientCount] [int] NULL,
	[UiDisplayPatientCountByYear] [nvarchar](max) NULL,
	[UiDropdownElements] [nvarchar](max) NULL,
	[UiDropdownDefaultText] [nvarchar](400) NULL,
	[UiNumericDefaultText] [nvarchar](50) NULL,
	PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (IGNORE_DUP_KEY = OFF)
)
GO
/****** Object:  UserDefinedTableType [app].[ImportDataTable]    Script Date: ******/
CREATE TYPE [app].[ImportDataTable] AS TABLE(
	[Id] [nvarchar](200) NOT NULL,
	[ImportMetadataId] [uniqueidentifier] NOT NULL,
	[PersonId] [nvarchar](100) NOT NULL,
	[SourcePersonId] [nvarchar](100) NOT NULL,
	[SourceValue] [nvarchar](100) NULL,
	[SourceModifier] [nvarchar](100) NULL,
	[ValueString] [nvarchar](100) NULL,
	[ValueNumber] [decimal](18, 3) NULL,
	[ValueDate] [datetime] NULL
)
GO
/****** Object:  UserDefinedTableType [app].[ListTable]    Script Date: ******/
CREATE TYPE [app].[ListTable] AS TABLE(
	[Id] [nvarchar](50) NULL
)
GO
/****** Object:  UserDefinedTableType [app].[ResourceIdTable]    Script Date: ******/
CREATE TYPE [app].[ResourceIdTable] AS TABLE(
	[Id] [uniqueidentifier] NULL
)
GO
/****** Object:  UserDefinedTableType [app].[ResourceUniversalIdTable]    Script Date: ******/
CREATE TYPE [app].[ResourceUniversalIdTable] AS TABLE(
	[UniversalId] [nvarchar](200) NOT NULL
)
GO
/****** Object:  UserDefinedTableType [app].[SearchTermTable]    Script Date: ******/
CREATE TYPE [app].[SearchTermTable] AS TABLE(
	[Id] [int] NULL,
	[Term] [nvarchar](50) NULL
)
GO
/****** Object:  UserDefinedTableType [app].[SpecializationTable]    Script Date: ******/
CREATE TYPE [app].[SpecializationTable] AS TABLE(
	[SpecializationGroupId] [int] NULL,
	[UniversalId] [nvarchar](200) NULL,
	[UiDisplayText] [nvarchar](100) NULL,
	[SqlSetWhere] [nvarchar](1000) NULL,
	[OrderId] [int] NULL
)
GO
/****** Object:  UserDefinedTableType [app].[SqlSelectors]    Script Date: ******/
CREATE TYPE [app].[SqlSelectors] AS TABLE(
	[Column] [nvarchar](100) NOT NULL,
	[Type] [nvarchar](20) NOT NULL,
	[Phi] [bit] NOT NULL,
	[Mask] [bit] NOT NULL,
	PRIMARY KEY CLUSTERED 
(
	[Column] ASC
)WITH (IGNORE_DUP_KEY = OFF)
)
GO
/****** Object:  UserDefinedTableType [auth].[Authorizations]    Script Date: ******/
CREATE TYPE [auth].[Authorizations] AS TABLE(
	[ConstraintId] [int] NOT NULL,
	[ConstraintValue] [nvarchar](1000) NOT NULL
)
GO
/****** Object:  UserDefinedTableType [auth].[GroupMembership]    Script Date: ******/
CREATE TYPE [auth].[GroupMembership] AS TABLE(
	[Group] [nvarchar](1000) NOT NULL
)
GO
/****** Object:  UserDefinedTableType [auth].[ResourceConstraintTable]    Script Date: ******/
CREATE TYPE [auth].[ResourceConstraintTable] AS TABLE(
	[ResourceId] [uniqueidentifier] NOT NULL,
	[ConstraintId] [int] NOT NULL,
	[ConstraintValue] [nvarchar](1000) NOT NULL
)
GO
/****** Object:  UserDefinedTableType [rela].[ConceptSpecializationGroupTable]    Script Date: ******/
CREATE TYPE [rela].[ConceptSpecializationGroupTable] AS TABLE(
	[ConceptId] [uniqueidentifier] NOT NULL,
	[SpecializationGroupId] [int] NOT NULL,
	[OrderId] [int] NULL
)
GO
/****** Object:  UserDefinedFunction [app].[fn_FilterConceptsByConstraint]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =======================================
-- Author:      Cliff Spital
-- Create date: 2018/10/24
-- Description: Recursively (ancestry applies) filters a list of concept ids by ConceptConstraint relationships.
-- =======================================
CREATE FUNCTION [app].[fn_FilterConceptsByConstraint]
(
    @user auth.[User],
    @groups auth.GroupMembership READONLY,
    @requested app.ResourceIdTable READONLY,
    @admin bit
)
RETURNS @allowed TABLE (
    [Id] [uniqueidentifier] NULL
)
AS
BEGIN

    IF (@admin = 1)
    BEGIN;
        INSERT INTO @allowed
        SELECT Id
        FROM @requested;
        RETURN;
    END;

    DECLARE @ancestry table
    (
        [Base] [uniqueidentifier] not null,
        [Current] [uniqueidentifier] not null,
        [Parent] [uniqueidentifier] null
    );

    -- Fetch the full ancestry of all requested Ids.
    WITH recRoots (Base, Id, ParentId) as
    (
        SELECT i.Id, i.Id, c.Parentid
        FROM @requested i
        JOIN app.Concept c on i.Id = c.Id

        UNION ALL

        SELECT r.Base, c.Id, c.ParentId
        FROM app.Concept c
        JOIN recRoots r on c.Id = r.ParentId
    )
    INSERT INTO @ancestry
    SELECT Base, Id, ParentId
    FROM recRoots;

    -- Identify any requested Ids that are disallowed by constraint anywhere in their ancestry.
    DECLARE @disallowed app.ResourceIdTable;
    WITH constrained AS
        (
            SELECT c.ConceptId, c.ConstraintId, c.ConstraintValue
            FROM auth.ConceptConstraint c
            WHERE EXISTS (SELECT 1 FROM @ancestry a WHERE a.[Current] = c.ConceptId)
        )
    , permitted AS
    (
        SELECT 
            a.Base
        , a.[Current]
        , HasConstraint = CASE WHEN EXISTS 
                        (SELECT 1 FROM constrained c 
                WHERE c.ConceptId = a.[Current])
                        THEN 1 ELSE 0 END
        , UserPermitted = CASE WHEN EXISTS 
                        (SELECT 1 FROM constrained c 
                WHERE c.ConceptId = a.[Current] 
                        AND c.ConstraintId = 1 
                        AND c.ConstraintValue = @user)
                        THEN 1 ELSE 0 END
        , GroupPermitted = CASE WHEN EXISTS 
                        (SELECT 1 FROM constrained c 
                WHERE c.ConceptId = a.[Current] 
                        AND c.ConstraintId = 2 
                        AND c.ConstraintValue IN (SELECT g.[Group] FROM @groups g))
                        THEN 1 ELSE 0 END
        FROM @ancestry a
    )
    INSERT INTO @disallowed
    SELECT p.Base
    FROM permitted p
    WHERE p.HasConstraint = 1
        AND (p.UserPermitted = 0 AND p.GroupPermitted = 0)

    -- Select only the allowed requested ids.
    INSERT INTO @allowed
    SELECT Id
    FROM @requested
    WHERE Id NOT IN (
        SELECT Id
        FROM @disallowed
    );
    RETURN;
END










GO
/****** Object:  UserDefinedFunction [app].[fn_JsonifySqlSelectors]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =======================================
-- Author:      Cliff Spital
-- Create date: 2018/8/17
-- Description: Converts two app.SqlSelectors into the JSON string.
-- =======================================
CREATE FUNCTION [app].[fn_JsonifySqlSelectors]
(
    @fields app.SqlSelectors READONLY
)
RETURNS nvarchar(4000)
AS
BEGIN
    DECLARE @fs nvarchar(4000) = N'{"fields":[';

    DECLARE @Column nvarchar(100), @Type nvarchar(20), @Phi bit, @Mask bit;
    DECLARE ColumnCursor CURSOR FOR
    SELECT [Column], [Type], Phi, Mask
    FROM @fields;


    OPEN ColumnCursor;
    FETCH NEXT FROM ColumnCursor
    INTO @Column, @Type, @Phi, @Mask;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        DECLARE @bphi nvarchar(5) = CASE WHEN @Phi = 1 THEN N'true' ELSE N'false' END;
        DECLARE @bmask nvarchar(5) = CASE WHEN @Mask = 1 THEN N'true' ELSE N'false' END;

        DECLARE @single nvarchar(500) = N'{"column":"' + @Column + '","type":"' + LOWER(@Type) + '","phi":' + @bphi + ',"mask":' + @bmask + '},';
        SET @fs = @fs + @single;

        FETCH NEXT FROM ColumnCursor
        INTO @Column, @Type, @Phi, @Mask;
    END;

    CLOSE ColumnCursor;
    DEALLOCATE ColumnCursor;

    SET @fs = SUBSTRING(@fs, 0, LEN(@fs)) + N']}';

    RETURN @fs;
END











GO
/****** Object:  UserDefinedFunction [app].[fn_NullOrWhitespace]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Cliff Spital
-- Create date: 2019/6/5
-- Description: Returns 1 if string is null or consists of only whitespace, else 0.
-- =======================================
CREATE FUNCTION [app].[fn_NullOrWhitespace]
(
    @s nvarchar(max)
)
RETURNS bit
AS
BEGIN
    IF (ISNULL(@s, N'') = N'')
        RETURN 1;

    RETURN 0;
END
GO
/****** Object:  UserDefinedFunction [app].[fn_StringifyGuid]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =======================================
-- Author:      Cliff Spital
-- Create date: 2018/12/5
-- Description: Converts a UNIQUEIDENTIFIER to NVARCHAR(50)
-- =======================================
CREATE FUNCTION [app].[fn_StringifyGuid]
(
    @guid UNIQUEIDENTIFIER
)
RETURNS nvarchar(50)
AS
BEGIN
    RETURN cast(@guid as nvarchar(50));
END





GO
/****** Object:  UserDefinedFunction [auth].[fn_UserIsAuthorized]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =======================================
-- Author:      Cliff Spital
-- Create date: 2018/12/5
-- Description: Determines if a user satisfies the given Authorizations.
-- =======================================
CREATE FUNCTION [auth].[fn_UserIsAuthorized]
(
    @user auth.[User],
    @groups auth.GroupMembership READONLY,
    @authorizations auth.Authorizations READONLY,
    @admin bit
)
RETURNS bit
AS
BEGIN

    -- pass through on admin
    IF (@admin = 1)
        RETURN 1;

    DECLARE @totalCount int;
    SELECT @totalCount = COUNT(*)
    FROM @authorizations;

    -- totally unconstrained, bail early with allow
    IF (@totalCount = 0)
        RETURN 1;
    
    DECLARE @userCount int;
    DECLARE @groupCount int;

    SELECT @userCount = COUNT(*)
    FROM @authorizations
    WHERE ConstraintId = 1; -- users

    SELECT @groupCount = COUNT(*)
    FROM @authorizations
    WHERE ConstraintId = 2; -- groups

    -- constrained by user
    IF (@userCount > 0)
    BEGIN;
        IF EXISTS (SELECT 1 FROM @authorizations WHERE ConstraintId = 1 AND ConstraintValue = @user)
            RETURN 1;
    END;

    -- constrained by group
    IF (@groupCount > 0)
    BEGIN;
        IF EXISTS
        (
            SELECT 1
            FROM @groups
            WHERE EXISTS (
                SELECT 1
                FROM @authorizations
                WHERE ConstraintId = 2
                AND ConstraintValue = [Group]
            )
        )
            RETURN 1;
    END;

    -- constraints are not satisfied
    RETURN 0;

END






GO
/****** Object:  UserDefinedFunction [auth].[fn_UserIsAuthorizedForDatasetQueryById]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =======================================
-- Author:      Cliff Spital
-- Create date: 2018/8/22
-- Description: Performs a security check on the requested DatasetQuery.
-- =======================================
CREATE FUNCTION [auth].[fn_UserIsAuthorizedForDatasetQueryById]
(
    @user [auth].[User],
    @groups [auth].[GroupMembership] READONLY,
    @id UNIQUEIDENTIFIER,
    @admin bit
)
RETURNS bit
AS
BEGIN
    -- Get the constraints for user and groups, make sure the constraint is satisfied.
    DECLARE @authorizations auth.Authorizations;

    INSERT INTO @authorizations (ConstraintId, ConstraintValue)
    SELECT
        dq.ConstraintId,
        dq.ConstraintValue
    FROM
        auth.DatasetQueryConstraint dq
    WHERE
        dq.DatasetQueryId = @id;

    RETURN auth.fn_UserIsAuthorized(@user, @groups, @authorizations, @admin);
END














GO
/****** Object:  UserDefinedFunction [auth].[fn_UserIsAuthorizedForImportMetadataById]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =======================================
-- Author:      Nic Dobbins
-- Create date: 2019/10/14
-- Description: Performs a security check on the requested ImportMetadataId.
-- =======================================
CREATE FUNCTION [auth].[fn_UserIsAuthorizedForImportMetadataById]
(
    @user [auth].[User],
    @groups [auth].[GroupMembership] READONLY,
    @id UNIQUEIDENTIFIER,
    @admin bit
)
RETURNS bit
AS
BEGIN
    -- Get the constraints for user and groups, make sure the constraint is satisfied.
    DECLARE @authorizations auth.Authorizations;

    INSERT INTO @authorizations (ConstraintId, ConstraintValue)
    SELECT
        IM.ConstraintId,
        IM.ConstraintValue
    FROM
        auth.ImportMetadataConstraint AS IM
    WHERE
        IM.ImportMetadataId = @id;

    RETURN auth.fn_UserIsAuthorized(@user, @groups, @authorizations, @admin);

END

GO
/****** Object:  UserDefinedFunction [auth].[fn_UserIsAuthorizedForQueryById]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =======================================
-- Author:      Cliff Spital
-- Create date: 2018/12/5
-- Description: Performs a security check on the requested Query.
-- =======================================
CREATE FUNCTION [auth].[fn_UserIsAuthorizedForQueryById]
(
    @user auth.[User],
    @groups auth.GroupMembership READONLY,
    @id UNIQUEIDENTIFIER,
    @admin bit
)
RETURNS  bit
AS
BEGIN
    -- Get the constraints for user and groups, make sure the constraint is satisfied
    DECLARE @authorizations auth.Authorizations;

    INSERT INTO @authorizations (ConstraintId, ConstraintValue)
    SELECT
        qc.ConstraintId,
        qc.ConstraintValue
    FROM
        auth.QueryConstraint qc
    WHERE
        qc.QueryId = @id;

    RETURN auth.fn_UserIsAuthorized(@user, @groups, @authorizations, @admin);
END






GO
/****** Object:  Table [app].[Cohort]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [app].[Cohort](
	[QueryId] [uniqueidentifier] NOT NULL,
	[PersonId] [nvarchar](200) NOT NULL,
	[Exported] [bit] NOT NULL,
	[Salt] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Index [IX_Cohort_QueryId]    Script Date: ******/
CREATE CLUSTERED INDEX [IX_Cohort_QueryId] ON [app].[Cohort]
(
	[QueryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [app].[Concept]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [app].[Concept](
	[Id] [uniqueidentifier] NOT NULL,
	[ParentId] [uniqueidentifier] NULL,
	[RootId] [uniqueidentifier] NULL,
	[ExternalId] [nvarchar](200) NULL,
	[ExternalParentId] [nvarchar](200) NULL,
	[UniversalId] [nvarchar](200) NULL,
	[IsPatientCountAutoCalculated] [bit] NULL,
	[IsNumeric] [bit] NULL,
	[IsParent] [bit] NULL,
	[IsRoot] [bit] NULL,
	[IsSpecializable] [bit] NULL,
	[SqlSetId] [int] NULL,
	[SqlSetWhere] [nvarchar](1000) NULL,
	[SqlFieldNumeric] [nvarchar](1000) NULL,
	[UiDisplayName] [nvarchar](400) NULL,
	[UiDisplayText] [nvarchar](1000) NULL,
	[UiDisplaySubtext] [nvarchar](100) NULL,
	[UiDisplayUnits] [nvarchar](50) NULL,
	[UiDisplayTooltip] [nvarchar](max) NULL,
	[UiDisplayPatientCount] [int] NULL,
	[UiDisplayPatientCountByYear] [nvarchar](max) NULL,
	[UiDisplayRowOrder] [int] NULL,
	[UiNumericDefaultText] [nvarchar](50) NULL,
	[AddDateTime] [datetime] NULL,
	[PatientCountLastUpdateDateTime] [datetime] NULL,
	[ContentLastUpdateDateTime] [datetime] NULL,
 CONSTRAINT [PK_Concept_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [auth].[UserRole]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [auth].[UserRole](
	[ScopedIdentity] [nvarchar](200) NOT NULL,
    [IsUser] [bit] NOT NULL,
    [IsAdmin] [bit] NOT NULL,
    [IsSuper] [bit] NOT NULL,
    [IsIdentified] [bit] NOT NULL,
    [IsFederated] [bit] NOT NULL,
    [Created] datetime NOT NULL,
    [Updated] datetime NOT NULL
 CONSTRAINT [PK__UserRole] PRIMARY KEY CLUSTERED 
(
	[ScopedIdentity] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] 
GO
/****** Object:  Table [auth].[UserGroup]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [auth].[UserGroup](
	[ScopedIdentity] [nvarchar](200) NOT NULL,
    [GroupName] [nvarchar](200) NOT NULL,
    [Created] datetime NOT NULL,
    [Updated] datetime NOT NULL
 CONSTRAINT [PK__UserGroup] PRIMARY KEY CLUSTERED 
(
	[ScopedIdentity] ASC,
    [GroupName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] 
GO
/****** Object:  Table [app].[ConceptEvent]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [app].[ConceptEvent](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UiDisplayEventName] [nvarchar](50) NOT NULL,
	[Created] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](1000) NOT NULL,
	[Updated] [datetime] NOT NULL,
	[UpdatedBy] [nvarchar](1000) NOT NULL,
 CONSTRAINT [PK_ConceptSqlEvent] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [app].[ConceptForwardIndex]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [app].[ConceptForwardIndex](
	[Word] [nvarchar](400) NULL,
	[WordId] [int] NOT NULL,
	[ConceptId] [uniqueidentifier] NOT NULL,
	[RootId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_ConceptForwardIndex] PRIMARY KEY CLUSTERED 
(
	[WordId] ASC,
	[ConceptId] ASC,
	[RootId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [app].[ConceptInvertedIndex]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [app].[ConceptInvertedIndex](
	[Word] [nvarchar](400) NOT NULL,
	[WordId] [int] IDENTITY(1,1) NOT NULL,
	[WordCount] [int] NULL,
 CONSTRAINT [PK_Concept_InvertedIndex] PRIMARY KEY CLUSTERED 
(
	[WordId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [app].[ConceptSqlSet]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [app].[ConceptSqlSet](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IsEncounterBased] [bit] NULL,
	[IsEventBased] [bit] NULL,
	[SqlSetFrom] [nvarchar](1000) NOT NULL,
	[SqlFieldDate] [nvarchar](1000) NULL,
	[SqlFieldEvent] [nvarchar](400) NULL,
	[Created] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](1000) NOT NULL,
	[Updated] [datetime] NOT NULL,
	[UpdatedBy] [nvarchar](1000) NOT NULL,
	[EventId] [int] NULL,
 CONSTRAINT [PK_ConceptSqlSet] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [app].[ConceptTokenizedIndex]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [app].[ConceptTokenizedIndex](
	[ConceptId] [uniqueidentifier] NOT NULL,
	[JsonTokens] [nvarchar](max) NULL,
	[Updated] [datetime] NULL,
 CONSTRAINT [PK_ConceptTokenizedIndex] PRIMARY KEY CLUSTERED 
(
	[ConceptId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [app].[DatasetQuery]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [app].[DatasetQuery](
	[Id] [uniqueidentifier] NOT NULL,
	[UniversalId] [nvarchar](200) NULL,
	[Shape] [int] NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[CategoryId] [int] NULL,
	[Description] [nvarchar](max) NULL,
	[SqlStatement] [nvarchar](4000) NOT NULL,
	[Created] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](1000) NOT NULL,
	[Updated] [datetime] NOT NULL,
	[UpdatedBy] [nvarchar](1000) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [app].[DatasetQueryCategory]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [app].[DatasetQueryCategory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Category] [nvarchar](200) NOT NULL,
	[Created] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](1000) NOT NULL,
	[Updated] [datetime] NOT NULL,
	[UpdatedBy] [nvarchar](1000) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [app].[DatasetQueryTag]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [app].[DatasetQueryTag](
	[DatasetQueryId] [uniqueidentifier] NOT NULL,
	[Tag] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_DatasetQueryTag] PRIMARY KEY CLUSTERED 
(
	[DatasetQueryId] ASC,
	[Tag] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [app].[DemographicQuery]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [app].[DemographicQuery](
	[Lock] [char](1) NOT NULL,
	[SqlStatement] [nvarchar](4000) NOT NULL,
	[Shape] [int] NOT NULL,
	[LastChanged] [datetime] NOT NULL,
	[ChangedBy] [nvarchar](1000) NOT NULL,
 CONSTRAINT [PK_DemographicQuery] PRIMARY KEY CLUSTERED 
(
	[Lock] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [app].[DynamicDatasetQuery]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [app].[DynamicDatasetQuery](
	[Id] [uniqueidentifier] NOT NULL,
	[SqlFieldDate] [nvarchar](1000) NULL,
	[SqlFieldValueString] [nvarchar](1000) NULL,
	[SqlFieldValueNumeric] [nvarchar](1000) NULL,
	[Schema] [nvarchar](max) NOT NULL,
	[IsEncounterBased] [bit] NOT NULL,
 CONSTRAINT [PK__DynamicDatasetQuery] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [app].[GeneralEquivalenceMapping]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [app].[GeneralEquivalenceMapping](
	[SourceCode] [nvarchar](10) NOT NULL,
	[TargetCode] [nvarchar](10) NOT NULL,
	[SourceCodeType] [nvarchar](10) NOT NULL,
	[TargetCodeType] [nvarchar](10) NOT NULL,
	[UiDisplayTargetName] [nvarchar](400) NULL,
 CONSTRAINT [PK_GeneralEquivalenceMapping] PRIMARY KEY CLUSTERED 
(
	[SourceCode] ASC,
	[TargetCode] ASC,
	[SourceCodeType] ASC,
	[TargetCodeType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [app].[Geometry]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [app].[Geometry](
	[GeometryId] [nvarchar](20) NOT NULL,
	[GeometryType] [nvarchar](20) NOT NULL,
	[GeometryJson] [nvarchar](max) NULL,
 CONSTRAINT [PK_Geometry] PRIMARY KEY CLUSTERED 
(
	[GeometryId] ASC,
	[GeometryType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [app].[GlobalPanelFilter]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [app].[GlobalPanelFilter](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IsInclusion] [bit] NOT NULL,
	[SessionType] [int] NULL,
	[SqlSetId] [int] NOT NULL,
	[SqlSetWhere] [nvarchar](1000) NULL,
	[Created] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](200) NOT NULL,
	[Updated] [datetime] NOT NULL,
	[UpdatedBy] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_GlobalPanelFilter] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [app].[Import]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [app].[Import](
	[Id] [nvarchar](200) NOT NULL,
	[ImportMetadataId] [uniqueidentifier] NOT NULL,
	[PersonId] [nvarchar](200) NOT NULL,
	[SourcePersonId] [nvarchar](200) NOT NULL,
	[SourceModifier] [nvarchar](100) NULL,
	[SourceValue] [nvarchar](100) NOT NULL,
	[ValueString] [nvarchar](100) NULL,
	[ValueNumber] [decimal](18, 3) NULL,
	[ValueDate] [datetime] NULL,
 CONSTRAINT [PK_Import_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC,
	[ImportMetadataId] ASC,
	[PersonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [app].[ImportMetadata]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [app].[ImportMetadata](
	[Id] [uniqueidentifier] NOT NULL,
	[SourceId] [nvarchar](200) NOT NULL,
	[Structure] [nvarchar](max) NOT NULL,
	[Type] [int] NOT NULL,
	[Created] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](200) NOT NULL,
	[Updated] [datetime] NOT NULL,
	[UpdatedBy] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_ImportMetadata_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [app].[ImportPatientMappingQuery]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [app].[ImportPatientMappingQuery](
	[Lock] [char](1) NOT NULL,
	[SqlStatement] [nvarchar](4000) NOT NULL,
	[SqlFieldSourceId] [nvarchar](100) NOT NULL,
	[LastChanged] [datetime] NOT NULL,
	[ChangedBy] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_ImportPatientMappingQuery] PRIMARY KEY CLUSTERED 
(
	[Lock] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [app].[PanelFilter]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [app].[PanelFilter](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ConceptId] [uniqueidentifier] NOT NULL,
	[IsInclusion] [bit] NOT NULL,
	[UiDisplayText] [nvarchar](1000) NULL,
	[UiDisplayDescription] [nvarchar](4000) NULL,
	[Created] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](1000) NOT NULL,
	[Updated] [datetime] NOT NULL,
	[UpdatedBy] [nvarchar](1000) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [app].[Query]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [app].[Query](
	[Id] [uniqueidentifier] NOT NULL,
	[Pepper] [uniqueidentifier] NOT NULL,
	[Nonce] [uniqueidentifier] NULL,
	[Owner] [nvarchar](1000) NOT NULL,
	[Created] [datetime] NOT NULL,
	[UniversalId] [nvarchar](200) NULL,
	[Name] [nvarchar](200) NULL,
	[Category] [nvarchar](200) NULL,
	[Updated] [datetime] NOT NULL,
	[Ver] [int] NOT NULL,
	[Definition] [nvarchar](max) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [app].[QueryDefinition]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [app].[QueryDefinition](
	[QueryId] [uniqueidentifier] NOT NULL,
	[Definition] [nvarchar](max) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[QueryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [app].[Specialization]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [app].[Specialization](
	[Id] [uniqueidentifier] NOT NULL,
	[SpecializationGroupId] [int] NOT NULL,
	[UniversalId] [nvarchar](200) NULL,
	[UiDisplayText] [nvarchar](100) NOT NULL,
	[SqlSetWhere] [nvarchar](1000) NOT NULL,
	[OrderId] [int] NULL,
 CONSTRAINT [PK_Specialization] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [app].[SpecializationGroup]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [app].[SpecializationGroup](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SqlSetId] [int] NOT NULL,
	[UiDefaultText] [nvarchar](100) NOT NULL,
	[LastChanged] [datetime] NULL,
	[ChangedBy] [nvarchar](1000) NULL,
 CONSTRAINT [PK_SpecializationGroup] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [auth].[ConceptConstraint]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [auth].[ConceptConstraint](
	[ConceptId] [uniqueidentifier] NOT NULL,
	[ConstraintId] [int] NOT NULL,
	[ConstraintValue] [nvarchar](1000) NOT NULL,
 CONSTRAINT [PK_ConceptConstraint_1] PRIMARY KEY CLUSTERED 
(
	[ConceptId] ASC,
	[ConstraintId] ASC,
	[ConstraintValue] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [auth].[Constraint]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [auth].[Constraint](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Type] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Constraint_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [auth].[DatasetQueryConstraint]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [auth].[DatasetQueryConstraint](
	[DatasetQueryId] [uniqueidentifier] NOT NULL,
	[ConstraintId] [int] NOT NULL,
	[ConstraintValue] [nvarchar](1000) NOT NULL,
 CONSTRAINT [PK_DatasetQueryConstraint] PRIMARY KEY CLUSTERED 
(
	[DatasetQueryId] ASC,
	[ConstraintId] ASC,
	[ConstraintValue] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [auth].[ImportMetadataConstraint]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [auth].[ImportMetadataConstraint](
	[ImportMetadataId] [uniqueidentifier] NOT NULL,
	[ConstraintId] [int] NOT NULL,
	[ConstraintValue] [nvarchar](1000) NOT NULL,
 CONSTRAINT [PK_ImportMetadataConstraint] PRIMARY KEY CLUSTERED 
(
	[ImportMetadataId] ASC,
	[ConstraintId] ASC,
	[ConstraintValue] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [auth].[Login]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [auth].[Login](
	[Id] [uniqueidentifier] NOT NULL,
	[ScopedIdentity] [nvarchar](500) NOT NULL,
	[FullIdentity] [nvarchar](1000) NOT NULL,
	[Claims] [nvarchar](max) NOT NULL,
	[Created] [datetime] NOT NULL,
	[Updated] [datetime] NOT NULL,
 CONSTRAINT [PK_Login_Id] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [auth].[QueryConstraint]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [auth].[QueryConstraint](
	[QueryId] [uniqueidentifier] NOT NULL,
	[ConstraintId] [int] NOT NULL,
	[ConstraintValue] [nvarchar](1000) NOT NULL,
 CONSTRAINT [PK_QueryConstraint_1] PRIMARY KEY CLUSTERED 
(
	[QueryId] ASC,
	[ConstraintId] ASC,
	[ConstraintValue] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [auth].[TokenBlacklist]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [auth].[TokenBlacklist](
	[IdNonce] [uniqueidentifier] NOT NULL,
	[Expires] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [network].[Endpoint]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [network].[Endpoint](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[Address] [nvarchar](1000) NOT NULL,
	[Issuer] [nvarchar](200) NOT NULL,
	[KeyId] [nvarchar](200) NOT NULL,
	[Certificate] [nvarchar](max) NOT NULL,
	[Created] [datetime] NOT NULL,
	[Updated] [datetime] NOT NULL,
	[IsInterrogator] [bit] NOT NULL,
	[IsResponder] [bit] NOT NULL,
 CONSTRAINT [PK_Endpoint] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_Endpoint] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_Endpoint_2] UNIQUE NONCLUSTERED 
(
	[KeyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [network].[Identity]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [network].[Identity](
	[Lock] [char](1) NOT NULL,
	[Name] [nvarchar](300) NOT NULL,
	[Abbreviation] [nvarchar](20) NULL,
	[Description] [nvarchar](4000) NULL,
	[TotalPatients] [int] NULL,
	[Latitude] [decimal](7, 4) NULL,
	[Longitude] [decimal](7, 4) NULL,
	[PrimaryColor] [nvarchar](40) NULL,
	[SecondaryColor] [nvarchar](40) NULL,
 CONSTRAINT [PK_NetworkIdentity] PRIMARY KEY CLUSTERED 
(
	[Lock] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [ref].[ImportType]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ref].[ImportType](
	[Id] [int] NOT NULL,
	[Variant] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Import_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [ref].[SessionType]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ref].[SessionType](
	[Id] [int] NOT NULL,
	[Variant] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_SessionType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [ref].[Shape]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ref].[Shape](
	[Id] [int] NOT NULL,
	[Variant] [nvarchar](100) NOT NULL,
	[Schema] [nvarchar](max) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [ref].[Version]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ref].[Version](
	[Lock] [char](1) NOT NULL,
	[Version] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Version] PRIMARY KEY CLUSTERED 
(
	[Lock] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [rela].[ConceptSpecializationGroup]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [rela].[ConceptSpecializationGroup](
	[ConceptId] [uniqueidentifier] NOT NULL,
	[SpecializationGroupId] [int] NOT NULL,
	[OrderId] [int] NULL,
 CONSTRAINT [PK_ConceptSpecializationGroup] PRIMARY KEY CLUSTERED 
(
	[ConceptId] ASC,
	[SpecializationGroupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [rela].[QueryConceptDependency]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [rela].[QueryConceptDependency](
	[QueryId] [uniqueidentifier] NOT NULL,
	[DependsOn] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_QueryConceptDependency_1] PRIMARY KEY CLUSTERED 
(
	[QueryId] ASC,
	[DependsOn] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [rela].[QueryDependency]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [rela].[QueryDependency](
	[QueryId] [uniqueidentifier] NOT NULL,
	[DependsOn] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_QueryDependency_1] PRIMARY KEY CLUSTERED 
(
	[QueryId] ASC,
	[DependsOn] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [IX_ParentId]    Script Date: ******/
CREATE NONCLUSTERED INDEX [IX_ParentId] ON [app].[Concept]
(
	[ParentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IXUniq_Concept_UniversalId]    Script Date: ******/
CREATE UNIQUE NONCLUSTERED INDEX [IXUniq_Concept_UniversalId] ON [app].[Concept]
(
	[UniversalId] ASC
)
WHERE ([UniversalId] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IXUniq_ConceptEvent_UiDisplayEventName]    Script Date: ******/
CREATE UNIQUE NONCLUSTERED INDEX [IXUniq_ConceptEvent_UiDisplayEventName] ON [app].[ConceptEvent]
(
	[UiDisplayEventName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_ConceptForwardIndex_ConceptId]    Script Date: ******/
CREATE NONCLUSTERED INDEX [IX_ConceptForwardIndex_ConceptId] ON [app].[ConceptForwardIndex]
(
	[ConceptId] ASC
)
INCLUDE ( 	[Word]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_ConceptInvertedIndex_Word]    Script Date: ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_ConceptInvertedIndex_Word] ON [app].[ConceptInvertedIndex]
(
	[Word] ASC
)
INCLUDE ( 	[WordId]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IXUniq_DatasetQuery_UniversalId]    Script Date: ******/
CREATE UNIQUE NONCLUSTERED INDEX [IXUniq_DatasetQuery_UniversalId] ON [app].[DatasetQuery]
(
	[UniversalId] ASC
)
WHERE ([UniversalId] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IXUniq_DatasetQueryCategory_Category]    Script Date: ******/
CREATE UNIQUE NONCLUSTERED INDEX [IXUniq_DatasetQueryCategory_Category] ON [app].[DatasetQueryCategory]
(
	[Category] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Query_Nonce]    Script Date: ******/
CREATE NONCLUSTERED INDEX [IX_Query_Nonce] ON [app].[Query]
(
	[Nonce] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Query_Owner]    Script Date: ******/
CREATE NONCLUSTERED INDEX [IX_Query_Owner] ON [app].[Query]
(
	[Owner] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Query_UniversalId]    Script Date: ******/
CREATE NONCLUSTERED INDEX [IX_Query_UniversalId] ON [app].[Query]
(
	[UniversalId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Login_ScopedIdentity]    Script Date: ******/
CREATE NONCLUSTERED INDEX [IX_Login_ScopedIdentity] ON [auth].[Login]
(
	[ScopedIdentity] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_TokenBlacklist_Expires]    Script Date: ******/
CREATE NONCLUSTERED INDEX [IX_TokenBlacklist_Expires] ON [auth].[TokenBlacklist]
(
	[Expires] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Endpoint_1]    Script Date: ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Endpoint_1] ON [network].[Endpoint]
(
	[Issuer] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IXUniq_Shape_Variant]    Script Date: ******/
CREATE UNIQUE NONCLUSTERED INDEX [IXUniq_Shape_Variant] ON [ref].[Shape]
(
	[Variant] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [app].[Concept] ADD  CONSTRAINT [DF_Concept_Id]  DEFAULT (newsequentialid()) FOR [Id]
GO
ALTER TABLE [app].[Concept] ADD  CONSTRAINT [DF_Concept_AddDateTime]  DEFAULT (getdate()) FOR [AddDateTime]
GO
ALTER TABLE [app].[DatasetQuery] ADD  CONSTRAINT [DF_DatasetQuery_Id]  DEFAULT (newsequentialid()) FOR [Id]
GO
ALTER TABLE [app].[DatasetQuery] ADD  CONSTRAINT [DF_DatasetQuery_Created]  DEFAULT (getdate()) FOR [Created]
GO
ALTER TABLE [app].[DatasetQuery] ADD  CONSTRAINT [DF_DatasetQuery_Updated]  DEFAULT (getdate()) FOR [Updated]
GO
ALTER TABLE [app].[DatasetQueryCategory] ADD  CONSTRAINT [DF_DatasetQueryCategory_Created]  DEFAULT (getdate()) FOR [Created]
GO
ALTER TABLE [app].[DemographicQuery] ADD  CONSTRAINT [DF_DemographicQuery_Lock]  DEFAULT ('X') FOR [Lock]
GO
ALTER TABLE [app].[ImportMetadata] ADD  CONSTRAINT [DF_Id]  DEFAULT (newsequentialid()) FOR [Id]
GO
ALTER TABLE [app].[ImportPatientMappingQuery] ADD  CONSTRAINT [DF_ImportPatientMappingQuery_Lock]  DEFAULT ('X') FOR [Lock]
GO
ALTER TABLE [app].[PanelFilter] ADD  CONSTRAINT [DF_PanelFilter_Created]  DEFAULT (getdate()) FOR [Created]
GO
ALTER TABLE [app].[PanelFilter] ADD  CONSTRAINT [DF_PanelFilter_Updated]  DEFAULT (getdate()) FOR [Updated]
GO
ALTER TABLE [app].[Query] ADD  CONSTRAINT [DF_Query_Id]  DEFAULT (newsequentialid()) FOR [Id]
GO
ALTER TABLE [app].[Query] ADD  CONSTRAINT [DF_Query_]  DEFAULT (newid()) FOR [Pepper]
GO
ALTER TABLE [app].[Query] ADD  CONSTRAINT [DF_Query_Created]  DEFAULT (getdate()) FOR [Created]
GO
ALTER TABLE [app].[Query] ADD  CONSTRAINT [DF_Query_Updated]  DEFAULT (getdate()) FOR [Updated]
GO
ALTER TABLE [app].[Query] ADD  CONSTRAINT [DF_Query_Ver]  DEFAULT ((1)) FOR [Ver]
GO
ALTER TABLE [app].[Specialization] ADD  CONSTRAINT [DF_ConceptSpecialization_Id]  DEFAULT (newsequentialid()) FOR [Id]
GO
ALTER TABLE [auth].[Login] ADD  CONSTRAINT [DF_Login_Id]  DEFAULT (newsequentialid()) FOR [Id]
GO
ALTER TABLE [network].[Endpoint] ADD  CONSTRAINT [DF_Endpoint_Created]  DEFAULT (getdate()) FOR [Created]
GO
ALTER TABLE [network].[Endpoint] ADD  CONSTRAINT [DF_Endpoint_Updated]  DEFAULT (getdate()) FOR [Updated]
GO
ALTER TABLE [network].[Endpoint] ADD  CONSTRAINT [DF_Endpoint_IsInterrogator]  DEFAULT ((0)) FOR [IsInterrogator]
GO
ALTER TABLE [network].[Endpoint] ADD  CONSTRAINT [DF_Endpoint_IsResponder]  DEFAULT ((0)) FOR [IsResponder]
GO
ALTER TABLE [network].[Identity] ADD  CONSTRAINT [DF_NetworkIdentity_Lock]  DEFAULT ('X') FOR [Lock]
GO
ALTER TABLE [ref].[Version] ADD  CONSTRAINT [DF_Version_Lock]  DEFAULT ('X') FOR [Lock]
GO
ALTER TABLE [app].[Cohort]  WITH NOCHECK ADD  CONSTRAINT [FK_Cohort_QueryId] FOREIGN KEY([QueryId])
REFERENCES [app].[Query] ([Id])
GO
ALTER TABLE [app].[Cohort] CHECK CONSTRAINT [FK_Cohort_QueryId]
GO
ALTER TABLE [app].[Concept]  WITH CHECK ADD  CONSTRAINT [FK_Concept_SqlSetId] FOREIGN KEY([SqlSetId])
REFERENCES [app].[ConceptSqlSet] ([Id])
GO
ALTER TABLE [app].[Concept] CHECK CONSTRAINT [FK_Concept_SqlSetId]
GO
ALTER TABLE [app].[ConceptForwardIndex]  WITH CHECK ADD  CONSTRAINT [FK_ConceptForwardIndex_Concept] FOREIGN KEY([ConceptId])
REFERENCES [app].[Concept] ([Id])
GO
ALTER TABLE [app].[ConceptForwardIndex] CHECK CONSTRAINT [FK_ConceptForwardIndex_Concept]
GO
ALTER TABLE [app].[ConceptForwardIndex]  WITH CHECK ADD  CONSTRAINT [FK_ConceptForwardIndex_ConceptInvertedIndex] FOREIGN KEY([WordId])
REFERENCES [app].[ConceptInvertedIndex] ([WordId])
GO
ALTER TABLE [app].[ConceptForwardIndex] CHECK CONSTRAINT [FK_ConceptForwardIndex_ConceptInvertedIndex]
GO
ALTER TABLE [app].[ConceptForwardIndex]  WITH CHECK ADD  CONSTRAINT [FK_ConceptForwardIndex_ConceptRoot] FOREIGN KEY([RootId])
REFERENCES [app].[Concept] ([Id])
GO
ALTER TABLE [app].[ConceptForwardIndex] CHECK CONSTRAINT [FK_ConceptForwardIndex_ConceptRoot]
GO
ALTER TABLE [app].[ConceptSqlSet]  WITH CHECK ADD  CONSTRAINT [FK_EventId] FOREIGN KEY([EventId])
REFERENCES [app].[ConceptEvent] ([Id])
GO
ALTER TABLE [app].[ConceptSqlSet] CHECK CONSTRAINT [FK_EventId]
GO
ALTER TABLE [app].[ConceptTokenizedIndex]  WITH CHECK ADD  CONSTRAINT [FK_ConceptTokenizedIndex_Concept] FOREIGN KEY([ConceptId])
REFERENCES [app].[Concept] ([Id])
GO
ALTER TABLE [app].[ConceptTokenizedIndex] CHECK CONSTRAINT [FK_ConceptTokenizedIndex_Concept]
GO
ALTER TABLE [app].[DatasetQuery]  WITH CHECK ADD  CONSTRAINT [FK_DatasetQuery_CategoryId] FOREIGN KEY([CategoryId])
REFERENCES [app].[DatasetQueryCategory] ([Id])
GO
ALTER TABLE [app].[DatasetQuery] CHECK CONSTRAINT [FK_DatasetQuery_CategoryId]
GO
ALTER TABLE [app].[DatasetQuery]  WITH CHECK ADD  CONSTRAINT [FK_DatasetQuery_Shape] FOREIGN KEY([Shape])
REFERENCES [ref].[Shape] ([Id])
GO
ALTER TABLE [app].[DatasetQuery] CHECK CONSTRAINT [FK_DatasetQuery_Shape]
GO
ALTER TABLE [app].[DatasetQueryTag]  WITH CHECK ADD  CONSTRAINT [FK_DatasetQueryTag_DatasetQueryId] FOREIGN KEY([DatasetQueryId])
REFERENCES [app].[DatasetQuery] ([Id])
GO
ALTER TABLE [app].[DatasetQueryTag] CHECK CONSTRAINT [FK_DatasetQueryTag_DatasetQueryId]
GO
ALTER TABLE [app].[DemographicQuery]  WITH CHECK ADD  CONSTRAINT [FK_DemographicQuery_Shape] FOREIGN KEY([Shape])
REFERENCES [ref].[Shape] ([Id])
GO
ALTER TABLE [app].[DemographicQuery] CHECK CONSTRAINT [FK_DemographicQuery_Shape]
GO
ALTER TABLE [app].[DynamicDatasetQuery]  WITH CHECK ADD  CONSTRAINT [FK_DynamicDatasetQuery_Id] FOREIGN KEY([Id])
REFERENCES [app].[DatasetQuery] ([Id])
GO
ALTER TABLE [app].[DynamicDatasetQuery] CHECK CONSTRAINT [FK_DynamicDatasetQuery_Id]
GO
ALTER TABLE [app].[GlobalPanelFilter]  WITH CHECK ADD  CONSTRAINT [FK_GlobalPanelFilter_ConceptSqlSetId] FOREIGN KEY([SqlSetId])
REFERENCES [app].[ConceptSqlSet] ([Id])
GO
ALTER TABLE [app].[GlobalPanelFilter] CHECK CONSTRAINT [FK_GlobalPanelFilter_ConceptSqlSetId]
GO
ALTER TABLE [app].[GlobalPanelFilter]  WITH CHECK ADD  CONSTRAINT [FK_GlobalPanelFilter_SessionType] FOREIGN KEY([SessionType])
REFERENCES [ref].[SessionType] ([Id])
GO
ALTER TABLE [app].[GlobalPanelFilter] CHECK CONSTRAINT [FK_GlobalPanelFilter_SessionType]
GO
ALTER TABLE [app].[Import]  WITH CHECK ADD  CONSTRAINT [FK_ImportConstraint_ImportMetadataId] FOREIGN KEY([ImportMetadataId])
REFERENCES [app].[ImportMetadata] ([Id])
GO
ALTER TABLE [app].[Import] CHECK CONSTRAINT [FK_ImportConstraint_ImportMetadataId]
GO
ALTER TABLE [app].[ImportMetadata]  WITH CHECK ADD  CONSTRAINT [FK_ImportMetadata_Type] FOREIGN KEY([Type])
REFERENCES [ref].[ImportType] ([Id])
GO
ALTER TABLE [app].[ImportMetadata] CHECK CONSTRAINT [FK_ImportMetadata_Type]
GO
ALTER TABLE [app].[PanelFilter]  WITH CHECK ADD  CONSTRAINT [FK_PanelFilter_ConceptId] FOREIGN KEY([ConceptId])
REFERENCES [app].[Concept] ([Id])
GO
ALTER TABLE [app].[PanelFilter] CHECK CONSTRAINT [FK_PanelFilter_ConceptId]
GO
ALTER TABLE [app].[QueryDefinition]  WITH CHECK ADD  CONSTRAINT [FK_QueryDefinition_QueryId] FOREIGN KEY([QueryId])
REFERENCES [app].[Query] ([Id])
GO
ALTER TABLE [app].[QueryDefinition] CHECK CONSTRAINT [FK_QueryDefinition_QueryId]
GO
ALTER TABLE [app].[Specialization]  WITH CHECK ADD  CONSTRAINT [FK_Specialization_SpecializationGroup] FOREIGN KEY([SpecializationGroupId])
REFERENCES [app].[SpecializationGroup] ([Id])
GO
ALTER TABLE [app].[Specialization] CHECK CONSTRAINT [FK_Specialization_SpecializationGroup]
GO
ALTER TABLE [app].[SpecializationGroup]  WITH CHECK ADD  CONSTRAINT [FK_SpecializationGroup_ConceptSqlSet] FOREIGN KEY([SqlSetId])
REFERENCES [app].[ConceptSqlSet] ([Id])
GO
ALTER TABLE [app].[SpecializationGroup] CHECK CONSTRAINT [FK_SpecializationGroup_ConceptSqlSet]
GO
ALTER TABLE [auth].[ConceptConstraint]  WITH CHECK ADD  CONSTRAINT [FK_ConceptConstraint_ConceptId] FOREIGN KEY([ConceptId])
REFERENCES [app].[Concept] ([Id])
GO
ALTER TABLE [auth].[ConceptConstraint] CHECK CONSTRAINT [FK_ConceptConstraint_ConceptId]
GO
ALTER TABLE [auth].[ConceptConstraint]  WITH CHECK ADD  CONSTRAINT [FK_ConceptConstraint_ConstraintId] FOREIGN KEY([ConstraintId])
REFERENCES [auth].[Constraint] ([Id])
GO
ALTER TABLE [auth].[ConceptConstraint] CHECK CONSTRAINT [FK_ConceptConstraint_ConstraintId]
GO
ALTER TABLE [auth].[DatasetQueryConstraint]  WITH CHECK ADD  CONSTRAINT [FK_DatasetQueryConstraint_ConstraintId] FOREIGN KEY([ConstraintId])
REFERENCES [auth].[Constraint] ([Id])
GO
ALTER TABLE [auth].[DatasetQueryConstraint] CHECK CONSTRAINT [FK_DatasetQueryConstraint_ConstraintId]
GO
ALTER TABLE [auth].[DatasetQueryConstraint]  WITH CHECK ADD  CONSTRAINT [FK_DatasetQueryConstraint_DatasetQueryId] FOREIGN KEY([DatasetQueryId])
REFERENCES [app].[DatasetQuery] ([Id])
GO
ALTER TABLE [auth].[DatasetQueryConstraint] CHECK CONSTRAINT [FK_DatasetQueryConstraint_DatasetQueryId]
GO
ALTER TABLE [auth].[ImportMetadataConstraint]  WITH CHECK ADD  CONSTRAINT [FK_ImportMetadataConstraint_ConstraintId] FOREIGN KEY([ConstraintId])
REFERENCES [auth].[Constraint] ([Id])
GO
ALTER TABLE [auth].[ImportMetadataConstraint] CHECK CONSTRAINT [FK_ImportMetadataConstraint_ConstraintId]
GO
ALTER TABLE [auth].[ImportMetadataConstraint]  WITH CHECK ADD  CONSTRAINT [FK_ImportMetadataConstraint_ImportMetadataId] FOREIGN KEY([ImportMetadataId])
REFERENCES [app].[ImportMetadata] ([Id])
GO
ALTER TABLE [auth].[ImportMetadataConstraint] CHECK CONSTRAINT [FK_ImportMetadataConstraint_ImportMetadataId]
GO
ALTER TABLE [auth].[QueryConstraint]  WITH CHECK ADD  CONSTRAINT [FK_QueryConstraint_ConstraintId] FOREIGN KEY([ConstraintId])
REFERENCES [auth].[Constraint] ([Id])
GO
ALTER TABLE [auth].[QueryConstraint] CHECK CONSTRAINT [FK_QueryConstraint_ConstraintId]
GO
ALTER TABLE [auth].[QueryConstraint]  WITH CHECK ADD  CONSTRAINT [FK_QueryConstraint_QueryId] FOREIGN KEY([QueryId])
REFERENCES [app].[Query] ([Id])
GO
ALTER TABLE [auth].[QueryConstraint] CHECK CONSTRAINT [FK_QueryConstraint_QueryId]
GO
ALTER TABLE [rela].[ConceptSpecializationGroup]  WITH CHECK ADD  CONSTRAINT [FK_ConceptSpecializationGroup_Concept] FOREIGN KEY([ConceptId])
REFERENCES [app].[Concept] ([Id])
GO
ALTER TABLE [rela].[ConceptSpecializationGroup] CHECK CONSTRAINT [FK_ConceptSpecializationGroup_Concept]
GO
ALTER TABLE [rela].[ConceptSpecializationGroup]  WITH CHECK ADD  CONSTRAINT [FK_ConceptSpecializationGroup_SpecializationGroup] FOREIGN KEY([SpecializationGroupId])
REFERENCES [app].[SpecializationGroup] ([Id])
GO
ALTER TABLE [rela].[ConceptSpecializationGroup] CHECK CONSTRAINT [FK_ConceptSpecializationGroup_SpecializationGroup]
GO
ALTER TABLE [rela].[QueryConceptDependency]  WITH CHECK ADD  CONSTRAINT [FK_QueryConceptDependency_DependsOn] FOREIGN KEY([DependsOn])
REFERENCES [app].[Concept] ([Id])
GO
ALTER TABLE [rela].[QueryConceptDependency] CHECK CONSTRAINT [FK_QueryConceptDependency_DependsOn]
GO
ALTER TABLE [rela].[QueryConceptDependency]  WITH CHECK ADD  CONSTRAINT [FK_QueryConceptDependency_QueryId] FOREIGN KEY([QueryId])
REFERENCES [app].[Query] ([Id])
GO
ALTER TABLE [rela].[QueryConceptDependency] CHECK CONSTRAINT [FK_QueryConceptDependency_QueryId]
GO
ALTER TABLE [rela].[QueryDependency]  WITH CHECK ADD  CONSTRAINT [FK_QueryDependency_DependsOn] FOREIGN KEY([DependsOn])
REFERENCES [app].[Query] ([Id])
GO
ALTER TABLE [rela].[QueryDependency] CHECK CONSTRAINT [FK_QueryDependency_DependsOn]
GO
ALTER TABLE [rela].[QueryDependency]  WITH CHECK ADD  CONSTRAINT [FK_QueryDependency_QueryId] FOREIGN KEY([QueryId])
REFERENCES [app].[Query] ([Id])
GO
ALTER TABLE [rela].[QueryDependency] CHECK CONSTRAINT [FK_QueryDependency_QueryId]
GO
ALTER TABLE [app].[DemographicQuery]  WITH CHECK ADD  CONSTRAINT [CK_DemographicQuery_1] CHECK  (([Lock]='X'))
GO
ALTER TABLE [app].[DemographicQuery] CHECK CONSTRAINT [CK_DemographicQuery_1]
GO
ALTER TABLE [app].[ImportPatientMappingQuery]  WITH CHECK ADD  CONSTRAINT [CK_ImportPatientMappingQuery_1] CHECK  (([Lock]='X'))
GO
ALTER TABLE [app].[ImportPatientMappingQuery] CHECK CONSTRAINT [CK_ImportPatientMappingQuery_1]
GO
ALTER TABLE [network].[Identity]  WITH CHECK ADD  CONSTRAINT [CK_NetworkIdentity_1] CHECK  (([Lock]='X'))
GO
ALTER TABLE [network].[Identity] CHECK CONSTRAINT [CK_NetworkIdentity_1]
GO
ALTER TABLE [ref].[Version]  WITH CHECK ADD  CONSTRAINT [CK_Version_1] CHECK  (([Lock]='X'))
GO
ALTER TABLE [ref].[Version] CHECK CONSTRAINT [CK_Version_1]
GO
/****** Object:  StoredProcedure [adm].[sp_CreateConcept]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Cliff Spital
-- Create date: 2019/3/29
-- Description: Creates an app.Concept along with auth.ConceptConstraint and rela.ConceptSpecializationGroup.
-- =======================================
CREATE PROCEDURE [adm].[sp_CreateConcept]
    @universalId nvarchar(200),
    @parentId uniqueidentifier,
    @rootId uniqueidentifier,
    @externalId nvarchar(200),
    @externalParentId nvarchar(200),
    @isPatientCountAutoCalculated bit,
    @isNumeric bit,
    @isParent bit,
    @isRoot bit,
    @isSpecializable bit,
    @sqlSetId int,
    @sqlSetWhere nvarchar(1000),
    @sqlFieldNumeric nvarchar(1000),
    @uiDisplayName nvarchar(400),
    @uiDisplayText nvarchar(1000),
    @uiDisplaySubtext nvarchar(100),
	@uiDisplayUnits nvarchar(50),
	@uiDisplayTooltip nvarchar(max),
	@uiDisplayPatientCount int,
	@uiNumericDefaultText nvarchar(50),
    @constraints auth.ResourceConstraintTable READONLY,
    @specializationGroups rela.ConceptSpecializationGroupTable READONLY,
    @user auth.[User]
AS
BEGIN
    SET NOCOUNT ON

    IF (@parentId IS NOT NULL AND NOT EXISTS(SELECT 1 FROM app.Concept WHERE Id = @parentId))
    BEGIN;
        THROW 70404, N'Parent concept not found.', 1;
    END;

    IF (@rootId IS NOT NULL AND NOT EXISTS(SELECT 1 FROM app.Concept WHERE Id = @rootId))
    BEGIN;
        THROW 70404, N'Root concept not found.', 1;
    END;

    IF ((SELECT COUNT(*) FROM app.SpecializationGroup WHERE Id IN (SELECT SpecializationGroupId FROM @specializationGroups)) != (SELECT COUNT(*) FROM @specializationGroups))
    BEGIN;
        THROW 70404, N'SpecializationGroup not found.', 1;
    END;

    BEGIN TRAN;
    BEGIN TRY
        DECLARE @ids app.ResourceIdTable;

        INSERT INTO app.Concept (
            UniversalId,
            ParentId,
            RootId,
            ExternalId,
            ExternalParentId,
            IsPatientCountAutoCalculated,
            [IsNumeric],
            IsParent,
            IsRoot,
            IsSpecializable,
            SqlSetId,
            SqlSetWhere,
            SqlFieldNumeric,
            UiDisplayName,
            UiDisplayText,
            UiDisplaySubtext,
            UiDisplayUnits,
            UiDisplayTooltip,
            UiDisplayPatientCount,
            UiNumericDefaultText,
            ContentLastUpdateDateTime,
            PatientCountLastUpdateDateTime
        )
        OUTPUT inserted.Id INTO @ids
        SELECT
            UniversalId = @universalId,
            ParentId = @parentId,
            RootId = @rootId,
            ExternalId = @externalId,
            ExternalParentId = @externalParentId,
            IsPatientCountAutoCalculated = @isPatientCountAutoCalculated,
            [IsNumeric] = @isNumeric,
            IsParent = @isParent,
            IsRoot = @isRoot,
            IsSpecializable = @isSpecializable,
            SqlSetId = @sqlSetId,
            SqlSetWhere = @sqlSetWhere,
            SqlFieldNumeric = @sqlFieldNumeric,
            UiDisplayName = @uiDisplayName,
            UiDisplayText = @uiDisplayText,
            UiDisplaySubtext = @uiDisplaySubtext,
            UiDisplayUnits = @uiDisplayUnits,
            UiDisplayTooltip = @uiDisplayTooltip,
            UiDisplayPatientCount = @uiDisplayPatientCount,
            UiNumericDefaultText = @uiNumericDefaultText,
            ContentLastUpdateDateTime = GETDATE(),
            PatientCountLastUpdateDateTime = GETDATE();

        DECLARE @id UNIQUEIDENTIFIER;
        SELECT TOP 1 @id = Id FROM @ids;

        INSERT INTO auth.ConceptConstraint
        SELECT @id, ConstraintId, ConstraintValue
        FROM @constraints;

        INSERT INTO rela.ConceptSpecializationGroup
        SELECT @id, SpecializationGroupId, OrderId
        FROM @specializationGroups;

		IF (@isRoot = 1)
		BEGIN
			UPDATE app.Concept
			SET RootId = @id
			WHERE Id = @id
		END

        COMMIT;

        EXEC adm.sp_GetConceptById @id;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        THROW;
    END CATCH;
END
GO
/****** Object:  StoredProcedure [adm].[sp_CreateConceptEvent]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Nic Dobbins
-- Create date: 2019/4/8
-- Description: Create a new app.ConceptSqlEvent.
-- =======================================
CREATE PROCEDURE [adm].[sp_CreateConceptEvent]
    @uiDisplayEventName nvarchar(100),
    @user auth.[User]
AS
BEGIN
    SET NOCOUNT ON

    IF (app.fn_NullOrWhitespace(@uiDisplayEventName) = 1)
        THROW 70400, N'ConceptSqlEvent.UiDisplayEventName is required.', 1;

    BEGIN TRAN;
    BEGIN TRY

        IF EXISTS (SELECT 1 FROM app.ConceptEvent WHERE UiDisplayEventName = @uiDisplayEventName)
            THROW 70409, N'ConceptEvent already exists with that UiDisplayEventName.', 1;

        INSERT INTO app.ConceptEvent (UiDisplayEventName, Created, CreatedBy, Updated, UpdatedBy)
        OUTPUT inserted.Id, inserted.UiDisplayEventName
        VALUES (@uiDisplayEventName, GETDATE(), @user, GETDATE(), @user);
        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        THROW;
    END CATCH;
END
GO
/****** Object:  StoredProcedure [adm].[sp_CreateConceptSqlSet]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =======================================
-- Author:      Cliff Spital
-- Create date: 2019/8/3
-- Description: Creates a new ConceptSqlSet.
-- =======================================
CREATE PROCEDURE [adm].[sp_CreateConceptSqlSet]
    @isEncounterBased bit,
    @isEventBased bit,
    @sqlSetFrom nvarchar(1000),
    @sqlFieldDate nvarchar(1000),
    @sqlFieldEvent nvarchar(400),
    @eventId int,
    @user auth.[User]
AS
BEGIN
    SET NOCOUNT ON

    IF (@sqlSetFrom IS NULL OR LEN(@sqlSetFrom) = 0)
        THROW 70409, N'ConceptSqlSet.SqlSetFrom is required.', 1;

    INSERT INTO app.ConceptSqlSet (IsEncounterBased, IsEventBased, SqlSetFrom, SqlFieldDate, SqlFieldEvent, EventId, Created, CreatedBy, Updated, UpdatedBy)
    OUTPUT inserted.Id, inserted.IsEncounterBased, inserted.IsEventBased, inserted.SqlSetFrom, inserted.SqlFieldDate, inserted.SqlFieldEvent, inserted.EventId
    SELECT @isEncounterBased, @isEventBased, @sqlSetFrom, @sqlFieldDate, @sqlFieldEvent, @eventId, GETDATE(), @user, GETDATE(), @user
END






GO
/****** Object:  StoredProcedure [adm].[sp_CreateDatasetQuery]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =======================================
-- Author:      Cliff Spital
-- Create date: 2019/6/5
-- Description: Create a dataset query.
-- =======================================
CREATE PROCEDURE [adm].[sp_CreateDatasetQuery]
    @uid app.UniversalId,
    @shape int,
    @name nvarchar(200),
    @catid int,
    @desc nvarchar(max),
    @sql nvarchar(4000),
    @tags app.DatasetQueryTagTable READONLY,
    @constraints auth.ResourceConstraintTable READONLY,
    @user auth.[User]
AS
BEGIN
    SET NOCOUNT ON

    IF (@shape IS NULL)
        THROW 70400, N'DatasetQuery.Shape is required.', 1;
    
    IF NOT EXISTS (SELECT Id FROM ref.Shape WHERE Id = @shape)
        THROW 70404, N'DatasetQuery.Shape is not supported.', 1;
    
    IF (app.fn_NullOrWhitespace(@name) = 1)
        THROW 70400, N'DatasetQuery.Name is required.', 1;

    IF (app.fn_NullOrWhitespace(@sql) = 1)
        THROW 70400, N'DatasetQuery.SqlStatement is required.', 1;
    
    BEGIN TRAN;
    BEGIN TRY

        IF EXISTS (SELECT 1 FROM app.DatasetQuery WHERE @uid = UniversalId)
            THROW 70409, N'DatasetQuery already exists with universal id.', 1;

        DECLARE @ins TABLE (
            Id uniqueidentifier,
            UniversalId nvarchar(200) null,
            Shape int not null,
            [Name] nvarchar(200) not null,
            CategoryId int null,
            [Description] nvarchar(max) null,
            SqlStatement nvarchar(4000) not null,
            Created datetime not null,
            CreatedBy nvarchar(1000) not null,
            Updated datetime not null,
            UpdatedBy nvarchar(1000) not null
        );

        INSERT INTO app.DatasetQuery (UniversalId, Shape, [Name], CategoryId, [Description], SqlStatement, Created, CreatedBy, Updated, UpdatedBy)
        OUTPUT
            inserted.Id,
            inserted.UniversalId,
            inserted.Shape,
            inserted.Name,
            inserted.CategoryId,
            inserted.[Description],
            inserted.SqlStatement,
            inserted.Created,
            inserted.CreatedBy,
            inserted.Updated,
            inserted.UpdatedBy
        INTO @ins
        VALUES (@uid, @shape, @name, @catid, @desc, @sql, GETDATE(), @user, GETDATE(), @user);

        DECLARE @id UNIQUEIDENTIFIER;
        SELECT TOP 1 @id = Id from @ins;

        SELECT
            Id,
            UniversalId,
            Shape,
            [Name],
            CategoryId,
            [Description],
            SqlStatement,
			IsEncounterBased = CAST(1 AS BIT),
            Created,
            CreatedBy,
            Updated,
            UpdatedBy
        FROM @ins;

        INSERT INTO app.DatasetQueryTag (DatasetQueryId, Tag)
        OUTPUT inserted.DatasetQueryId, inserted.Tag
        SELECT @id, Tag
        FROM @tags;

        INSERT INTO auth.DatasetQueryConstraint (DatasetQueryId, ConstraintId, ConstraintValue)
        OUTPUT inserted.DatasetQueryId, inserted.ConstraintId, inserted.ConstraintValue
        SELECT @id, ConstraintId, ConstraintValue
        FROM @constraints;

        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        THROW;
    END CATCH;

END
GO
/****** Object:  StoredProcedure [adm].[sp_CreateDatasetQueryCategory]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Cliff Spital
-- Create date: 2019/6/5
-- Description: Creates an app.DatasetQueryCategory
-- =======================================
CREATE PROCEDURE [adm].[sp_CreateDatasetQueryCategory]
    @cat nvarchar(200),
    @user auth.[User]
AS
BEGIN
    SET NOCOUNT ON

    IF (app.fn_NullOrWhitespace(@cat) = 1)
        THROW 70400, N'DatasetQueryCategory.Category is required.', 1;

    BEGIN TRAN;
    BEGIN TRY
        IF EXISTS(SELECT Id FROM app.DatasetQueryCategory WHERE Category = @cat)
            THROW 70409, N'DatasetQueryCategory already exists with that name.', 1;
        
        INSERT INTO app.DatasetQueryCategory (Category, Created, CreatedBy, Updated, UpdatedBy)
        OUTPUT inserted.Id, inserted.Category, inserted.Created, inserted.CreatedBy, inserted.Updated, inserted.UpdatedBy
        VALUES(@cat, GETDATE(), @user, GETDATE(), @user);

        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        THROW;
    END CATCH;
END
GO
/****** Object:  StoredProcedure [adm].[sp_CreateDynamicDatasetQuery]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =======================================
-- Author:      Nic Dobbins
-- Create date: 2019/7/22
-- Description: Create a dynamic datasetquery.
-- =======================================
CREATE PROCEDURE [adm].[sp_CreateDynamicDatasetQuery]
	@shape INT,
    @name nvarchar(200),
    @catid int,
    @desc nvarchar(max),
    @sql nvarchar(4000),
	@isEnc bit,
	@schema nvarchar(max),
	@sqlDate nvarchar(1000) = NULL,
	@sqlValString nvarchar(1000) = NULL,
	@sqlValNum nvarchar(1000) = NULL,
    @tags app.DatasetQueryTagTable READONLY,
    @constraints auth.ResourceConstraintTable READONLY,
    @user auth.[User]
AS
BEGIN
    SET NOCOUNT ON
    
    IF (app.fn_NullOrWhitespace(@name) = 1)
        THROW 70400, N'DatasetQuery.Name is required.', 1;

    IF (app.fn_NullOrWhitespace(@sql) = 1)
        THROW 70400, N'DatasetQuery.SqlStatement is required.', 1;

	IF (app.fn_NullOrWhitespace(@schema) = 1)
        THROW 70400, N'DatasetQuery.Schema is required.', 1;
    
    BEGIN TRAN;
    BEGIN TRY

        DECLARE @ins1 TABLE (
            [Id] uniqueidentifier,
			[Shape] int not null,
            [Name] nvarchar(200) not null,
            [CategoryId] int null,
            [Description] nvarchar(max) null,
            [SqlStatement] nvarchar(4000) not null,
			[Schema] nvarchar(max) null,
			[IsEncounterBased] bit null,
			[SqlFieldDate] nvarchar(1000) null,
			[SqlFieldValueString] nvarchar(1000) null,
			[SqlFieldValueNumeric] nvarchar(1000) null,
            [Created] datetime not null,
            [CreatedBy] nvarchar(1000) not null,
            [Updated] datetime not null,
            [UpdatedBy] nvarchar(1000) not null
        );

		DECLARE @ins2 TABLE (
            [Id] uniqueidentifier,
			[Schema] nvarchar(max) null,
			[IsEncounterBased] bit null,
			[SqlFieldDate] nvarchar(1000) null,
			[SqlFieldValueString] nvarchar(1000) null,
			[SqlFieldValueNumeric] nvarchar(1000) null
        );

		INSERT INTO app.DatasetQuery ([Shape], [Name], CategoryId, [Description], SqlStatement, Created, CreatedBy, Updated, UpdatedBy)
        OUTPUT
            inserted.Id,
			inserted.Shape,
            inserted.[Name],
            inserted.CategoryId,
            inserted.[Description],
            inserted.SqlStatement,
            inserted.Created,
            inserted.CreatedBy,
            inserted.Updated,
            inserted.UpdatedBy
        INTO @ins1 ([Id], [Shape], [Name], CategoryId, [Description], SqlStatement, Created, CreatedBy, Updated, UpdatedBy)
        VALUES (@shape, @name, @catid, @desc, @sql, GETDATE(), @user, GETDATE(), @user);

		DECLARE @id UNIQUEIDENTIFIER = (SELECT TOP 1 Id FROM @ins1);

        INSERT INTO app.DynamicDatasetQuery ([Id], [Schema], IsEncounterBased, SqlFieldDate, SqlFieldValueString, SqlFieldValueNumeric)
		OUTPUT
            inserted.Id,
			inserted.[Schema],
			inserted.[IsEncounterBased],
			inserted.[SqlFieldDate],
			inserted.[SqlFieldValueString],
			inserted.[SqlFieldValueNumeric]
        INTO @ins2 ([Id], [Schema], [IsEncounterBased], [SqlFieldDate], [SqlFieldValueString], [SqlFieldValueNumeric])
        VALUES (@id, @schema, @isEnc, @sqlDate, @sqlValString, @sqlValNum);

		UPDATE @ins1
		SET [Schema] = i2.[Schema]
		  , [IsEncounterBased] = i2.[IsEncounterBased]
		  , [SqlFieldDate] = i2.[SqlFieldDate]
		  , [SqlFieldValueString] = i2.[SqlFieldValueString]
		  , [SqlFieldValueNumeric] = i2.[SqlFieldValueNumeric]
		FROM @ins2 AS i2
        
        SELECT
            [Id],
			[Shape],
            [Name],
            [CategoryId],
            [Description],
            [SqlStatement],
			[Schema],
			[IsEncounterBased],
			[SqlFieldDate],
			[SqlFieldValueString],
			[SqlFieldValueNumeric],
            [Created],
            [CreatedBy],
            [Updated],
            [UpdatedBy]
        FROM @ins1;

        INSERT INTO app.DatasetQueryTag (DatasetQueryId, Tag)
        OUTPUT inserted.DatasetQueryId, inserted.Tag
        SELECT @id, Tag
        FROM @tags;

        INSERT INTO auth.DatasetQueryConstraint (DatasetQueryId, ConstraintId, ConstraintValue)
        OUTPUT inserted.DatasetQueryId, inserted.ConstraintId, inserted.ConstraintValue
        SELECT @id, ConstraintId, ConstraintValue
        FROM @constraints;

        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        THROW;
    END CATCH;

END
GO
/****** Object:  StoredProcedure [adm].[sp_CreateEndpoint]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Cliff Spital
-- Create date: 2019/5/23
-- Description: Creates a new network.Endpoint
-- =======================================
CREATE PROCEDURE [adm].[sp_CreateEndpoint]
    @name nvarchar(200),
    @addr nvarchar(1000),
    @iss nvarchar(200),
    @kid nvarchar(200),
    @cert nvarchar(max),
    @isInterrogator bit,
    @isResponder bit,
    @user auth.[User]
AS
BEGIN
    SET NOCOUNT ON

    IF (app.fn_NullOrWhitespace(@name) = 1)
        THROW 70400, N'NetworkEndpoint.Name is required.', 1;
    
    IF (app.fn_NullOrWhitespace(@addr) = 1)
        THROW 70400, N'NetworkEndpoint.Address is required.', 1;
    
    IF (app.fn_NullOrWhitespace(@iss) = 1)
        THROW 70400, N'NetworkEndpoint.Issuer is required.', 1;

    IF (app.fn_NullOrWhitespace(@kid) = 1)
        THROW 70400, N'NetworkEndpoint.KeyId is required.', 1;
    
    IF (app.fn_NullOrWhitespace(@cert) = 1)
        THROW 70400, N'NetworkEndpoint.Certificate is required.', 1;
    
    IF (@isInterrogator IS NULL)
        THROW 70400, N'NetworkEndpoint.IsInterrogator is required.', 1;

    IF (@isResponder IS NULL)
        THROW 70400, N'NetworkEndpoint.IsResponder is required.', 1;
    
    BEGIN TRAN;
    BEGIN TRY
        IF EXISTS (SELECT 1 FROM network.Endpoint WHERE Name = @name OR KeyId = @kid OR Issuer = @iss)
            THROW 70409, N'NetworkEndpoint already exists with that name, key id, or issuer value.', 1;

        INSERT INTO network.Endpoint ([Name], [Address], Issuer, KeyId, [Certificate], Created, Updated, IsInterrogator, IsResponder)
        OUTPUT inserted.Id, inserted.Name, inserted.Address, inserted.Issuer, inserted.KeyId, inserted.Certificate, inserted.Created, inserted.Updated, inserted.IsInterrogator, inserted.IsResponder
        VALUES (@name, @addr, @iss, @kid, @cert, getdate(), getdate(), @isInterrogator, @isResponder);
        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        THROW;
    END CATCH;

END
GO
/****** Object:  StoredProcedure [adm].[sp_CreateGlobalPanelFilter]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Nic Dobbins
-- Create date: 2019/8/26
-- Description: Create a new app.GlobalPanelFilter.
-- =======================================
CREATE PROCEDURE [adm].[sp_CreateGlobalPanelFilter]
    @sessionType auth.SessionType,
	@isInclusion bit,
	@sqlSetId int,
	@sqlSetWhere nvarchar(1000),
	@user auth.[User]
AS
BEGIN
    SET NOCOUNT ON

	SET @sessionType = CASE @sessionType WHEN 0 THEN NULL ELSE @sessionType END

    BEGIN TRAN;
    BEGIN TRY

        INSERT INTO app.GlobalPanelFilter (SessionType, IsInclusion, SqlSetId, SqlSetWhere, Created, CreatedBy, Updated, UpdatedBy)
        OUTPUT 
			inserted.Id
		  , inserted.SessionType
		  , inserted.IsInclusion
		  , inserted.SqlSetId
		  , inserted.SqlSetWhere
        VALUES (@sessionType, @isInclusion, @sqlSetId, @sqlSetWhere, GETDATE(), @user, GETDATE(), @user);
        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        THROW;
    END CATCH;
END
GO
/****** Object:  StoredProcedure [adm].[sp_CreatePanelFilter]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Nic Dobbins
-- Create date: 2019/8/26
-- Description: Create a new app.PanelFilter.
-- =======================================
CREATE PROCEDURE [adm].[sp_CreatePanelFilter]
    @conceptId uniqueidentifier,
    @isInclusion bit,
	@uiDisplayText nvarchar(1000),
	@uiDisplayDescription nvarchar(4000),
	@user auth.[User]
AS
BEGIN
    SET NOCOUNT ON

	IF NOT EXISTS (SELECT 1 FROM app.Concept WHERE Id = @conceptId)
        THROW 70400, N'PanelFilter.Concept does not exist.', 1;

    IF (app.fn_NullOrWhitespace(@uiDisplayText) = 1)
        THROW 70400, N'PanelFilter.UiDisplayText is required.', 1;

	IF (app.fn_NullOrWhitespace(@uiDisplayDescription) = 1)
        THROW 70400, N'PanelFilter.UiDisplayDescription is required.', 1;

    BEGIN TRAN;
    BEGIN TRY

        IF EXISTS (SELECT 1 FROM app.PanelFilter WHERE ConceptId = @conceptId AND IsInclusion = @isInclusion)
            THROW 70409, N'PanelFilter already exists with that ConceptId and Inclusion setting.', 1;

        INSERT INTO app.PanelFilter (ConceptId, IsInclusion, UiDisplayText, UiDisplayDescription, Created, CreatedBy, Updated, UpdatedBy)
        OUTPUT 
			inserted.Id
		  , inserted.ConceptId
		  , inserted.IsInclusion
		  , inserted.UiDisplayText
		  , inserted.UiDisplayDescription
        VALUES (@conceptId, @isInclusion, @uiDisplayText, @uiDisplayDescription, GETDATE(), @user, GETDATE(), @user);
        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        THROW;
    END CATCH;
END
GO
/****** Object:  StoredProcedure [adm].[sp_CreateSpecialization]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Cliff Spital
-- Create date: 2019/3/11
-- Description: Create a new app.Specialization.
-- =======================================
CREATE PROCEDURE [adm].[sp_CreateSpecialization]
    @groupId int,
    @uid app.UniversalId,
    @uiDisplayText nvarchar(100),
    @sqlSetWhere nvarchar(1000),
    @order int,
    @user auth.[User]
AS
BEGIN
    SET NOCOUNT ON

    IF (app.fn_NullOrWhitespace(@groupId) = 1)
        THROW 70400, N'Specialization.SpecializationGroupId is required.', 1;
    
    IF (app.fn_NullOrWhitespace(@uiDisplayText) = 1)
        THROW 70400, N'Specialization.UiDisplayText is required.', 1;

    IF (app.fn_NullOrWhitespace(@sqlSetWhere) = 1)
        THROW 70400, N'Specialization.SqlSetWhere is required.', 1;

    IF NOT EXISTS (SELECT 1 FROM app.SpecializationGroup WHERE Id = @groupId)
        THROW 70409, N'SpecializationGroup is missing.', 1;

    INSERT INTO app.Specialization (SpecializationGroupId, UniversalId, UiDisplayText, SqlSetWhere, OrderId)
    OUTPUT inserted.Id, inserted.SpecializationGroupId, inserted.UniversalId, inserted.UiDisplayText, inserted.SqlSetWhere, inserted.OrderId
    VALUES (@groupId, @uid, @uiDisplayText, @sqlSetWhere, @order);
END
GO
/****** Object:  StoredProcedure [adm].[sp_CreateSpecializationGroup]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Cliff Spital
-- Create date: 2019/3/12
-- Description: Create a new app.SpecializationGroup with associated (if any) app.Specialization.
-- =======================================
CREATE PROCEDURE [adm].[sp_CreateSpecializationGroup]
    @sqlSetId int,
    @uiDefaultText nvarchar(100),
    @specs app.SpecializationTable READONLY,
    @user auth.[User]
AS
BEGIN
    SET NOCOUNT ON

    -- validate
    IF (app.fn_NullOrWhitespace(@sqlSetId) = 1)
        THROW 70400, N'SpecializationGroup.SqlSetId is missing.', 1;
    
    IF (app.fn_NullOrWhitespace(@uiDefaultText) = 1)
        THROW 70400, N'SpecializationGroup.UiDefaultText is required.', 1;

    IF EXISTS(SELECT 1 FROM @specs WHERE UiDisplayText IS NULL OR LEN(UiDisplayText) = 0 OR SqlSetWhere IS NULL OR LEN(SqlSetWhere) = 0)
        THROW 70400, N'Malformed Specialization.', 1;

    IF NOT EXISTS(SELECT 1 FROM app.ConceptSqlSet WHERE Id = @sqlSetId)
        THROW 70404, N'ConceptSqlSet is missing.', 1;

    BEGIN TRAN;

    DECLARE @g TABLE (
        Id int not null,
        SqlSetId int not null,
        UiDefaultText nvarchar(100) not null
    );

    INSERT INTO app.SpecializationGroup (SqlSetId, UiDefaultText, LastChanged, ChangedBy)
    OUTPUT inserted.Id, inserted.SqlSetId, inserted.UiDefaultText INTO @g
    SELECT @sqlSetId, @uiDefaultText, GETDATE(), @user;

    DECLARE @id int
    SELECT TOP 1 @id = Id FROM @g;

    DECLARE @s TABLE (
        Id UNIQUEIDENTIFIER not null,
        SpecializationGroupId int not null,
        UniversalId nvarchar(200) null,
        UiDisplayText nvarchar(100) not null,
        SqlSetWhere nvarchar(1000) not null,
        OrderId int null
    )

    INSERT INTO app.Specialization (SpecializationGroupId, UniversalId, UiDisplayText, SqlSetWhere, OrderId)
    OUTPUT inserted.Id, inserted.SpecializationGroupId, inserted.UniversalId, inserted.UiDisplayText, inserted.SqlSetWhere, inserted.OrderId INTO @s
    SELECT @id, UniversalId, UiDisplayText, SqlSetWhere, OrderId
    FROM @specs;

    COMMIT;

    SELECT Id, SqlSetId, UiDefaultText
    FROM @g;

    SELECT Id, SpecializationGroupId, UniversalId, UiDisplayText, SqlSetWhere, OrderId
    FROM @s;

END
GO
/****** Object:  StoredProcedure [adm].[sp_DeleteConcept]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Cliff Spital
-- Create date: 2019/4/1
-- Description: Deletes a concept if unhooked, returns dependents.
-- =======================================
CREATE PROCEDURE [adm].[sp_DeleteConcept]
    @id uniqueidentifier,
    @user auth.[User]
AS
BEGIN
    SET NOCOUNT ON

    BEGIN TRAN;

    IF NOT EXISTS(SELECT 1 FROM app.Concept WHERE Id = @id)
    BEGIN;
        THROW 70404, N'Concept not found.', 1;
    END;

    declare @filters table (
        Id int,
        UiDisplayText nvarchar(1000) NULL
    );
    INSERT INTO @filters
    SELECT Id, UiDisplayText
    FROM app.PanelFilter
    WHERE ConceptId = @id;

    declare @queries table (
        Id uniqueidentifier,
        UniversalId nvarchar(200) null,
        [Name] nvarchar(200) null,
        [Owner] nvarchar(200) not null
    );
    INSERT INTO @queries
    SELECT q.Id, q.UniversalId, q.[Name], q.[Owner]
    FROM app.Query q
    JOIN rela.QueryConceptDependency cd on q.Id = cd.QueryId
    WHERE cd.DependsOn = @id;

    declare @concepts table(
        Id UNIQUEIDENTIFIER,
        UniversalId nvarchar(200) null,
        UiDisplayName nvarchar(400) null
    );
    INSERT INTO @concepts
    SELECT Id, UniversalId, UiDisplayName
    FROM app.Concept
    WHERE ParentId = @id OR (RootId = @id AND Id != @id);

    IF NOT(EXISTS(SELECT 1 FROM @filters) OR EXISTS(SELECT 1 FROM @queries) OR EXISTS(SELECT 1 FROM @concepts))
    BEGIN;
        BEGIN TRY
            DELETE FROM auth.ConceptConstraint
            WHERE ConceptId = @id;

            DELETE FROM rela.ConceptSpecializationGroup
            WHERE ConceptId = @id;

            DELETE FROM app.ConceptForwardIndex
            WHERE ConceptId = @id;

            DELETE FROM app.ConceptTokenizedIndex
            WHERE ConceptId = @id;

            DELETE FROM app.Concept
            WHERE Id = @id;

            COMMIT;
        END TRY
        BEGIN CATCH
            ROLLBACK;
        END CATCH;
    END;
    ELSE
    BEGIN;
        ROLLBACK;
    END;

    SELECT Id, UiDisplayText
    FROM @filters;
    SELECT Id, UniversalId, [Name], [Owner]
    FROM @queries;
    SELECT Id, UniversalId, UiDisplayName
    FROM @concepts;
END
GO
/****** Object:  StoredProcedure [adm].[sp_DeleteConceptEvent]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =======================================
-- Author:      Nic Dobbins
-- Create date: 2019/4/8
-- Description: Deletes an app.ConceptSqlEvent by id.
-- =======================================
CREATE PROCEDURE [adm].[sp_DeleteConceptEvent]
    @id int,
    @user auth.[User]
AS
BEGIN
    SET NOCOUNT ON

    IF NOT EXISTS(SELECT 1 FROM app.ConceptEvent WHERE Id = @id)
        THROW 70404, N'app.ConceptEvent is missing.', 1;

    BEGIN TRAN;
    BEGIN TRY
        DELETE FROM app.ConceptEvent
        WHERE Id = @id;

        COMMIT;

        SELECT Id = NULL, SqlSetFrom = NULL
        WHERE 0 = 1;
    END TRY
    BEGIN CATCH
        DECLARE @sqlSets TABLE (
            Id int,
            SqlSetFrom nvarchar(1000) NULL
        );
        INSERT INTO @sqlSets
        SELECT Id, SqlSetFrom
        FROM app.ConceptSqlSet
        WHERE app.ConceptSqlSet.EventId = @id;

        ROLLBACK;

        IF EXISTS(SELECT 1 FROM @sqlSets)
        BEGIN;
            SELECT Id, SqlSetFrom
            FROM @sqlSets;
            RETURN;
        END;
        THROW;
    END CATCH;
END







GO
/****** Object:  StoredProcedure [adm].[sp_DeleteConceptSqlSet]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =======================================
-- Author:      Cliff Spital
-- Create date: 2019/8/3
-- Description: Deletes an app.ConceptSqlSet by id.
-- =======================================
CREATE PROCEDURE [adm].[sp_DeleteConceptSqlSet]
    @id int,
    @user auth.[User]
AS
BEGIN
    SET NOCOUNT ON

    IF NOT EXISTS(SELECT 1 FROM app.ConceptSqlSet WHERE Id = @id)
        THROW 70404, N'app.ConceptSqlSet is missing.', 1;

    BEGIN TRAN;
    BEGIN TRY
        DELETE FROM app.ConceptSqlSet
        WHERE Id = @id;

        COMMIT;

        SELECT Id = NULL, UniversalId = NULL, UiDisplayName = NULL
        WHERE 0 = 1;

        SELECT Id = NULL, UiDefaultText = NULL
        WHERE 0 = 1;
    END TRY
    BEGIN CATCH
        DECLARE @concepts TABLE (
            Id UNIQUEIDENTIFIER,
            UniversalId app.UniversalId NULL,
            UiDisplayName nvarchar(400) NULL
        );
        INSERT INTO @concepts
        SELECT Id, UniversalId, UiDisplayName
        FROM app.Concept
        WHERE app.Concept.SqlSetId = @id;

        DECLARE @specs TABLE (
            Id int,
            UiDefaultText nvarchar(100) NULL
        );
        INSERT INTO @specs
        SELECT Id, UiDefaultText
        FROM app.SpecializationGroup
        WHERE SqlSetId = @id;
        
        ROLLBACK;

        IF EXISTS(SELECT 1 FROM @concepts) OR EXISTS(SELECT 1 FROM @specs)
        BEGIN;
            SELECT Id, UniversalId, UiDisplayName
            FROM @concepts;

            SELECT Id, UiDefaultText
            FROM @specs;
            RETURN;
        END;
        THROW;
    END CATCH;
END





GO
/****** Object:  StoredProcedure [adm].[sp_DeleteDatasetQuery]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Cliff Spital
-- Create date: 2019/6/5
-- Description: Delete an app.DatasetQuery.
-- =======================================
CREATE PROCEDURE [adm].[sp_DeleteDatasetQuery]
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON

    BEGIN TRAN;
    BEGIN TRY
        DELETE FROM app.DatasetQueryTag
        WHERE DatasetQueryId = @id;

		DELETE FROM auth.DatasetQueryConstraint
		WHERE DatasetQueryId = @id

		DELETE FROM app.DynamicDatasetQuery
		WHERE Id = @id

		DELETE FROM app.DatasetQuery
		OUTPUT deleted.Id
		WHERE Id = @id;

        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        THROW;
    END CATCH;
END
GO
/****** Object:  StoredProcedure [adm].[sp_DeleteDatasetQueryCategory]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Cliff Spital
-- Create date: 2019/6/6
-- Description: Delete an app.DatasetQueryCategory if there are no dependents.
-- =======================================
CREATE PROCEDURE [adm].[sp_DeleteDatasetQueryCategory]
    @id int,
    @user auth.[User]
AS
BEGIN
    SET NOCOUNT ON

    IF NOT EXISTS(SELECT 1 FROM app.DatasetQueryCategory WHERE Id = @id)
        THROW 70404, N'DatasetQueryCategory not found.', 1;
    
    BEGIN TRAN;

    DECLARE @deps TABLE (
        Id uniqueidentifier not null
    );
    INSERT INTO @deps (Id)
    SELECT Id
    FROM app.DatasetQuery
    WHERE CategoryId = @id;

    IF EXISTS(SELECT 1 FROM @deps)
    BEGIN;
        -- there are dependents, bail
        ROLLBACK;

        SELECT Id
        FROM @deps;

        RETURN;
    END;

    DELETE FROM app.DatasetQueryCategory
    WHERE Id = @id;

    COMMIT;

    -- No dependents.
    SELECT Id = NULL
    WHERE 0 = 1;
END
GO
/****** Object:  StoredProcedure [adm].[sp_DeleteEndpoint]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Cliff Spital
-- Create date: 2019/5/23
-- Description: Deletes a new network.Endpoint
-- =======================================
CREATE PROCEDURE [adm].[sp_DeleteEndpoint]
    @id int,
	@user auth.[User]
AS
BEGIN
    SET NOCOUNT ON

    DELETE FROM network.Endpoint
    OUTPUT deleted.Id, deleted.Name, deleted.Address, deleted.Issuer, deleted.KeyId, deleted.Certificate, deleted.Created, deleted.Updated, deleted.IsInterrogator, deleted.IsResponder
    WHERE Id = @id;

END
GO
/****** Object:  StoredProcedure [adm].[sp_DeleteGlobalPanelFilter]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Nic Dobbins
-- Create date: 2019/8/26
-- Description: Deletes an app.GlobalPanelFilter.
-- =======================================
CREATE PROCEDURE [adm].[sp_DeleteGlobalPanelFilter]
	@id int
AS
BEGIN
    SET NOCOUNT ON

    BEGIN TRAN;
    BEGIN TRY

        IF NOT EXISTS (SELECT 1 FROM app.GlobalPanelFilter WHERE Id = @id)
            THROW 70409, N'GlobalPanelFilter does not exist.', 1;

		DELETE app.GlobalPanelFilter
		OUTPUT deleted.Id
		WHERE Id = @id;

        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        THROW;
    END CATCH;
END
GO
/****** Object:  StoredProcedure [adm].[sp_DeletePanelFilter]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Nic Dobbins
-- Create date: 2019/8/26
-- Description: Deletes an app.PanelFilter.
-- =======================================
CREATE PROCEDURE [adm].[sp_DeletePanelFilter]
	@id int
AS
BEGIN
    SET NOCOUNT ON

    BEGIN TRAN;
    BEGIN TRY

        IF NOT EXISTS (SELECT 1 FROM app.PanelFilter WHERE Id = @id)
            THROW 70409, N'PanelFilter does not exist.', 1;

		DELETE app.PanelFilter
		OUTPUT deleted.Id
		WHERE Id = @id;

        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        THROW;
    END CATCH;
END
GO
/****** Object:  StoredProcedure [adm].[sp_DeleteSpecialization]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =======================================
-- Author:      Cliff Spital
-- Create date: 2019/3/11
-- Description: Deletes an app.Specialization by id.
-- =======================================
CREATE PROCEDURE [adm].[sp_DeleteSpecialization]
    @id UNIQUEIDENTIFIER,
    @user auth.[User]
AS
BEGIN
    SET NOCOUNT ON

    DELETE FROM app.Specialization
    OUTPUT deleted.Id, deleted.SpecializationGroupId, deleted.UniversalId, deleted.UiDisplayText, deleted.SqlSetWhere, deleted.OrderId
    WHERE Id = @id;
END




GO
/****** Object:  StoredProcedure [adm].[sp_DeleteSpecializationGroup]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =======================================
-- Author:      Cliff Spital
-- Create date: 2019/3/14
-- Description: Deletes an app.SpecializationGroup and associated app.Specialization if FKs are satisfied.
-- =======================================
CREATE PROCEDURE [adm].[sp_DeleteSpecializationGroup]
    @id int,
    @user auth.[User]
AS
BEGIN
    SET NOCOUNT ON

    IF NOT EXISTS(SELECT 1 FROM app.SpecializationGroup WHERE Id = @id)
        THROW 70404, N'SpecializationGroup not found.', 1;

    BEGIN TRAN;

    DECLARE @deps TABLE (
        Id UNIQUEIDENTIFIER NOT NULL,
        UniversalId nvarchar(200) NULL,
        UiDisplayName nvarchar(400) NULL
    );
    INSERT INTO @deps (Id, UniversalId, UiDisplayName)
    SELECT c.Id, c.UniversalId, c.UiDisplayName
    FROM app.Concept c
    JOIN rela.ConceptSpecializationGroup csg ON c.Id = csg.ConceptId
    WHERE csg.SpecializationGroupId = @id;

    IF EXISTS(SELECT 1 FROM @deps)
    BEGIN;
        -- there are dependents, bail
        ROLLBACK;

        SELECT Id, UniversalId, UiDisplayName
        FROM @deps;

        RETURN;
    END;

    DELETE FROM app.Specialization
    WHERE SpecializationGroupId = @id;

    DELETE FROM app.SpecializationGroup
    WHERE Id = @id;

    COMMIT;

    SELECT Id = NULL, UniversalId = NULL, UiDisplayName = NULL
    WHERE 0 = 1;

END




GO
/****** Object:  StoredProcedure [adm].[sp_GetConceptById]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =======================================
-- Author:      Cliff Spital
-- Create date: 2019/3/19
-- Description: Retrieve a fully hydrated Admin.Concept by Id.
-- =======================================
CREATE PROCEDURE [adm].[sp_GetConceptById]
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON

    -- select concept
    SELECT 
        Id,
        UniversalId,
        ParentId,
        RootId,
        ExternalId,
        ExternalParentId,
        SqlSetId,
        [IsNumeric],
        IsParent,
        IsPatientCountAutoCalculated,
        IsSpecializable,
        SqlSetWhere,
        SqlFieldNumeric,
        UiDisplayName,
        UiDisplayText,
        UiDisplaySubtext,
        UiDisplayUnits,
        UiDisplayTooltip,
        UiDisplayPatientCount,
        UiDisplayPatientCountByYear,
        UiNumericDefaultText
    FROM app.Concept
    WHERE Id = @id;

    -- select specializationgroupids
    SELECT
        SpecializationGroupId,
        OrderId
    FROM rela.ConceptSpecializationGroup csg
    WHERE csg.ConceptId = @id;

    -- select constraints
    SELECT
        ConceptId,
        ConstraintId,
        ConstraintValue
    FROM auth.ConceptConstraint
    WHERE ConceptId = @id;

END



GO
/****** Object:  StoredProcedure [adm].[sp_GetConceptEvents]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =======================================
-- Author:      Nic Dobbins
-- Create date: 2019/4/8
-- Description: Gets all app.ConceptEvent records.
-- =======================================
CREATE PROCEDURE [adm].[sp_GetConceptEvents]    
AS
BEGIN
    SET NOCOUNT ON

    SELECT
        Id,
        UiDisplayEventName
    FROM
        app.ConceptEvent;
END



GO
/****** Object:  StoredProcedure [adm].[sp_GetConceptSqlSets]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =======================================
-- Author:      Cliff Spital
-- Create date: 2019/3/7
-- Description: Gets all app.ConceptSqlSet records.
-- =======================================
CREATE PROCEDURE [adm].[sp_GetConceptSqlSets]    
AS
BEGIN
    SET NOCOUNT ON

    SELECT
        Id,
        IsEncounterBased,
        IsEventBased,
        SqlSetFrom,
        SqlFieldDate,
        SqlFieldEvent,
		EventId
    FROM
        app.ConceptSqlSet;
END



GO
/****** Object:  StoredProcedure [adm].[sp_GetDatasetQueryById]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =======================================
-- Author:      Cliff Spital
-- Create date: 2019/6/4
-- Description: Get an app.DatasetQuery by Id for admins.
-- =======================================
CREATE PROCEDURE [adm].[sp_GetDatasetQueryById]
    @id UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON

	-- Get dataset
	SELECT
		dq.Id,
		dq.UniversalId,
		dq.Shape,
		dq.Name,
		dq.CategoryId,
		dq.[Description],
		dq.SqlStatement,
		IsEncounterBased = ISNULL(ddq.IsEncounterBased, 1),
		ddq.[Schema],
		ddq.SqlFieldDate,
		ddq.SqlFieldValueString,
		ddq.SqlFieldValueNumeric,
		dq.Created,
		dq.CreatedBy,
		dq.Updated,
		dq.UpdatedBy
	FROM app.DatasetQuery dq
		 LEFT JOIN app.DynamicDatasetQuery ddq
			ON dq.Id = ddq.Id
	WHERE dq.Id = @id

    -- Get tags
    SELECT
        DatasetQueryId,
        Tag
    FROM app.DatasetQueryTag
    WHERE DatasetQueryId = @id;

    -- Get constraints
    SELECT
        DatasetQueryId,
        ConstraintId,
        ConstraintValue
    FROM auth.DatasetQueryConstraint
    WHERE DatasetQueryId = @id;
END
GO
/****** Object:  StoredProcedure [adm].[sp_GetDatasetQueryCategory]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Cliff Spital
-- Create date: 2019/6/5
-- Description: Gets all DatasetQueryCategory.
-- =======================================
CREATE PROCEDURE [adm].[sp_GetDatasetQueryCategory]    
AS
BEGIN
    SET NOCOUNT ON

    SELECT
        Id,
        Category,
        Created,
        CreatedBy,
        Updated,
        UpdatedBy
    FROM app.DatasetQueryCategory;
END
GO
/****** Object:  StoredProcedure [adm].[sp_GetDemographicQuery]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Cliff Spital
-- Create date: 2019/6/12
-- Description: Fetch the app.DemographicQuery record for an admin.
-- =======================================
CREATE PROCEDURE [adm].[sp_GetDemographicQuery]
AS
BEGIN
    SET NOCOUNT ON

    SELECT
        SqlStatement,
        LastChanged,
        ChangedBy
    FROM app.DemographicQuery;
END
GO
/****** Object:  StoredProcedure [adm].[sp_GetGlobalPanelFilters]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Nic Dobbins
-- Create date: 2019/8/26
-- Description: Gets all GlobalPanelFilters.
-- =======================================
CREATE PROCEDURE [adm].[sp_GetGlobalPanelFilters]
AS
BEGIN
    
	SELECT
		Id
	  , SessionType
	  , IsInclusion
	  , SqlSetId
	  , SqlSetWhere
	FROM app.GlobalPanelFilter

END
GO
/****** Object:  StoredProcedure [adm].[sp_GetPanelFilters]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Nic Dobbins
-- Create date: 2019/8/26 
-- Description: Gets all panel filters.
-- =======================================
CREATE PROCEDURE [adm].[sp_GetPanelFilters]
AS
BEGIN
    
	SELECT
		Id
	  , ConceptId
	  , IsInclusion
	  , UiDisplayText
	  , UiDisplayDescription
	FROM app.PanelFilter

END
GO
/****** Object:  StoredProcedure [adm].[sp_GetSpecializationGroups]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =======================================
-- Author:      Cliff Spital
-- Create date: 2019/3/13
-- Description: Gets all app.SpecializationGroup and associated app.Specialization.
-- =======================================
CREATE PROCEDURE [adm].[sp_GetSpecializationGroups]
AS
BEGIN
    SET NOCOUNT ON

    SELECT
        Id,
        SqlSetId,
        UiDefaultText
    FROM app.SpecializationGroup;

    SELECT
        Id,
        SpecializationGroupId,
        UniversalId,
        UiDisplayText,
        SqlSetWhere,
        OrderId
    FROM app.Specialization;
END



GO
/****** Object:  StoredProcedure [adm].[sp_GetSpecializationsByGroupId]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =======================================
-- Author:      Cliff Spital
-- Create date: 2019/3/11
-- Description: Gets all app.Specialization by SpecializationGroupId.
-- =======================================
CREATE PROCEDURE [adm].[sp_GetSpecializationsByGroupId]
    @groupId int
AS
BEGIN
    SET NOCOUNT ON

    DECLARE @s TABLE (
        Id UNIQUEIDENTIFIER not null,
        SpecializationGroupId int not null,
        UniversalId nvarchar(200),
        UiDisplayText nvarchar(100) not null,
        SqlSetWhere nvarchar(1000) not null,
        OrderId int
    )

    INSERT INTO @s
    SELECT
        Id,
        SpecializationGroupId,
        UniversalId,
        UiDisplayText,
        SqlSetWhere,
        OrderId
    FROM app.Specialization
    WHERE SpecializationGroupId = @groupId;

    IF NOT EXISTS(SELECT 1 FROM @s) AND NOT EXISTS(SELECT 1 FROM app.SpecializationGroup WHERE Id = @groupId)
        THROW 70404, N'SpecializationGroup is missing.', 1;
    
    SELECT
        Id,
        SpecializationGroupId,
        UniversalId,
        UiDisplayText,
        SqlSetWhere,
        OrderId
    FROM @s;
END




GO
/****** Object:  StoredProcedure [adm].[sp_GetUsersBySearchTerm]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Nic Dobbins
-- Create date: 2019/11/15
-- Description: Retrieves all users who matching a given search string.
-- =======================================
CREATE PROCEDURE [adm].[sp_GetUsersBySearchTerm]
    @term NVARCHAR(50),
	@limit INT = 10
AS
BEGIN
    SET NOCOUNT ON

    SELECT TOP (@limit)
		L.Id
	  , L.ScopedIdentity
	  , L.FullIdentity
	  , SavedQueryCount = (SELECT COUNT(*) FROM [app].[Query] AS Q WHERE L.FullIdentity = Q.[Owner] AND Q.UniversalId IS NOT NULL AND Q.Nonce IS NULL)
	  , L.Created
	  , L.Updated
	FROM auth.[Login] AS L
	WHERE L.ScopedIdentity LIKE @term + '%'

END
GO
/****** Object:  StoredProcedure [adm].[sp_UpdateConcept]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Cliff Spital
-- Create date: 2019/3/29
-- Description: Updates an app.Concept along with auth.ConceptConstraint and rela.ConceptSpecializationGroup.
-- =======================================
CREATE PROCEDURE [adm].[sp_UpdateConcept]
    @id uniqueidentifier,
    @universalId nvarchar(200),
    @parentId uniqueidentifier,
    @rootId uniqueidentifier,
    @externalId nvarchar(200),
    @externalParentId nvarchar(200),
    @isPatientCountAutoCalculated bit,
    @isNumeric bit,
    @isParent bit,
    @isRoot bit,
    @isSpecializable bit,
    @sqlSetId int,
    @sqlSetWhere nvarchar(1000),
    @sqlFieldNumeric nvarchar(1000),
    @uiDisplayName nvarchar(400),
    @uiDisplayText nvarchar(1000),
    @uiDisplaySubtext nvarchar(100),
	@uiDisplayUnits nvarchar(50),
	@uiDisplayTooltip nvarchar(max),
	@uiDisplayPatientCount int,
	@uiNumericDefaultText nvarchar(50),
    @constraints auth.ResourceConstraintTable READONLY,
    @specializationGroups rela.ConceptSpecializationGroupTable READONLY,
    @user auth.[User]
AS
BEGIN
    SET NOCOUNT ON

    IF NOT EXISTS(SELECT 1 FROM app.Concept WHERE Id = @id)
    BEGIN;
        THROW 70404, N'Concept not found.', 1;
    END;

    IF (@parentId IS NOT NULL AND NOT EXISTS(SELECT 1 FROM app.Concept WHERE Id = @parentId))
    BEGIN;
        THROW 70404, N'Parent concept not found.', 1;
    END;

    IF (@rootId IS NOT NULL AND NOT EXISTS(SELECT 1 FROM app.Concept WHERE Id = @rootId))
    BEGIN;
        THROW 70404, N'Root concept not found.', 1;
    END;

    IF ((SELECT COUNT(*) FROM app.SpecializationGroup WHERE Id IN (SELECT SpecializationGroupId FROM @specializationGroups)) != (SELECT COUNT(*) FROM @specializationGroups))
    BEGIN;
        THROW 70404, N'SpecializationGroup not found.', 1;
    END;

    BEGIN TRAN;
    BEGIN TRY

		DECLARE @oldRootId UNIQUEIDENTIFIER = (SELECT TOP 1 RootId FROM app.Concept WHERE Id = @id)

        UPDATE app.Concept
        SET
            UniversalId = @universalId,
            ParentId = @parentId,
            RootId = @rootId,
            ExternalId = @externalId,
            ExternalParentId = @externalParentId,
            IsPatientCountAutoCalculated = @isPatientCountAutoCalculated,
            [IsNumeric] = @isNumeric,
            IsParent = @isParent,
            IsRoot = @isRoot,
            IsSpecializable = @isSpecializable,
            SqlSetId = @sqlSetId,
            SqlSetWhere = @sqlSetWhere,
            SqlFieldNumeric = @sqlFieldNumeric,
            UiDisplayName = @uiDisplayName,
            UiDisplayText = @uiDisplayText,
            UiDisplaySubtext = @uiDisplaySubtext,
            UiDisplayUnits = @uiDisplayUnits,
            UiDisplayTooltip = @uiDisplayTooltip,
            UiDisplayPatientCount = @uiDisplayPatientCount,
            UiNumericDefaultText = @uiNumericDefaultText,
            ContentLastUpdateDateTime = GETDATE(),
            PatientCountLastUpdateDateTime = CASE WHEN UiDisplayPatientCount = @uiDisplayPatientCount THEN PatientCountLastUpdateDateTime ELSE GETDATE() END
        WHERE Id = @id;

		IF (@rootId != @oldRootId)

		BEGIN
			; WITH descendents AS
			(
				SELECT Id = @id
				UNION ALL
				SELECT C2.Id
				FROM descendents AS D
					 INNER JOIN app.Concept AS C2
						ON C2.ParentId = D.Id
			)
			SELECT DISTINCT Id
			INTO #descendents
			FROM descendents

			UPDATE app.Concept
			SET RootId = @rootId
			FROM app.Concept AS C
			WHERE EXISTS (SELECT 1 FROM #descendents AS D WHERE C.Id = D.Id)

			UPDATE app.ConceptForwardIndex
			SET RootId = @rootId
			FROM app.Concept C
				 INNER JOIN app.ConceptForwardIndex FI
					ON C.Id = FI.ConceptId
			WHERE EXISTS (SELECT 1 FROM #descendents AS D WHERE C.Id = D.Id)

			DROP TABLE #descendents

		END

        DELETE FROM auth.ConceptConstraint
        WHERE ConceptId = @id;

        INSERT INTO auth.ConceptConstraint
        SELECT @id, ConstraintId, ConstraintValue
        FROM @constraints;

        DELETE FROM rela.ConceptSpecializationGroup
        WHERE ConceptId = @id;

        INSERT INTO rela.ConceptSpecializationGroup
        SELECT @id, SpecializationGroupId, OrderId
        FROM @specializationGroups;

        COMMIT;

        EXEC adm.sp_GetConceptById @id;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        THROW;
    END CATCH;
END
GO
/****** Object:  StoredProcedure [adm].[sp_UpdateConceptEvent]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Nic Dobbins
-- Create date: 2019/4/8
-- Description: Updates an app.ConceptSqlEvent.
-- =======================================
CREATE PROCEDURE [adm].[sp_UpdateConceptEvent]
    @id int,
    @uiDisplayEventName nvarchar(50),
    @user auth.[User]
AS
BEGIN
    SET NOCOUNT ON

    IF (@id IS NULL)
        THROW 70400, N'ConceptSqlEvent.Id is required.', 1;

    IF (app.fn_NullOrWhitespace(@uiDisplayEventName) = 1)
        THROW 70400, N'ConceptSqlEvent.UiDisplayEventName is required', 1;

    BEGIN TRAN;
    BEGIN TRY

        IF EXISTS (SELECT 1 FROM app.ConceptEvent WHERE Id != @id AND UiDisplayEventName = @uiDisplayEventName)
            THROW 70409, N'ConceptEvent already exists with that UiDisplayEventName.', 1;

        UPDATE app.ConceptEvent
        SET
            UiDisplayEventName = @uiDisplayEventName,
            Updated = GETDATE(),
            UpdatedBy = @user
        OUTPUT inserted.Id, inserted.UiDisplayEventName
        WHERE
            Id = @id;
        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        THROW;
    END CATCH;

END
GO
/****** Object:  StoredProcedure [adm].[sp_UpdateConceptSqlSet]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Cliff Spital
-- Create date: 2019/8/3
-- Description: Updates an app.ConceptSqlSet.
-- =======================================
CREATE PROCEDURE [adm].[sp_UpdateConceptSqlSet]
    @id int,
    @isEncounterBased bit,
    @isEventBased bit,
    @sqlSetFrom nvarchar(1000),
    @sqlFieldDate nvarchar(1000),
    @sqlFieldEvent nvarchar(400),
    @eventId int,
    @user auth.[User]
AS
BEGIN
    SET NOCOUNT ON

    IF (@id IS NULL)
        THROW 70400, N'ConceptSqlSet.Id is required.', 1;
    
    IF (app.fn_NullOrWhitespace(@sqlSetFrom) = 1)
        THROW 70400, N'ConceptSqlSet.SqlSetFrom is required.', 1;

    UPDATE app.ConceptSqlSet
    SET
        IsEncounterBased = @isEncounterBased,
        IsEventBased = @isEventBased,
        SqlSetFrom = @sqlSetFrom,
        SqlFieldDate = @sqlFieldDate,
        SqlFieldEvent = @sqlFieldEvent,
        EventId = @eventId,
        Updated = GETDATE(),
        UpdatedBy = @user
    OUTPUT inserted.Id, inserted.IsEncounterBased, inserted.IsEventBased, inserted.SqlSetFrom, inserted.SqlFieldDate, inserted.SqlFieldEvent, inserted.EventId
    WHERE Id = @id;
END
GO
/****** Object:  StoredProcedure [adm].[sp_UpdateDatasetQuery]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Cliff Spital
-- Create date: 2019/6/4
-- Description: Update a datasetquery.
-- =======================================
CREATE PROCEDURE [adm].[sp_UpdateDatasetQuery]
    @id UNIQUEIDENTIFIER,
    @uid app.UniversalId,
    @shape int,
    @name nvarchar(200),
    @catid int,
    @desc nvarchar(max),
    @sql nvarchar(4000),
    @tags app.DatasetQueryTagTable READONLY,
    @constraints auth.ResourceConstraintTable READONLY,
    @user auth.[User]
AS
BEGIN
    SET NOCOUNT ON

    IF (@id IS NULL)
        THROW 70400, N'DatasetQuery.Id is required.', 1;

    IF (@shape IS NULL)
        THROW 70400, N'DatasetQuery.Shape is required.', 1;
    
    IF NOT EXISTS (SELECT Id FROM ref.Shape WHERE Id = @shape)
        THROW 70404, N'DatasetQuery.Shape is not supported.', 1;
    
    IF (app.fn_NullOrWhitespace(@name) = 1)
        THROW 70400, N'DatasetQuery.Name is required.', 1;

    IF (app.fn_NullOrWhitespace(@sql) = 1)
        THROW 70400, N'DatasetQuery.SqlStatement is required.', 1;
    
    BEGIN TRAN;
    BEGIN TRY

        IF NOT EXISTS (SELECT Id FROM app.DatasetQuery WHERE Id = @id)
            THROW 70404, N'DatasetQuery not found.', 1;

        IF EXISTS (SELECT 1 FROM app.DatasetQuery WHERE Id != @id AND (@uid = UniversalId))
            THROW 70409, N'DatasetQuery already exists with universal id.', 1;

		DECLARE @ins TABLE (
            Id uniqueidentifier,
            UniversalId nvarchar(200) null,
            Shape int not null,
            [Name] nvarchar(200) not null,
            CategoryId int null,
            [Description] nvarchar(max) null,
            SqlStatement nvarchar(4000) not null,
            Created datetime not null,
            CreatedBy nvarchar(1000) not null,
            Updated datetime not null,
            UpdatedBy nvarchar(1000) not null,
			[IsEncounterBased] bit null
        );

        UPDATE app.DatasetQuery
        SET
            UniversalId = @uid,
            Shape = @shape,
            [Name] = @name,
            CategoryId = @catid,
            [Description] = @desc,
            SqlStatement = @sql,
            Updated = GETDATE(),
            UpdatedBy = @user
		OUTPUT
            inserted.Id,
            inserted.UniversalId,
            inserted.Shape,
            inserted.Name,
            inserted.CategoryId,
            inserted.[Description],
            inserted.SqlStatement,
            inserted.Created,
            inserted.CreatedBy,
            inserted.Updated,
            inserted.UpdatedBy,
			CAST(1 AS BIT)
		INTO @ins
        WHERE Id = @id;

		DELETE app.DynamicDatasetQuery
		WHERE Id = @id

		SELECT * FROM @ins

        DELETE FROM app.DatasetQueryTag
        WHERE DatasetQueryId = @id;

        INSERT INTO app.DatasetQueryTag (DatasetQueryId, Tag)
        OUTPUT inserted.DatasetQueryId, inserted.Tag
        SELECT @id, Tag
        FROM @tags;

        DELETE FROM auth.DatasetQueryConstraint
        WHERE DatasetQueryId = @id;

        INSERT INTO auth.DatasetQueryConstraint (DatasetQueryId, ConstraintId, ConstraintValue)
        OUTPUT inserted.DatasetQueryId, inserted.ConstraintId, inserted.ConstraintValue
        SELECT @id, ConstraintId, ConstraintValue
        FROM @constraints;

        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        THROW;
    END CATCH;

END
GO
/****** Object:  StoredProcedure [adm].[sp_UpdateDatasetQueryCategory]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Cliff Spital
-- Create date: 2019/6/6
-- Description: Updates an app.DatasetQueryCategory.
-- =======================================
CREATE PROCEDURE [adm].[sp_UpdateDatasetQueryCategory]
    @id int,
    @cat nvarchar(200),
    @user auth.[User]
AS
BEGIN
    SET NOCOUNT ON

    IF (@id IS NULL)
        THROW 70400, N'DatasetQueryCategory.Id is required.', 1;

    IF (app.fn_NullOrWhitespace(@cat) = 1)
        THROW 70400, N'DatasetQueryCategory.Category is required.', 1;

    BEGIN TRAN;
    BEGIN TRY
        IF NOT EXISTS(SELECT 1 FROM app.DatasetQueryCategory WHERE Id = @id)
            THROW 70404, N'DatasetQueryCategory not found.', 1;

        IF EXISTS(SELECT Id FROM app.DatasetQueryCategory WHERE Id != @id AND Category = @cat)
            THROW 70409, N'DatasetQueryCategory already exists with that name.', 1;
        
        UPDATE app.DatasetQueryCategory
        SET
            Category = @cat,
            Updated = GETDATE(),
            UpdatedBy = @user
        OUTPUT
            inserted.Id,
            inserted.Category,
            inserted.Created,
            inserted.CreatedBy,
            inserted.Updated,
            inserted.UpdatedBy
        WHERE Id = @id

        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        THROW;
    END CATCH;
END
GO
/****** Object:  StoredProcedure [adm].[sp_UpdateDemographicQuery]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [adm].[sp_UpdateDemographicQuery]
    @sql nvarchar(4000),
    @user auth.[User]
AS
BEGIN
    SET NOCOUNT ON

    IF (app.fn_NullOrWhitespace(@sql) = 1)
        THROW 70400, N'DemographicQuery.SqlStatement is required.', 1;
    
    BEGIN TRAN;
    BEGIN TRY
        
        IF EXISTS (SELECT Lock FROM app.DemographicQuery)
        BEGIN;
            UPDATE app.DemographicQuery
            SET
                SqlStatement = @sql,
                LastChanged = GETDATE(),
                ChangedBy = @user
            OUTPUT
                inserted.SqlStatement,
                inserted.LastChanged,
                inserted.ChangedBy;
        END;
        ELSE
        BEGIN;
            INSERT INTO app.DemographicQuery (SqlStatement, LastChanged, ChangedBy, Shape)
            OUTPUT inserted.SqlStatement, inserted.LastChanged, inserted.ChangedBy, inserted.Shape
            VALUES (@sql, GETDATE(), @user, 3);
        END;

        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        THROW;
    END CATCH;

END

GO
/****** Object:  StoredProcedure [adm].[sp_UpdateDynamicDatasetQuery]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =======================================
-- Author:      Nic Dobbins
-- Create date: 2019/7/22
-- Description: Update a dynamic datasetquery.
-- =======================================
CREATE PROCEDURE [adm].[sp_UpdateDynamicDatasetQuery]
    @id UNIQUEIDENTIFIER,
    @name nvarchar(200),
    @catid int,
    @desc nvarchar(max),
    @sql nvarchar(4000),
	@isEnc bit,
	@schema nvarchar(max),
	@sqlDate nvarchar(1000) = NULL,
	@sqlValString nvarchar(1000) = NULL,
	@sqlValNum nvarchar(1000) = NULL,
    @tags app.DatasetQueryTagTable READONLY,
    @constraints auth.ResourceConstraintTable READONLY,
    @user auth.[User]
AS
BEGIN
    SET NOCOUNT ON

    IF (@id IS NULL)
        THROW 70400, N'DatasetQuery.Id is required.', 1;
    
    IF (app.fn_NullOrWhitespace(@name) = 1)
        THROW 70400, N'DatasetQuery.Name is required.', 1;

    IF (app.fn_NullOrWhitespace(@sql) = 1)
        THROW 70400, N'DatasetQuery.SqlStatement is required.', 1;

	IF (app.fn_NullOrWhitespace(@schema) = 1)
        THROW 70400, N'DatasetQuery.Schema is required.', 1;
    
    BEGIN TRAN;
    BEGIN TRY

        IF NOT EXISTS (SELECT Id FROM app.DatasetQuery WHERE Id = @id)
            THROW 70404, N'DatasetQuery not found.', 1;

		DECLARE @upd1 TABLE (
            Id uniqueidentifier,
            UniversalId nvarchar(200) null,
            Shape int not null,
            [Name] nvarchar(200) not null,
            CategoryId int null,
            [Description] nvarchar(max) null,
            SqlStatement nvarchar(4000) not null,
			IsEncounterBased bit null,
			[Schema] nvarchar(max) null,
			SqlFieldDate nvarchar(1000) null,
			SqlFieldValueString nvarchar(1000) null,
			SqlFieldValueNumeric nvarchar(1000) null,
            Created datetime not null,
            CreatedBy nvarchar(1000) not null,
            Updated datetime not null,
            UpdatedBy nvarchar(1000) not null
        );

		DECLARE @upd2 TABLE (
            Id uniqueidentifier,
			IsEncounterBased bit null,
			[Schema] nvarchar(max) null,
			SqlFieldDate nvarchar(1000) null,
			SqlFieldValueString nvarchar(1000) null,
			SqlFieldValueNumeric nvarchar(1000) null
        );

		UPDATE app.DatasetQuery
        SET
            [Shape] = -1,
            [Name] = @name,
            [CategoryId] = @catid,
            [Description] = @desc,
            [SqlStatement] = @sql,
            [Updated] = GETDATE(),
            [UpdatedBy] = @user
		OUTPUT
            inserted.Id,
            inserted.UniversalId,
            inserted.Shape,
            inserted.[Name],
            inserted.CategoryId,
            inserted.[Description],
            inserted.SqlStatement,
            inserted.Created,
            inserted.CreatedBy,
            inserted.Updated,
            inserted.UpdatedBy
        INTO @upd1 (Id, UniversalId, Shape, [Name], CategoryId, [Description], SqlStatement, Created, CreatedBy, Updated, UpdatedBy)
        WHERE Id = @id;

		DELETE app.DynamicDatasetQuery
		WHERE Id = @id

        INSERT INTO app.DynamicDatasetQuery ([Id], [IsEncounterBased], [Schema], [SqlFieldDate], [SqlFieldValueString], [SqlFieldValueNumeric])
		OUTPUT
            inserted.Id,
            inserted.[IsEncounterBased],
			inserted.[Schema],
			inserted.[SqlFieldDate],
			inserted.[SqlFieldValueString],
			inserted.[SqlFieldValueNumeric]
        INTO @upd2 ([Id], [IsEncounterBased], [Schema], [SqlFieldDate], [SqlFieldValueString], [SqlFieldValueNumeric])
		VALUES (@id, @isEnc, @schema, @sqlDate, @sqlValString, @sqlValNum)

		UPDATE @upd1
		SET 
			[IsEncounterBased] = i2.[IsEncounterBased],
			[Schema] = i2.[Schema],
			[SqlFieldDate] = i2.[SqlFieldDate],
			[SqlFieldValueString] = i2.[SqlFieldValueString],
			[SqlFieldValueNumeric] = i2.[SqlFieldValueNumeric]
		FROM @upd2 AS i2

		SELECT * FROM @upd1

        DELETE FROM app.DatasetQueryTag
        WHERE DatasetQueryId = @id;

        INSERT INTO app.DatasetQueryTag (DatasetQueryId, Tag)
        OUTPUT inserted.DatasetQueryId, inserted.Tag
        SELECT @id, Tag
        FROM @tags;

        DELETE FROM auth.DatasetQueryConstraint
        WHERE DatasetQueryId = @id;

        INSERT INTO auth.DatasetQueryConstraint (DatasetQueryId, ConstraintId, ConstraintValue)
        OUTPUT inserted.DatasetQueryId, inserted.ConstraintId, inserted.ConstraintValue
        SELECT @id, ConstraintId, ConstraintValue
        FROM @constraints;

        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        THROW;
    END CATCH;

END
GO
/****** Object:  StoredProcedure [adm].[sp_UpdateEndpoint]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Cliff Spital
-- Create date: 2019/5/28
-- Description:	Update the given network.Endpoint
-- =============================================
CREATE PROCEDURE [adm].[sp_UpdateEndpoint]
	@id int,
	@name nvarchar(200),
	@addr nvarchar(1000),
	@iss nvarchar(200),
	@kid nvarchar(200),
	@cert nvarchar(max),
    @isResponder bit,
    @isInterrogator bit,
    @user auth.[User]
AS
BEGIN
	SET NOCOUNT ON;

    IF (@id IS NULL)
		THROW 70400, N'NetworkEndpoint.Id is required.', 1;

	IF (app.fn_NullOrWhitespace(@name) = 1)
        THROW 70400, N'NetworkEndpoint.Name is required.', 1;
    
    IF (app.fn_NullOrWhitespace(@addr) = 1)
        THROW 70400, N'NetworkEndpoint.Address is required.', 1;
    
    IF (app.fn_NullOrWhitespace(@iss) = 1)
        THROW 70400, N'NetworkEndpoint.Issuer is required.', 1;
    
    IF (app.fn_NullOrWhitespace(@kid) = 1)
        THROW 70400, N'NetworkEndpoint.KeyId is required.', 1;
    
    IF (app.fn_NullOrWhitespace(@cert) = 1)
        THROW 70400, N'NetworkEndpoint.Certificate is required.', 1;
    
    IF (@isInterrogator IS NULL)
        THROW 70400, N'NetworkEndpoint.IsInterrogator is required.', 1;

    IF (@isResponder IS NULL)
        THROW 70400, N'NetworkEndpoint.IsResponder is required.', 1;

    BEGIN TRAN;
    BEGIN TRY
        IF NOT EXISTS (SELECT 1 FROM network.Endpoint WHERE Id = @id)
			THROW 70404, N'NetworkEndpoint not found.', 1;

        IF EXISTS (SELECT 1 FROM network.Endpoint WHERE Id != @id AND (Name = @name OR KeyId = @kid OR Issuer = @iss))
            THROW 70409, N'NetworkEndpoint already exists with that name, key id, or issuer value.', 1;

        UPDATE network.Endpoint
        SET
            Name = @name,
            Address = @addr,
            Issuer = @iss,
            KeyId = @kid,
            Certificate = @cert,
            IsResponder = @isResponder,
            IsInterrogator = @isInterrogator,
            Updated = GETDATE()
        OUTPUT
            inserted.Id,
            inserted.Name,
            inserted.Address,
            inserted.Issuer,
            inserted.KeyId,
            inserted.Certificate,
            inserted.IsResponder,
            inserted.IsInterrogator,
            inserted.Updated,
            inserted.Created
        WHERE
            Id = @id;
        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        THROW;
    END CATCH;

END
GO
/****** Object:  StoredProcedure [adm].[sp_UpdateGlobalPanelFilter]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Nic Dobbins
-- Create date: 2019/8/26
-- Description: Updates an app.GlobalPanelFilter.
-- =======================================
CREATE PROCEDURE [adm].[sp_UpdateGlobalPanelFilter]
	@id int,
    @sessionType auth.SessionType,
	@isInclusion bit,
	@sqlSetId int,
	@sqlSetWhere nvarchar(1000),
	@user auth.[User]
AS
BEGIN
    SET NOCOUNT ON

    BEGIN TRAN;
    BEGIN TRY

		IF NOT EXISTS (SELECT 1 FROM app.GlobalPanelFilter WHERE Id = @id)
            THROW 70409, N'GlobalPanelFilter does not exist.', 1;

		SET @sessionType = CASE @sessionType WHEN 0 THEN NULL ELSE @sessionType END

		UPDATE app.GlobalPanelFilter
		SET SessionType = @sessionType
		  , IsInclusion = @isInclusion
		  , SqlSetId = @sqlSetId
		  , SqlSetWhere = @sqlSetWhere
		  , Updated = GETDATE()
		  , UpdatedBy = @user
		OUTPUT inserted.Id, inserted.SessionType, inserted.IsInclusion, inserted.SqlSetId, inserted.SqlSetWhere
		WHERE Id = @id

        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        THROW;
    END CATCH;
END
GO
/****** Object:  StoredProcedure [adm].[sp_UpdatePanelFilter]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Nic Dobbins
-- Create date: 2019/8/26
-- Description: Updates a app.PanelFilter.
-- =======================================
CREATE PROCEDURE [adm].[sp_UpdatePanelFilter]
	@id int,
    @conceptId uniqueidentifier,
    @isInclusion bit,
	@uiDisplayText nvarchar(1000),
	@uiDisplayDescription nvarchar(4000),
	@user auth.[User]
AS
BEGIN
    SET NOCOUNT ON

	IF NOT EXISTS (SELECT 1 FROM app.Concept WHERE Id = @conceptId)
        THROW 70400, N'PanelFilter.Concept does not exist.', 1;

    IF (app.fn_NullOrWhitespace(@uiDisplayText) = 1)
        THROW 70400, N'PanelFilter.UiDisplayText is required.', 1;

	IF (app.fn_NullOrWhitespace(@uiDisplayDescription) = 1)
        THROW 70400, N'PanelFilter.UiDisplayDescription is required.', 1;

    BEGIN TRAN;
    BEGIN TRY

        IF NOT EXISTS (SELECT 1 FROM app.PanelFilter WHERE Id = @id)
            THROW 70409, N'PanelFilter does not exist.', 1;

		UPDATE app.PanelFilter
		SET ConceptId = @conceptId
		  , IsInclusion = @isInclusion
		  , UiDisplayText = @uiDisplayText
		  , UiDisplayDescription = @uiDisplayDescription
		  , Updated = GETDATE()
		  , UpdatedBy = @user
		OUTPUT inserted.Id, inserted.ConceptId, inserted.IsInclusion, inserted.UiDisplayText, inserted.UiDisplayDescription
		WHERE Id = @id

        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        THROW;
    END CATCH;
END
GO
/****** Object:  StoredProcedure [adm].[sp_UpdateSpecialization]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Cliff Spital
-- Create date: 2019/3/11
-- Description: Updates an app.Specialization.
-- =======================================
CREATE PROCEDURE [adm].[sp_UpdateSpecialization]
    @id UNIQUEIDENTIFIER,
    @groupId int,
    @uid app.UniversalId,
    @uiDisplayText nvarchar(100),
    @sqlSetWhere nvarchar(1000),
    @order int,
    @user auth.[User]
AS
BEGIN
    SET NOCOUNT ON

    IF (@groupId IS NULL)
        THROW 70400, N'Specialization.SpecializationGroupId is required.', 1;

    IF (app.fn_NullOrWhitespace(@uiDisplayText) = 1)
        THROW 70400, N'Specialization.UiDisplayText is required.', 1;

    IF (app.fn_NullOrWhitespace(@sqlSetWhere) = 1)
        THROW 70400, N'Specialization.SqlSetWhere is required.', 1;

    UPDATE app.Specialization
    SET
        SpecializationGroupId = @groupId,
        UniversalId = @uid,
        UiDisplayText = @uiDisplayText,
        SqlSetWhere = @sqlSetWhere,
        OrderId = @order
    OUTPUT inserted.Id, inserted.SpecializationGroupId, inserted.UniversalId, inserted.UiDisplayText, inserted.SqlSetWhere, inserted.OrderId
    WHERE
        Id = @id;

END
GO
/****** Object:  StoredProcedure [adm].[sp_UpdateSpecializationGroup]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Cliff Spital
-- Create date: 2019/3/14
-- Description: Updates an app.SpecializationGroup.
-- =======================================
CREATE PROCEDURE [adm].[sp_UpdateSpecializationGroup]
    @id int,
    @sqlSetId int,
    @uiDefaultText nvarchar(100),
    @user auth.[User]
AS
BEGIN
    SET NOCOUNT ON

    IF (@id IS NULL)
        THROW 70400, N'SpecializationGroup.Id is required.', 1;

    IF (app.fn_NullOrWhitespace(@sqlSetId) = 1)
        THROW 70400, N'SpecializationGroup.SqlSetId is missing.', 1;
    
    IF (app.fn_NullOrWhitespace(@uiDefaultText) = 1)
        THROW 70400, N'SpecializationGroup.UiDefaultText is required.', 1;

    IF NOT EXISTS(SELECT 1 FROM app.ConceptSqlSet WHERE Id = @sqlSetId)
        THROW 70404, N'ConceptSqlSet is missing.', 1;
    
    UPDATE app.SpecializationGroup
    SET
        SqlSetId = @sqlSetId,
        UiDefaultText = @uiDefaultText,
        LastChanged = GETDATE(),
        ChangedBy = @user
    OUTPUT inserted.Id, inserted.SqlSetId, inserted.UiDefaultText
    WHERE Id = @id;
END
GO
/****** Object:  StoredProcedure [adm].[sp_UpsertIdentity]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Cliff Spital
-- Create date: 2019/5/23
-- Description: Inserts or updates network.Identity.
-- =======================================
CREATE PROCEDURE [adm].[sp_UpsertIdentity]
    @name nvarchar(300),
    @abbr nvarchar(20),
    @desc nvarchar(4000),
    @totalPatients int,
    @lat DECIMAL(7,4),
    @lng DECIMAL(7,4),
    @primColor nvarchar(40),
    @secColor nvarchar(40),
    @user auth.[User]
AS
BEGIN
    SET NOCOUNT ON

    IF (app.fn_NullOrWhitespace(@name) = 1)
        THROW 70400, N'NetworkIdentity.Name is required.', 1;

    BEGIN TRAN;

    IF EXISTS (SELECT Lock FROM network.[Identity])
    BEGIN;
        UPDATE network.[Identity]
        SET
            [Name] = @name,
            Abbreviation = @abbr,
            [Description] = @desc,
            TotalPatients = @totalPatients,
            Latitude = @lat,
            Longitude = @lng,
            PrimaryColor = @primColor,
            SecondaryColor = @secColor
        OUTPUT
            inserted.Name,
            inserted.Abbreviation,
            inserted.[Description],
            inserted.TotalPatients,
            inserted.Latitude,
            inserted.Longitude,
            inserted.PrimaryColor,
            inserted.SecondaryColor;
    END;
    ELSE
    BEGIN;
        INSERT INTO network.[Identity] ([Name], Abbreviation, [Description], TotalPatients, Latitude, Longitude, PrimaryColor, SecondaryColor)
        OUTPUT inserted.Name, inserted.Abbreviation, inserted.[Description], inserted.TotalPatients, inserted.Latitude, inserted.Longitude, inserted.PrimaryColor, inserted.SecondaryColor
        VALUES (@name, @abbr, @desc, @totalPatients, @lat, @lng, @primColor, @secColor);
    END;

    COMMIT;
END
GO
/****** Object:  StoredProcedure [app].[sp_CalculateConceptPatientCount]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Nic Dobbins
-- Create date: 2019/5/23
-- Description: Calculates the patient count for a given concept using
--              dynamic SQL for both the total unique patients and unique 
--              count by year.
-- =======================================
CREATE PROCEDURE [app].[sp_CalculateConceptPatientCount]
	@PersonIdField NVARCHAR(50),
	@TargetDatabaseName NVARCHAR(100),
	@From NVARCHAR(MAX),
	@Where NVARCHAR(MAX),
	@Date NVARCHAR(200),
	@isEncounterBased BIT,
	@CurrentRootId [uniqueidentifier],
	@CurrentConceptId [uniqueidentifier]
AS
BEGIN

	DECLARE @ExecuteSql NVARCHAR(MAX),
			@Result NVARCHAR(MAX),
			@ParameterDefinition NVARCHAR(MAX)= N'@TotalPatientsOUT INT OUTPUT',
			@PatientsByYearParameterDefinition NVARCHAR(MAX)= N'@TotalPatientsByYearOUT NVARCHAR(MAX) OUTPUT'
	
	BEGIN 

			-- Figure out if we need to add the db name
			DECLARE @DbFrom NVARCHAR(100) = @TargetDatabaseName + '.' + @From
			SET @DbFrom = 
				CASE
					WHEN OBJECT_ID(@DbFrom, 'U') IS NULL AND OBJECT_ID(@DbFrom, 'V') IS NULL THEN @From
					ELSE @DbFrom
				END
			
			------------------------------------------------------------------------------------------------------------------------------ 
			-- Total Patient Count
			------------------------------------------------------------------------------------------------------------------------------
			SELECT @ExecuteSql = 'SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;  
			
							      SELECT @TotalPatientsOUT = (SELECT COUNT(DISTINCT _T.' + @PersonIdField + ') ' +
															 'FROM ' + @DbFrom + ' AS _T ' +
															  ISNULL('WHERE ' + @Where,'') + 
															')'

			BEGIN TRY 
			
				EXECUTE sp_executesql 
					@ExecuteSql,
					@ParameterDefinition,
					@TotalPatientsOUT = @Result OUTPUT

				UPDATE app.Concept
				SET UiDisplayPatientCount = TRY_PARSE(@Result AS INT)
				  , PatientCountLastUpdateDateTime = GETDATE()
				WHERE Id = @CurrentConceptId

			END TRY 
			
			BEGIN CATCH 

				PRINT('Failed to run query for ' + CONVERT(NVARCHAR(50),@CurrentConceptId));
				PRINT('Failed query: ' + @ExecuteSql);
				PRINT('Error: ' + ERROR_MESSAGE())
				PRINT('')

			END CATCH

			------------------------------------------------------------------------------------------------------------------------------ 
			-- Patient Count by Year
			------------------------------------------------------------------------------------------------------------------------------
			IF (@isEncounterBased = 1 AND TRY_CONVERT(INT, @Result) > 0)
			
				BEGIN
				
					-- Output to the @TotalPatientsByYear (JSON) parameter to log the result
					SET @ExecuteSql = 
								'SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;  
								 
								 WITH year_calculation AS
									  (SELECT PatientYear = CONVERT(NVARCHAR(10),YEAR(' + @Date + '))
											, _T.' + @PersonIdField +'
									   FROM ' + @DbFrom + ' AS _T ' + 
									   ISNULL('WHERE ' + @Where,'') + ')
									  
									, year_grouping AS
									  (SELECT PatientYear
											, PatientCount = COUNT(DISTINCT ' + @PersonIdField + ')
									   FROM year_calculation
									   GROUP BY PatientYear)
								SELECT @TotalPatientsByYearOUT = (' + 
										 '''['' + STUFF(
		  										(SELECT ''{"Year":'' + PatientYear + '',"PatientCount":'' + CONVERT(NVARCHAR(20),PatientCount) + ''},'' 
		  										 FROM year_grouping
												 WHERE PatientCount > 0
												 ORDER BY PatientYear
		  										 FOR XML PATH(''''), TYPE).value(''text()[1]'', ''varchar(MAX)''
												 ), 1, 0, '''') +
										'']'')'
	
					BEGIN TRY 
						
						EXECUTE sp_executesql 
							@ExecuteSql,
							@PatientsByYearParameterDefinition,
							@TotalPatientsByYearOUT = @Result OUTPUT

						-- Clean up JSON by removing last unnecessary comma
						SET @Result = LEFT(@Result, LEN(@Result) - 2) + ']'

						UPDATE app.Concept
						SET UiDisplayPatientCountByYear = @Result
						WHERE Id = @CurrentConceptId

					END TRY 
			
					BEGIN CATCH 
			
						PRINT('Failed to run query for ' + CONVERT(NVARCHAR(50),@CurrentConceptId));
						PRINT('Failed query: ' + @ExecuteSql);
						PRINT('Error: ' + ERROR_MESSAGE())
						PRINT('')

					END CATCH

				END

		END 

END
GO
/****** Object:  StoredProcedure [app].[sp_CalculatePatientCounts]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Nic Dobbins
-- Create date: 2019/5/23
-- Description: Loops through Concepts and auto-calculates patient counts.
-- =======================================
CREATE PROCEDURE [app].[sp_CalculatePatientCounts]

@PersonIdField NVARCHAR(50),
@TargetDataBaseName NVARCHAR(50),
@TotalAllowedRuntimeInMinutes INT,
@PerRootConceptAllowedRuntimeInMinutes INT,
@SpecificRootConcept UNIQUEIDENTIFIER = NULL

AS
BEGIN

	SELECT Id
		 , RowNumber = DENSE_RANK() OVER(ORDER BY Id)
	INTO #Roots
	FROM app.Concept
	WHERE IsRoot = 1
		  AND (Id = @SpecificRootConcept OR @SpecificRootConcept IS NULL)

	DECLARE @TotalRoots INT = (SELECT MAX(RowNumber) FROM #roots),
			@CurrentRoot INT = 1,
			@CurrentRootId UNIQUEIDENTIFIER,
			@TotalConcepts INT,
			@CurrentConcept INT = 1,
			@CurrentConceptId UNIQUEIDENTIFIER,
			@From NVARCHAR(MAX),
			@Where NVARCHAR(MAX),
			@Date NVARCHAR(200),
			@isEncounterBased BIT,
			@SetMarker NVARCHAR(5) = '@',
			@SetAlias NVARCHAR(5) = '_T',
			@TimeLimit DATETIME = DATEADD(MINUTE,@TotalAllowedRuntimeInMinutes,GETDATE()),
			@TimeLimitPerRootConcept DATETIME = DATEADD(MINUTE,@PerRootConceptAllowedRuntimeInMinutes,GETDATE()),
			@PerRootConceptRowLimit INT = 50000,
			@CurrentDateTime DATETIME = GETDATE()
	
	------------------------------------------------------------------------------------------------------------------------------ 
	-- ForEach root concept
	------------------------------------------------------------------------------------------------------------------------------
	WHILE @CurrentRoot <= @TotalRoots AND @CurrentDateTime < @TimeLimit

	BEGIN
		
		SET @CurrentRootId = (SELECT Id FROM #roots WHERE RowNumber = @CurrentRoot)

		BEGIN TRY DROP TABLE #Concepts END TRY BEGIN CATCH END CATCH

		-- Find all children concepts under current root concept
		SELECT TOP (@PerRootConceptRowLimit)
			   c.Id
			 , SqlSetFrom = REPLACE(s.SqlSetFrom,@SetMarker,@SetAlias)
			 , SqlSetWhere = REPLACE(c.SqlSetWhere,@SetMarker,@SetAlias)
			 , SqlFieldDate = REPLACE(s.SqlFieldDate,@SetMarker,@SetAlias)
			 , isEncounterBased
			 , RowNumber = DENSE_RANK() OVER(ORDER BY PatientCountLastUpdateDateTime,c.Id)
		INTO #Concepts
		FROM app.Concept AS c
			 LEFT JOIN app.ConceptSqlSet AS s
				ON c.SqlSetId = s.Id
		WHERE c.RootId = @CurrentRootId
			  AND c.IsPatientCountAutoCalculated = 1
		ORDER BY PatientCountLastUpdateDateTime ASC

		SET @TotalConcepts = @@ROWCOUNT
		SET @CurrentConcept = 1

		------------------------------------------------------------------------------------------------------------------------------
		-- ForEach concept in concepts
		------------------------------------------------------------------------------------------------------------------------------
		WHILE @CurrentConcept <= @TotalConcepts AND @CurrentDateTime < @TimeLimit AND @CurrentDateTime < @TimeLimitPerRootConcept

		BEGIN 

			SELECT @From = C.SqlSetFrom
				 , @Where = C.SqlSetWhere
				 , @Date = C.SqlFieldDate
				 , @isEncounterBased = C.isEncounterBased
				 , @CurrentConceptId = Id
			FROM #Concepts C
			WHERE RowNumber = @CurrentConcept

			BEGIN TRY 
			
				-- Calculate patient counts for this concept
				EXECUTE app.sp_CalculateConceptPatientCount
					@PersonIdField,
					@TargetDatabaseName,
					@From,
					@Where,
					@Date,
					@isEncounterBased,
					@CurrentRootId,
					@CurrentConceptId

			END TRY BEGIN CATCH END CATCH

			-- Increment the @CurrentConcept parameter
			SET @CurrentConcept = @CurrentConcept + 1
			SET @CurrentDateTime = GETDATE()

		END 
		-- End ForEach concept

		SET @CurrentRoot = @CurrentRoot + 1
		SET @TimeLimitPerRootConcept = DATEADD(MINUTE,@PerRootConceptAllowedRuntimeInMinutes,GETDATE())

	END 
	-- End ForEach root concept
END
GO
/****** Object:  StoredProcedure [app].[sp_CreateCachedUnsavedQuery]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =======================================
-- Author:      Cliff Spital
-- Create date: 2018/8/13
-- Description: Creates and constrains a new Unsaved Query.
-- =======================================
CREATE PROCEDURE [app].[sp_CreateCachedUnsavedQuery]
    @user auth.[User],
	@definition NVARCHAR(MAX),
    @nonce UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON

    DECLARE @qid UNIQUEIDENTIFIER;
    DECLARE @qids TABLE
    (
        QueryId UNIQUEIDENTIFIER NOT NULL
    );

    -- clear out previous cohort cache
    EXEC app.sp_DeleteCachedUnsavedQueryByNonce @user, @nonce;

    BEGIN TRAN;

    -- create the query
    INSERT INTO app.Query (UniversalId, Nonce, [Owner], [Definition])
    OUTPUT inserted.Id INTO @qids
    VALUES (null, @nonce, @user, @definition)

    -- get the id
    SELECT TOP 1
        @qid = QueryId
    FROM @qids;

    -- constrain the query
    INSERT INTO auth.QueryConstraint (QueryId, ConstraintId, ConstraintValue)
    VALUES (@qid, 1, @user);

    COMMIT TRAN;

    SELECT @qid;
END












GO
/****** Object:  StoredProcedure [app].[sp_CreateImportMetadata]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Nic Dobbins
-- Create date: 2019/9/30
-- Description: Creates an Import Metadata record.
-- =======================================
CREATE PROCEDURE [app].[sp_CreateImportMetadata]
    @user auth.[User],
	@constraints auth.ResourceConstraintTable READONLY,
	@sourceId nvarchar(100),
	@type int,
	@structure nvarchar(max)
AS
BEGIN
    SET NOCOUNT ON

	IF (NOT EXISTS (SELECT 1 FROM ref.ImportType AS IT WHERE @type = IT.Id))
    BEGIN;
        THROW 70404, N'ImportType does not exist.', 1;
    END;

	IF (app.fn_NullOrWhitespace(@sourceId) = 1)
        THROW 70400, N'SourceId is required.', 1;

	IF (app.fn_NullOrWhitespace(@structure) = 1)
        THROW 70400, N'Structure is required.', 1;

	DECLARE @created TABLE (Id uniqueidentifier, SourceId nvarchar(100), Structure nvarchar(max), [Type] int, Created datetime, Updated datetime);
	DECLARE @cons TABLE (ImportMetadataId uniqueidentifier, ConstraintId int, ConstraintValue nvarchar(100));

	-- INSERT metadata row
	INSERT INTO app.ImportMetadata (SourceId, [Type], Structure, Created, CreatedBy, Updated, UpdatedBy)
	OUTPUT inserted.Id, inserted.SourceId, inserted.Structure, inserted.[Type], inserted.Created, inserted.Updated INTO @created
	VALUES (@sourceId, @type, @structure, GETDATE(), @user, GETDATE(), @user);

	DECLARE @id uniqueidentifier = (SELECT TOP 1 Id FROM @created);

	-- INSERT contraints
	INSERT INTO auth.ImportMetadataConstraint (ImportMetadataId, ConstraintId, ConstraintValue)
	OUTPUT inserted.ImportMetadataId, inserted.ConstraintId, inserted.ConstraintValue INTO @cons
	SELECT
		ImportMetadataId = @id
	  , C.ConstraintId
	  , C.ConstraintValue
	FROM @constraints AS C;

	SELECT * FROM @created;
	SELECT * FROM @cons;

END

GO
/****** Object:  StoredProcedure [app].[sp_DeleteCachedUnsavedQueryByNonce]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =======================================
-- Author:      Cliff Spital
-- Create date: 2018/8/10
-- Description: Deletes a user's previous cached cohort and query by Nonce
-- =======================================
CREATE PROCEDURE [app].[sp_DeleteCachedUnsavedQueryByNonce]
    @user auth.[User],
    @nonce UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON

    DECLARE @qid UNIQUEIDENTIFIER;
    DECLARE @owner nvarchar(1000);

    -- Ensure an Atomic Operation as there are many steps here
    BEGIN TRAN;
    
    -- convert Nonce into queryid IF AND ONLY IF the user owns the query
    SELECT
        @qid = Id,
        @owner = [Owner]
    FROM app.Query
    WHERE Nonce = @nonce;

    -- query not found, just rollback and bounce
    IF (@qid is null)
    BEGIN;
        ROLLBACK TRAN;
        RETURN 0;
    END;

    -- query found but not owned
    IF (@owner != @user)
    BEGIN;
        DECLARE @security nvarchar(1000) = @user + ' cannot delete query ' + cast(@qid as nvarchar(50));
        THROW 70403, @security, 1;
    END;

    -- remove cached cohort
    DELETE FROM app.Cohort
    WHERE QueryId = @qid;

    -- unconstrain query
    DELETE FROM auth.QueryConstraint
    WHERE QueryId = @qid;

    -- delete unsaved query
    DELETE FROM app.Query
    WHERE Id = @qid;
    
    COMMIT TRAN;

END

















GO
/****** Object:  StoredProcedure [app].[sp_DeleteImportMetadata]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Nic Dobbins
-- Create date: 2019/9/30
-- Description: Deletes an Import Metadata record.
-- =======================================
CREATE PROCEDURE [app].[sp_DeleteImportMetadata]
	@id uniqueidentifier,
    @user auth.[User],
	@groups auth.GroupMembership READONLY,
	@admin bit = 0
AS
BEGIN
    SET NOCOUNT ON

	IF (NOT EXISTS (SELECT 1 FROM app.ImportMetadata AS IT WHERE @id = IT.Id))
    BEGIN;
        THROW 70404, N'ImportMetadata does not exist.', 1;
    END;

	DECLARE @authorized BIT = [auth].[fn_UserIsAuthorizedForImportMetadataById](@user, @groups, @id, @admin)

	IF @authorized = 0
	BEGIN;
		DECLARE @403msg1 nvarchar(400) = @user + N' is not allowed to to delete import ' + CONVERT(NVARCHAR(100),@id);
        THROW 70403, @403msg1, 1;
	END;

	DECLARE @deleted TABLE (Id uniqueidentifier, SourceId nvarchar(100), Structure nvarchar(max), [Type] int);
	DECLARE @cons TABLE (ImportMetadataId uniqueidentifier, ConstraintId int, ConstraintValue nvarchar(100))

	-- DELETE any constraints
	DELETE auth.ImportMetadataConstraint
	OUTPUT deleted.ImportMetadataId, deleted.ConstraintId, deleted.ConstraintValue INTO @cons
	WHERE ImportMetadataId = @id;

	-- DELETE any imported data
	DELETE app.Import
	WHERE ImportMetadataId = @id

	-- DELETE metadata
	DELETE app.ImportMetadata
	OUTPUT deleted.Id, deleted.SourceId, deleted.Structure, deleted.[Type] INTO @deleted
	WHERE Id = @id;

	SELECT * FROM @deleted;
	SELECT * FROM @cons;

END

GO
/****** Object:  StoredProcedure [app].[sp_DeleteQuery]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Cliff Spital
-- Create date: 2019/3/6
-- Description: Deletes a query and all dependents (if forced).
-- =======================================
CREATE PROCEDURE [app].[sp_DeleteQuery]
    @uid app.UniversalId,
    @force bit,
    @user auth.[User],
	@admin bit = 0
AS
BEGIN
    SET NOCOUNT ON

    -- make sure the user is the owner of the query and the query exists
    DECLARE @id UNIQUEIDENTIFIER, @owner nvarchar(1000);
    SELECT @id = Id, @owner = [Owner] FROM app.Query WHERE UniversalId = @uid;
    IF (@id IS NULL)
    BEGIN;
        DECLARE @404msg nvarchar(400) = N'Query ' + @uid + N' does not exist';
        THROW 70404, @404msg, 1;
    END;

    IF (@owner != @user AND @admin = 0)
    BEGIN;
        DECLARE @403msg1 nvarchar(400) = @user + N' does not own query ' + @uid;
        THROW 70403, @403msg1, 1;
    END;

    -- collect query dependents
    declare @dependentRefs table (
        Lvl int,
        QueryId UNIQUEIDENTIFIER,
        QueryUniversalId app.UniversalId,
        [QueryName] NVARCHAR(200),
        [Owner] NVARCHAR(1000),
        DependsOn UNIQUEIDENTIFIER
    );
    with cte (Lvl, QueryId, DependsOn) as (
        select 1, QueryId, DependsOn
        from rela.QueryDependency
        where DependsOn = @id
        union all
        select c.Lvl + 1, qd.QueryId, qd.DependsOn
        from rela.QueryDependency qd
        join cte c on qd.DependsOn = c.QueryId
    )
    insert into @dependentRefs
    select Lvl, QueryId, q.UniversalId, q.Name, q.[Owner], DependsOn
    from cte
    join app.Query q
        on cte.QueryId = q.Id;

    BEGIN TRAN;
    BEGIN TRY
        -- there are dependents
        IF EXISTS (SELECT 1 FROM @dependentRefs)
        BEGIN;
            -- no force, select enriched dependency graph
            IF (@force = 0)
            BEGIN;
                ROLLBACK;
                SELECT Id = QueryId, UniversalId = QueryUniversalId, [Name] = QueryName, [Owner]
                FROM @dependentRefs;
                RETURN;
            END;
            ELSE -- force it
            BEGIN;
                -- if there are any non user owned queries in the tree, bail with 403
                IF ((SELECT COUNT(*) FROM @dependentRefs WHERE [Owner] != @user) > 0)
                BEGIN;
                    declare @403msg2 nvarchar(400) = N'Query ' + @uid + N' has dependents owned by other users.';
                    throw 70403, @403msg2, 1;
                END;

                -- delete all dependents
                DECLARE @forceDeleteId UNIQUEIDENTIFIER;
                DECLARE force_cursor CURSOR FOR
                SELECT QueryId
                FROM @dependentRefs
                ORDER BY Lvl DESC;

                OPEN force_cursor;

                FETCH NEXT FROM force_cursor
                INTO @forceDeleteId;

                WHILE @@FETCH_STATUS = 0
                BEGIN;
                    DELETE FROM auth.QueryConstraint
                    WHERE QueryId = @forceDeleteId;

                    DELETE FROM rela.QueryConceptDependency
                    WHERE QueryId = @forceDeleteId;

                    DELETE FROM rela.QueryDependency
                    WHERE QueryId = @forceDeleteId;

                    DELETE FROM app.QueryDefinition
                    WHERE QueryId = @forceDeleteId;

					DELETE FROM app.Cohort
					WHERE QueryId = @forceDeleteId

                    DELETE FROM app.Query
                    WHERE Id = @forceDeleteId;

                    FETCH NEXT FROM force_cursor
                    INTO @forceDeleteId;
                END;

                CLOSE force_cursor;
                DEALLOCATE force_cursor;
            END;
        END;
        -- delete the constraint, dependencies, querydefinition, query
        DELETE FROM auth.QueryConstraint
        WHERE QueryId = @id;

        DELETE FROM rela.QueryConceptDependency
        WHERE QueryId = @id;

        DELETE FROM rela.QueryDependency
        WHERE QueryId = @id;

        DELETE FROM app.QueryDefinition
        WHERE QueryId = @id;

		DELETE FROM app.Cohort
		WHERE QueryId = @id

        DELETE FROM app.Query
        WHERE Id = @id;

        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        THROW;
    END CATCH;

    SELECT Id = QueryId, UniversalId = QueryUniversalId, [Name] = QueryName, [Owner]
    FROM @dependentRefs
    WHERE 0 = 1;
END

GO
/****** Object:  StoredProcedure [app].[sp_FilterConceptsByConstraint]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =======================================
-- Author:      Cliff Spital
-- Create date: 2018/8/2
-- Description: Recursively (ancestry applies) filters a list of concept ids by ConceptConstraint relationships.
-- =======================================
CREATE PROCEDURE [app].[sp_FilterConceptsByConstraint]
    @user [auth].[User],
    @groups auth.GroupMembership READONLY,
    @requested app.ResourceIdTable READONLY,
    @admin bit = 0
AS
BEGIN
    SET NOCOUNT ON

    IF (@admin = 1)
    BEGIN;
        SELECT Id
        FROM @requested;
        RETURN;
    END;

    DECLARE @ancestry table
    (
        [Base] [uniqueidentifier] not null,
        [Current] [uniqueidentifier] not null,
        [Parent] [uniqueidentifier] null
    );

    -- Fetch the full ancestry of all requested Ids.
    WITH recRoots (Base, Id, ParentId) as
    (
        SELECT i.Id, i.Id, c.Parentid
        FROM @requested i
        JOIN app.Concept c on i.Id = c.Id

        UNION ALL

        SELECT r.Base, c.Id, c.ParentId
        FROM app.Concept c
        JOIN recRoots r on c.Id = r.ParentId
    )
    INSERT INTO @ancestry
    SELECT Base, Id, ParentId
    FROM recRoots;

    -- Identify any requested Ids that are disallowed by constraint anywhere in their ancestry.
    DECLARE @disallowed app.ResourceIdTable;
    WITH constrained AS
        (
            SELECT c.ConceptId, c.ConstraintId, c.ConstraintValue
            FROM auth.ConceptConstraint c
            WHERE EXISTS (SELECT 1 FROM @ancestry a WHERE a.[Current] = c.ConceptId)
        )
    , permitted AS
    (
        SELECT 
            a.Base
        , a.[Current]
        , HasConstraint = CASE WHEN EXISTS 
                        (SELECT 1 FROM constrained c 
                WHERE c.ConceptId = a.[Current])
                        THEN 1 ELSE 0 END
        , UserPermitted = CASE WHEN EXISTS 
                        (SELECT 1 FROM constrained c 
                WHERE c.ConceptId = a.[Current] 
                        AND c.ConstraintId = 1 
                        AND c.ConstraintValue = @user)
                        THEN 1 ELSE 0 END
        , GroupPermitted = CASE WHEN EXISTS 
                        (SELECT 1 FROM constrained c 
                WHERE c.ConceptId = a.[Current] 
                        AND c.ConstraintId = 2 
                        AND c.ConstraintValue IN (SELECT g.[Group] FROM @groups g))
                        THEN 1 ELSE 0 END
        FROM @ancestry a
    )
    INSERT INTO @disallowed
    SELECT p.Base
    FROM permitted p
    WHERE p.HasConstraint = 1
        AND (p.UserPermitted = 0 AND p.GroupPermitted = 0)

    -- Select only the allowed requested ids.
    SELECT Id
    FROM @requested
    WHERE Id NOT IN (
        SELECT Id
        FROM @disallowed
    );

END













GO
/****** Object:  StoredProcedure [app].[sp_GetChildConceptsByParentId]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =======================================
-- Author:      Cliff Spital
-- Create date: 2018/7/2
-- Description: Retrieves children concepts of the given parent concept.
-- =======================================
CREATE PROCEDURE [app].[sp_GetChildConceptsByParentId]
    @parentId UNIQUEIDENTIFIER,
    @user auth.[User],
    @groups auth.GroupMembership READONLY,
    @admin bit = 0
AS
BEGIN
    SET NOCOUNT ON

    -- ensure user can see parent
    DECLARE @requested app.ResourceIdTable;
    INSERT INTO @requested
    SELECT @parentId;

    DECLARE @allowed app.ResourceIdTable;
    INSERT INTO @allowed
    EXEC app.sp_FilterConceptsByConstraint @user, @groups, @requested, @admin = @admin;

    IF ((SELECT COUNT(*) FROM @allowed) != 1)
        THROW 70403, 'User is not permitted.', 1;

    -- clear tables for reuse
    DELETE FROM @requested;
    DELETE FROM @allowed;

    -- ensure only permitted children are returned
    INSERT INTO @requested
    SELECT
        Id
    FROM app.Concept
    WHERE ParentId = @parentId;

    -- TODO(cspital) this is wasteful, we've already checked parent up to root, just need to check children, write focused version with no recursion
    INSERT INTO @allowed
    EXEC app.sp_FilterConceptsByConstraint @user, @groups, @requested, @admin = @admin

    EXEC app.sp_HydrateConceptsByIds @allowed;

END















GO
/****** Object:  StoredProcedure [app].[sp_GetConceptById]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =======================================
-- Author:      Cliff Spital
-- Create date: 2018/7/2
-- Description: Retrieves a concept directly by Id.
-- =======================================
CREATE PROCEDURE [app].[sp_GetConceptById]
    @id [uniqueidentifier],
    @user auth.[User],
    @groups auth.GroupMembership READONLY,
    @admin bit = 0
AS
BEGIN
    SET NOCOUNT ON

    DECLARE @requested app.ResourceIdTable;

    INSERT INTO @requested
    SELECT @id;

    DECLARE @allowed app.ResourceIdTable;
    INSERT INTO @allowed
    EXEC app.sp_FilterConceptsByConstraint @user, @groups, @requested, @admin = @admin;

    IF ((SELECT COUNT(*) FROM @allowed) != 1)
        THROW 70403, 'User is not permitted.', 1;

    EXEC app.sp_HydrateConceptsByIds @allowed;
END
















GO
/****** Object:  StoredProcedure [app].[sp_GetConceptByUId]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Nic Dobbins
-- Create date: 2020/12/28
-- Description: Retrieves Concept requested by UniversalId, filtered by constraint.
-- =======================================
CREATE PROCEDURE [app].[sp_GetConceptByUId]
    @uid NVARCHAR(200),
    @user auth.[User],
    @groups auth.GroupMembership READONLY,
    @admin bit = 0
AS
BEGIN
    SET NOCOUNT ON

    DECLARE @ids app.ResourceIdTable;
    INSERT INTO @ids
    SELECT Id
    FROM app.Concept c
    WHERE c.UniversalId = @uid
    
    DECLARE @allowed app.ResourceIdTable;
    INSERT INTO @allowed
    EXEC app.sp_FilterConceptsByConstraint @user, @groups, @ids, @admin = @admin;

    EXEC app.sp_HydrateConceptsByIds @allowed;
END

GO
/****** Object:  StoredProcedure [app].[sp_GetConceptDatasetContextByQueryIdConceptId]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [app].[sp_GetConceptDatasetContextByQueryIdConceptId]
    @queryid UNIQUEIDENTIFIER,
    @conceptid UNIQUEIDENTIFIER,
    @user auth.[User],
    @groups auth.GroupMembership READONLY,
    @admin bit = 0
AS
BEGIN
    SET NOCOUNT ON

    -- queryconstraint ok?
    IF (auth.fn_UserIsAuthorizedForQueryById(@user, @groups, @queryid, @admin) = 0)
    BEGIN;
        DECLARE @query403 nvarchar(400) = @user + N' is not authorized to execute query ' + app.fn_StringifyGuid(@queryid);
        THROW 70403, @query403, 1;
    END;

    SELECT
        QueryId = Id,
        Pepper
    FROM app.Query
    WHERE Id = @queryid;

    -- concept
    EXEC app.sp_GetConceptById @conceptid, @user, @groups, @admin
END

GO
/****** Object:  StoredProcedure [app].[sp_GetConceptDatasetContextByQueryIdConceptUId]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [app].[sp_GetConceptDatasetContextByQueryIdConceptUId]
    @queryid UNIQUEIDENTIFIER,
    @conceptuid UNIQUEIDENTIFIER,
    @user auth.[User] = NULL,
    @groups auth.GroupMembership READONLY,
    @admin bit = 0
AS
BEGIN
    SET NOCOUNT ON

    -- convert conceptuid to conceptid
    DECLARE @conceptid UNIQUEIDENTIFIER
    SELECT TOP 1 @conceptid = Id
    FROM app.Concept AS C
    WHERE C.UniversalId = @conceptuid

    EXEC app.sp_GetConceptDatasetContextByQueryIdConceptId @queryid, @conceptid, @user, @groups, @admin
END

GO
/****** Object:  StoredProcedure [app].[sp_GetConceptDatasetContextByQueryUIdConceptId]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Nic Dobbins
-- Create date: 2020/12/28
-- Description: Retrieves the Query by UId and Concept by Id.
-- =======================================
CREATE PROCEDURE [app].[sp_GetConceptDatasetContextByQueryUIdConceptId]
    @queryuid UNIQUEIDENTIFIER,
    @conceptid [uniqueidentifier],
    @user auth.[User],
    @groups auth.GroupMembership READONLY,
    @admin bit = 0
AS
BEGIN
    SET NOCOUNT ON

    -- convert queryuid to queryid
    DECLARE @qid UNIQUEIDENTIFIER;
    SELECT TOP 1 @qid = Id
    FROM app.Query AS Q
    WHERE Q.UniversalId = @queryuid;

    EXEC app.sp_GetConceptDatasetContextByQueryIdConceptId @qid, @conceptid, @user, @groups, @admin
END

GO
/****** Object:  StoredProcedure [app].[sp_GetConceptDatasetContextByQueryUIdConceptUId]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Nic Dobbins
-- Create date: 2020/12/28
-- Description: Retrieves the Query by UId and Concept by UId.
-- =======================================
CREATE PROCEDURE [app].[sp_GetConceptDatasetContextByQueryUIdConceptUId]
    @queryuid UNIQUEIDENTIFIER,
    @uid [uniqueidentifier],
    @user auth.[User],
    @groups auth.GroupMembership READONLY,
    @admin bit = 0
AS
BEGIN
    SET NOCOUNT ON

    -- convert queryuid to queryid
    DECLARE @qid UNIQUEIDENTIFIER;
    SELECT TOP 1 @qid = Id
    FROM app.Query AS Q
    WHERE Q.UniversalId = @queryuid;

    -- convert conceptuid to conceptid
    DECLARE @conceptid UNIQUEIDENTIFIER
    SELECT TOP 1 @conceptid = Id
    FROM app.Concept AS C
    WHERE C.UniversalId = @uid

    EXEC app.sp_GetConceptDatasetContextByQueryIdConceptId @qid, @conceptid, @user, @groups, @admin
END

GO
/****** Object:  StoredProcedure [app].[sp_GetConceptHintsBySearchTerms]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =======================================
-- Authors:     Nic Dobbins
-- Create date: 2019/3/23
-- Description: Retrieves a list of concept hints for the given search terms.
-- =======================================
CREATE PROCEDURE [app].[sp_GetConceptHintsBySearchTerms]
    @terms app.SearchTermTable READONLY,
    @rootId [uniqueidentifier] = NULL,
    @user auth.[User],
    @groups auth.GroupMembership READONLY,
    @admin bit = 0
AS
BEGIN
    SET NOCOUNT ON

	DECLARE @requested app.ResourceIdTable
	DECLARE @allowed app.ResourceIdTable
    DECLARE @initialTerm NVARCHAR(30) = (SELECT TOP (1) Term FROM @terms)
	DECLARE @termLastIdx INT = (SELECT COUNT(*) FROM @terms) - 1

	/*
	 * Find hits for initial term.
	 */
	; WITH cte AS 
	(
		SELECT FI.ConceptId, FI.Word, Lvl = 0
		FROM app.ConceptForwardIndex FI
		WHERE (@rootId IS NULL OR FI.RootId = @rootId)
			  AND EXISTS 
			(
				SELECT 1
				FROM app.ConceptInvertedIndex II
				WHERE II.Word LIKE @initialTerm + '%'
					  AND FI.WordId = II.WordId
			)
	)

	/*
	 * Recurse through following terms.
	 */
	, cte2 AS
	(
		SELECT ConceptId, Lvl
		FROM cte

		UNION ALL

		SELECT cte2.ConceptId, Lvl = cte2.Lvl + 1
		FROM cte2
		WHERE EXISTS 
			(
				SELECT 1
				FROM app.ConceptForwardIndex FI
				WHERE cte2.ConceptId = FI.ConceptId
					  AND (@rootId IS NULL OR FI.RootId = @rootId)
					  AND EXISTS 
							(
								SELECT 1
								FROM @terms T 
									 INNER JOIN app.ConceptInvertedIndex II
										ON II.Word LIKE T.Term + '%'
								WHERE FI.WordId = II.WordId
									  AND T.Id = cte2.Lvl + 1
							)
			)
	)

	/*
	 * Limit to only TOP 100 Concepts that matched all terms.
	 */
	, cte3 AS
	(
		SELECT TOP (100) ConceptId
		FROM cte2
		WHERE Lvl = @termLastIdx
	)

	INSERT INTO @requested
	SELECT ConceptId
	FROM cte3

	/*
	 * Filter out any Concepts not allowed for user.
	 */
	INSERT INTO @allowed
	EXEC app.sp_FilterConceptsByConstraint @user, @groups, @requested, @admin = @admin;

	/*
	 * Return matches and their JSON tokens.
	 */
	SELECT TI.ConceptId
		 , TI.JsonTokens
	FROM app.ConceptTokenizedIndex TI
	WHERE EXISTS (SELECT 1 FROM @allowed A WHERE TI.ConceptId = A.Id)

END




GO
/****** Object:  StoredProcedure [app].[sp_GetConceptsByIds]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =======================================
-- Author:      Cliff Spital
-- Create date: 2018/8/3
-- Description: Retrieves Concepts requested, filtered by constraint.
-- =======================================
CREATE PROCEDURE [app].[sp_GetConceptsByIds]
    @ids app.ResourceIdTable READONLY,
    @user auth.[User],
    @groups auth.GroupMembership READONLY,
    @admin bit = 0
AS
BEGIN
    SET NOCOUNT ON

    DECLARE @allowed app.ResourceIdTable;

    INSERT INTO @allowed
    EXEC app.sp_FilterConceptsByConstraint @user, @groups, @ids, @admin = @admin;

    EXEC app.sp_HydrateConceptsByIds @allowed;
END













GO
/****** Object:  StoredProcedure [app].[sp_GetConceptsBySearchTerms]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =======================================
-- Author:      Nic Dobbins; Ported by Cliff Spital
-- Create date: 2018/6/27
-- Description: Retrieves concepts matching the given search terms.
-- Old name:    sp_GetSearchConceptsByTerm
-- =======================================
CREATE PROCEDURE [app].[sp_GetConceptsBySearchTerms]
    @terms app.SearchTermTable READONLY,
    @rootId [uniqueidentifier] = NULL,
    @user auth.[User],
    @groups auth.GroupMembership READONLY,
    @admin bit = 0
AS
BEGIN
    SET NOCOUNT ON

    DECLARE @requested app.ResourceIdTable
	DECLARE @allowed app.ResourceIdTable
    DECLARE @initialTerm NVARCHAR(30) = (SELECT TOP (1) Term FROM @terms)
	DECLARE @termLastIdx INT = (SELECT COUNT(*) FROM @terms) - 1

	/*
	 * Find hits for initial term.
	 */
	; WITH cte AS 
	(
		SELECT FI.ConceptId, FI.Word, Lvl = 0
		FROM app.ConceptForwardIndex FI
		WHERE (@rootId IS NULL OR FI.RootId = @rootId)
			  AND EXISTS 
			(
				SELECT 1
				FROM app.ConceptInvertedIndex II
				WHERE II.Word LIKE @initialTerm + '%'
					  AND FI.WordId = II.WordId
			)
	)

	/*
	 * Recurse through following terms.
	 */
	, cte2 AS
	(
		SELECT ConceptId, Lvl
		FROM cte

		UNION ALL

		SELECT cte2.ConceptId, Lvl = cte2.Lvl + 1
		FROM cte2
		WHERE EXISTS 
			(
				SELECT 1
				FROM app.ConceptForwardIndex FI
				WHERE cte2.ConceptId = FI.ConceptId
					  AND (@rootId IS NULL OR FI.RootId = @rootId)
					  AND EXISTS 
							(
								SELECT 1
								FROM @terms T 
									 INNER JOIN app.ConceptInvertedIndex II
										ON II.Word LIKE T.Term + '%'
								WHERE FI.WordId = II.WordId
									  AND T.Id = cte2.Lvl + 1
							)
			)
	)

	/*
	 * Limit to only TOP 100 Concepts that matched all terms.
	 */
	, cte3 AS
	(
		SELECT TOP (100) ConceptId
		FROM cte2
		WHERE Lvl = @termLastIdx
	)

	INSERT INTO @requested
	SELECT ConceptId
	FROM cte3

	/*
	 * Filter out any Concepts not allowed for user.
	 */
	INSERT INTO @allowed
	EXEC app.sp_FilterConceptsByConstraint @user, @groups, @requested, @admin = @admin;

    EXEC app.sp_GetParentConceptsByChildIds @allowed, @user, @groups, @admin = @admin;

END




GO
/****** Object:  StoredProcedure [app].[sp_GetConceptsByUIds]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =======================================
-- Author:      Cliff Spital
-- Create date: 2018/8/10
-- Description: Retrieves Concepts requested by UniversalIds, filtered by constraint.
-- =======================================
CREATE PROCEDURE [app].[sp_GetConceptsByUIds]
    @uids app.ResourceUniversalIdTable READONLY,
    @user auth.[User],
    @groups auth.GroupMembership READONLY,
    @admin bit = 0
AS
BEGIN
    SET NOCOUNT ON

    DECLARE @ids app.ResourceIdTable;
    INSERT INTO @ids
    SELECT Id
    FROM app.Concept c
    JOIN @uids u on c.UniversalId = u.UniversalId;
    
    DECLARE @allowed app.ResourceIdTable;
    INSERT INTO @allowed
    EXEC app.sp_FilterConceptsByConstraint @user, @groups, @ids, @admin = @admin;

    EXEC app.sp_HydrateConceptsByIds @allowed;
END












GO
/****** Object:  StoredProcedure [app].[sp_GetContextById]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [app].[sp_GetContextById]
    @queryid UNIQUEIDENTIFIER,
    @user auth.[User] = NULL,
    @groups auth.GroupMembership READONLY,
    @admin bit = 0
AS
BEGIN
    SET NOCOUNT ON

    -- queryconstraint ok?
    IF (auth.fn_UserIsAuthorizedForQueryById(@user, @groups, @queryid, @admin) = 0)
    BEGIN;
        DECLARE @query403 nvarchar(400) = @user + N' is not authorized to execute query ' + app.fn_StringifyGuid(@queryid);
        THROW 70403, @query403, 1;
    END;

    SELECT
        QueryId = Id,
        Pepper,
        Definition
    FROM app.Query
    WHERE Id = @queryid;

END

GO
/****** Object:  StoredProcedure [app].[sp_GetContextByUId]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [app].[sp_GetContextByUId]
    @queryuid UNIQUEIDENTIFIER,
    @user auth.[User] = NULL,
    @groups auth.GroupMembership READONLY,
    @admin bit = 0
AS
BEGIN
    SET NOCOUNT ON

    -- convert queryuid to queryid
    DECLARE @qid UNIQUEIDENTIFIER;
    SELECT TOP 1 @qid = Id
    FROM app.Query AS Q
    WHERE Q.UniversalId = @queryuid;

    EXEC [app].[sp_GetContextById] @qid, @user, @groups, @admin

END

GO
/****** Object:  StoredProcedure [app].[sp_GetDatasetContextByDatasetIdQueryUId]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =======================================
-- Author:      Cliff Spital
-- Create date: 2018/12/5
-- Description: Retrieves the app.Query.Pepper and app.DatasetQuery by Query.UniversalId and DatasetQuery.Id.
-- =======================================
CREATE PROCEDURE [app].[sp_GetDatasetContextByDatasetIdQueryUId]
    @datasetid UNIQUEIDENTIFIER,
    @queryuid app.UniversalId,
    @joinpanel BIT,
    @user auth.[User],
    @groups auth.GroupMembership READONLY,
    @admin bit = 0
AS
BEGIN
    SET NOCOUNT ON

    -- convert queryuid to queryid
    DECLARE @qid UNIQUEIDENTIFIER;
    SELECT TOP 1 @qid = Id
    FROM app.Query
    WHERE app.Query.UniversalId = @queryuid;

    EXEC app.sp_GetDatasetContextById @datasetid, @qid, @user, @joinpanel, @groups, @admin = @admin;
END

GO
/****** Object:  StoredProcedure [app].[sp_GetDatasetContextByDatasetUIdQueryId]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =======================================
-- Author:      Cliff Spital
-- Create date: 2018/12/6
-- Description: Retrieves the app.Query.Pepper and app.DatasetQuery by Query.Id and DatasetQuery.UniversalId.
-- =======================================
CREATE PROCEDURE [app].[sp_GetDatasetContextByDatasetUIdQueryId]
    @datasetuid app.UniversalId,
    @queryid UNIQUEIDENTIFIER,
    @joinpanel BIT,
    @user auth.[User],
    @groups auth.GroupMembership READONLY,
    @admin bit = 0
AS
BEGIN
    SET NOCOUNT ON

    -- convert datasetuid to datasetid
    DECLARE @did UNIQUEIDENTIFIER;
    SELECT TOP 1 @did = Id
    FROM app.DatasetQuery
    WHERE app.DatasetQuery.UniversalId = @datasetuid;

    -- do the normal thing
    EXEC app.sp_GetDatasetContextById @did, @queryid, @joinpanel, @user, @groups, @admin = @admin;
END

GO
/****** Object:  StoredProcedure [app].[sp_GetDatasetContextByDatasetUIdQueryUId]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =======================================
-- Author:      Cliff Spital
-- Create date: 2018/12/6
-- Description: Retrieves the app.Query.Pepper and app.DatasetQuery by Query.UniversalId and DatasetQuery.UniversalId.
-- =======================================
CREATE PROCEDURE [app].[sp_GetDatasetContextByDatasetUIdQueryUId]
    @datasetuid app.UniversalId,
    @queryuid app.UniversalId,
    @joinpanel BIT,
    @user auth.[User],
    @groups auth.GroupMembership READONLY,
    @admin bit = 0
AS
BEGIN
    SET NOCOUNT ON

    -- convert datasetuid to datasetid
    DECLARE @did UNIQUEIDENTIFIER;
    SELECT TOP 1 @did = Id
    FROM app.DatasetQuery
    WHERE app.DatasetQuery.UniversalId = @datasetuid;

    -- convert queryuid to queryid
    DECLARE @qid UNIQUEIDENTIFIER;
    SELECT TOP 1 @qid = Id
    FROM app.DatasetQuery
    WHERE app.DatasetQuery.UniversalId = @queryuid;

    -- do the normal thing
    EXEC app.sp_GetDatasetContextById @did, @qid, @joinpanel, @user, @groups, @admin = @admin;
END

GO
/****** Object:  StoredProcedure [app].[sp_GetDatasetContextById]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Cliff Spital
-- Create date: 2018/12/5
-- Description: Retrieves the app.Query.Pepper and app.DatasetQuery by Query.Id and DatasetQuery.Id.
-- =======================================
CREATE PROCEDURE [app].[sp_GetDatasetContextById]
    @datasetid UNIQUEIDENTIFIER,
    @queryid UNIQUEIDENTIFIER,
	@joinpanel BIT,
    @user auth.[User],
    @groups auth.GroupMembership READONLY,
    @admin bit = 0
AS
BEGIN
    SET NOCOUNT ON

    -- queryconstraint ok?
    IF (auth.fn_UserIsAuthorizedForQueryById(@user, @groups, @queryid, @admin) = 0)
    BEGIN;
        DECLARE @query403 nvarchar(400) = @user + N' is not authorized to execute query ' + app.fn_StringifyGuid(@queryid);
        THROW 70403, @query403, 1;
    END;

    -- datasetconstraint ok?
    IF (auth.fn_UserIsAuthorizedForDatasetQueryById(@user, @groups, @datasetid, @admin) = 0)
    BEGIN;
        DECLARE @dataset403 nvarchar(400) = @user + N' is not authorized to execute dataset ' + app.fn_StringifyGuid(@datasetid);
        THROW 70403, @dataset403, 1;
    END;

    -- get pepper
    SELECT
        QueryId = Id,
        Pepper,
		[Definition] = CASE WHEN @joinpanel = 0 THEN NULL ELSE [Definition] END
    FROM
        app.Query
    WHERE Id = @queryid;

	-- dynamic
	IF EXISTS (SELECT 1 FROM app.DynamicDatasetQuery ddq WHERE ddq.Id = @datasetid)
		BEGIN
			SELECT
				ddq.Id,
				dq.[Name],
				dq.SqlStatement,
				ddq.IsEncounterBased,
				ddq.[Schema],
				ddq.SqlFieldDate,
				ddq.SqlFieldValueString,
				ddq.SqlFieldValueNumeric,
				dq.Shape
			FROM
				app.DynamicDatasetQuery ddq
			JOIN app.DatasetQuery dq ON ddq.Id = dq.Id
			LEFT JOIN
				app.DatasetQueryCategory dqc ON dq.CategoryId = dqc.Id
			WHERE
				ddq.Id = @datasetid;
		END

	-- else shaped
	ELSE
		BEGIN
			SELECT
				dq.Id,
				dq.UniversalId,
				dq.Shape,
				dq.Name,
				dq.SqlStatement
			FROM
				app.DatasetQuery dq
			LEFT JOIN
				app.DatasetQueryCategory dqc ON dq.CategoryId = dqc.Id
			WHERE
				dq.Id = @datasetid;
		END

END
GO
/****** Object:  StoredProcedure [app].[sp_GetDatasetQueries]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Cliff Spital
-- Create date: 2018/12/21
-- Description: Retrieves all DatasetQuery records to which the user is authorized.
-- =======================================
CREATE PROCEDURE [app].[sp_GetDatasetQueries]
    @user auth.[User],
    @groups auth.GroupMembership READONLY,
    @admin bit = 0
AS
BEGIN
    SET NOCOUNT ON

    DECLARE @ids TABLE (
        Id UNIQUEIDENTIFIER NOT NULL
    );

    IF (@admin = 1)
    BEGIN;
        -- user is an admin, load them all
        INSERT INTO @ids
        SELECT dq.Id
        FROM app.DatasetQuery dq
    END;
    ELSE
    BEGIN;
        -- user is not an admin, assess their privilege
        INSERT INTO @ids (Id)
        SELECT
            dq.Id
        FROM app.DatasetQuery dq
        WHERE EXISTS (
            SELECT 1
            FROM auth.DatasetQueryConstraint
            WHERE DatasetQueryId = dq.Id AND
            ConstraintId = 1 AND
            ConstraintValue = @user
        )
        OR EXISTS (
            SELECT 1
            FROM auth.DatasetQueryConstraint
            WHERE DatasetQueryId = dq.Id AND
            ConstraintId = 2 AND
            ConstraintValue in (SELECT [Group] FROM @groups)
        )
        OR NOT EXISTS (
            SELECT 1
            FROM auth.DatasetQueryConstraint
            WHERE DatasetQueryId = dq.Id
        );
    END;

    -- produce the hydrated records
    SELECT
        i.Id,
        dq.UniversalId,
        dq.Shape,
        dq.[Name],
        dqc.Category,
        dq.[Description],
        dq.SqlStatement,
		IsEncounterBased = ISNULL(ddq.IsEncounterBased, 1),
		ddq.[Schema],
		ddq.SqlFieldDate,
		ddq.SqlFieldValueString,
		ddq.SqlFieldValueNumeric
    FROM @ids i
    JOIN app.DatasetQuery dq ON i.Id = dq.Id
	LEFT JOIN app.DynamicDatasetQuery ddq ON dq.Id = ddq.Id
    LEFT JOIN app.DatasetQueryCategory dqc ON dq.CategoryId = dqc.Id

    -- produce the tags for each record
    SELECT
        i.Id,
        Tag
    FROM @ids i
    JOIN app.DatasetQueryTag t on i.Id = t.DatasetQueryId

END
GO
/****** Object:  StoredProcedure [app].[sp_GetDemographicContextById]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =======================================
-- Author:      Cliff Spital
-- Create date: 2018/12/17
-- Description: Retrieves the app.Query.Pepper and app.DemographicQuery by Query.Id
-- =======================================
CREATE PROCEDURE [app].[sp_GetDemographicContextById]
    @queryid UNIQUEIDENTIFIER,
    @user auth.[User],
    @groups auth.GroupMembership READONLY,
    @admin bit = 0
AS
BEGIN
    SET NOCOUNT ON

    -- queryconstraint ok?
    IF (auth.fn_UserIsAuthorizedForQueryById(@user, @groups, @queryid, @admin) = 0)
    BEGIN;
        DECLARE @query403 nvarchar(400) = @user + N' is not authorized to execute query ' + app.fn_StringifyGuid(@queryid);
        THROW 70403, @query403, 1;
    END;

    -- get pepper
    SELECT
        QueryId = Id,
        Pepper
    FROM app.Query
    WHERE Id = @queryid;

    -- get demographicquery
    SELECT
        SqlStatement
    FROM app.DemographicQuery
END








GO
/****** Object:  StoredProcedure [app].[sp_GetDemographicContextByUId]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =======================================
-- Author:      Cliff Spital
-- Create date: 2018/12/17
-- Description: Retrieves the app.Query.Pepper and app.DemographicQuery by Query.UniversalId
-- =======================================
CREATE PROCEDURE [app].[sp_GetDemographicContextByUId]
    @queryuid app.UniversalId,
    @user auth.[User],
    @groups auth.GroupMembership READONLY,
    @admin bit = 0
AS
BEGIN
    SET NOCOUNT ON

    -- convert queryuid to queryid
    DECLARE @qid UNIQUEIDENTIFIER;
    SELECT TOP 1 @qid = Id
    FROM app.Query
    WHERE app.Query.UniversalId = @queryuid;

    EXEC app.sp_GetDemographicContextById @qid, @user, @groups, @admin = @admin;
END







GO
/****** Object:  StoredProcedure [app].[sp_GetDemographicQuery]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =======================================
-- Author:      Cliff Spital
-- Create date: 2018/8/28
-- Description: Retrieves the DemographicQuery record.
-- =======================================
CREATE PROCEDURE [app].[sp_GetDemographicQuery]
AS
BEGIN
    SET NOCOUNT ON

    SELECT TOP 1
        SqlStatement
    FROM app.DemographicQuery
END








GO
/****** Object:  StoredProcedure [app].[sp_GetGeneralEquivalenceMapping]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nic Dobbins
-- Create date: 2018/9/20
-- Description:	Gets the closest estimated ICD9->10 or ICD10->9 equivalent
-- =============================================
CREATE PROCEDURE [app].[sp_GetGeneralEquivalenceMapping]
	@source nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT TOP (1) 
		 [TargetCode]
		,[TargetCodeType]
		,[UiDisplayTargetName]
    FROM [app].[GeneralEquivalenceMapping]
    WHERE SourceCode LIKE @source + '%'

END









GO
/****** Object:  StoredProcedure [app].[sp_GetGeometries]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nic Dobbins
-- Create date: 2018/9/20
-- Description:	Gets zip code GeoJson for choropleth mapping
-- =============================================
CREATE PROCEDURE [app].[sp_GetGeometries]
	@ids app.ListTable READONLY,
	@geoType NVARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT G.GeometryId
		 , G.GeometryType
		 , G.GeometryJson
	FROM [app].[Geometry] AS G
	WHERE G.GeometryType = @geoType
		  AND EXISTS (SELECT 1 FROM @ids AS ID WHERE G.GeometryId = ID.Id)

END








GO
/****** Object:  StoredProcedure [app].[sp_GetImportData]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Nic Dobbins
-- Create date: 2019/9/30
-- Description: Gets all imported records for a given metadata.
-- =======================================
CREATE PROCEDURE [app].[sp_GetImportData]
	@id uniqueidentifier,
    @user auth.[User],
	@groups auth.GroupMembership READONLY,
	@admin bit = 0
AS
BEGIN
    SET NOCOUNT ON

	IF (NOT EXISTS (SELECT 1 FROM app.ImportMetadata AS IT WHERE @id = IT.Id))
    BEGIN;
        THROW 70404, N'ImportMetadata does not exist.', 1;
    END;

	DECLARE @authorized BIT = [auth].[fn_UserIsAuthorizedForImportMetadataById](@user, @groups, @id, @admin)

	IF @authorized = 0
	BEGIN;
		DECLARE @403msg1 nvarchar(400) = @user + N' is not allowed to access import ' + CONVERT(NVARCHAR(100),@id);
        THROW 70403, @403msg1, 1;
	END;

	DECLARE @changed INT = 0;

	SELECT
		I.Id
	  , I.ImportMetadataId
	  , I.PersonId
	  , I.SourcePersonId
	  , I.SourceValue
	  , I.ValueString
	  , I.ValueNumber
	  , I.ValueDate
	FROM app.Import AS I
	WHERE I.ImportMetadataId = @id

END

GO
/****** Object:  StoredProcedure [app].[sp_GetImportMetadata]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Nic Dobbins
-- Create date: 2019/9/30
-- Description: Retrieves all Import Metadata depending on user and groups.
-- =======================================
CREATE PROCEDURE [app].[sp_GetImportMetadata]
    @user auth.[User],
    @groups auth.GroupMembership READONLY,
    @admin bit = 0
AS
BEGIN
    SET NOCOUNT ON

	DECLARE @requested app.ResourceIdTable;

	INSERT INTO @requested
	SELECT Id
	FROM app.ImportMetadata;

	DECLARE @ids TABLE (Id uniqueidentifier)

	IF (@admin = 1)
    BEGIN;
        -- user is an admin, load them all
        INSERT INTO @ids
        SELECT IM.Id
        FROM app.ImportMetadata AS IM
    END;
    ELSE
    BEGIN;
        -- user is not an admin, assess their privilege
        INSERT INTO @ids (Id)
        SELECT
            IM.Id
        FROM app.ImportMetadata AS IM
        WHERE EXISTS (
            SELECT 1
            FROM auth.ImportMetadataConstraint
            WHERE ImportMetadataId = IM.Id AND
            ConstraintId = 1 AND
            ConstraintValue = @user
        )
        OR EXISTS (
            SELECT 1
            FROM auth.ImportMetadataConstraint
            WHERE ImportMetadataId = IM.Id AND
            ConstraintId = 2 AND
            ConstraintValue in (SELECT [Group] FROM @groups)
        )
        OR NOT EXISTS (
            SELECT 1
            FROM auth.ImportMetadataConstraint
            WHERE ImportMetadataId = IM.Id
        );
    END;

	SELECT 
		Id
	  , SourceId
	  , Structure
	  , [Type]
	  , Created
	  , Updated
	FROM app.ImportMetadata AS IM
	WHERE EXISTS (SELECT 1 FROM @ids AS I WHERE I.Id = IM.Id)

	SELECT
		ImportMetadataId
	  , ConstraintId
	  , ConstraintValue
	FROM auth.ImportMetadataConstraint AS IMC
	WHERE EXISTS (SELECT 1 FROM @ids AS I WHERE I.Id = IMC.ImportMetadataId);

END

GO
/****** Object:  StoredProcedure [app].[sp_GetImportMetadataById]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Nic Dobbins
-- Create date: 2019/9/30
-- Description: Retrieves Import Metadata by Id.
-- =======================================
CREATE PROCEDURE [app].[sp_GetImportMetadataById]
	@id uniqueidentifier,
    @user auth.[User],
    @groups auth.GroupMembership READONLY,
    @admin bit = 0
AS
BEGIN
    SET NOCOUNT ON

	DECLARE @authorized BIT = [auth].[fn_UserIsAuthorizedForImportMetadataById](@user, @groups, @id, @admin)

	IF @authorized = 0
	BEGIN;
		DECLARE @403msg1 nvarchar(400) = @user + N' is not allowed to to use import ' + CONVERT(NVARCHAR(100),@id);
        THROW 70403, @403msg1, 1;
	END;

	SELECT 
		Id
	  , SourceId
	  , Structure
	  , [Type]
	  , Created
	  , Updated
	FROM app.ImportMetadata AS IM
	WHERE IM.Id = @id

	SELECT
		ImportMetadataId
	  , ConstraintId
	  , ConstraintValue
	FROM auth.ImportMetadataConstraint AS IMC
	WHERE IMC.ImportMetadataId = @id

END

GO
/****** Object:  StoredProcedure [app].[sp_GetImportMetadataBySourceId]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Nic Dobbins
-- Create date: 2019/9/30
-- Description: Retrieves Import Metadata by SourceId.
-- =======================================
CREATE PROCEDURE [app].[sp_GetImportMetadataBySourceId]
	@sourceId nvarchar(100),
    @user auth.[User],
    @groups auth.GroupMembership READONLY,
    @admin bit = 0
AS
BEGIN
    SET NOCOUNT ON

	DECLARE @id uniqueidentifier = (SELECT TOP 1 Id from app.ImportMetadata WHERE SourceId = @sourceId)

	EXEC app.sp_GetImportMetadataById @id, @user, @groups, @admin

END

GO
/****** Object:  StoredProcedure [app].[sp_GetImportPatientMappingQuery]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Nic Dobbins
-- Create date: 2019/10/29
-- Description: Fetch the app.ImportPatientMappingQuery record.
-- =======================================
CREATE PROCEDURE [app].[sp_GetImportPatientMappingQuery]
AS
BEGIN
    SET NOCOUNT ON

    SELECT
        SqlStatement,
        SqlFieldSourceId
    FROM app.ImportPatientMappingQuery;
END

GO
/****** Object:  StoredProcedure [app].[sp_GetParentConceptsByChildIds]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =======================================
-- Author:      Nic Dobbins; Ported by Cliff Spital
-- Create date: 2018/6/27
-- Description: Returns parent concept Ids for the given child concept Ids
-- =======================================
CREATE PROCEDURE [app].[sp_GetParentConceptsByChildIds]
    @ids app.ResourceIdTable READONLY,
    @user auth.[User],
    @groups auth.GroupMembership READONLY,
    @outputLimit int = 20,
    @admin bit = 0
AS
BEGIN
    SET NOCOUNT ON

    CREATE TABLE #t
    (
        Id [uniqueidentifier] null,
        ParentId [uniqueidentifier] null,
        TreeLevel int null,
        PatientCount int null
    )

    INSERT INTO #t
    SELECT TOP (@outputLimit)
        c.Id,
        c.ParentId,
        TreeLevel = 0,
        c.UiDisplayPatientCount
    FROM app.Concept c 
    WHERE EXISTS (SELECT 1 FROM @ids i WHERE i.Id = c.Id)
    ORDER BY c.UiDisplayPatientCount DESC

    DECLARE
        @LoopCount int = 0,
        @LoopLimit int = 10,
        @RetrievedRows int = 1;
    
    WHILE @LoopCount < @LoopLimit AND @RetrievedRows > 0
    BEGIN

        INSERT INTO #t (Id, ParentId, TreeLevel)
        SELECT
            c.Id,
            c.ParentId,
            TreeLevel = @LoopCount + 1 --> NOTE CHS why make this a one based index?
        FROM app.Concept c 
        WHERE EXISTS (SELECT 1 FROM #t t WHERE c.Id = t.ParentId AND t.TreeLevel = @LoopCount)

        SET @RetrievedRows = @@ROWCOUNT
        SET @LoopCount += 1

    END

    DECLARE @requested app.ResourceIdTable;
    INSERT INTO @requested
    SELECT DISTINCT Id
    FROM #t;

    DECLARE @allowed app.ResourceIdTable;
    INSERT INTO @allowed
    EXEC app.sp_FilterConceptsByConstraint @user, @groups, @requested, @admin = @admin;

    EXEC app.sp_HydrateConceptsByIds @allowed;
END















GO
/****** Object:  StoredProcedure [app].[sp_GetPreflightConceptById]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =======================================
-- Author:      Cliff Spital
-- Create date: 2018/10/24
-- Description: Retrieves a preflight report and concept directly by Id.
-- =======================================
CREATE PROCEDURE [app].[sp_GetPreflightConceptById]
    @id [uniqueidentifier],
    @user auth.[User],
    @groups auth.GroupMembership READONLY,
    @admin bit = 0
AS
BEGIN
    SET NOCOUNT ON

    DECLARE @requested app.ResourceIdTable;

    INSERT INTO @requested
    SELECT @id;

    DECLARE @preflight app.ConceptPreflightTable;
    INSERT INTO @preflight
    EXEC app.sp_InternalConceptPreflightCheck @requested, @user, @groups, @admin = @admin;

    DECLARE @allowed app.ResourceIdTable;
    INSERT INTO @allowed
    SELECT Id
    FROM @preflight
    WHERE IsPresent = 1 AND IsAuthorized = 1;

    SELECT Id, UniversalId, IsPresent, IsAuthorized
    FROM @preflight;

    EXEC app.sp_HydrateConceptsByIds @allowed;

END









GO
/****** Object:  StoredProcedure [app].[sp_GetPreflightConceptByUId]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =======================================
-- Author:      Cliff Spital
-- Create date: 2018/10/24
-- Description: Retrieves preflight report and concepts requested by universalIds.
-- =======================================
CREATE PROCEDURE [app].[sp_GetPreflightConceptByUId]
    @uid nvarchar(200),
    @user auth.[User],
    @groups auth.GroupMembership READONLY,
    @admin bit = 0
AS
BEGIN
    SET NOCOUNT ON

    DECLARE @requested app.ResourceUniversalIdTable;

    INSERT INTO @requested
    SELECT @uid;

    DECLARE @preflight app.ConceptPreflightTable;
    INSERT INTO @preflight
    EXEC app.sp_UniversalConceptPreflightCheck @requested, @user, @groups, @admin = @admin;

    DECLARE @allowed app.ResourceIdTable;
    INSERT INTO @allowed
    SELECT Id
    FROM @preflight
    WHERE IsPresent = 1 and IsAuthorized = 1;

    SELECT Id, UniversalId, IsPresent, IsAuthorized
    FROM @preflight;

    exec app.sp_HydrateConceptsByIds @allowed;

END










GO
/****** Object:  StoredProcedure [app].[sp_GetPreflightConceptsByIds]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =======================================
-- Author:      Cliff Spital
-- Create date: 2018/10/24
-- Description: Retrieves preflight report and concepts by Id.
-- =======================================
CREATE PROCEDURE [app].[sp_GetPreflightConceptsByIds]
    @ids app.ResourceIdTable READONLY,
    @user auth.[User],
    @groups auth.GroupMembership READONLY,
    @admin bit = 0
AS
BEGIN
    SET NOCOUNT ON

    DECLARE @preflight app.ConceptPreflightTable;
    INSERT INTO @preflight
    EXEC app.sp_InternalConceptPreflightCheck @ids, @user, @groups, @admin = @admin;

    DECLARE @allowed app.ResourceIdTable;
    INSERT INTO @allowed
    SELECT Id
    FROM @preflight
    WHERE IsPresent = 1 AND IsAuthorized = 1;

    SELECT Id, UniversalId, IsPresent, IsAuthorized
    FROM @preflight;
    
    EXEC app.sp_HydrateConceptsByIds @allowed;

END









GO
/****** Object:  StoredProcedure [app].[sp_GetPreflightConceptsByUIds]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =======================================
-- Author:      Cliff Spital
-- Create date: 2018/10/24
-- Description: Retrieves preflight report and concepts by UIds.
-- =======================================
CREATE PROCEDURE [app].[sp_GetPreflightConceptsByUIds]
    @uids app.ResourceUniversalIdTable READONLY,
    @user auth.[User],
    @groups auth.GroupMembership READONLY,
    @admin bit = 0
AS
BEGIN
    SET NOCOUNT ON

    DECLARE @preflight app.ConceptPreflightTable;
    INSERT INTO @preflight
    EXEC app.sp_UniversalConceptPreflightCheck @uids, @user, @groups, @admin = @admin;

    DECLARE @allowed app.ResourceIdTable;
    INSERT INTO @allowed
    SELECT Id
    FROM @preflight
    WHERE IsPresent = 1 and IsAuthorized = 1;

    SELECT Id, UniversalId, IsPresent, IsAuthorized
    FROM @preflight;

    EXEC app.sp_HydrateConceptsByIds @allowed;

END









GO
/****** Object:  StoredProcedure [app].[sp_GetPreflightGlobalPanelFilters]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Nic Dobbins
-- Create date: 2019/9/5
-- Description: Retrieves global panel filters 
--              relevant to current session context
-- =======================================
CREATE PROCEDURE [app].[sp_GetPreflightGlobalPanelFilters]
    @sessionType auth.SessionType
AS
BEGIN
    SET NOCOUNT ON

    SELECT
        GPF.Id
      , GPF.IsInclusion
      , CS.SqlSetFrom
      , GPF.SqlSetWhere
    FROM app.GlobalPanelFilter AS GPF
         INNER JOIN app.ConceptSqlSet AS CS
            ON GPF.SqlSetId = CS.Id
    WHERE (GPF.SessionType = @sessionType OR GPF.SessionType IS NULL)
    
END
GO
/****** Object:  StoredProcedure [app].[sp_GetPreflightImportsByIds]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Nic Dobbins
-- Create date: 2019/10/21
-- Description: Retrieves preflight import Ids by Id.
-- =======================================
CREATE PROCEDURE [app].[sp_GetPreflightImportsByIds]
    @ids app.ResourceIdTable READONLY,
    @user auth.[User],
    @groups auth.GroupMembership READONLY,
    @admin bit = 0
AS
BEGIN
    SET NOCOUNT ON

	DECLARE @authorized TABLE (Id uniqueIdentifier)
	DECLARE @results TABLE (Id uniqueidentifier, IsPresent bit, IsAuthorized bit)
	INSERT INTO @results (Id, IsPresent, IsAuthorized)
	SELECT 
		Id
	  , IsPresent = CASE WHEN EXISTS (SELECT 1 FROM app.ImportMetadata AS IM WHERE IM.Id = IDS.Id) THEN 1 ELSE 0 END
	  , IsAuthorized = 0
	FROM @ids AS IDS

	IF (@admin = 1)
    BEGIN;
        -- user is an admin, load all
		INSERT INTO @authorized (Id)
        SELECT IM.Id
        FROM app.ImportMetadata AS IM
		WHERE EXISTS (SELECT 1 FROM @ids AS IDS WHERE IM.ID = IDS.Id)
    END;
    ELSE
    BEGIN;
        -- user is not an admin, assess their privilege
		INSERT INTO @authorized (Id)
        SELECT IM.Id
        FROM app.ImportMetadata AS IM
        WHERE EXISTS (SELECT 1 FROM @ids AS IDS WHERE IM.ID = IDS.Id)
		AND
		(
			EXISTS (
				SELECT 1
				FROM auth.ImportMetadataConstraint AS IMC
				WHERE IMC.ImportMetadataId = IM.Id AND
				ConstraintId = 1 AND
				ConstraintValue = @user
			)
			OR EXISTS (
				SELECT 1
				FROM auth.ImportMetadataConstraint AS IMC
				WHERE IMC.ImportMetadataId = IM.Id AND
				ConstraintId = 2 AND
				ConstraintValue in (SELECT [Group] FROM @groups)
			)
			OR NOT EXISTS (
				SELECT 1
				FROM auth.ImportMetadataConstraint AS IMC
				WHERE IMC.ImportMetadataId = IM.Id
			)
		);
    END;

	UPDATE @results
	SET IsAuthorized = 1
	FROM @results AS R
	WHERE EXISTS (SELECT 1 FROM @authorized AS A WHERE R.Id = A.Id)

	SELECT *
	FROM @results

END

GO
/****** Object:  StoredProcedure [app].[sp_GetPreflightImportsByUIds]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Nic Dobbins
-- Create date: 2019/10/21
-- Description: Retrieves preflight import Ids by UId.
-- =======================================
CREATE PROCEDURE [app].[sp_GetPreflightImportsByUIds]
    @uids app.ResourceUniversalIdTable READONLY,
    @user auth.[User],
    @groups auth.GroupMembership READONLY,
    @admin bit = 0
AS
BEGIN
    SET NOCOUNT ON

	-- Imports cannot be accessed by UID, return nothing.
	SELECT 
		Id = CAST(NULL AS uniqueidentifier)
	  , IsPresent = CAST(0 AS BIT)
	  , IsAuthorized = CAST(0 AS BIT)

END

GO
/****** Object:  StoredProcedure [app].[sp_GetPreflightQueriesByIds]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Cliff Spital
-- Create date: 2019/2/4
-- Description: Performs a query preflight check by Ids.
-- =======================================
CREATE PROCEDURE [app].[sp_GetPreflightQueriesByIds]
    @qids app.ResourceIdTable READONLY,
    @user auth.[User],
    @groups auth.GroupMembership READONLY,
    @admin bit = 0
AS
BEGIN
    SET NOCOUNT ON

    declare @preflight table (
        QueryId UNIQUEIDENTIFIER,
        QueryUniversalId app.UniversalId,
        QueryVer int,
        QueryIsPresent bit null,
        QueryIsAuthorized bit null,
        ConceptId UNIQUEIDENTIFIER,
        ConceptUniversalId app.UniversalId null,
        ConceptIsPresent bit null,
        ConceptIsAuthorized bit null
    );

    with queries (QueryId, IsPresent) as (
        select qs.Id, IsPresent = case when aq.Id is not null then cast(1 as bit) else cast(0 as bit) end
        from @qids qs
        left join app.Query aq on qs.Id = aq.Id
        union
        select QueryId, cast(1 as bit)
        from rela.QueryDependency qd
        where exists (select 1 from @qids where Id = QueryId)
        union all
        select qd.DependsOn, cast(1 as bit)
        from queries q
        join rela.QueryDependency qd on qd.QueryId = q.QueryId
    ),
    enriched (QueryId, UniversalId, Ver, IsPresent) as (
        select
            qs.QueryId,
            q.UniversalId,
            q.Ver,
            qs.IsPresent
        from queries qs
        left join app.Query q on qs.QueryId = q.Id
    ),
    authQ (QueryId, UniversalId, Ver, IsPresent, IsAuthorized) as (
        select e.QueryId, e.UniversalId, e.Ver, e.IsPresent, auth.fn_UserIsAuthorizedForQueryById(@user, @groups, e.QueryId, @admin)
        from enriched e
    ),
    withConcepts (QueryId, UniversalId, Ver, IsPresent, IsAuthorized, ConceptId) as (
        select a.*, ConceptId = qc.DependsOn
        from authQ a
        left join rela.QueryConceptDependency qc on a.QueryId = qc.QueryId -- left
    )
    insert into @preflight (QueryId, QueryUniversalId, QueryVer, QueryIsPresent, QueryIsAuthorized, ConceptId)
    select QueryId, UniversalId, Ver, IsPresent, IsAuthorized, ConceptId
    from withConcepts;

    declare @concIds app.ResourceIdTable;
    insert into @concIds
    select distinct ConceptId
    from @preflight;

    declare @conceptAuths app.ConceptPreflightTable;
    insert @conceptAuths
    exec app.sp_InternalConceptPreflightCheck @concIds, @user, @groups, @admin = @admin;

    update p
    set
        p.ConceptUniversalId = ca.UniversalId,
        p.ConceptIsPresent = ca.IsPresent,
        p.ConceptIsAuthorized = ca.IsAuthorized
    from @preflight p
    join @conceptAuths ca on p.ConceptId = ca.Id;

    select *
    from @preflight
    order by QueryId desc;
END
GO
/****** Object:  StoredProcedure [app].[sp_GetPreflightQueriesByUIds]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Cliff Spital
-- Create date: 2019/2/4
-- Description: Performs a query preflight check by Ids.
-- =======================================
CREATE PROCEDURE [app].[sp_GetPreflightQueriesByUIds]
    @quids app.ResourceUniversalIdTable READONLY,
    @user auth.[User],
    @groups auth.GroupMembership READONLY,
    @admin bit = 0
AS
BEGIN
    SET NOCOUNT ON

    declare @preflight table (
        QueryId UNIQUEIDENTIFIER,
        QueryUniversalId app.UniversalId,
        QueryVer int,
        QueryIsPresent bit null,
        QueryIsAuthorized bit null,
        ConceptId UNIQUEIDENTIFIER,
        ConceptUniversalId app.UniversalId null,
        ConceptIsPresent bit null,
        ConceptIsAuthorized bit null
    );


    with initial (QueryId, UniversalId, Ver, IsPresent) as (
        select aq.Id, qs.UniversalId, Ver, IsPresent = case when aq.Id is not null then cast(1 as bit) else cast(0 as bit) end
        from @quids qs
        left join app.Query aq on qs.UniversalId = aq.UniversalId
    ),
    queries (QueryId, IsPresent) as (
        select qs.QueryId, IsPresent
        from initial qs
        left join app.Query aq on qs.QueryId = aq.Id
        union all
        select qd.DependsOn, cast(1 as bit)
        from queries q
        join rela.QueryDependency qd on qd.QueryId = q.QueryId
    ),
    enriched (QueryId, UniversalId, Ver, IsPresent) as (
        select
            qs.QueryId,
            q.UniversalId,
            q.Ver,
            qs.IsPresent
        from queries qs
        left join app.Query q on qs.QueryId = q.Id
    ),
    authQ (QueryId, UniversalId, Ver, IsPresent, IsAuthorized) as (
        select e.QueryId, e.UniversalId, e.Ver, e.IsPresent, auth.fn_UserIsAuthorizedForQueryById(@user, @groups, e.QueryId, @admin)
        from enriched e
    ),
    withConcepts (QueryId, UniversalId, Ver, IsPresent, IsAuthorized, ConceptId) as (
        select a.*, ConceptId = qc.DependsOn
        from authQ a
        left join rela.QueryConceptDependency qc on a.QueryId = qc.QueryId
    )
    insert into @preflight (QueryId, QueryUniversalId, QueryVer, QueryIsPresent, QueryIsAuthorized, ConceptId)
    select QueryId, UniversalId, Ver, IsPresent, NULL, NULL
    from initial
    where QueryId is null
    union
    select QueryId, UniversalId, Ver, IsPresent, IsAuthorized, ConceptId
    from withConcepts;

    declare @concIds app.ResourceIdTable;
    insert into @concIds
    select distinct ConceptId
    from @preflight;

    declare @conceptAuths app.ConceptPreflightTable;
    insert @conceptAuths
    exec app.sp_InternalConceptPreflightCheck @concIds, @user, @groups, @admin = @admin;

    update p
    set
        p.ConceptUniversalId = ca.UniversalId,
        p.ConceptIsPresent = ca.IsPresent,
        p.ConceptIsAuthorized = ca.IsAuthorized
    from @preflight p
    join @conceptAuths ca on p.ConceptId = ca.Id;

    select *
    from @preflight
    order by QueryId desc;
END
GO
/****** Object:  StoredProcedure [app].[sp_GetPreflightResourcesByIds]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Cliff Spital
-- Create date: 2019/2/4
-- Description: Performs a preflight resource check by Ids.
-- =======================================
CREATE PROCEDURE [app].[sp_GetPreflightResourcesByIds]
    @qids app.ResourceIdTable READONLY,
    @cids app.ResourceIdTable READONLY,
	@iids app.ResourceIdTable READONLY,
    @user auth.[User],
    @groups auth.GroupMembership READONLY,
    @sessionType auth.SessionType,
    @admin bit = 0
AS
BEGIN
    SET NOCOUNT ON

    exec app.sp_GetPreflightQueriesByIds @qids, @user, @groups, @admin = @admin;

    exec app.sp_GetPreflightConceptsByIds @cids, @user, @groups, @admin = @admin;

	exec app.sp_GetPreflightImportsByIds @iids, @user, @groups, @admin = @admin

    exec app.sp_GetPreflightGlobalPanelFilters @sessionType;
END

GO
/****** Object:  StoredProcedure [app].[sp_GetPreflightResourcesByUIds]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Cliff Spital
-- Create date: 2019/2/4
-- Description: Performs a preflight resources check by UIds
-- =======================================
CREATE PROCEDURE [app].[sp_GetPreflightResourcesByUIds]
    @quids app.ResourceUniversalIdTable READONLY,
    @cuids app.ResourceUniversalIdTable READONLY,
	@iuids app.ResourceUniversalIdTable READONLY,
    @user auth.[User],
    @groups auth.GroupMembership READONLY,
    @sessionType auth.SessionType,
    @admin bit = 0
AS
BEGIN
    SET NOCOUNT ON

    exec app.sp_GetPreflightQueriesByUIds @quids, @user, @groups, @admin = @admin;

    exec app.sp_GetPreflightConceptsByUIds @cuids, @user, @groups, @admin = @admin;

	exec app.sp_GetPreflightImportsByUIds @iuids, @user, @groups, @admin = @admin;

    exec app.sp_GetPreflightGlobalPanelFilters @sessionType;
END

GO
/****** Object:  StoredProcedure [app].[sp_GetRootConcepts]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =======================================
-- Author:      Cliff Spital
-- Create date: 2018/7/10
-- Description: Retrieves all Top Parent concept's
-- =======================================
CREATE PROCEDURE [app].[sp_GetRootConcepts]
    @user auth.[User],
    @groups auth.GroupMembership READONLY,
    @admin bit = 0
AS
BEGIN
    SET NOCOUNT ON

    DECLARE @requested app.ResourceIdTable;

    INSERT INTO @requested
    SELECT Id
    FROM app.Concept
    WHERE IsRoot = 1;

    DECLARE @allowed app.ResourceIdTable;
    INSERT INTO @allowed
    EXEC app.sp_FilterConceptsByConstraint @user, @groups, @requested, @admin = @admin;

    EXEC app.sp_HydrateConceptsByIds @allowed;
END















GO
/****** Object:  StoredProcedure [app].[sp_GetRootsPanelFilters]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =======================================
-- Author:      Cliff Spital
-- Create date: 2018/9/14
-- Description: Gets roots and panel filters, in the first and second result set respecively.
-- =======================================
CREATE PROCEDURE [app].[sp_GetRootsPanelFilters]
    @user auth.[User],
    @groups auth.GroupMembership READONLY,
    @admin bit = 0
AS
BEGIN
    SET NOCOUNT ON

    EXEC app.sp_GetRootConcepts @user, @groups, @admin = @admin;

    SELECT
        f.Id,
        f.ConceptId,
        ConceptUniversalId = c.UniversalId,
        f.IsInclusion,
        f.UiDisplayText,
        f.UiDisplayDescription
    FROM
        app.PanelFilter f
    JOIN app.Concept c on f.ConceptId = c.Id
    
END

GO
/****** Object:  StoredProcedure [app].[sp_GetSavedBaseQueriesByConstraint]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Cliff Spital
-- Create date: 2018/10/29
-- Description: Retrieves all saved query pointers owned by the given user.
-- =======================================
CREATE PROCEDURE [app].[sp_GetSavedBaseQueriesByConstraint]
    @user auth.[User],
    @groups auth.GroupMembership READONLY
AS
BEGIN
    SET NOCOUNT ON;

    WITH permitted (QueryId) AS (
        -- user based constraint
        SELECT
            QueryId
        FROM auth.QueryConstraint
        WHERE ConstraintId = 1
        AND ConstraintValue = @user
        UNION
        -- group base constraint
        SELECT
            QueryId
        FROM auth.QueryConstraint
        WHERE ConstraintId = 2
        AND ConstraintValue IN (SELECT [Group] FROM @groups)
    )
    SELECT
        q.Id,
        q.UniversalId,
        q.[Name],
        q.[Category],
        q.[Owner],
        q.Created,
        q.Updated,
        [Count] = COUNT(c.QueryId)
    FROM app.Query q
    LEFT JOIN app.Cohort c on q.Id = c.QueryId
    WHERE (q.[Owner] = @user OR q.Id IN (SELECT QueryId FROM permitted))
    AND UniversalId IS NOT NULL
    AND Nonce IS NULL
    GROUP BY q.Id,
        q.UniversalId,
        q.[Name],
        q.[Category],
        q.[Owner],
        q.Created,
        q.Updated;
END
GO
/****** Object:  StoredProcedure [app].[sp_GetSavedBaseQueriesByOwner]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Cliff Spital
-- Create date: 2018/10/29
-- Description: Retrieves all saved query pointers owned by the given user.
-- =======================================
CREATE PROCEDURE [app].[sp_GetSavedBaseQueriesByOwner]
    @user auth.[User]
AS
BEGIN
    SET NOCOUNT ON

    SELECT
        q.Id,
        q.UniversalId,
        q.[Name],
        q.[Category],
        q.[Owner],
        q.Created,
        q.Updated,
        [Count] = COUNT(c.QueryId)
    FROM
        app.Query q
    LEFT JOIN app.Cohort c on q.Id = c.QueryId
    WHERE [Owner] = @user
    AND UniversalId IS NOT NULL
    AND Nonce IS NULL
    GROUP BY q.Id,
        q.UniversalId,
        q.[Name],
        q.[Category],
        q.[Owner],
        q.Created,
        q.Updated;
END
GO
/****** Object:  StoredProcedure [app].[sp_GetSavedQueryByUId]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Cliff Spital
-- Create date: 2018/10/29
-- Description: Retrieve a query by UniversalId if owner.
-- =======================================
CREATE PROCEDURE [app].[sp_GetSavedQueryByUId]
    @uid app.UniversalId,
    @user auth.[User],
    @groups auth.GroupMembership READONLY,
	@admin bit = 0
AS
BEGIN
    SET NOCOUNT ON;

    -- translate to local id
    DECLARE @id uniqueidentifier;
    SELECT @id = Id
    FROM app.Query
    WHERE UniversalId = @uid;

    DECLARE @result TABLE (
        Id UNIQUEIDENTIFIER NOT NULL,
        UniversalId nvarchar(200) NOT NULL,
        [Name] nvarchar(400) NULL,
        [Category] nvarchar(400) NULL,
        [Owner] nvarchar(1000) NOT NULL,
        Created datetime NOT NULL,
        [Definition] app.QueryDefinitionJson,
        Updated datetime not null,
        [Count] int null
    );

    -- if not found
    IF @id IS NULL
    BEGIN
        SELECT
            Id,
            UniversalId,
            [Name],
            [Category],
            [Owner],
            Created,
            Updated,
            [Definition],
            [Count]
        FROM @result;
        RETURN;
    END;

	-- Admin can access any query
	IF (@admin = 1)
		INSERT INTO @result (Id, UniversalId, [Name], [Category], [Owner], Created, Updated, [Definition])
		SELECT
			q.Id,
			q.UniversalId,
			q.[Name],
			q.[Category],
			q.[Owner],
			q.Created,
			q.Updated,
			d.[Definition]
		FROM app.Query q
		JOIN app.QueryDefinition d on q.Id = d.QueryId
		WHERE q.UniversalId = @uid;
	ELSE
		BEGIN
			-- permission filter
			WITH permitted AS (
				-- user based constraint
				SELECT
					QueryId
				FROM auth.QueryConstraint
				WHERE QueryId = @id
				AND ConstraintId = 1
				AND ConstraintValue = @user
				UNION
				-- group base constraint
				SELECT
					QueryId
				FROM auth.QueryConstraint
				WHERE QueryId = @id
				AND ConstraintId = 2
				AND ConstraintValue IN (SELECT [Group] FROM @groups)
			)
			INSERT INTO @result (Id, UniversalId, [Name], [Category], [Owner], Created, Updated, [Definition])
			SELECT
				q.Id,
				q.UniversalId,
				q.[Name],
				q.[Category],
				q.[Owner],
				q.Created,
				q.Updated,
				d.[Definition]
			FROM app.Query q
			JOIN app.QueryDefinition d on q.Id = d.QueryId
			WHERE (q.[Owner] = @user OR q.Id IN (SELECT Id FROM permitted))
				  AND q.UniversalId = @uid;
		END

    -- did not pass filter
    IF (SELECT COUNT(*) FROM @result) < 1
		BEGIN
			DECLARE @secmsg nvarchar(400) = @user + ' not permitted to query ' + @uid;
			THROW 70403, @secmsg, 1
		END;
    
    -- collect counts
    WITH counts (QueryId, Cnt) as (
        SELECT QueryId, Cnt = COUNT(*)
        FROM @result r
        JOIN app.Cohort c on r.Id = c.QueryId
        GROUP BY QueryId
    )
    UPDATE r
    SET [Count] = c.Cnt
    FROM @result r
    JOIN counts c on c.QueryId = r.Id;


    -- return
    SELECT
        Id,
        UniversalId,
        [Name],
        [Category],
        [Owner],
        Created,
        Updated,
        [Definition],
        [Count]
    FROM @result;
END

GO
/****** Object:  StoredProcedure [app].[sp_HydrateConceptsByIds]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =======================================
-- Author:      Cliff Spital, modified by Nic Dobbins
-- Create date: 2018/8/2
-- Modify date: 2019/1/4 - Added Concept Specializations
-- Description: Hydrates a list of Concept Models by Ids
-- =======================================
CREATE PROCEDURE [app].[sp_HydrateConceptsByIds]
    @ids app.ResourceIdTable READONLY
AS
BEGIN
    SET NOCOUNT ON

	DECLARE @specializedGroups app.ListTable

	-- Get specialization groups for
	-- the concepts to be retrieved
	INSERT INTO @specializedGroups (Id)
	SELECT sg.Id
	FROM app.SpecializationGroup sg
	WHERE EXISTS (SELECT 1 
				  FROM rela.ConceptSpecializationGroup csg
					   INNER JOIN app.Concept c
							ON csg.ConceptId = c.Id
				  WHERE EXISTS (SELECT 1 FROM @ids i WHERE i.Id = c.Id)
						AND c.SqlSetId = sg.SqlSetId
						AND c.IsSpecializable = 1)

	-- Return concepts
    SELECT
        c.Id,
        c.ParentId,
        c.RootId,
        c.ExternalId,
        c.ExternalParentId,
        c.UniversalId,
        c.IsNumeric,
        s.IsEventBased,
        c.IsParent,
        s.IsEncounterBased,
        c.IsPatientCountAutoCalculated,
        c.IsSpecializable,
        s.SqlSetFrom,
        c.SqlSetWhere,
        s.SqlFieldDate,
        c.SqlFieldNumeric,
        s.SqlFieldEvent,
        c.UiDisplayName,
        c.UiDisplayText,
		c.UiDisplaySubtext,
        c.UiDisplayUnits,
        c.UiDisplayTooltip,
        c.UiDisplayPatientCount,
        c.UiDisplayPatientCountByYear,
        e.UiDisplayEventName,
        c.UiNumericDefaultText,
        EventTypeId = e.Id
    FROM app.Concept c
		 INNER JOIN app.ConceptSqlSet s
			ON c.SqlSetId = s.Id
         LEFT JOIN app.ConceptEvent e
            ON s.EventId = e.Id
               AND s.IsEventBased = 1
    WHERE EXISTS (SELECT 1 FROM @ids i WHERE c.Id = i.Id)
    ORDER BY c.UiDisplayRowOrder, c.UiDisplayName

	-- Return Specialization groups
	-- with ConceptId context
	SELECT csg.ConceptId
		 , sg.Id
		 , sg.UiDefaultText
		 , csg.OrderId
	FROM rela.ConceptSpecializationGroup csg
		 INNER JOIN app.SpecializationGroup sg
			ON csg.SpecializationGroupId = sg.Id
	WHERE EXISTS (SELECT 1 FROM @ids i WHERE i.Id = csg.ConceptId)
		  AND EXISTS (SELECT 1 FROM @specializedGroups sg WHERE sg.Id = sg.Id)

	-- Return Specializations
	SELECT s.Id
		 , s.SpecializationGroupId	
		 , s.UniversalId
		 , s.UiDisplayText
		 , s.SqlSetWhere
		 , s.OrderId
	FROM app.Specialization s
	WHERE EXISTS (SELECT 1 FROM @specializedGroups sg WHERE sg.Id = s.SpecializationGroupId)

END
GO


/****** Object:  StoredProcedure [auth].[sp_GetUserGroupsAndRoles]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Nic Dobbins
-- Create date: 2021/10/19
-- Description: Gets user roles
-- =======================================
CREATE PROCEDURE [auth].[sp_GetUserGroupsAndRoles]
    @scopedId nvarchar(200)
AS
BEGIN
    SET NOCOUNT ON

    -- Roles
    SELECT IsUser, IsAdmin, IsSuper, IsIdentified, IsFederated
    FROM [auth].[UserRole] AS R
    WHERE R.ScopedIdentity = @scopedId

    -- Groups
    SELECT GroupName
    FROM [auth].[UserGroup] AS G
    WHERE G.ScopedIdentity = @scopedId

END
GO





/****** Object:  StoredProcedure [app].[sp_ImportData]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Nic Dobbins
-- Create date: 2019/9/30
-- Description: Adds import records tied to a metadata record.
-- =======================================
CREATE PROCEDURE [app].[sp_ImportData]
	@id uniqueidentifier,
	@data [app].[ImportDataTable] READONLY,
    @user auth.[User],
	@groups auth.GroupMembership READONLY,
	@admin bit = 0
AS
BEGIN
    SET NOCOUNT ON

	IF (NOT EXISTS (SELECT 1 FROM app.ImportMetadata AS IT WHERE @id = IT.Id))
    BEGIN;
        THROW 70404, N'ImportMetadata does not exist.', 1;
    END;

	DECLARE @authorized BIT = [auth].[fn_UserIsAuthorizedForImportMetadataById](@user, @groups, @id, @admin)

	IF @authorized = 0
	BEGIN;
		DECLARE @403msg1 nvarchar(400) = @user + N' is not allowed to to import data for ' + CONVERT(NVARCHAR(100),@id);
        THROW 70403, @403msg1, 1;
	END;

	DECLARE @changed INT = 0;

	-- Check for UPDATEs
	UPDATE app.Import
	SET
		PersonId = D.PersonId
	  , SourcePersonId = D.SourcePersonId
	  , SourceValue = D.SourceValue
	  , SourceModifier = D.SourceModifier
	  , ValueString = D.ValueString
	  , ValueNumber = D.ValueNumber
	  , ValueDate = D.ValueDate
	FROM @data AS D
		 INNER JOIN app.Import AS I
			ON I.Id = D.Id 
			   AND I.PersonId = D.PersonId
			   AND I.ImportMetadataId = D.ImportMetadataId
			   AND I.ImportMetadataId = @id

	SET @changed += @@ROWCOUNT
	
	-- INSERT the remainder
	INSERT INTO app.Import(Id, ImportMetadataId, PersonId, SourcePersonId, SourceValue, SourceModifier, ValueString, ValueNumber, ValueDate)
	SELECT
		D.Id
	  , ImportMetadataId = @id
	  , D.PersonId
	  , D.SourcePersonId
	  , D.SourceValue
	  , D.SourceModifier
	  , D.ValueString
	  , D.ValueNumber
	  , D.ValueDate
	FROM @data AS D
	WHERE NOT EXISTS (SELECT 1 
					  FROM app.Import AS I 
					  WHERE I.Id = D.Id 
						    AND I.PersonId = D.PersonId
						    AND I.ImportMetadataId = D.ImportMetadataId
						    AND I.ImportMetadataId = @id)

	SELECT Changed = @changed + @@ROWCOUNT

END

GO
/****** Object:  StoredProcedure [app].[sp_InternalConceptPreflightCheck]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =======================================
-- Author:      Cliff Spital
-- Create date: 2018/10/23
-- Description: Preflight checks institutionally referenced conceptIds.
-- Required Checks: Is concept present? Is the user authorized to execute?
-- =======================================
CREATE PROCEDURE [app].[sp_InternalConceptPreflightCheck]
    @ids app.ResourceIdTable READONLY,
    @user auth.[User],
    @groups auth.GroupMembership READONLY,
    @admin bit = 0
AS
BEGIN
    SET NOCOUNT ON

    DECLARE @results app.ConceptPreflightTable;

    INSERT INTO @results (Id, IsPresent, IsAuthorized)
    SELECT Id, 0, 0 -- initialize bools to false
    FROM @ids;

    -- identify which ids are present
    WITH present as (
        SELECT Id, UniversalId
        FROM app.Concept c
        WHERE EXISTS (SELECT 1 FROM @ids i WHERE i.Id = c.Id)
    )
    UPDATE @results
    SET
        UniversalId = p.UniversalId,
        IsPresent = 1
    FROM @results r
    JOIN present p on r.Id = p.Id

    -- identify which ids are authorized
    -- dont bother checking missing concepts
    DECLARE @requested app.ResourceIdTable;
    INSERT INTO @requested
    SELECT Id
    FROM @results
    WHERE IsPresent = 1;

    DECLARE @allowed app.ResourceIdTable;
    INSERT INTO @allowed
    SELECT Id FROM app.fn_FilterConceptsByConstraint(@user, @groups, @requested, @admin);

    UPDATE @results
    SET
        IsAuthorized = 1
    FROM @results r
    WHERE EXISTS (SELECT 1 FROM @allowed a WHERE r.Id = a.Id)

    SELECT
        Id,
        UniversalId,
        IsPresent,
        IsAuthorized
    FROM @results;



END










GO
/****** Object:  StoredProcedure [app].[sp_InternalQuerySaveInitial]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Cliff Spital
-- Create date: 2019/1/9
-- Description: Contains core logic for initial save functionality.
-- =======================================
CREATE PROCEDURE [app].[sp_InternalQuerySaveInitial]
    @queryid UNIQUEIDENTIFIER,
    @urn app.UniversalId,
    @ver int,
    @name nvarchar(200),
    @category nvarchar(200),
    @conceptids app.ResourceIdTable READONLY,
    @queryids app.ResourceIdTable READONLY,
    @definition app.QueryDefinitionJson,
    @user auth.[User]
AS
BEGIN
    SET NOCOUNT ON

    -- update app.Query with name, category, universalid, remove nonce
    UPDATE app.Query
    SET
        Nonce = NULL,
		[Owner] = @user,
        [Name] = @name,
        Category = @category,
        UniversalId = @urn,
        Ver = @ver
    WHERE Id = @queryid;

    -- insert definition into app.QueryDefinition
    INSERT INTO app.QueryDefinition
    SELECT @queryid, @definition;

    -- insert dependencies into rela.QueryConceptDependency
    INSERT INTO rela.QueryConceptDependency
    SELECT @queryid, Id
    FROM @conceptids;
    
    -- insert dependencies into rela.QueryDependency
    INSERT INTO rela.QueryDependency
    SELECT @queryid, Id
    FROM @queryids;

END

GO
/****** Object:  StoredProcedure [app].[sp_InternalQuerySaveUpdateMove]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Cliff Spital
-- Create date: 2019/1/9
-- Description: Performs a resave of an existing query.
-- =======================================
CREATE PROCEDURE [app].[sp_InternalQuerySaveUpdateMove]
    @oldqueryid UNIQUEIDENTIFIER,
    @queryid UNIQUEIDENTIFIER,
    @urn app.UniversalId,
    @ver int,
    @name nvarchar(200),
    @category nvarchar(200),
    @conceptids app.ResourceIdTable READONLY,
    @queryids app.ResourceIdTable READONLY,
    @definition app.QueryDefinitionJson,
    @user auth.[User]
AS
BEGIN
    SET NOCOUNT ON

    DECLARE @created table (
        created datetime
    );

    -- satisfy the FK
    UPDATE app.Query
    SET UniversalId = NULL
    OUTPUT deleted.Created INTO @created
    WHERE Id = @oldqueryid;

    -- delegate to sp_InternalQuerySaveInitial
    EXEC app.sp_InternalQuerySaveInitial @queryid, @urn, @ver, @name, @category, @conceptids, @queryids, @definition, @user;

    UPDATE app.Query
    SET Created = (SELECT TOP 1 created FROM @created)
    WHERE Id = @queryid;

    -- move constraints from oldqueryid that aren't already present
    INSERT INTO auth.QueryConstraint
    SELECT @queryid, ConstraintId, ConstraintValue
    FROM auth.QueryConstraint AS QC
    WHERE QueryId = @oldqueryid
		  AND NOT EXISTS (SELECT 1 
						  FROM auth.QueryConstraint AS NEWQC 
						  WHERE NEWQC.QueryId = @queryid
								AND QC.ConstraintId = NEWQC.ConstraintId 
								AND QC.ConstraintValue = NEWQC.ConstraintValue)

    -- cleanup the oldqueryid
    -- remove cached cohort
    DELETE FROM app.Cohort
    WHERE QueryId = @oldqueryid;

    -- unconstrain query
    DELETE FROM auth.QueryConstraint
    WHERE QueryId = @oldqueryid;

    -- delete definition
    DELETE FROM app.QueryDefinition
    WHERE QueryId = @oldqueryid;

    -- migrate dependents over to new id before deleting old deps
    UPDATE rela.QueryDependency
    SET DependsOn = @queryid
    WHERE DependsOn = @oldqueryid;

    -- update dependents definition to new id (search/replace)
    WITH directParents(QueryId) as (
        SELECT QueryId
        FROM rela.QueryDependency
        WHERE DependsOn = @oldqueryid
    )
    UPDATE app.QueryDefinition
    SET
        [Definition] = REPLACE([Definition], cast(@oldqueryid as [nvarchar](50)), cast(@queryid as [nvarchar](50)))
    WHERE QueryId IN (SELECT QueryId FROM directParents);

    -- delete dependencies
    DELETE FROM rela.QueryConceptDependency
    WHERE QueryId = @oldqueryid;

    DELETE FROM rela.QueryDependency
    WHERE QueryId = @oldqueryid;

    -- delete unsaved query
    DELETE FROM app.Query
    WHERE Id = @oldqueryid;
END

GO
/****** Object:  StoredProcedure [app].[sp_QuerySaveInitial]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =======================================
-- Author:      Cliff Spital
-- Create date: 2019/1/9
-- Description: Performs the initial homerun query save.
-- =======================================
CREATE PROCEDURE [app].[sp_QuerySaveInitial]
    @queryid UNIQUEIDENTIFIER,
    @urn app.UniversalId,
    @name nvarchar(200),
    @category nvarchar(200),
    @conceptids app.ResourceIdTable READONLY,
    @queryids app.ResourceIdTable READONLY,
    @definition app.QueryDefinitionJson,
    @user auth.[User]
AS
BEGIN
    SET NOCOUNT ON

    -- ensure saving user is the owner of the query
    DECLARE @owner NVARCHAR(1000), @qid UNIQUEIDENTIFIER;

    SELECT @qid = Id, @owner = [Owner]
    FROM app.Query
    WHERE Id = @queryid;

    IF (@qid IS NULL)
    BEGIN;
        SELECT UniversalId = NULL, Ver = NULL WHERE 1 = 0;
        RETURN;
    END;
    
    IF (@owner != @user)
    BEGIN;
        DECLARE @403msg NVARCHAR(400) = N'Query ' + cast(@queryid as nvarchar(50)) + N' is not owned by ' + @user;
        THROW 70403, @403msg, 1;
    END;

    -- if so begin transaction and continue
    BEGIN TRAN;

    BEGIN TRY

        EXEC app.sp_InternalQuerySaveInitial @queryid, @urn, 1, @name, @category, @conceptids, @queryids, @definition, @user;

        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        THROW;
    END CATCH;
    
    SELECT UniversalId, Ver
    FROM app.Query
    WHERE Id = @queryid
END










GO
/****** Object:  StoredProcedure [app].[sp_QuerySaveUpsert]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Cliff Spital
-- Create date: 2018/1/9
-- Description: Performs a query upsert save.
-- =======================================
CREATE PROCEDURE [app].[sp_QuerySaveUpsert]
    @queryid UNIQUEIDENTIFIER,
    @urn app.UniversalId,
    @ver int,
    @name nvarchar(200),
    @category nvarchar(200),
    @conceptids app.ResourceIdTable READONLY,
    @queryids app.ResourceIdTable READONLY,
    @definition app.QueryDefinitionJson,
    @user auth.[User],
	@admin bit = 0
AS
BEGIN
    SET NOCOUNT ON

    -- ensure saving user is the owner of the query
    DECLARE @owner NVARCHAR(1000), @qid UNIQUEIDENTIFIER;

    SELECT @qid = Id, @owner = [Owner]
    FROM app.Query
    WHERE Id = @queryid;

    IF (@qid IS NULL)
    BEGIN;
        SELECT UniversalId = NULL, Ver = NULL WHERE 1 = 0;
        RETURN;
    END;
    
    IF (@owner != @user AND @admin = 0)
    BEGIN;
        DECLARE @new403msg NVARCHAR(400) = N'Query ' + cast(@queryid as nvarchar(50)) + N' is not owned by ' + @user;
        THROW 70403, @new403msg, 1;
    END;

    -- determine if urn exists already
    DECLARE @oldowner NVARCHAR(1000), @oldqid UNIQUEIDENTIFIER, @oldver int;

    BEGIN TRAN;
    BEGIN TRY

        SELECT @oldqid = Id, @oldowner = [Owner], @oldver = Ver
        FROM app.Query
        WHERE UniversalId = @urn;

        IF (@oldqid IS NULL) -- if no this is an initial save for the node
        BEGIN;
            -- delegate to querysaveinitial
            EXEC app.sp_InternalQuerySaveInitial @queryid, @urn, 1, @name, @category, @conceptids, @queryids, @definition, @user;
        END;
        ELSE -- if yes this is a resave, ensure the old query is also owned by the user
        BEGIN;
            IF (@oldowner != @user AND @admin = 0)
            BEGIN;
                DECLARE @old403msg NVARCHAR(400) = N'Query ' + cast(@oldqid as nvarchar(50)) + N' is not owned by ' + @user;
                THROW 70403, @old403msg, 1;
            END;

            -- home node resave
            IF @ver IS NULL AND @oldver IS NOT NULL
                SET @ver = @oldver + 1;
                
            IF (@oldqid = @queryid)
            BEGIN;
                -- check for shallow save, @oldid = @queryid, app.Query update only, bump ver, incr updated.
                UPDATE app.Query
                SET
                    [Name] = @name,
                    Category = @category,
                    Updated = GETDATE(),
                    Ver = @ver
                WHERE Id = @queryid;
            END;
            ELSE
            BEGIN;
				
				-- If admin is making a change, allow it but make sure the original query owner remains so.
				IF (@admin = 0)
					-- delegate to resave sproc
					EXEC app.sp_InternalQuerySaveUpdateMove @oldqid, @queryid, @urn, @ver, @name, @category, @conceptids, @queryids, @definition, @user;
				ELSE
					BEGIN;
						-- save changes on user's behalf
						EXEC app.sp_InternalQuerySaveUpdateMove @oldqid, @queryid, @urn, @ver, @name, @category, @conceptids, @queryids, @definition, @oldowner;

						-- remove explicit admin privileges to query
						DELETE auth.QueryConstraint
						WHERE QueryId = @queryid
							  AND ConstraintValue = @user
					END;
            END;
        END;
        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        THROW;
    END CATCH;
    
    SELECT UniversalId, Ver
    FROM app.Query
    WHERE Id = @queryid;
END

GO
/****** Object:  StoredProcedure [app].[sp_UniversalConceptPreflightCheck]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =======================================
-- Author:      Cliff Spital
-- Create date: 2018/10/24
-- Description: Preflight checks universally referenced conceptIds.
-- Required Checks: Is concept present? Is the user authorized to execute?
-- =======================================
CREATE PROCEDURE [app].[sp_UniversalConceptPreflightCheck]
    @uids app.ResourceUniversalIdTable READONLY,
    @user auth.[User],
    @groups auth.GroupMembership READONLY,
    @admin bit = 0
AS
BEGIN
    SET NOCOUNT ON

    DECLARE @results app.ConceptPreflightTable;

    INSERT INTO @results (UniversalId, IsPresent, IsAuthorized)
    SELECT UniversalId, 0, 0 -- initialize bools to false
    FROM @uids;

    -- identify which ids are present
    WITH present as (
        SELECT Id, UniversalId
        FROM app.Concept c
        WHERE EXISTS (SELECT 1 FROM @uids u WHERE u.UniversalId = c.UniversalId)
    )
    UPDATE @results
    SET
        Id = p.Id,
        IsPresent = 1
    FROM @results r
    JOIN present p on r.UniversalId = p.UniversalId;

    -- identify which ids are authorized
    -- dont bother checking missing concepts
    DECLARE @requested app.ResourceIdTable;
    INSERT INTO @requested
    SELECT Id
    FROM @results
    WHERE IsPresent = 1;

    DECLARE @allowed app.ResourceIdTable;
    INSERT INTO @allowed
    SELECT Id FROM app.fn_FilterConceptsByConstraint(@user, @groups, @requested, @admin);

    UPDATE @results
    SET
        IsAuthorized = 1
    FROM @results r
    WHERE EXISTS (SELECT 1 FROM @allowed a WHERE r.Id = a.Id);

    SELECT
        Id,
        UniversalId,
        IsPresent,
        IsAuthorized
    FROM @results;

END









GO
/****** Object:  StoredProcedure [app].[sp_UpdateDemographicQuery]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =======================================
-- Author:      Cliff Spital
-- Create date: 2018/8/28
-- Description: Updates the SqlStatement for the DemographicQuery record.
-- =======================================
CREATE PROCEDURE [app].[sp_UpdateDemographicQuery]
    @sql app.DatasetQuerySqlStatement,
    @user auth.[User]
AS
BEGIN
    SET NOCOUNT ON

    UPDATE app.DemographicQuery
    SET
        SqlStatement = @sql,
        LastChanged = GETDATE(),
        ChangedBy = @user
    OUTPUT
        inserted.SqlStatement,
        inserted.LastChanged,
        inserted.ChangedBy;
END











GO
/****** Object:  StoredProcedure [app].[sp_UpdateImportMetadata]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Nic Dobbins
-- Create date: 2019/9/30
-- Description: Updates an Import Metadata record.
-- =======================================
CREATE PROCEDURE [app].[sp_UpdateImportMetadata]
	@id uniqueidentifier,
	@sourceId nvarchar(100),
	@type int,
	@structure nvarchar(max),
	@constraints auth.ResourceConstraintTable READONLY,
    @user auth.[User],
	@groups auth.GroupMembership READONLY,
	@admin bit = 0
AS
BEGIN
    SET NOCOUNT ON

	IF (NOT EXISTS (SELECT 1 FROM ref.ImportType AS IT WHERE @type = IT.Id))
    BEGIN;
        THROW 70404, N'ImportType does not exist.', 1;
    END;

	IF (app.fn_NullOrWhitespace(@sourceId) = 1)
        THROW 70400, N'SourceId is required.', 1;

	IF (app.fn_NullOrWhitespace(@structure) = 1)
        THROW 70400, N'Structure is required.', 1;

	DECLARE @authorized BIT = [auth].[fn_UserIsAuthorizedForImportMetadataById](@user, @groups, @id, @admin)

	IF @authorized = 0
	BEGIN;
		DECLARE @403msg1 nvarchar(400) = @user + N' is not allowed to to alter import ' + CONVERT(NVARCHAR(100),@id);
        THROW 70403, @403msg1, 1;
	END;

	DECLARE @updated TABLE (Id uniqueidentifier, SourceId nvarchar(100), Structure nvarchar(max), [Type] int, Created datetime, Updated datetime);
	DECLARE @cons TABLE (ImportMetadataId uniqueidentifier, ConstraintId int, ConstraintValue nvarchar(100))

	-- INSERT metadata row
	UPDATE TOP (1) app.ImportMetadata 
	SET 
		SourceId = @sourceId
	  , [Type] = @type
	  , Structure = @structure
	  , Updated = GETDATE()
	  , UpdatedBy = @user
	OUTPUT inserted.Id, inserted.SourceId, inserted.Structure, inserted.[Type], inserted.Created, inserted.Updated INTO @updated
	WHERE Id = @id;

	-- DELETE any previous constraints
	DELETE auth.ImportMetadataConstraint
	WHERE ImportMetadataId = @id;

	-- INSERT contraints
	INSERT INTO auth.ImportMetadataConstraint (ImportMetadataId, ConstraintId, ConstraintValue)
	OUTPUT inserted.ImportMetadataId, inserted.ConstraintId, inserted.ConstraintValue INTO @cons
	SELECT
		ImportMetadataId = @id
	  , C.ConstraintId
	  , C.ConstraintValue
	FROM @constraints AS C;

	SELECT * FROM @updated;
	SELECT * FROM @cons;

END

GO
/****** Object:  StoredProcedure [app].[sp_UpdateSearchIndexTables]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [app].[sp_UpdateSearchIndexTables]
AS
BEGIN
    SET NOCOUNT ON

	/**
	 * Find concepts where the content update
	 * time is greater than the last
	 * search token update time, or they've never been tokenized.
	 */
	DECLARE @ids app.ResourceIdTable
	INSERT INTO @ids
	SELECT C.Id
	FROM app.Concept C
	WHERE NOT EXISTS (SELECT 1 
					  FROM app.ConceptTokenizedIndex TI 
					  WHERE C.Id = TI.ConceptId 
						    AND TI.Updated > C.ContentLastUpdateDateTime)
	
	/**
	 * Ensure concepts have RootIds set.
	 */
	; WITH roots AS
	(
		SELECT RootId = c.Id
			 , RootUiDisplayName = c.UiDisplayName
			 , c.IsRoot
			 , c.Id
			 , c.ParentId
			 , c.UiDisplayName
		FROM app.Concept AS c
		WHERE c.IsRoot = 1
 
		UNION ALL
 
		SELECT roots.RootId
			 , roots.RootUiDisplayName
			 , c2.IsRoot
			 , c2.Id
			 , c2.ParentId
			 , c2.UiDisplayName
		FROM roots
			 INNER JOIN app.Concept c2
				ON c2.ParentId = roots.Id
	)
 
	UPDATE app.Concept
	SET RootId = roots.RootId
	FROM app.Concept AS C
		 INNER JOIN roots
			ON C.Id = roots.Id
	WHERE C.RootId IS NULL

	/**
	 * Insert concepts of interest for evaluation.
	 */
	CREATE TABLE #concepts (Id [uniqueidentifier] NULL, rootId [uniqueidentifier] NULL, uiDisplayName NVARCHAR(400) NULL)
	INSERT INTO #concepts
	SELECT Id
		  ,rootID
		  ,LEFT(UiDisplayName,400)
	FROM app.Concept C
	WHERE EXISTS (SELECT 1 FROM @ids ID WHERE C.Id = ID.Id)
    UNION ALL
	SELECT Id
		  ,rootID
		  ,LEFT(UiDisplaySubtext,400)
	FROM app.Concept C
	WHERE UiDisplaySubtext IS NOT NULL 
		  AND EXISTS (SELECT 1 FROM @ids ID WHERE C.Id = ID.Id)

	/**
	 * Remove puncuation and non-alphabetic characters.
	 */
	UPDATE #concepts
	SET uiDisplayName = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
						uiDisplayName,',',' '),':',' '),';',' '),'"',' '),']',' '),'[',' '),'(',' '),')',' '),'?',' '),'/',' '),'\',' '),'-',' ')

	/**
	 * Loop through each word in the uiDisplayName and separate each into its own row.
	 */
	DECLARE @loopCount INT = 0,
			@delimeter NVARCHAR(2) = ' ',
			@loopLimit INT = 30,
			@updatedRows INT = 1;

	CREATE TABLE #words
	(
		Word NVARCHAR(400) NULL,
		Id [uniqueidentifier] NULL,
		rootId [uniqueidentifier] NULL
	)

	WHILE @loopCount < @loopLimit AND @updatedRows > 0
	BEGIN

		BEGIN TRY DROP TABLE #currentWords END TRY BEGIN CATCH END CATCH

		/**
		 * Get the current left-most word (i.e. everything up to the first space " ").
		 */
		INSERT INTO #words
		SELECT Word = CASE CHARINDEX(@delimeter, uiDisplayName) 
						   WHEN 0 THEN LEFT(LTRIM(RTRIM(uiDisplayName)),400)
						   ELSE LEFT(LTRIM(RTRIM(LEFT(uiDisplayName, CHARINDEX(@delimeter, uiDisplayName)))),400) 
					  END
			  ,Id = c.Id
			  ,rootId = c.rootId
		FROM #concepts c

		/** 
		 * Update row count.
		 */
		SET @updatedRows = @@ROWCOUNT

		/**
		 * NULL out rows with no more spaces (their last word has already been inserted into the #words table).
		 */
		UPDATE #concepts
		SET uiDisplayName = NULL
		WHERE CHARINDEX(@delimeter, uiDisplayName) = 0
			  OR LEN(uiDisplayName) - CHARINDEX(@delimeter, uiDisplayName) < 0

		/**
		 * Chop off everything to the left of the first space " ".
		 */
		UPDATE #concepts
		SET uiDisplayName = NULLIF(LTRIM(RTRIM(RIGHT(uiDisplayName, LEN(uiDisplayName) - CHARINDEX(@delimeter, uiDisplayName) + 1))),'')
		WHERE uiDisplayName IS NOT NULL 
		  
		/**
		 * DELETE from table if no text left to process.
		 */
		DELETE FROM #concepts
		WHERE NULLIF(uiDisplayName,'') IS NULL

		/**
		 * Increment the @loopCount.
		 */ 
		SET @loopCount += 1

	END

	/**
	 * Index the output and remove any remaining whitespace.
	 */
	CREATE NONCLUSTERED INDEX IDX_WORD ON #words (Word ASC, Id ASC) INCLUDE (RootId)

	UPDATE #words
	SET Word = LOWER(LTRIM(RTRIM(REPLACE(Word, ' ',''))))

	DELETE FROM #words
	WHERE Word IN ('a','-','--','')

	/**
	 * Clear old data.
	 */
	DELETE app.ConceptForwardIndex
	FROM app.ConceptForwardIndex FI
	WHERE EXISTS (SELECT 1 FROM @ids ID WHERE FI.ConceptId = ID.Id)

	DELETE app.ConceptTokenizedIndex
	FROM app.ConceptTokenizedIndex TI
	WHERE NOT EXISTS (SELECT 1 FROM app.Concept C WHERE TI.ConceptId = C.Id)

	/**
	 * Set the last update time on included Concepts
	 * that were picked up here to make sure they
	 * aren't unnecessarily rerun next time due to 
	 * a NULL last update time.
	 */
	UPDATE app.Concept
	SET ContentLastUpdateDateTime = GETDATE()
	FROM app.Concept C
	WHERE EXISTS (SELECT 1 FROM @ids ID WHERE C.Id = ID.Id)
		  AND C.ContentLastUpdateDateTime IS NULL

	/**
	 * Add any words that didn't exist before.
	 */
	INSERT INTO app.ConceptInvertedIndex (Word)
	SELECT DISTINCT Word
	FROM #words W
	WHERE NOT EXISTS (SELECT 1 FROM app.ConceptInvertedIndex II WHERE W.Word = II.Word)

	/**
	 * Update forward index.
	 */
	INSERT INTO app.ConceptForwardIndex (WordId, Word, ConceptId, rootId)
	SELECT II.WordId, W.Word, W.Id, W.RootId
	FROM (SELECT DISTINCT Word, Id, RootId 
		  FROM #words) W
		  INNER JOIN app.ConceptInvertedIndex II
			ON W.Word = II.Word

	/**
	 * Create JSON string array of all tokens
	 * for a given Concept.
	 */
	SELECT ID.Id
		 , STUFF(
		 		 (SELECT '"' + W.Word + '",'
		 		  FROM #words W
		 		  WHERE W.Id = ID.Id
		 		  FOR XML PATH(''))
		  ,1,0,'') AS Tokens
	INTO #jsonTokens
	FROM @ids ID

	UPDATE #jsonTokens
	SET Tokens = '[' + LEFT(Tokens, LEN(Tokens) - 1) + ']'

	/**
	 * Merge into tokenized index.
	 */
	MERGE INTO app.ConceptTokenizedIndex AS tgt
	USING #jsonTokens as src
		ON tgt.ConceptId = src.Id
	WHEN MATCHED THEN
		UPDATE SET JsonTokens = Tokens
		         , Updated = GETDATE()
	WHEN NOT MATCHED THEN
		INSERT (ConceptId, JsonTokens, Updated)
		VALUES (src.Id, src.Tokens, GETDATE());

	/**
	 * Update word counts.
	 */
	; WITH wordCountCte AS
	(
		SELECT II.WordId, WordCount = COUNT(*)
		FROM app.ConceptInvertedIndex II
			 INNER JOIN app.ConceptForwardIndex FI
				ON II.WordId = FI.WordId
		GROUP BY II.WordId
	)

	UPDATE app.ConceptInvertedIndex
	SET WordCount = CTE.WordCount
	FROM app.ConceptInvertedIndex II
		 INNER JOIN wordCountCte CTE
			ON II.WordId = CTE.WordId

	/**
	 * Cleanup temp tables.
	 */
	DROP TABLE #concepts
	DROP TABLE #words
	DROP TABLE #jsonTokens

END




GO
/****** Object:  StoredProcedure [auth].[sp_BlacklistToken]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =======================================
-- Author:      Cliff Spital
-- Create date: 2018/9/27
-- Description: Blacklists a token
-- =======================================
CREATE PROCEDURE [auth].[sp_BlacklistToken]
    @idNonce UNIQUEIDENTIFIER,
    @exp datetime
AS
BEGIN
    SET NOCOUNT ON

    INSERT INTO auth.TokenBlacklist
    VALUES (@idNonce, @exp);
END







GO
/****** Object:  StoredProcedure [auth].[sp_RefreshTokenBlacklist]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =======================================
-- Author:      Cliff Spital
-- Create date: 2018/9/27
-- Description: Clears expired tokens, and returns remainder.
-- =======================================
CREATE PROCEDURE [auth].[sp_RefreshTokenBlacklist]
AS
BEGIN
    SET NOCOUNT ON

    DELETE FROM auth.TokenBlacklist
    WHERE Expires < GETDATE();

    SELECT IdNonce, Expires
    FROM auth.TokenBlacklist;
END







GO
/****** Object:  StoredProcedure [auth].[sp_UpsertLogin]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:      Cliff Spital
-- Create date: 2019/7/24
-- Description: Records a Login event from Leaf
-- =======================================
CREATE PROCEDURE [auth].[sp_UpsertLogin]
    @scopedId nvarchar(500),
    @fullId nvarchar(1000),
    @claims nvarchar(max)
AS
BEGIN
    SET NOCOUNT ON

    DECLARE @id UNIQUEIDENTIFIER;
    SELECT @id = Id FROM auth.Login WHERE ScopedIdentity = @scopedId;
    IF (@id IS NOT NULL)
    BEGIN;
        UPDATE auth.[Login]
        SET
            ScopedIdentity = @scopedId,
            FullIdentity = @fullId,
            Claims = @claims,
            Updated = GETDATE()
        WHERE Id = @id;
    END;
    ELSE
    BEGIN;
        INSERT INTO auth.[Login] (ScopedIdentity, FullIdentity, Claims, Created, Updated)
        SELECT @scopedId, @fullId, @claims, GETDATE(), GETDATE();
    END;
END
GO
/****** Object:  StoredProcedure [network].[sp_GetEndpoints]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Cliff Spital
-- Create date: 2018/6/12
-- Description:	Gets all network.Endpoint records.
-- =============================================
CREATE PROCEDURE [network].[sp_GetEndpoints]
AS
BEGIN
	SET NOCOUNT ON;

    SELECT
		Id,
		Name,
		Address,
		Issuer,
		KeyId,
		Certificate,
        IsInterrogator,
        IsResponder
	FROM
		network.Endpoint;
END











GO
/****** Object:  StoredProcedure [network].[sp_GetIdentity]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =======================================
-- Author:      Cliff Spital
-- Create date: 2018/10/11
-- Description: Returns the network.Identity
-- =======================================
CREATE PROCEDURE [network].[sp_GetIdentity]
AS
BEGIN
    SET NOCOUNT ON

    SELECT
        [Name],
        Abbreviation,
        [Description],
        TotalPatients,
        Latitude,
        Longitude,
        PrimaryColor,
        SecondaryColor
    FROM network.[Identity];
END







GO
/****** Object:  StoredProcedure [network].[sp_GetIdentityEndpoints]    Script Date: ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =======================================
-- Author:      Cliff Spital
-- Create date: 2018/10/11
-- Description: Returns the network.Identity and the network.Endpoint
-- =======================================
CREATE PROCEDURE [network].[sp_GetIdentityEndpoints]
AS
BEGIN
    SET NOCOUNT ON

    EXEC network.sp_GetIdentity;

    EXEC network.sp_GetEndpoints;
END








GO
USE [master]
GO
ALTER DATABASE [LeafDB] SET  READ_WRITE 
GO

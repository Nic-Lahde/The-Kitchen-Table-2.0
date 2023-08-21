-- Drop the database if it exists
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'TheKitchenTable')
BEGIN
    ALTER DATABASE TheKitchenTable SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE TheKitchenTable;
END

-- Create the database
CREATE DATABASE TheKitchenTable;
GO
-- Use the newly created database
USE TheKitchenTable;
GO
-- Create the UserProfile table
CREATE TABLE [UserProfile] (
  [Id] int PRIMARY KEY IDENTITY(1, 1),
  [Name] nvarchar(50) NOT NULL,
  [Email] nvarchar(50) NOT NULL,
  [FirebaseId] nvarchar(50) NOT NULL,
  [Bio] nvarchar(255)
);
GO
-- Create the Event table
CREATE TABLE [Event] (
  [Id] int PRIMARY KEY IDENTITY(1, 1),
  [UserProfileId] int NOT NULL,
  [Date] date NOT NULL,
  [Location] nvarchar(255) NOT NULL,
  [GameId] int NOT NULL
);
GO
-- Create the Player table
CREATE TABLE [Player] (
  [Id] int PRIMARY KEY IDENTITY(1, 1),
  [UserProfileId] int NOT NULL,
  [EventId] int NOT NULL
);
GO
-- Create the Game table
CREATE TABLE [Game] (
  [Id] int PRIMARY KEY IDENTITY(1, 1),
  [Name] nvarchar(50) NOT NULL,
  [MinPlayers] int NOT NULL,
  [MaxPlayers] int NOT NULL,
  [Weight] float
);
GO
-- Create the UserGame table
CREATE TABLE [UserGame] (
  [Id] int PRIMARY KEY IDENTITY(1, 1),
  [GameId] int NOT NULL,
  [UserId] int NOT NULL
);
GO
-- Add foreign key constraints
ALTER TABLE [Player] ADD FOREIGN KEY ([UserProfileId]) REFERENCES [UserProfile] ([Id]);
GO
ALTER TABLE [Player] ADD FOREIGN KEY ([EventId]) REFERENCES [Event] ([Id]);
GO
ALTER TABLE [Event] ADD FOREIGN KEY ([GameId]) REFERENCES [Game] ([Id]);
GO
ALTER TABLE [Event] ADD FOREIGN KEY ([UserProfileId]) REFERENCES [UserProfile] ([Id]);
GO
ALTER TABLE [UserGame] ADD FOREIGN KEY ([GameId]) REFERENCES [Game] ([Id]);
GO
ALTER TABLE [UserGame] ADD FOREIGN KEY ([UserId]) REFERENCES [UserProfile] ([Id]);
GO

-- Add foreign key constraints with cascading deletes
ALTER TABLE [Player] ADD FOREIGN KEY ([UserProfileId]) REFERENCES [UserProfile] ([Id]) ON DELETE CASCADE;
GO
ALTER TABLE [Event] ADD FOREIGN KEY ([UserProfileId]) REFERENCES [UserProfile] ([Id]) ON DELETE CASCADE;
GO
ALTER TABLE [UserGame] ADD FOREIGN KEY ([UserId]) REFERENCES [UserProfile] ([Id]) ON DELETE CASCADE;
GO
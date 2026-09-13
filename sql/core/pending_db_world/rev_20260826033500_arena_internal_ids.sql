START TRANSACTION;

DELETE FROM `battleground_template` WHERE `ID` IN (102, 103, 870, 871);
INSERT INTO `battleground_template` (`ID`,`MinPlayersPerTeam`,`MaxPlayersPerTeam`,`MinLvl`,`MaxLvl`,`AllianceStartLoc`,`AllianceStartO`,`HordeStartLoc`,`HordeStartO`,`StartMaxDist`,`Weight`,`ScriptName`,`Comment`) VALUES
(102,0,5,10,80,4136,0,4137,0,0,1,'','Tol\'vir Arena'),
(103,0,5,10,80,4535,0,4534,0,0,1,'','The Tiger\'s Peak Arena');

COMMIT;

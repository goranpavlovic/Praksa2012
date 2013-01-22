/*MetaEAVEntityType*/
INSERT INTO MetaEAVEntityType (EntityTypeName) VALUES ('Movie');
INSERT INTO MetaEAVEntityType (EntityTypeName) VALUES ('Sports Event');
INSERT INTO MetaEAVEntityType (EntityTypeName) VALUES ('Show');
INSERT INTO MetaEAVEntityType (EntityTypeName) VALUES ('Broadcast');
INSERT INTO MetaEAVEntityType (EntityTypeName) VALUES ('Music Show');
INSERT INTO MetaEAVEntityType (EntityTypeName) VALUES ('Race');
INSERT INTO MetaEAVEntityType (EntityTypeName) VALUES ('Sports Match');
INSERT INTO MetaEAVEntityType (EntityTypeName) VALUES ('Cartoon');
INSERT INTO MetaEAVEntityType (EntityTypeName) VALUES ('TV Show');
/*MetaEAVAttribute*/
/*General*/
INSERT INTO MetaEAVAttribute (AttributeName,DefaultValue,DataType,RegularExpressionMatch) VALUES ('Rerun',NULL,'BOOLEAN','');
INSERT INTO MetaEAVAttribute (AttributeName,DefaultValue,DataType,RegularExpressionMatch) VALUES ('Link',NULL,'URL','');
INSERT INTO MetaEAVAttribute (AttributeName,DefaultValue,DataType,RegularExpressionMatch) VALUES ('Description',NULL,'String','');
INSERT INTO MetaEAVAttribute (AttributeName,DefaultValue,DataType,RegularExpressionMatch) VALUES ('Comments',NULL,'String','');
INSERT INTO MetaEAVAttribute (AttributeName,DefaultValue,DataType,RegularExpressionMatch) VALUES ('Rating',NULL,'String','');
INSERT INTO MetaEAVAttribute(DefaultValue, Datatype, AttributeName, RegularExpressionMatch) VALUES (NULL,'INT','Length','');
/*Movie*/
INSERT INTO MetaEAVAttribute (AttributeName,DefaultValue,DataType,RegularExpressionMatch) VALUES ('Name',NULL,'String','');
INSERT INTO MetaEAVAttribute (AttributeName,DefaultValue,DataType,RegularExpressionMatch) VALUES ('Surname',NULL,'String','');
INSERT INTO MetaEAVAttribute (AttributeName,DefaultValue,DataType,RegularExpressionMatch) VALUES ('Gender',NULL,'Char(1)','');
INSERT INTO MetaEAVAttribute (AttributeName,DefaultValue,DataType,RegularExpressionMatch) VALUES ('Age of Birth',NULL,'Year','');
INSERT INTO MetaEAVAttribute (AttributeName,DefaultValue,DataType,RegularExpressionMatch) VALUES ('Country',NULL,'String','');
INSERT INTO MetaEAVAttribute (AttributeName,DefaultValue,DataType,RegularExpressionMatch) VALUES ('Picture',NULL,'URL','');
INSERT INTO MetaEAVAttribute (AttributeName,DefaultValue,DataType,RegularExpressionMatch) VALUES ('Premiere Year',NULL,'Year','');
INSERT INTO MetaEAVAttribute (AttributeName,DefaultValue,DataType,RegularExpressionMatch) VALUES ('Trailer',NULL,'URL','');
INSERT INTO MetaEAVAttribute (AttributeName,DefaultValue,DataType,RegularExpressionMatch) VALUES ('Genre',NULL,'String','');
INSERT INTO MetaEAVAttribute (AttributeName,DefaultValue,DataType,RegularExpressionMatch) VALUES ('Reward',NULL,'String','');
INSERT INTO MetaEAVAttribute (AttributeName,DefaultValue,DataType,RegularExpressionMatch) VALUES ('Synopsis',NULL,'String','');
/*Sports Event*/
INSERT INTO MetaEAVAttribute (AttributeName,DefaultValue,DataType,RegularExpressionMatch) VALUES ('Street Name',NULL,'String','');
INSERT INTO MetaEAVAttribute (AttributeName,DefaultValue,DataType,RegularExpressionMatch) VALUES ('Street Number','n/a','String','');
INSERT INTO MetaEAVAttribute (AttributeName,DefaultValue,DataType,RegularExpressionMatch) VALUES ('Surface',NULL,'String','');
INSERT INTO MetaEAVAttribute (AttributeName,DefaultValue,DataType,RegularExpressionMatch) VALUES ('Number of visitors','0','INT','');
INSERT INTO MetaEAVAttribute(DefaultValue, Datatype, AttributeName, RegularExpressionMatch) VALUES (NULL,'String','Location','');
/*Show*/
INSERT INTO MetaEAVAttribute (AttributeName,DefaultValue,DataType,RegularExpressionMatch) VALUES ('Themes',NULL,'String','');
/*Broadcast*/
INSERT INTO MetaEAVAttribute (AttributeName,DefaultValue,DataType,RegularExpressionMatch) VALUES ('Broadcast Type',NULL,'String','');
INSERT INTO MetaEAVAttribute (AttributeName,DefaultValue,DataType,RegularExpressionMatch) VALUES ('Is for Kids',NULL,'BOOLEAN','');
/*Race*/
INSERT INTO MetaEAVAttribute (AttributeName,DefaultValue,DataType,RegularExpressionMatch) VALUES ('Circuit Name',NULL,'String','');
INSERT INTO MetaEAVAttribute (AttributeName,DefaultValue,DataType,RegularExpressionMatch) VALUES ('Circuit Length',NULL,'INT','');
INSERT INTO MetaEAVAttribute (AttributeName,DefaultValue,DataType,RegularExpressionMatch) VALUES ('Place',NULL,'INT','');
INSERT INTO MetaEAVAttribute (AttributeName,DefaultValue,DataType,RegularExpressionMatch) VALUES ('Race Team Name',NULL,'String','');
/*Sports match*/
INSERT INTO MetaEAVAttribute (AttributeName,DefaultValue,DataType,RegularExpressionMatch) VALUES ('Stadium',NULL,'String','');
INSERT INTO MetaEAVAttribute (AttributeName,DefaultValue,DataType,RegularExpressionMatch) VALUES ('Result',NULL,'String','');
INSERT INTO MetaEAVAttribute (AttributeName,DefaultValue,DataType,RegularExpressionMatch) VALUES ('League',NULL,'String','');
INSERT INTO MetaEAVAttribute (AttributeName,DefaultValue,DataType,RegularExpressionMatch) VALUES ('Team Name',NULL,'String','');
INSERT INTO MetaEAVAttribute(DefaultValue, Datatype, AttributeName, RegularExpressionMatch) VALUES (NULL,'String','Players','');
/*Cartoon*/
INSERT INTO MetaEAVAttribute (AttributeName,DefaultValue,DataType,RegularExpressionMatch) VALUES ('Age','18','INT','');
/*Tv*/
INSERT INTO MetaEAVAttribute (AttributeName,DefaultValue,DataType,RegularExpressionMatch) VALUES ('Season',NULL,'INT','');
INSERT INTO MetaEAVAttribute (AttributeName,DefaultValue,DataType,RegularExpressionMatch) VALUES ('Episode',NULL,'INT','');
/*MetaEAVAttributeSet*/
/*General*/
INSERT INTO MetaEAVAttributeSet(`AttributeSetName`, `Required`) VALUES ('General',false);
/*movie*/
INSERT INTO MetaEAVAttributeSet (AttributeSetName,Required) VALUES ('Actors',FALSE);
INSERT INTO MetaEAVAttributeSet (AttributeSetName,Required) VALUES ('Director',FALSE);
INSERT INTO MetaEAVAttributeSet (AttributeSetName,Required) VALUES ('Country',FALSE);
INSERT INTO MetaEAVAttributeSet (AttributeSetName,Required) VALUES ('Screenwriter',FALSE);
INSERT INTO MetaEAVAttributeSet (AttributeSetName,Required) VALUES ('Movie Set',FALSE);
/*Sports Event*/
INSERT INTO MetaEAVAttributeSet (AttributeSetName,Required) VALUES ('Sports Event Set',FALSE);
/*show*/
INSERT INTO MetaEAVAttributeSet (AttributeSetName,Required) VALUES ('Host',FALSE);
INSERT INTO MetaEAVAttributeSet (AttributeSetName,Required) VALUES ('Redaction',FALSE);
INSERT INTO MetaEAVAttributeSet (AttributeSetName,Required) VALUES ('Cameraman',FALSE);
INSERT INTO MetaEAVAttributeSet (AttributeSetName,Required) VALUES ('Soundman',FALSE);
/*BCast*/
INSERT INTO MetaEAVAttributeSet(AttributeSetName, Required) VALUES ('Broadcast set',false);
/*Music Show*/
INSERT INTO MetaEAVAttributeSet (AttributeSetName,Required) VALUES ('Artist',FALSE);
/*Race*/
INSERT INTO MetaEAVAttributeSet (AttributeSetName,Required) VALUES ('Circuit',FALSE);
INSERT INTO MetaEAVAttributeSet (AttributeSetName,Required) VALUES ('Driver',FALSE);
/*Sports Match*/
INSERT INTO MetaEAVAttributeSet (AttributeSetName,Required) VALUES ('Sports Match Set',FALSE);
INSERT INTO MetaEAVAttributeSet (AttributeSetName,Required) VALUES ('Home Team',FALSE);
INSERT INTO MetaEAVAttributeSet (AttributeSetName,Required) VALUES ('Away Team',FALSE);
INSERT INTO MetaEAVAttributeSet (AttributeSetName,Required) VALUES ('Referee',FALSE);
/*Cartoon*/
INSERT INTO MetaEAVAttributeSet (AttributeSetName,Required) VALUES ('Illustrator',FALSE);
INSERT INTO MetaEAVAttributeSet (AttributeSetName,Required) VALUES ('Cartoon Set',FALSE);
/*TV Show*/
INSERT INTO MetaEAVAttributeSet (AttributeSetName,Required) VALUES ('TV Show set',FALSE);
/*MetaEntitySetDependancy*/
INSERT INTO MetaEntitySetDependency (EntityTypeId, AttributeSetId) VALUES 
((SELECT EntityTypeId FROM MetaEAVEntityType WHERE EntityTypeName='Movie'),
(SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Actors'));

INSERT INTO MetaEntitySetDependency (EntityTypeId, AttributeSetId) VALUES 
((SELECT EntityTypeId FROM MetaEAVEntityType WHERE EntityTypeName='Movie'),
(SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Director'));

INSERT INTO MetaEntitySetDependency (EntityTypeId, AttributeSetId) VALUES 
((SELECT EntityTypeId FROM MetaEAVEntityType WHERE EntityTypeName='Movie'),
(SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='General'));

INSERT INTO MetaEntitySetDependency (EntityTypeId, AttributeSetId) VALUES 
((SELECT EntityTypeId FROM MetaEAVEntityType WHERE EntityTypeName='Movie'),
(SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Screenwriter'));

INSERT INTO MetaEntitySetDependency (EntityTypeId, AttributeSetId) VALUES 
((SELECT EntityTypeId FROM MetaEAVEntityType WHERE EntityTypeName='Movie'),
(SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Movie Set'));

/*Sports Event*/
INSERT INTO MetaEntitySetDependency (EntityTypeId, AttributeSetId) VALUES 
((SELECT EntityTypeId FROM MetaEAVEntityType WHERE EntityTypeName='Sports Event'),
(SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='General'));
/*Show*/
INSERT INTO MetaEntitySetDependency (EntityTypeId, AttributeSetId) VALUES 
((SELECT EntityTypeId FROM MetaEAVEntityType WHERE EntityTypeName='Show'),
(SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Host'));

INSERT INTO MetaEntitySetDependency (EntityTypeId, AttributeSetId) VALUES 
((SELECT EntityTypeId FROM MetaEAVEntityType WHERE EntityTypeName='Show'),
(SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Redaction'));

INSERT INTO MetaEntitySetDependency (EntityTypeId, AttributeSetId) VALUES 
((SELECT EntityTypeId FROM MetaEAVEntityType WHERE EntityTypeName='Show'),
(SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Cameraman'));

INSERT INTO MetaEntitySetDependency (EntityTypeId, AttributeSetId) VALUES 
((SELECT EntityTypeId FROM MetaEAVEntityType WHERE EntityTypeName='Show'),
(SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Soundman'));


INSERT INTO MetaEntitySetDependency (EntityTypeId, AttributeSetId) VALUES 
((SELECT EntityTypeId FROM MetaEAVEntityType WHERE EntityTypeName='Show'),
(SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='General'));
/*BCast*/
INSERT INTO MetaEntitySetDependency (EntityTypeId, AttributeSetId) VALUES 
((SELECT EntityTypeId FROM MetaEAVEntityType WHERE EntityTypeName='Broadcast'),
(SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='General'));

INSERT INTO MetaEntitySetDependency (EntityTypeId, AttributeSetId) VALUES 
((SELECT EntityTypeId FROM MetaEAVEntityType WHERE EntityTypeName='Broadcast'),
(SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Host'));

INSERT INTO MetaEntitySetDependency (EntityTypeId, AttributeSetId) VALUES 
((SELECT EntityTypeId FROM MetaEAVEntityType WHERE EntityTypeName='Broadcast'),
(SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Redaction'));

INSERT INTO MetaEntitySetDependency (EntityTypeId, AttributeSetId) VALUES 
((SELECT EntityTypeId FROM MetaEAVEntityType WHERE EntityTypeName='Broadcast'),
(SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Cameraman'));

INSERT INTO MetaEntitySetDependency (EntityTypeId, AttributeSetId) VALUES 
((SELECT EntityTypeId FROM MetaEAVEntityType WHERE EntityTypeName='Broadcast'),
(SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Soundman'));
/*Music show*/
INSERT INTO MetaEntitySetDependency (EntityTypeId, AttributeSetId) VALUES
((SELECT EntityTypeId FROM MetaEAVEntityType WHERE EntityTypeName='Music Show'),
(SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Host'));

INSERT INTO MetaEntitySetDependency (EntityTypeId, AttributeSetId) VALUES 
((SELECT EntityTypeId FROM MetaEAVEntityType WHERE EntityTypeName='Music Show'),
(SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Redaction'));

INSERT INTO MetaEntitySetDependency (EntityTypeId, AttributeSetId) VALUES 
((SELECT EntityTypeId FROM MetaEAVEntityType WHERE EntityTypeName='Music Show'),
(SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Cameraman'));

INSERT INTO MetaEntitySetDependency (EntityTypeId, AttributeSetId) VALUES 
((SELECT EntityTypeId FROM MetaEAVEntityType WHERE EntityTypeName='Music Show'),
(SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Soundman'));

INSERT INTO MetaEntitySetDependency (EntityTypeId, AttributeSetId) VALUES 
((SELECT EntityTypeId FROM MetaEAVEntityType WHERE EntityTypeName='Music Show'),
(SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='General'));

INSERT INTO MetaEntitySetDependency (EntityTypeId, AttributeSetId) VALUES 
((SELECT EntityTypeId FROM MetaEAVEntityType WHERE EntityTypeName='Music Show'),
(SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Artist'));
/*Race*/
INSERT INTO MetaEntitySetDependency (EntityTypeId, AttributeSetId) VALUES 
((SELECT EntityTypeId FROM MetaEAVEntityType WHERE EntityTypeName='Race'),
(SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='General'));

INSERT INTO MetaEntitySetDependency (EntityTypeId, AttributeSetId) VALUES 
((SELECT EntityTypeId FROM MetaEAVEntityType WHERE EntityTypeName='Race'),
(SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Circuit'));

INSERT INTO MetaEntitySetDependency (EntityTypeId, AttributeSetId) VALUES 
((SELECT EntityTypeId FROM MetaEAVEntityType WHERE EntityTypeName='Race'),
(SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Driver'));
/*Sports Match*/
INSERT INTO MetaEntitySetDependency (EntityTypeId, AttributeSetId) VALUES 
((SELECT EntityTypeId FROM MetaEAVEntityType WHERE EntityTypeName='Sports Match'),
(SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='General'));

INSERT INTO MetaEntitySetDependency (EntityTypeId, AttributeSetId) VALUES 
((SELECT EntityTypeId FROM MetaEAVEntityType WHERE EntityTypeName='Sports Match'),
(SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Sports Match set'));

INSERT INTO MetaEntitySetDependency (EntityTypeId, AttributeSetId) VALUES 
((SELECT EntityTypeId FROM MetaEAVEntityType WHERE EntityTypeName='Sports Match'),
(SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Home Team'));

INSERT INTO MetaEntitySetDependency (EntityTypeId, AttributeSetId) VALUES 
((SELECT EntityTypeId FROM MetaEAVEntityType WHERE EntityTypeName='Sports Match'),
(SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Away Team'));

INSERT INTO MetaEntitySetDependency (EntityTypeId, AttributeSetId) VALUES 
((SELECT EntityTypeId FROM MetaEAVEntityType WHERE EntityTypeName='Sports Match'),
(SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Referee'));
/*Cartoon*/
INSERT INTO MetaEntitySetDependency (EntityTypeId, AttributeSetId) VALUES 
((SELECT EntityTypeId FROM MetaEAVEntityType WHERE EntityTypeName='Cartoon'),
(SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Actors'));

INSERT INTO MetaEntitySetDependency (EntityTypeId, AttributeSetId) VALUES 
((SELECT EntityTypeId FROM MetaEAVEntityType WHERE EntityTypeName='Cartoon'),
(SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Director'));

INSERT INTO MetaEntitySetDependency (EntityTypeId, AttributeSetId) VALUES 
((SELECT EntityTypeId FROM MetaEAVEntityType WHERE EntityTypeName='Cartoon'),
(SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='General'));

INSERT INTO MetaEntitySetDependency (EntityTypeId, AttributeSetId) VALUES 
((SELECT EntityTypeId FROM MetaEAVEntityType WHERE EntityTypeName='Cartoon'),
(SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Screenwriter'));

INSERT INTO MetaEntitySetDependency (EntityTypeId, AttributeSetId) VALUES 
((SELECT EntityTypeId FROM MetaEAVEntityType WHERE EntityTypeName='Cartoon'),
(SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Illustrator'));

INSERT INTO MetaEntitySetDependency (EntityTypeId, AttributeSetId) VALUES 
((SELECT EntityTypeId FROM MetaEAVEntityType WHERE EntityTypeName='Cartoon'),
(SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Cartoon Set'));

INSERT INTO MetaEntitySetDependency (EntityTypeId, AttributeSetId) VALUES 
((SELECT EntityTypeId FROM MetaEAVEntityType WHERE EntityTypeName='Cartoon'),
(SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Movie Set'));
/*TV Show*/
INSERT INTO MetaEntitySetDependency (EntityTypeId, AttributeSetId) VALUES 
((SELECT EntityTypeId FROM MetaEAVEntityType WHERE EntityTypeName='TV Show'),
(SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Director'));

INSERT INTO MetaEntitySetDependency (EntityTypeId, AttributeSetId) VALUES 
((SELECT EntityTypeId FROM MetaEAVEntityType WHERE EntityTypeName='TV Show'),
(SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='General'));

INSERT INTO MetaEntitySetDependency (EntityTypeId, AttributeSetId) VALUES 
((SELECT EntityTypeId FROM MetaEAVEntityType WHERE EntityTypeName='TV Show'),
(SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Screenwriter'));

INSERT INTO MetaEntitySetDependency (EntityTypeId, AttributeSetId) VALUES 
((SELECT EntityTypeId FROM MetaEAVEntityType WHERE EntityTypeName='TV Show'),
(SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Movie Set'));

INSERT INTO MetaEntitySetDependency (EntityTypeId, AttributeSetId) VALUES 
((SELECT EntityTypeId FROM MetaEAVEntityType WHERE EntityTypeName='TV Show'),
(SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Actors'));

INSERT INTO MetaEntitySetDependency (EntityTypeId, AttributeSetId) VALUES 
((SELECT EntityTypeId FROM MetaEAVEntityType WHERE EntityTypeName='TV Show'),
(SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='TV Show set'));
/*MetaAtrSetDependecy*/
/*Actors*/
INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Actors'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Name'));


INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Actors'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Surname'));


INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Actors'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Gender'));


INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Actors'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Age of Birth'));

/*Director*/
INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Director'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Name'));


INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Director'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Surname'));


INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Director'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Gender'));


INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Director'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Age of Birth'));

/*Screenwriter*/
INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Screenwriter'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Name'));


INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Screenwriter'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Surname'));


INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Screenwriter'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Gender'));


INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Screenwriter'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Age of Birth'));

/*Host*/
INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Host'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Name'));


INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Host'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Surname'));


INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Host'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Gender'));


INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Host'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Age of Birth'));

/*Redaction*/
INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Redaction'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Name'));


INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Redaction'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Surname'));


INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Redaction'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Gender'));


INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Redaction'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Age of Birth'));

/*Cameraman*/
INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Cameraman'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Name'));


INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Cameraman'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Surname'));


INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Cameraman'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Gender'));


INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Cameraman'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Age of Birth'));

/*Soundman*/
INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Soundman'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Name'));


INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Soundman'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Surname'));


INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Soundman'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Gender'));


INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Soundman'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Age of Birth'));

/*Artist*/
INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Artist'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Name'));


INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Artist'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Surname'));


INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Artist'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Gender'));


INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Artist'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Age of Birth'));

/*Referee*/
INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Referee'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Name'));


INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Referee'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Surname'));


INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Referee'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Gender'));


INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Referee'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Age of Birth'));

/*Illustrator*/
INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Illustrator'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Name'));


INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Illustrator'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Surname'));


INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Illustrator'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Gender'));


INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Illustrator'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Age of Birth'));

/*Circuit*/
INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Circuit'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Circuit Name'));


INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Circuit'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Circuit Length'));

/*Driver*/
INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Driver'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Name'));


INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Driver'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Surname'));


INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Driver'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Gender'));


INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Driver'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Age of Birth'));


INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Driver'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Place'));# 1 row affected.


INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Driver'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Race Team Name'));


/*Sports Match Set*/
INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Sports Match Set'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Stadium'));


INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Sports Match Set'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Result'));


INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Sports Match Set'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='League'));

/*TV Show Set*/
INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='TV Show Set'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Season'));


INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='TV Show Set'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Episode'));

/*Movie Set*/
INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Movie Set'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Country'));


INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Movie Set'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Picture'));


INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Movie Set'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Premiere Year'));


INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Movie Set'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Trailer'));


INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Movie Set'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Genre'));


INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Movie Set'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Reward'));


INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Movie Set'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Synopsis'));


/*Cartoon Set*/

INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Cartoon Set'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Age'));


/*General*/
INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='General'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Rerun'));


INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='General'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Link'));


INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='General'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Description'));


INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='General'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Picture'));


INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='General'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Length'));


INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='General'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Comments'));


INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='General'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Rating'));


/*Sports Event Set*/
INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Sports Event Set'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Location'));


INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Sports Event Set'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Surface'));


INSERT INTO MetaAtrSetDependecy (AttributeSetId, AttributeId) VALUES 
((SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName='Sports Event Set'),
(SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName='Number of visitors'));


--
-- This file is part of lavagna.
--
-- lavagna is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- lavagna is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with lavagna.  If not, see <http://www.gnu.org/licenses/>.
--

-- DEMO CONF PARAMETER
INSERT INTO LA_CONF(CONF_KEY, CONF_VALUE) VALUES ('SETUP_COMPLETE', 'true');
INSERT INTO LA_CONF(CONF_KEY, CONF_VALUE) VALUES ('BASE_APPLICATION_URL', 'http://localhost:8080/');
--INSERT INTO LA_CONF(CONF_KEY, CONF_VALUE) VALUES ('BASE_APPLICATION_URL', 'http://localhost:8080/test/');
INSERT INTO LA_CONF(CONF_KEY, CONF_VALUE) VALUES ('AUTHENTICATION_METHOD', '["DEMO"]');

--200kb max file size
INSERT INTO LA_CONF(CONF_KEY, CONF_VALUE) VALUES ('MAX_UPLOAD_FILE_SIZE', '204800');

INSERT INTO LA_CONF(CONF_KEY, CONF_VALUE) VALUES ('TRELLO_API_KEY', 'd9e452d67d0e4407b9077e15df9dfd5a');
--INSERT INTO LA_CONF(CONF_KEY, CONF_VALUE) VALUES ('ENABLE_ANON_USER', 'true');


--
--INSERT INTO LA_CONF(CONF_KEY, CONF_VALUE) VALUES ('AUTHENTICATION_METHOD', '["OAUTH"]');
--INSERT INTO LA_CONF(CONF_KEY, CONF_VALUE) VALUES ('OAUTH_CONFIGURATION', '{ "baseUrl" : "http://localhost:8080", "providers" : [{"provider" : "bitbucket", "apiKey" : "", "apiSecret" : ""},{"provider" : "github", "apiKey" : "", "apiSecret" : ""}, {"provider" : "google", "apiKey": "", "apiSecret" : ""}]}');
--

--
--INSERT INTO LA_CONF(CONF_KEY, CONF_VALUE) VALUES ('AUTHENTICATION_METHOD', '["PERSONA"]');
--INSERT INTO LA_CONF(CONF_KEY, CONF_VALUE) VALUES ('PERSONA_AUDIENCE', 'http://localhost:8080');
--

--
--INSERT INTO LA_CONF(CONF_KEY, CONF_VALUE) VALUES ('AUTHENTICATION_METHOD', '["LDAP"]');
--INSERT INTO LA_CONF(CONF_KEY, CONF_VALUE) VALUES ('LDAP_SERVER_URL', 'ldap://localhost:10389');
--INSERT INTO LA_CONF(CONF_KEY, CONF_VALUE) VALUES ('LDAP_MANAGER_DN', 'uid=admin,ou=system');
--INSERT INTO LA_CONF(CONF_KEY, CONF_VALUE) VALUES ('LDAP_MANAGER_PASSWORD', 'secret');
--INSERT INTO LA_CONF(CONF_KEY, CONF_VALUE) VALUES ('LDAP_USER_SEARCH_BASE', 'ou=system');
--INSERT INTO LA_CONF(CONF_KEY, CONF_VALUE) VALUES ('LDAP_USER_SEARCH_FILTER', 'uid={0}');
--

-- TEST USER
INSERT INTO LA_USER(USER_PROVIDER, USER_NAME) VALUES ('demo', 'user');
INSERT INTO LA_USER(USER_PROVIDER, USER_NAME) VALUES ('demo', 'user1');
INSERT INTO LA_USER(USER_PROVIDER, USER_NAME) VALUES ('demo', 'user2');
--INSERT INTO LA_USER(USER_PROVIDER, USER_NAME) VALUES ('ldap', 'user');
--INSERT INTO LA_USER(USER_PROVIDER, USER_NAME) VALUES ('persona', 'sylvain.jermini@syjer.com');
--INSERT INTO LA_USER(USER_PROVIDER, USER_NAME) VALUES ('oauth.google', 'sylvain.jermini@syjer.com');
--INSERT INTO LA_USER(USER_PROVIDER, USER_NAME) VALUES ('oauth.github', 'syjer');
--INSERT INTO LA_USER(USER_PROVIDER, USER_NAME) VALUES ('oauth.bitbucket', 'syjer');

-- TEST PROJECT
INSERT INTO LA_PROJECT(PROJECT_NAME, PROJECT_SHORT_NAME, PROJECT_DESCRIPTION) VALUES ('test', 'TEST', 'Test Project');

-- DEFAULT ANON ROLE
INSERT INTO LA_PROJECT_ROLE(PROJECT_ROLE_NAME, PROJECT_ID_FK, PROJECT_ROLE_HIDDEN, PROJECT_ROLE_READONLY, PROJECT_ROLE_REMOVABLE) VALUES('ANONYMOUS', (SELECT PROJECT_ID FROM LA_PROJECT WHERE PROJECT_SHORT_NAME = 'TEST'), TRUE, TRUE, FALSE);
INSERT INTO LA_PROJECT_ROLE_PERMISSION(PROJECT_ROLE_ID_FK, PERMISSION) VALUES (IDENTITY(), 'READ');

-- DEFAULT LABELS FOR TEST PROJECT
INSERT INTO LA_CARD_LABEL(CARD_LABEL_PROJECT_ID_FK, CARD_LABEL_UNIQUE, CARD_LABEL_TYPE, CARD_LABEL_DOMAIN, CARD_LABEL_NAME, CARD_LABEL_COLOR) VALUES((SELECT PROJECT_ID FROM LA_PROJECT WHERE PROJECT_SHORT_NAME = 'TEST'), FALSE, 'USER', 'SYSTEM', 'ASSIGNED', 0);
INSERT INTO LA_CARD_LABEL(CARD_LABEL_PROJECT_ID_FK, CARD_LABEL_UNIQUE, CARD_LABEL_TYPE, CARD_LABEL_DOMAIN, CARD_LABEL_NAME, CARD_LABEL_COLOR) VALUES((SELECT PROJECT_ID FROM LA_PROJECT WHERE PROJECT_SHORT_NAME = 'TEST'), TRUE, 'TIMESTAMP', 'SYSTEM', 'DUE_DATE', 0);
INSERT INTO LA_CARD_LABEL(CARD_LABEL_PROJECT_ID_FK, CARD_LABEL_UNIQUE, CARD_LABEL_TYPE, CARD_LABEL_DOMAIN, CARD_LABEL_NAME, CARD_LABEL_COLOR) VALUES((SELECT PROJECT_ID FROM LA_PROJECT WHERE PROJECT_SHORT_NAME = 'TEST'), TRUE, 'LIST', 'SYSTEM', 'MILESTONE', 0);
INSERT INTO LA_CARD_LABEL_LIST_VALUE(CARD_LABEL_ID_FK, CARD_LABEL_LIST_VALUE_ORDER,CARD_LABEL_LIST_VALUE) VALUES ((SELECT CARD_LABEL_ID FROM LA_CARD_LABEL WHERE CARD_LABEL_NAME = 'MILESTONE' AND CARD_LABEL_PROJECT_ID_FK = (SELECT PROJECT_ID FROM LA_PROJECT WHERE PROJECT_SHORT_NAME = 'TEST')), 0, '1.0.0');
INSERT INTO LA_CARD_LABEL_LIST_VALUE(CARD_LABEL_ID_FK, CARD_LABEL_LIST_VALUE_ORDER,CARD_LABEL_LIST_VALUE) VALUES ((SELECT CARD_LABEL_ID FROM LA_CARD_LABEL WHERE CARD_LABEL_NAME = 'MILESTONE' AND CARD_LABEL_PROJECT_ID_FK = (SELECT PROJECT_ID FROM LA_PROJECT WHERE PROJECT_SHORT_NAME = 'TEST')), 1, 'Unplanned');
INSERT INTO LA_CARD_LABEL(CARD_LABEL_PROJECT_ID_FK, CARD_LABEL_UNIQUE, CARD_LABEL_TYPE, CARD_LABEL_DOMAIN, CARD_LABEL_NAME, CARD_LABEL_COLOR) VALUES((SELECT PROJECT_ID FROM LA_PROJECT WHERE PROJECT_SHORT_NAME = 'TEST'), FALSE, 'USER', 'SYSTEM', 'WATCHED_BY', 0);

-- DEFAULT COLUMN DEFINITION
INSERT INTO LA_BOARD_COLUMN_DEFINITION(BOARD_COLUMN_DEFINITION_PROJECT_ID_FK, BOARD_COLUMN_DEFINITION_VALUE, BOARD_COLUMN_DEFINITION_COLOR) VALUES((SELECT PROJECT_ID FROM LA_PROJECT WHERE PROJECT_SHORT_NAME = 'TEST'), 'OPEN', 14242639);
INSERT INTO LA_BOARD_COLUMN_DEFINITION(BOARD_COLUMN_DEFINITION_PROJECT_ID_FK, BOARD_COLUMN_DEFINITION_VALUE, BOARD_COLUMN_DEFINITION_COLOR) VALUES((SELECT PROJECT_ID FROM LA_PROJECT WHERE PROJECT_SHORT_NAME = 'TEST'), 'CLOSED', 6076508);
INSERT INTO LA_BOARD_COLUMN_DEFINITION(BOARD_COLUMN_DEFINITION_PROJECT_ID_FK, BOARD_COLUMN_DEFINITION_VALUE, BOARD_COLUMN_DEFINITION_COLOR) VALUES((SELECT PROJECT_ID FROM LA_PROJECT WHERE PROJECT_SHORT_NAME = 'TEST'), 'BACKLOG', 4361162);
INSERT INTO LA_BOARD_COLUMN_DEFINITION(BOARD_COLUMN_DEFINITION_PROJECT_ID_FK, BOARD_COLUMN_DEFINITION_VALUE, BOARD_COLUMN_DEFINITION_COLOR) VALUES((SELECT PROJECT_ID FROM LA_PROJECT WHERE PROJECT_SHORT_NAME = 'TEST'), 'DEFERRED', 15773006);

-- TEST BOARD
INSERT INTO LA_BOARD(BOARD_PROJECT_ID_FK, BOARD_NAME, BOARD_SHORT_NAME) VALUES ((SELECT PROJECT_ID FROM LA_PROJECT WHERE PROJECT_SHORT_NAME = 'TEST'),'test', 'TEST');
INSERT INTO LA_BOARD_COUNTER(BOARD_COUNTER_ID_FK, BOARD_COUNTER_CARD_SEQUENCE) VALUES(IDENTITY() , 1);

-- TEST COLUMNS
INSERT INTO LA_BOARD_COLUMN(BOARD_COLUMN_NAME, BOARD_COLUMN_ORDER, BOARD_COLUMN_BOARD_ID_FK, BOARD_COLUMN_LOCATION, BOARD_COLUMN_DEFINITION_ID_FK) VALUES ('New', 0, (SELECT BOARD_ID FROM LA_BOARD WHERE BOARD_NAME = 'test'), 'BOARD', (SELECT BOARD_COLUMN_DEFINITION_ID FROM LA_BOARD_COLUMN_DEFINITION JOIN LA_PROJECT ON PROJECT_ID = BOARD_COLUMN_DEFINITION_PROJECT_ID_FK WHERE BOARD_COLUMN_DEFINITION_VALUE = 'OPEN' AND PROJECT_SHORT_NAME = 'TEST'));
INSERT INTO LA_BOARD_COLUMN(BOARD_COLUMN_NAME, BOARD_COLUMN_ORDER, BOARD_COLUMN_BOARD_ID_FK, BOARD_COLUMN_LOCATION, BOARD_COLUMN_DEFINITION_ID_FK) VALUES ('Done', 1, (SELECT BOARD_ID FROM LA_BOARD WHERE BOARD_NAME = 'test'), 'BOARD', (SELECT BOARD_COLUMN_DEFINITION_ID FROM LA_BOARD_COLUMN_DEFINITION JOIN LA_PROJECT ON PROJECT_ID = BOARD_COLUMN_DEFINITION_PROJECT_ID_FK WHERE BOARD_COLUMN_DEFINITION_VALUE = 'CLOSED' AND PROJECT_SHORT_NAME = 'TEST'));
INSERT INTO LA_BOARD_COLUMN(BOARD_COLUMN_NAME, BOARD_COLUMN_ORDER, BOARD_COLUMN_BOARD_ID_FK, BOARD_COLUMN_LOCATION, BOARD_COLUMN_DEFINITION_ID_FK) VALUES ('ARCHIVE', 0, (SELECT BOARD_ID FROM LA_BOARD WHERE BOARD_NAME = 'test'), 'ARCHIVE', (SELECT BOARD_COLUMN_DEFINITION_ID FROM LA_BOARD_COLUMN_DEFINITION JOIN LA_PROJECT ON PROJECT_ID = BOARD_COLUMN_DEFINITION_PROJECT_ID_FK WHERE BOARD_COLUMN_DEFINITION_VALUE = 'CLOSED' AND PROJECT_SHORT_NAME = 'TEST'));
INSERT INTO LA_BOARD_COLUMN(BOARD_COLUMN_NAME, BOARD_COLUMN_ORDER, BOARD_COLUMN_BOARD_ID_FK, BOARD_COLUMN_LOCATION, BOARD_COLUMN_DEFINITION_ID_FK) VALUES ('BACKLOG', 0, (SELECT BOARD_ID FROM LA_BOARD WHERE BOARD_NAME = 'test'), 'BACKLOG', (SELECT BOARD_COLUMN_DEFINITION_ID FROM LA_BOARD_COLUMN_DEFINITION JOIN LA_PROJECT ON PROJECT_ID = BOARD_COLUMN_DEFINITION_PROJECT_ID_FK WHERE BOARD_COLUMN_DEFINITION_VALUE = 'BACKLOG' AND PROJECT_SHORT_NAME = 'TEST'));
INSERT INTO LA_BOARD_COLUMN(BOARD_COLUMN_NAME, BOARD_COLUMN_ORDER, BOARD_COLUMN_BOARD_ID_FK, BOARD_COLUMN_LOCATION, BOARD_COLUMN_DEFINITION_ID_FK) VALUES ('TRASH', 0, (SELECT BOARD_ID FROM LA_BOARD WHERE BOARD_NAME = 'test'), 'TRASH', (SELECT BOARD_COLUMN_DEFINITION_ID FROM LA_BOARD_COLUMN_DEFINITION JOIN LA_PROJECT ON PROJECT_ID = BOARD_COLUMN_DEFINITION_PROJECT_ID_FK WHERE BOARD_COLUMN_DEFINITION_VALUE = 'CLOSED' AND PROJECT_SHORT_NAME = 'TEST'));
INSERT INTO LA_BOARD_COLUMN(BOARD_COLUMN_NAME, BOARD_COLUMN_ORDER, BOARD_COLUMN_BOARD_ID_FK, BOARD_COLUMN_LOCATION, BOARD_COLUMN_DEFINITION_ID_FK) VALUES ('Deferred', 2, (SELECT BOARD_ID FROM LA_BOARD WHERE BOARD_NAME = 'test'), 'BOARD', (SELECT BOARD_COLUMN_DEFINITION_ID FROM LA_BOARD_COLUMN_DEFINITION JOIN LA_PROJECT ON PROJECT_ID = BOARD_COLUMN_DEFINITION_PROJECT_ID_FK WHERE BOARD_COLUMN_DEFINITION_VALUE = 'DEFERRED' AND PROJECT_SHORT_NAME = 'TEST'));

-- TEST CARDS
UPDATE LA_BOARD_COUNTER SET BOARD_COUNTER_CARD_SEQUENCE = 9 WHERE BOARD_COUNTER_ID_FK = 0;
INSERT INTO LA_CARD VALUES(0,'Card1',0,1,1, 1, NOW(), 1);
INSERT INTO LA_CARD VALUES(1,'Card2',0,2,2, 1, NOW(), 1);
INSERT INTO LA_CARD VALUES(2,'Card3',1,1,3, 1, NOW(), 1);
INSERT INTO LA_CARD VALUES(3,'Archived Card',2,1,4, 1, NOW(), 1);
INSERT INTO LA_CARD VALUES(4,'Backlog card',3,1,5, 1, NOW(), 1);
INSERT INTO LA_CARD VALUES(5,'Card4',1,2,6, 1, NOW(), 1);
INSERT INTO LA_CARD VALUES(6,'Card5',5,3,7, 1, NOW(), 1);
INSERT INTO LA_CARD VALUES(7,'Card6',5,3,8, 1, NOW(), 1);

-- TEST LABELS
INSERT INTO LA_CARD_LABEL(CARD_LABEL_PROJECT_ID_FK, CARD_LABEL_UNIQUE, CARD_LABEL_TYPE, CARD_LABEL_DOMAIN, CARD_LABEL_NAME, CARD_LABEL_COLOR) VALUES
	((SELECT PROJECT_ID FROM LA_PROJECT WHERE PROJECT_SHORT_NAME = 'TEST'), TRUE, 'STRING', 'USER','Type', 52224);
INSERT INTO LA_CARD_LABEL_VALUE VALUES(0, TRUE, FALSE, 2, (SELECT CARD_LABEL_ID FROM LA_CARD_LABEL WHERE CARD_LABEL_NAME = 'Type'), 'STRING', 'Feature', NULL, NULL, NULL, NULL, NULL);
INSERT INTO LA_CARD_LABEL_VALUE VALUES(1, TRUE, FALSE, 1, (SELECT CARD_LABEL_ID FROM LA_CARD_LABEL WHERE CARD_LABEL_NAME = 'MILESTONE' AND CARD_LABEL_PROJECT_ID_FK = (SELECT PROJECT_ID FROM LA_PROJECT WHERE PROJECT_SHORT_NAME = 'TEST')), 'LIST', NULL, NULL, NULL, NULL, NULL, (SELECT CARD_LABEL_LIST_VALUE_ID FROM LA_CARD_LABEL_LIST_VALUE WHERE CARD_LABEL_LIST_VALUE = '1.0.0'));
INSERT INTO LA_CARD_LABEL_VALUE VALUES(2, TRUE, FALSE, 2, (SELECT CARD_LABEL_ID FROM LA_CARD_LABEL WHERE CARD_LABEL_NAME = 'MILESTONE' AND CARD_LABEL_PROJECT_ID_FK = (SELECT PROJECT_ID FROM LA_PROJECT WHERE PROJECT_SHORT_NAME = 'TEST')), 'LIST', NULL, NULL, NULL, NULL, NULL, (SELECT CARD_LABEL_LIST_VALUE_ID FROM LA_CARD_LABEL_LIST_VALUE WHERE CARD_LABEL_LIST_VALUE = '1.0.0'));
INSERT INTO LA_CARD_LABEL_VALUE VALUES(3, TRUE, FALSE, 5, (SELECT CARD_LABEL_ID FROM LA_CARD_LABEL WHERE CARD_LABEL_NAME = 'MILESTONE' AND CARD_LABEL_PROJECT_ID_FK = (SELECT PROJECT_ID FROM LA_PROJECT WHERE PROJECT_SHORT_NAME = 'TEST')), 'LIST', NULL, NULL, NULL, NULL, NULL, (SELECT CARD_LABEL_LIST_VALUE_ID FROM LA_CARD_LABEL_LIST_VALUE WHERE CARD_LABEL_LIST_VALUE = '1.0.0'));
INSERT INTO LA_CARD_LABEL_VALUE VALUES(4, TRUE, FALSE, 6, (SELECT CARD_LABEL_ID FROM LA_CARD_LABEL WHERE CARD_LABEL_NAME = 'MILESTONE' AND CARD_LABEL_PROJECT_ID_FK = (SELECT PROJECT_ID FROM LA_PROJECT WHERE PROJECT_SHORT_NAME = 'TEST')), 'LIST', NULL, NULL, NULL, NULL, NULL, (SELECT CARD_LABEL_LIST_VALUE_ID FROM LA_CARD_LABEL_LIST_VALUE WHERE CARD_LABEL_LIST_VALUE = '1.0.0'));
INSERT INTO LA_CARD_LABEL_VALUE VALUES(5, TRUE, FALSE, 7, (SELECT CARD_LABEL_ID FROM LA_CARD_LABEL WHERE CARD_LABEL_NAME = 'MILESTONE' AND CARD_LABEL_PROJECT_ID_FK = (SELECT PROJECT_ID FROM LA_PROJECT WHERE PROJECT_SHORT_NAME = 'TEST')), 'LIST', NULL, NULL, NULL, NULL, NULL, (SELECT CARD_LABEL_LIST_VALUE_ID FROM LA_CARD_LABEL_LIST_VALUE WHERE CARD_LABEL_LIST_VALUE = '1.0.0'));
INSERT INTO LA_CARD_LABEL_VALUE VALUES(6, TRUE, FALSE, 1, (SELECT CARD_LABEL_ID FROM LA_CARD_LABEL WHERE CARD_LABEL_NAME = 'Type'), 'STRING', 'Bugfixing', NULL, NULL, NULL, NULL, NULL);

INSERT INTO LA_CARD_LABEL(CARD_LABEL_PROJECT_ID_FK, CARD_LABEL_UNIQUE, CARD_LABEL_TYPE, CARD_LABEL_DOMAIN, CARD_LABEL_NAME, CARD_LABEL_COLOR) VALUES((SELECT PROJECT_ID FROM LA_PROJECT WHERE PROJECT_SHORT_NAME = 'TEST'), TRUE, 'NULL', 'USER','Bug', 15012864);
INSERT INTO LA_CARD_LABEL(CARD_LABEL_PROJECT_ID_FK, CARD_LABEL_UNIQUE, CARD_LABEL_TYPE, CARD_LABEL_DOMAIN, CARD_LABEL_NAME, CARD_LABEL_COLOR) VALUES((SELECT PROJECT_ID FROM LA_PROJECT WHERE PROJECT_SHORT_NAME = 'TEST'), TRUE, 'INT', 'USER','Effort', 22000);
INSERT INTO LA_CARD_LABEL(CARD_LABEL_PROJECT_ID_FK, CARD_LABEL_UNIQUE, CARD_LABEL_TYPE, CARD_LABEL_DOMAIN, CARD_LABEL_NAME, CARD_LABEL_COLOR) VALUES((SELECT PROJECT_ID FROM LA_PROJECT WHERE PROJECT_SHORT_NAME = 'TEST'), FALSE, 'CARD', 'USER','Duplicate of', 32000);
INSERT INTO LA_CARD_LABEL(CARD_LABEL_PROJECT_ID_FK, CARD_LABEL_UNIQUE, CARD_LABEL_TYPE, CARD_LABEL_DOMAIN, CARD_LABEL_NAME, CARD_LABEL_COLOR) VALUES((SELECT PROJECT_ID FROM LA_PROJECT WHERE PROJECT_SHORT_NAME = 'TEST'), TRUE, 'USER', 'USER','Reviewer', 15767049);
INSERT INTO LA_CARD_LABEL(CARD_LABEL_PROJECT_ID_FK, CARD_LABEL_UNIQUE, CARD_LABEL_TYPE, CARD_LABEL_DOMAIN, CARD_LABEL_NAME, CARD_LABEL_COLOR) VALUES((SELECT PROJECT_ID FROM LA_PROJECT WHERE PROJECT_SHORT_NAME = 'TEST'), TRUE, 'TIMESTAMP', 'USER','Deadline', 13556480);
INSERT INTO LA_CARD_LABEL(CARD_LABEL_PROJECT_ID_FK, CARD_LABEL_UNIQUE, CARD_LABEL_TYPE, CARD_LABEL_DOMAIN, CARD_LABEL_NAME, CARD_LABEL_COLOR) VALUES((SELECT PROJECT_ID FROM LA_PROJECT WHERE PROJECT_SHORT_NAME = 'TEST'), TRUE, 'LIST', 'USER','Priority', 52200);
INSERT INTO LA_CARD_LABEL_LIST_VALUE(CARD_LABEL_ID_FK, CARD_LABEL_LIST_VALUE_ORDER,CARD_LABEL_LIST_VALUE) VALUES ((SELECT CARD_LABEL_ID FROM LA_CARD_LABEL WHERE CARD_LABEL_NAME = 'Priority' AND CARD_LABEL_PROJECT_ID_FK = (SELECT PROJECT_ID FROM LA_PROJECT WHERE PROJECT_SHORT_NAME = 'TEST')), 0, 'Low');
INSERT INTO LA_CARD_LABEL_LIST_VALUE(CARD_LABEL_ID_FK, CARD_LABEL_LIST_VALUE_ORDER,CARD_LABEL_LIST_VALUE) VALUES ((SELECT CARD_LABEL_ID FROM LA_CARD_LABEL WHERE CARD_LABEL_NAME = 'Priority' AND CARD_LABEL_PROJECT_ID_FK = (SELECT PROJECT_ID FROM LA_PROJECT WHERE PROJECT_SHORT_NAME = 'TEST')), 1, 'High');

-- ADD A GLOBAL ROLE READ_ONLY
INSERT INTO LA_ROLE(ROLE_NAME, ROLE_REMOVABLE) VALUES('READ_ONLY', FALSE);
INSERT INTO LA_ROLE_PERMISSION(ROLE_ID_FK, PERMISSION) VALUES
	((SELECT ROLE_ID FROM LA_ROLE WHERE ROLE_NAME = 'READ_ONLY'), 'READ');

-- ADD user 'user' the role 'ADMIN'
INSERT INTO LA_USER_ROLE(USER_ID_FK, ROLE_ID_FK) VALUES
((SELECT USER_ID FROM LA_USER WHERE USER_NAME = 'user' AND USER_PROVIDER = 'demo'), (SELECT ROLE_ID FROM LA_ROLE WHERE ROLE_NAME = 'ADMIN'));
INSERT INTO LA_USER_ROLE(USER_ID_FK, ROLE_ID_FK) VALUES
((SELECT USER_ID FROM LA_USER WHERE USER_NAME = 'user1' AND USER_PROVIDER = 'demo'), (SELECT ROLE_ID FROM LA_ROLE WHERE ROLE_NAME = 'DEFAULT'));
INSERT INTO LA_USER_ROLE(USER_ID_FK, ROLE_ID_FK) VALUES
((SELECT USER_ID FROM LA_USER WHERE USER_NAME = 'user2' AND USER_PROVIDER = 'demo'), (SELECT ROLE_ID FROM LA_ROLE WHERE ROLE_NAME = 'READ_ONLY'));


--INSERT INTO LA_USER_ROLE(USER_ID_FK, ROLE_ID_FK) VALUES
--((SELECT USER_ID FROM LA_USER WHERE USER_NAME = 'user' AND USER_PROVIDER = 'ldap'), (SELECT ROLE_ID FROM LA_ROLE WHERE ROLE_NAME = 'ADMIN'));
--INSERT INTO LA_USER_ROLE(USER_ID_FK, ROLE_ID_FK) VALUES
--((SELECT USER_ID FROM LA_USER WHERE USER_NAME = 'sylvain.jermini@syjer.com' AND USER_PROVIDER = 'persona'), (SELECT ROLE_ID FROM LA_ROLE WHERE ROLE_NAME = 'ADMIN'));
--INSERT INTO LA_USER_ROLE(USER_ID_FK, ROLE_ID_FK) VALUES
--((SELECT USER_ID FROM LA_USER WHERE USER_NAME = 'sylvain.jermini@syjer.com' AND USER_PROVIDER = 'oauth.google'), (SELECT ROLE_ID FROM LA_ROLE WHERE ROLE_NAME = 'ADMIN'));
--INSERT INTO LA_USER_ROLE(USER_ID_FK, ROLE_ID_FK) VALUES
--((SELECT USER_ID FROM LA_USER WHERE USER_NAME = 'syjer' AND USER_PROVIDER = 'oauth.github'), (SELECT ROLE_ID FROM LA_ROLE WHERE ROLE_NAME = 'ADMIN'));
--INSERT INTO LA_USER_ROLE(USER_ID_FK, ROLE_ID_FK) VALUES
--((SELECT USER_ID FROM LA_USER WHERE USER_NAME = 'syjer' AND USER_PROVIDER = 'oauth.bitbucket'), (SELECT ROLE_ID FROM LA_ROLE WHERE ROLE_NAME = 'ADMIN'));


-- CARD EVENTS
INSERT INTO LA_EVENT (EVENT_CARD_ID_FK, EVENT_USER_ID_FK, EVENT_TYPE, EVENT_TIME, EVENT_COLUMN_ID_FK, EVENT_VALUE_STRING) VALUES (0, 1, 'CARD_CREATE', NOW(), (SELECT BOARD_COLUMN_ID FROM LA_BOARD_COLUMN JOIN LA_BOARD ON BOARD_COLUMN_BOARD_ID_FK = BOARD_ID WHERE BOARD_NAME = 'test' AND BOARD_COLUMN_NAME = 'New'), 'Card1');
INSERT INTO LA_EVENT (EVENT_CARD_ID_FK, EVENT_USER_ID_FK, EVENT_TYPE, EVENT_TIME, EVENT_COLUMN_ID_FK, EVENT_VALUE_STRING) VALUES (1, 1, 'CARD_CREATE', NOW(), (SELECT BOARD_COLUMN_ID FROM LA_BOARD_COLUMN JOIN LA_BOARD ON BOARD_COLUMN_BOARD_ID_FK = BOARD_ID WHERE BOARD_NAME = 'test' AND BOARD_COLUMN_NAME = 'New'), 'Card2');
INSERT INTO LA_EVENT (EVENT_CARD_ID_FK, EVENT_USER_ID_FK, EVENT_TYPE, EVENT_TIME, EVENT_COLUMN_ID_FK, EVENT_VALUE_STRING) VALUES (2, 1, 'CARD_CREATE', NOW(), (SELECT BOARD_COLUMN_ID FROM LA_BOARD_COLUMN JOIN LA_BOARD ON BOARD_COLUMN_BOARD_ID_FK = BOARD_ID WHERE BOARD_NAME = 'test' AND BOARD_COLUMN_NAME = 'Done'), 'Card3');
INSERT INTO LA_EVENT (EVENT_CARD_ID_FK, EVENT_USER_ID_FK, EVENT_TYPE, EVENT_TIME, EVENT_COLUMN_ID_FK, EVENT_VALUE_STRING) VALUES (3, 1, 'CARD_CREATE', NOW(), (SELECT BOARD_COLUMN_ID FROM LA_BOARD_COLUMN JOIN LA_BOARD ON BOARD_COLUMN_BOARD_ID_FK = BOARD_ID WHERE BOARD_NAME = 'test' AND BOARD_COLUMN_NAME = 'ARCHIVE'), 'Archived Card');
INSERT INTO LA_EVENT (EVENT_CARD_ID_FK, EVENT_USER_ID_FK, EVENT_TYPE, EVENT_TIME, EVENT_COLUMN_ID_FK, EVENT_VALUE_STRING) VALUES (4, 1, 'CARD_CREATE', NOW(), (SELECT BOARD_COLUMN_ID FROM LA_BOARD_COLUMN JOIN LA_BOARD ON BOARD_COLUMN_BOARD_ID_FK = BOARD_ID WHERE BOARD_NAME = 'test' AND BOARD_COLUMN_NAME = 'BACKLOG'), 'Backlog card');

INSERT INTO LA_EVENT (EVENT_CARD_ID_FK, EVENT_USER_ID_FK, EVENT_TYPE, EVENT_TIME, EVENT_COLUMN_ID_FK, EVENT_VALUE_STRING) VALUES (5, 1, 'CARD_CREATE', NOW() - INTERVAL 3 DAY, (SELECT BOARD_COLUMN_ID FROM LA_BOARD_COLUMN JOIN LA_BOARD ON BOARD_COLUMN_BOARD_ID_FK = BOARD_ID WHERE BOARD_NAME = 'test' AND BOARD_COLUMN_NAME = 'New'), 'Card4');
INSERT INTO LA_EVENT (EVENT_CARD_ID_FK, EVENT_USER_ID_FK, EVENT_TYPE, EVENT_TIME, EVENT_COLUMN_ID_FK, EVENT_PREV_COLUMN_ID_FK) VALUES (5, 1, 'CARD_MOVE', NOW() - INTERVAL 2 DAY, (SELECT BOARD_COLUMN_ID FROM LA_BOARD_COLUMN JOIN LA_BOARD ON BOARD_COLUMN_BOARD_ID_FK = BOARD_ID WHERE BOARD_NAME = 'test' AND BOARD_COLUMN_NAME = 'Done'), (SELECT BOARD_COLUMN_ID FROM LA_BOARD_COLUMN JOIN LA_BOARD ON BOARD_COLUMN_BOARD_ID_FK = BOARD_ID WHERE BOARD_NAME = 'test' AND BOARD_COLUMN_NAME = 'New'));

INSERT INTO LA_EVENT (EVENT_CARD_ID_FK, EVENT_USER_ID_FK, EVENT_TYPE, EVENT_TIME, EVENT_COLUMN_ID_FK, EVENT_VALUE_STRING) VALUES (6, 1, 'CARD_CREATE', NOW() - INTERVAL 2 DAY, (SELECT BOARD_COLUMN_ID FROM LA_BOARD_COLUMN JOIN LA_BOARD ON BOARD_COLUMN_BOARD_ID_FK = BOARD_ID WHERE BOARD_NAME = 'test' AND BOARD_COLUMN_NAME = 'New'), 'Card5');
INSERT INTO LA_EVENT (EVENT_CARD_ID_FK, EVENT_USER_ID_FK, EVENT_TYPE, EVENT_TIME, EVENT_COLUMN_ID_FK, EVENT_PREV_COLUMN_ID_FK) VALUES (6, 1, 'CARD_MOVE', NOW() - INTERVAL 1 DAY, (SELECT BOARD_COLUMN_ID FROM LA_BOARD_COLUMN JOIN LA_BOARD ON BOARD_COLUMN_BOARD_ID_FK = BOARD_ID WHERE BOARD_NAME = 'test' AND BOARD_COLUMN_NAME = 'Deferred'), (SELECT BOARD_COLUMN_ID FROM LA_BOARD_COLUMN JOIN LA_BOARD ON BOARD_COLUMN_BOARD_ID_FK = BOARD_ID WHERE BOARD_NAME = 'test' AND BOARD_COLUMN_NAME = 'New'));

INSERT INTO LA_EVENT (EVENT_CARD_ID_FK, EVENT_USER_ID_FK, EVENT_TYPE, EVENT_TIME, EVENT_COLUMN_ID_FK, EVENT_VALUE_STRING) VALUES (7, 1, 'CARD_CREATE', NOW() - INTERVAL 2 DAY, (SELECT BOARD_COLUMN_ID FROM LA_BOARD_COLUMN JOIN LA_BOARD ON BOARD_COLUMN_BOARD_ID_FK = BOARD_ID WHERE BOARD_NAME = 'test' AND BOARD_COLUMN_NAME = 'New'), 'Card6');
INSERT INTO LA_EVENT (EVENT_CARD_ID_FK, EVENT_USER_ID_FK, EVENT_TYPE, EVENT_TIME, EVENT_COLUMN_ID_FK, EVENT_PREV_COLUMN_ID_FK) VALUES (7, 1, 'CARD_MOVE', NOW() - INTERVAL 1 DAY, (SELECT BOARD_COLUMN_ID FROM LA_BOARD_COLUMN JOIN LA_BOARD ON BOARD_COLUMN_BOARD_ID_FK = BOARD_ID WHERE BOARD_NAME = 'test' AND BOARD_COLUMN_NAME = 'Done'), (SELECT BOARD_COLUMN_ID FROM LA_BOARD_COLUMN JOIN LA_BOARD ON BOARD_COLUMN_BOARD_ID_FK = BOARD_ID WHERE BOARD_NAME = 'test' AND BOARD_COLUMN_NAME = 'New'));

INSERT INTO LA_EVENT (EVENT_CARD_ID_FK, EVENT_USER_ID_FK, EVENT_TYPE, EVENT_TIME, EVENT_COLUMN_ID_FK, EVENT_PREV_COLUMN_ID_FK) VALUES (3, 1, 'CARD_ARCHIVE', NOW(), 2, 0);
INSERT INTO LA_EVENT (EVENT_CARD_ID_FK, EVENT_USER_ID_FK, EVENT_TYPE, EVENT_TIME, EVENT_COLUMN_ID_FK, EVENT_PREV_COLUMN_ID_FK) VALUES (4, 1, 'CARD_BACKLOG', NOW(), 3, 0);

INSERT INTO LA_EVENT (EVENT_CARD_ID_FK, EVENT_USER_ID_FK, EVENT_TYPE, EVENT_TIME, EVENT_LABEL_NAME, EVENT_LABEL_TYPE, EVENT_VALUE_STRING) VALUES (2, 1,'LABEL_CREATE',NOW(), 'Type', 'STRING', 'Feature');
INSERT INTO LA_EVENT (EVENT_CARD_ID_FK, EVENT_USER_ID_FK, EVENT_TYPE, EVENT_TIME, EVENT_LABEL_NAME, EVENT_LABEL_TYPE, EVENT_VALUE_STRING) VALUES (1, 1,'LABEL_CREATE',NOW(), 'Type', 'STRING', 'Bugfixing');

-- BOARD STATISTICS
INSERT INTO LA_BOARD_STATISTICS VALUES (NOW() - INTERVAL 2 DAY, (SELECT BOARD_ID FROM LA_BOARD WHERE BOARD_NAME = 'test'), (SELECT BOARD_COLUMN_DEFINITION_ID_FK FROM LA_BOARD_COLUMN JOIN LA_BOARD ON BOARD_COLUMN_BOARD_ID_FK = BOARD_ID WHERE BOARD_NAME = 'test' AND BOARD_COLUMN_NAME = 'Done'), 'BOARD', 1);

INSERT INTO LA_BOARD_STATISTICS VALUES (NOW() - INTERVAL 1 DAY, (SELECT BOARD_ID FROM LA_BOARD WHERE BOARD_NAME = 'test'), (SELECT BOARD_COLUMN_DEFINITION_ID_FK FROM LA_BOARD_COLUMN JOIN LA_BOARD ON BOARD_COLUMN_BOARD_ID_FK = BOARD_ID WHERE BOARD_NAME = 'test' AND BOARD_COLUMN_NAME = 'Done'), 'BOARD', 1);
INSERT INTO LA_BOARD_STATISTICS VALUES (NOW() - INTERVAL 1 DAY, (SELECT BOARD_ID FROM LA_BOARD WHERE BOARD_NAME = 'test'), (SELECT BOARD_COLUMN_DEFINITION_ID_FK FROM LA_BOARD_COLUMN JOIN LA_BOARD ON BOARD_COLUMN_BOARD_ID_FK = BOARD_ID WHERE BOARD_NAME = 'test' AND BOARD_COLUMN_NAME = 'Deferred'), 'BOARD', 1);

INSERT INTO LA_BOARD_STATISTICS VALUES (NOW(), (SELECT BOARD_ID FROM LA_BOARD WHERE BOARD_NAME = 'test'), (SELECT BOARD_COLUMN_DEFINITION_ID_FK FROM LA_BOARD_COLUMN JOIN LA_BOARD ON BOARD_COLUMN_BOARD_ID_FK = BOARD_ID WHERE BOARD_NAME = 'test' AND BOARD_COLUMN_NAME = 'New'), 'BOARD', 2);
INSERT INTO LA_BOARD_STATISTICS VALUES (NOW(), (SELECT BOARD_ID FROM LA_BOARD WHERE BOARD_NAME = 'test'), (SELECT BOARD_COLUMN_DEFINITION_ID_FK FROM LA_BOARD_COLUMN JOIN LA_BOARD ON BOARD_COLUMN_BOARD_ID_FK = BOARD_ID WHERE BOARD_NAME = 'test' AND BOARD_COLUMN_NAME = 'Done'), 'BOARD', 2);
INSERT INTO LA_BOARD_STATISTICS VALUES (NOW(), (SELECT BOARD_ID FROM LA_BOARD WHERE BOARD_NAME = 'test'), (SELECT BOARD_COLUMN_DEFINITION_ID_FK FROM LA_BOARD_COLUMN JOIN LA_BOARD ON BOARD_COLUMN_BOARD_ID_FK = BOARD_ID WHERE BOARD_NAME = 'test' AND BOARD_COLUMN_NAME = 'Deferred'), 'BOARD', 1);
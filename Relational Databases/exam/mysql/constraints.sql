-- PRIMARY KEYS

ALTER TABLE CATEGORIES MODIFY ID_WEIGHT INTEGER NOT NULL;
ALTER TABLE CATEGORIES ADD CONSTRAINT cat_pk PRIMARY KEY (ID_WEIGHT);

ALTER TABLE COMPETITIONS MODIFY ID_COMPETITION INTEGER NOT NULL;
ALTER TABLE COMPETITIONS ADD CONSTRAINT comp_pk PRIMARY KEY (ID_COMPETITION);

ALTER TABLE COMPETITORS MODIFY ID_COMPETITOR INT NOT NULL;
ALTER TABLE COMPETITORS ADD CONSTRAINT judoka_pk PRIMARY KEY (ID_COMPETITOR);


ALTER TABLE CONTESTS MODIFY CONTEST_CODE_LONG VARCHAR(355) NOT NULL;
ALTER TABLE CONTESTS ADD CONSTRAINT fight_pk PRIMARY KEY (CONTEST_CODE_LONG);

ALTER TABLE EVENT_TYPES MODIFY TYPE_CODE INTEGER NOT NULL;
ALTER TABLE EVENT_TYPES ADD CONSTRAINT type_pk PRIMARY KEY (TYPE_CODE);

ALTER TABLE EVENTS MODIFY ID_EVENT INTEGER NOT NULL;
ALTER TABLE EVENTS ADD CONSTRAINT event_pk PRIMARY KEY (ID_EVENT);


-- Data adjustments for missing values
DELETE FROM EVENTS_DETAILS WHERE ID_EVENT IS NULL;
DELETE FROM EVENTS_DETAILS WHERE EVENTS_DETAILS.ID_ACTOR IS NULL;
DELETE ed
FROM EVENTS_DETAILS ed
         LEFT JOIN EVENTS ev ON ed.ID_EVENT = ev.ID_EVENT
WHERE ev.ID_EVENT IS NULL;

DELETE
FROM CONTESTS
WHERE ID_WINNER NOT IN (SELECT ID_COMPETITOR FROM COMPETITORS);

ALTER TABLE EVENTS_DETAILS MODIFY ID_EVENT INT NOT NULL;
ALTER TABLE EVENTS_DETAILS MODIFY ID_ACTOR INT NOT NULL;
ALTER TABLE EVENTS_DETAILS MODIFY ID_GROUP INT NOT NULL;
ALTER TABLE EVENTS_DETAILS ADD CONSTRAINT evt_details_pk PRIMARY KEY (ID_EVENT, ID_ACTOR, ID_GROUP);

-- FOREIGN KEYS
ALTER TABLE CONTESTS ADD CONSTRAINT competitor_blue_contest_fk FOREIGN KEY (ID_PERSON_BLUE) REFERENCES COMPETITORS(ID_COMPETITOR);
ALTER TABLE CONTESTS ADD CONSTRAINT competitor_white_contest_fk FOREIGN KEY (ID_PERSON_WHITE) REFERENCES COMPETITORS(ID_COMPETITOR);
ALTER TABLE CONTESTS ADD CONSTRAINT competitor_winner_contest_fk FOREIGN KEY (ID_WINNER) REFERENCES COMPETITORS(ID_COMPETITOR);
ALTER TABLE CONTESTS ADD CONSTRAINT competition_contests_fk FOREIGN KEY (ID_COMPETITION) REFERENCES COMPETITIONS(ID_COMPETITION);

ALTER TABLE EVENTS_DETAILS ADD CONSTRAINT event_details_type_fk FOREIGN KEY (ID_GROUP) REFERENCES EVENT_TYPES(TYPE_CODE);
ALTER TABLE EVENTS_DETAILS ADD CONSTRAINT event_details_competitor_fk FOREIGN KEY (ID_ACTOR) REFERENCES COMPETITORS(ID_COMPETITOR);
ALTER TABLE EVENTS_DETAILS ADD CONSTRAINT event_details_event_fk FOREIGN KEY (ID_EVENT) REFERENCES EVENTS(ID_EVENT);

CREATE TABLE area (
    area           VARCHAR(40) NOT NULL,
    region_region  VARCHAR(40) NOT NULL
);

ALTER TABLE area ADD CONSTRAINT area_pk PRIMARY KEY ( area );

CREATE TABLE classprofile (
    classprofile VARCHAR(40) NOT NULL
);

ALTER TABLE classprofile ADD CONSTRAINT classprofile_pk PRIMARY KEY ( classprofile );

CREATE TABLE eoperant (
    eoparent VARCHAR(40) NOT NULL
);

ALTER TABLE eoperant ADD CONSTRAINT eoperant_pk PRIMARY KEY ( eoparent );

CREATE TABLE eotypename (
    eotypename VARCHAR(40) NOT NULL
);

ALTER TABLE eotypename ADD CONSTRAINT eotypename_pk PRIMARY KEY ( eotypename );

CREATE TABLE languges (
    language VARCHAR(40) NOT NULL
);

ALTER TABLE languges ADD CONSTRAINT languges_pk PRIMARY KEY ( language );

CREATE TABLE person (
    outid                                       VARCHAR(40) NOT NULL,
    birth                                       VARCHAR(10),
    sex                                         VARCHAR(30),
    year                                        VARCHAR(10),
    classprofile_classprofile                   VARCHAR(40) NOT NULL, 
    placeofregistration_placeofregistration_id  NUMERIC(3,2) NOT NULL
);

ALTER TABLE person ADD CONSTRAINT person_pk PRIMARY KEY ( outid );

CREATE TABLE placeofperfomance (
    tername_tername  VARCHAR(30) NOT NULL,
    person_outid     VARCHAR(40) NOT NULL
);

CREATE TABLE placeofregistration (
    tername_tername         VARCHAR(30) NOT NULL,
    placeofregistration_id  NUMERIC(3,2) NOT NULL
);

ALTER TABLE placeofregistration ADD CONSTRAINT placeofregistration_pk PRIMARY KEY ( placeofregistration_id );

CREATE TABLE region (
    region VARCHAR(40) NOT NULL
);

ALTER TABLE region ADD CONSTRAINT region_pk PRIMARY KEY ( region );

CREATE TABLE result (
    ball                       NUMERIC(5,2),
    testconditions_adaptscale  NUMERIC(5,2) NOT NULL,
    ballzno                    NUMERIC(5,2),
    balldpa                    VARCHAR(40),
    person_outid               VARCHAR(40) NOT NULL,
    testname_testname          VARCHAR(40) NOT NULL
);

CREATE TABLE school (
    eoname                 VARCHAR(40) NOT NULL,
    eoperant_eoparent      VARCHAR(40) NOT NULL,
    tername_tername        VARCHAR(30) NOT NULL,
    eotypename_eotypename  VARCHAR(40) NOT NULL
);

ALTER TABLE school ADD CONSTRAINT school_pk PRIMARY KEY ( eoname );

CREATE TABLE schoolclassprofile (
    classprofile_classprofile  VARCHAR(40) NOT NULL,
    school_eoname              VARCHAR(40) NOT NULL
);

ALTER TABLE schoolclassprofile ADD CONSTRAINT relation_20_pk PRIMARY KEY ( classprofile_classprofile,
                                                                           school_eoname );

CREATE TABLE testname (
    testname VARCHAR(40) NOT NULL
);

ALTER TABLE testname ADD CONSTRAINT testname_pk PRIMARY KEY ( testname );


CREATE TABLE schoollanguage (
    school_eoname      VARCHAR(40) NOT NULL,
    languges_language  VARCHAR(40) NOT NULL
);

ALTER TABLE schoollanguage ADD CONSTRAINT relation_22_pk PRIMARY KEY ( school_eoname,
                                                                       languges_language );

CREATE TABLE tername (
    tername    VARCHAR(30) NOT NULL,
    area_area  VARCHAR(40) NOT NULL
);

ALTER TABLE tername ADD CONSTRAINT tername_pk PRIMARY KEY ( tername );

CREATE TABLE testconditions (
    adaptscale         NUMERIC(5, 2) NOT NULL,
    languges_language  VARCHAR(40) NOT NULL
);

CREATE UNIQUE INDEX testconditions__idx ON
    testconditions (
        languges_language);

ALTER TABLE testconditions ADD CONSTRAINT testconditions_pk PRIMARY KEY ( adaptscale );

ALTER TABLE area
    ADD CONSTRAINT area_region_fk FOREIGN KEY ( region_region )
        REFERENCES region ( region );

ALTER TABLE person
    ADD CONSTRAINT person_classprofile_fk FOREIGN KEY ( classprofile_classprofile )
        REFERENCES classprofile ( classprofile );

ALTER TABLE person
    ADD CONSTRAINT person_placeofregistration_fk FOREIGN KEY ( placeofregistration_placeofregistration_id )
        REFERENCES placeofregistration ( placeofregistration_id );

ALTER TABLE placeofperfomance
    ADD CONSTRAINT placeofperfomance_person_fk FOREIGN KEY ( person_outid )
        REFERENCES person ( outid );

ALTER TABLE placeofperfomance
    ADD CONSTRAINT placeofperfomance_tername_fk FOREIGN KEY ( tername_tername )
        REFERENCES tername ( tername );

ALTER TABLE placeofregistration
    ADD CONSTRAINT placeofregistration_tername_fk FOREIGN KEY ( tername_tername )
        REFERENCES tername ( tername );

ALTER TABLE schoolclassprofile
    ADD CONSTRAINT relation_20_classprofile_fk FOREIGN KEY ( classprofile_classprofile )
        REFERENCES classprofile ( classprofile );

ALTER TABLE schoolclassprofile
    ADD CONSTRAINT relation_20_school_fk FOREIGN KEY ( school_eoname )
        REFERENCES school ( eoname );

ALTER TABLE schoollanguage
    ADD CONSTRAINT relation_22_languges_fk FOREIGN KEY ( languges_language )
        REFERENCES languges ( language );

ALTER TABLE schoollanguage
    ADD CONSTRAINT relation_22_school_fk FOREIGN KEY ( school_eoname )
        REFERENCES school ( eoname );

ALTER TABLE result
    ADD CONSTRAINT result_person_fk FOREIGN KEY ( person_outid )
        REFERENCES person ( outid );

ALTER TABLE result
    ADD CONSTRAINT result_testconditions_fk FOREIGN KEY ( testconditions_adaptscale )
        REFERENCES testconditions ( adaptscale );

ALTER TABLE result
    ADD CONSTRAINT result_testname_fk FOREIGN KEY ( testname_testname )
        REFERENCES testname ( testname );

ALTER TABLE school
    ADD CONSTRAINT school_eoperant_fk FOREIGN KEY ( eoperant_eoparent )
        REFERENCES eoperant ( eoparent );

ALTER TABLE school
    ADD CONSTRAINT school_eotypename_fk FOREIGN KEY ( eotypename_eotypename )
        REFERENCES eotypename ( eotypename );

ALTER TABLE school
    ADD CONSTRAINT school_tername_fk FOREIGN KEY ( tername_tername )
        REFERENCES tername ( tername );

ALTER TABLE tername
    ADD CONSTRAINT tername_area_fk FOREIGN KEY ( area_area )
        REFERENCES area ( area );

ALTER TABLE testconditions
    ADD CONSTRAINT testconditions_languges_fk FOREIGN KEY ( languges_language )
        REFERENCES languges ( language );

INSERT INTO region (region) SELECT regname from zno;
INSERT INTO area (area,region_region) SELECT areaname,regname from zno;
INSERT INTO eoperant (eoparent) SELECT eoparent from zno;
INSERT INTO eotypename (eotypename) SELECT eotypename from zno;
INSERT INTO languges (language) SELECT classlangname from zno;
INSERT INTO classprofile (classprofile) SELECT classprofilename from zno;
INSERT INTO tername (tername,area_area) SELECT tername,areaname from zno;
INSERT INTO placeofregistration (tername_tername,placeofregistration_id) SELECT  tername,1 FROM zno;
INSERT INTO person (outid, birth,sex,year,classprofile_classprofile, placeofregistration_placeofregistration_id) SELECT outid,birth,sextypename,year,classprofilename , 1 from zno;
INSERT INTO placeofperfomance (tername_tername, person_outid) SELECT tername,outid from zno; 
INSERT INTO school (eoname, eoperant_eoparent,tername_tername, eotypename_eotypename) SELECT eoname,eoparent,tername,eotypename from zno;
INSERT INTO schoolclassprofile (classprofile_classprofile, school_eoname) SELECT classprofilename,eoname from zno;
INSERT INTO schoollanguage (school_eoname,languges_language) SELECT eoname,classlangname from zno;
INSERT INTO testconditions (adaptscale, languges_language) SELECT ukradaptscale,classlangname from zno;
INSERT INTO testname VALUES ('phis');
INSERT INTO testname VALUES ('ukr');
INSERT INTO testname VALUES ('hist');
INSERT INTO testname VALUES ('math');
INSERT INTO testname VALUES ('chem');
INSERT INTO testname VALUES ('bio');
INSERT INTO testname VALUES ('geo');
INSERT INTO testname VALUES ('eng');
INSERT INTO testname VALUES ('fra');
INSERT INTO testname VALUES ('deu');
INSERT INTO testname VALUES ('1');

INSERT INTO result (ball,
    testconditions_adaptscale,
    ballzno,
    balldpa,
    person_outid,
    testname_testname)
    SELECT 
    urkball,ukradaptscale,ukrball100,ukrball12,outid,ukrtest from zno;
INSERT INTO result (ball,
    testconditions_adaptscale,
    ballzno,
    balldpa,
    person_outid,
    testname_testname)
    SELECT spaball,ukradaptscale,spaball100,spaball12,outid,spatest from zno;
INSERT INTO result (ball,
    testconditions_adaptscale,
    ballzno,
    balldpa,
    person_outid,
    testname_testname)
    SELECT deuball,ukradaptscale,deuball100,deuball12,outid,deutest from zno;
INSERT INTO result (ball,
    testconditions_adaptscale,
    ballzno,
    balldpa,
    person_outid,
    testname_testname)
    SELECT fraball,ukradaptscale,fraball100,fraball12,outid,fratest from zno;
INSERT INTO result (ball,
    testconditions_adaptscale,
    ballzno,
    balldpa,
    person_outid,
    testname_testname)
    SELECT engball,ukradaptscale,engball100,engball12,outid,engtest from zno;
INSERT INTO result (ball,
    testconditions_adaptscale,
    ballzno,
    balldpa,
    person_outid,
    testname_testname)
    SELECT geoball,ukradaptscale,geoball100,geoball12,outid,geotest from zno;
INSERT INTO result (ball,
    testconditions_adaptscale,
    ballzno,
    balldpa,
    person_outid,
    testname_testname)
    SELECT bioball,ukradaptscale,bioball100,bioball12,outid,biotest from zno;
INSERT INTO result (ball,
    testconditions_adaptscale,
    ballzno,
    balldpa,
    person_outid,
    testname_testname)
    SELECT chemball,ukradaptscale,chemball100,chemball12,outid,chemtest from zno;
INSERT INTO result (ball,
    testconditions_adaptscale,
    ballzno,
    balldpa,
    person_outid,
    testname_testname)
    SELECT mathball,ukradaptscale,mathball100,mathball12,outid,mathtest from zno;
INSERT INTO result (ball,
    testconditions_adaptscale,
    ballzno,
    balldpa,
    person_outid,
    testname_testname)
    SELECT histball,ukradaptscale,histball100,histball12,outid,histtest from zno;
INSERT INTO result (ball,
    testconditions_adaptscale,
    ballzno,
    balldpa,
    person_outid,
    testname_testname)
    SELECT physball,ukradaptscale,physball100,physball12,outid,physTest from zno;


DROP TABLE zno;


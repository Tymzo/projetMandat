-- -----------------------------------------------------------------------------
--             Génération d'une base de données pour
--                      Oracle Version 10g
--                        (2/9/2022 11:06:06)
-- -----------------------------------------------------------------------------
--      Nom de la base : modèleLogique
--      Projet : PneuTrott.ch
--      Auteur : ESIG
--      Date de dernière modification : 2/9/2022 11:05:38
-- -----------------------------------------------------------------------------

DROP TABLE PERSONNE ;

DROP TABLE FACTURE ;

DROP TABLE COMMANDE ;

DROP TABLE ADRESSE ;

DROP TABLE PRODUIT ;

DROP TABLE CATEGORIE ;

DROP TABLE PARAMETRE ;

DROP TABLE PRODUITCOMMANDER ;

-- -----------------------------------------------------------------------------
--       CREATION DE LA BASE 
-- -----------------------------------------------------------------------------

CREATE TABLE PERSONNE;
CREATE TABLE FACTURE;
CREATE TABLE COMMANDE;
CREATE TABLE ADRESSE;
CREATE TABLE PRODUIT;
CREATE TABLE PARAMETRE;
CREATE TABLE PRODUITCOMMANDER;


-- -----------------------------------------------------------------------------
--       TABLE : PERSONNE
-- -----------------------------------------------------------------------------

CREATE TABLE PERSONNE
   (
    PER_ID NUMBER(5)  NOT NULL,
    ADR_ID_PERSONNE NUMBER(5)  NULL,
    PER_NOM VARCHAR2(50)  NULL,
    PER_PRENOM VARCHAR2(32)  NULL,
    PER_EMAIL VARCHAR2(80)  NULL,
    PER_TYPE VARCHAR2(10)  NULL,
    PER_DATENAISSANCE DATE  NULL,
    PER_MDP VARCHAR2(500)  NULL,
    PER_NOAVS VARCHAR2(20)  NULL
,   CONSTRAINT PK_PERSONNE PRIMARY KEY (PER_ID)  
   ) ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE PERSONNE
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_PERSONNE_ADRESSE
     ON PERSONNE (ADR_ID_PERSONNE ASC)
    ;

-- -----------------------------------------------------------------------------
--       TABLE : FACTURE
-- -----------------------------------------------------------------------------

CREATE TABLE FACTURE
   (
    FAC_ID NUMBER(5)  NOT NULL,
    COM_ID NUMBER(5)  NOT NULL,
    FAC_DATE DATE  NULL,
    FAC_STATUT VARCHAR2(32)  NULL,
    FAC_NO NUMBER(5)  NULL,
    FAC_ADRESSE VARCHAR2(50)  NULL,
    FAC_NPA NUMBER(4)  NULL,
    FAC_LOCALITE VARCHAR2(30)  NULL,
    FAC_PAYS VARCHAR2(30)  NULL
,   CONSTRAINT PK_FACTURE PRIMARY KEY (FAC_ID)  
   ) ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE FACTURE
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_FACTURE_COMMANDE
     ON FACTURE (COM_ID ASC)
    ;

-- -----------------------------------------------------------------------------
--       TABLE : COMMANDE
-- -----------------------------------------------------------------------------

CREATE TABLE COMMANDE
   (
    COM_ID NUMBER(5)  NOT NULL,
    ADR_ID NUMBER(5)  NOT NULL,
    COM_DATE DATE  NULL,
    COM_HEURE DATETIME  NULL,
    COM_STATUT VARCHAR2(20)  NULL
,   CONSTRAINT PK_COMMANDE PRIMARY KEY (COM_ID)  
   ) ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE COMMANDE
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_COMMANDE_ADRESSE
     ON COMMANDE (ADR_ID ASC)
    ;

-- -----------------------------------------------------------------------------
--       TABLE : ADRESSE
-- -----------------------------------------------------------------------------

CREATE TABLE ADRESSE
   (
    ADR_ID NUMBER(5)  NOT NULL,
    ADR_NPA NUMBER(4)  NULL,
    ADR_LOCALITE VARCHAR2(30)  NULL,
    ADR_PAYS VARCHAR2(30)  NULL,
    ADR_RUE VARCHAR2(50)  NULL
,   CONSTRAINT PK_ADRESSE PRIMARY KEY (ADR_ID)  
   ) ;

-- -----------------------------------------------------------------------------
--       TABLE : PRODUIT
-- -----------------------------------------------------------------------------

CREATE TABLE PRODUIT
   (
    PRO_ID NUMBER(5)  NOT NULL,
    CAT_ID NUMBER(5)  NOT NULL,
    PER_ID NUMBER(5)  NOT NULL,
    PRO_NOM VARCHAR2(50)  NULL,
    PRO_DESC VARCHAR2(500)  NULL,
    PRO_PRIXUNITAIRE FLOAT(2)  NULL,
    PRO_IMAGE VARCHAR2(500)  NULL,
    PRO_QTESTOCK NUMBER(4)  NULL,
    PRO_VISIBLE NUMBER(10,2)  NULL
,   CONSTRAINT PK_PRODUIT PRIMARY KEY (PRO_ID)  
   ) ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE PRODUIT
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_PRODUIT_CATEGORIE
     ON PRODUIT (CAT_ID ASC)
    ;

CREATE  INDEX I_FK_PRODUIT_PERSONNE
     ON PRODUIT (PER_ID ASC)
    ;

-- -----------------------------------------------------------------------------
--       TABLE : CATEGORIE
-- -----------------------------------------------------------------------------

CREATE TABLE CATEGORIE
   (
    CAT_ID NUMBER(5)  NOT NULL,
    CAT_NOM VARCHAR2(64)  NULL
,   CONSTRAINT PK_CATEGORIE PRIMARY KEY (CAT_ID)  
   ) ;

-- -----------------------------------------------------------------------------
--       TABLE : PARAMETRE
-- -----------------------------------------------------------------------------

CREATE TABLE PARAMETRE
   (
    NOMENTREPRISE VARCHAR2(50)  NOT NULL,
    NUMTELEPHONE VARCHAR2(25)  NOT NULL,
    ADRESSE VARCHAR2(50)  NOT NULL,
    TVA FLOAT(2)  NOT NULL,
    LOGO VARCHAR2(500)  NOT NULL
,   CONSTRAINT PK_PARAMETRE PRIMARY KEY (NOMENTREPRISE, TVA, ADRESSE, NUMTELEPHONE, LOGO)  
   ) ;

-- -----------------------------------------------------------------------------
--       TABLE : PRODUITCOMMANDER
-- -----------------------------------------------------------------------------

CREATE TABLE PRODUITCOMMANDER
   (
    PRO_ID NUMBER(5)  NOT NULL,
    COM_ID NUMBER(5)  NOT NULL,
    QTECOMMANDER NUMBER(2)  NULL
,   CONSTRAINT PK_PRODUITCOMMANDER PRIMARY KEY (PRO_ID, COM_ID)  
   ) ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE PRODUITCOMMANDER
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_PRODUITCOMMANDER_PRODUIT
     ON PRODUITCOMMANDER (PRO_ID ASC)
    ;

CREATE  INDEX I_FK_PRODUITCOMMANDER_COMMANDE
     ON PRODUITCOMMANDER (COM_ID ASC)
    ;


-- -----------------------------------------------------------------------------
--       CREATION DES REFERENCES DE TABLE
-- -----------------------------------------------------------------------------


ALTER TABLE PERSONNE ADD (
     CONSTRAINT FK_PERSONNE_ADRESSE
          FOREIGN KEY (ADR_ID_PERSONNE)
               REFERENCES ADRESSE (ADR_ID))   ;

ALTER TABLE FACTURE ADD (
     CONSTRAINT FK_FACTURE_COMMANDE
          FOREIGN KEY (COM_ID)
               REFERENCES COMMANDE (COM_ID))   ;

ALTER TABLE COMMANDE ADD (
     CONSTRAINT FK_COMMANDE_ADRESSE
          FOREIGN KEY (ADR_ID)
               REFERENCES ADRESSE (ADR_ID))   ;

ALTER TABLE PRODUIT ADD (
     CONSTRAINT FK_PRODUIT_CATEGORIE
          FOREIGN KEY (CAT_ID)
               REFERENCES CATEGORIE (CAT_ID))   ;

ALTER TABLE PRODUIT ADD (
     CONSTRAINT FK_PRODUIT_PERSONNE
          FOREIGN KEY (PER_ID)
               REFERENCES PERSONNE (PER_ID))   ;

ALTER TABLE PRODUITCOMMANDER ADD (
     CONSTRAINT FK_PRODUITCOMMANDER_PRODUIT
          FOREIGN KEY (PRO_ID)
               REFERENCES PRODUIT (PRO_ID))   ;

ALTER TABLE PRODUITCOMMANDER ADD (
     CONSTRAINT FK_PRODUITCOMMANDER_COMMANDE
          FOREIGN KEY (COM_ID)
               REFERENCES COMMANDE (COM_ID))   ;


-- -----------------------------------------------------------------------------
--                FIN DE GENERATION
-- -----------------------------------------------------------------------------

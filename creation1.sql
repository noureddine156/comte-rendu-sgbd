
DROP TABLE changement CASCADE CONSTRAINTS;
DROP TABLE user_telephone CASCADE CONSTRAINTS;


CREATE TABLE user_telephone (
    cin VARCHAR2(20),
    nom VARCHAR2(50),
    prenom VARCHAR2(50),
    numtel VARCHAR2(15) PRIMARY KEY,
    fourniseur VARCHAR2(50),
    solde NUMBER(10,2)
);


CREATE TABLE chargement (
    numtel VARCHAR2(15),
    code_chargement VARCHAR2(20) PRIMARY KEY,
    date_debut_chargement DATE,
    date_fin_chargement DATE,
    CONSTRAINT fk_numtel FOREIGN KEY (numtel)
        REFERENCES user_telephone(numtel)
        ON DELETE CASCADE
);

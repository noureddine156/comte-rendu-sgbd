CREATE TABLE communication (
    numTel VARCHAR2(15),
    date_communication DATE,
    heure_debut_communication VARCHAR2(8),
    heure_fin_communication VARCHAR2(8),
    CONSTRAINT pk_communication PRIMARY KEY (numTel, date_communication, heure_debut_communication),
    CONSTRAINT fk_comm_numtel FOREIGN KEY (numTel)
        REFERENCES user_telephone(numtel)
        ON DELETE CASCADE
);

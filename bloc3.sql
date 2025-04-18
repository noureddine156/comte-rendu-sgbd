SET SERVEROUTPUT ON;

-- Création de la procédure stockée
CREATE OR REPLACE PROCEDURE effectuer_nouveau_chargement (
    p_numTel IN VARCHAR2,
    p_date_debut_chargement IN DATE,
    p_date_fin_chargement IN DATE
) AS
    v_solde_actuel NUMBER(10,2);
    v_num_tel_exists INTEGER;

    -- Exception personnalisée
    ex_date_invalide EXCEPTION;
    ex_num_tel_incorrect EXCEPTION;

BEGIN
    -- Vérification si le numéro de téléphone existe dans la table user_telephone
    SELECT COUNT(*) INTO v_num_tel_exists 
    FROM user_telephone 
    WHERE numtel = p_numTel;

    IF v_num_tel_exists = 0 THEN
        RAISE ex_num_tel_incorrect;  -- Si le numéro n'existe pas, lancer une exception
    END IF;

    -- Vérification de la validité des dates (date de fin doit être après la date de début)
    IF p_date_fin_chargement < p_date_debut_chargement THEN
        RAISE ex_date_invalide;  -- Si la date de fin est avant la date de début, lancer une exception
    END IF;

    -- Insertion du nouveau chargement dans la table 'changement'
    INSERT INTO changement (numtel, code_chargement, date_debut_chargement, date_fin_chargement)
    VALUES (p_numTel, 'CHARG_' || TO_CHAR(SYSDATE, 'YYYYMMDDHH24MISS'), p_date_debut_chargement, p_date_fin_chargement);

    -- Mise à jour du solde dans la table 'user_telephone' après le chargement
    SELECT solde INTO v_solde_actuel
    FROM user_telephone
    WHERE numtel = p_numTel;

    -- Supposons que le solde est mis à jour avec un ajout de 10 Dinars pour chaque nouveau chargement
    UPDATE user_telephone
    SET solde = v_solde_actuel + 10 -- Crédit de 10 dinars pour chaque chargement
    WHERE numtel = p_numTel;

    -- Affichage de la mise à jour dans le log
    DBMS_OUTPUT.PUT_LINE('Chargement effectué avec succès pour le numéro ' || p_numTel);
    DBMS_OUTPUT.PUT_LINE('Solde mis à jour : ' || v_solde_actuel + 10 || ' DT');

EXCEPTION
    WHEN ex_date_invalide THEN
        DBMS_OUTPUT.PUT_LINE('Erreur : La date de fin est inférieure à la date de début.');
    WHEN ex_num_tel_incorrect THEN
        DBMS_OUTPUT.PUT_LINE('Erreur : Le numéro de téléphone ' || p_numTel || ' n''existe pas.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erreur inconnue : ' || SQLERRM);
END effectuer_nouveau_chargement;
/

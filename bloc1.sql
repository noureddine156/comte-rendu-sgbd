SET SERVEROUTPUT ON;

DECLARE
    v_numTel user_telephone.numtel%TYPE;
    v_date_comm DATE;
    v_heure_debut VARCHAR2(8);
    v_heure_fin VARCHAR2(8);
    v_duree_minutes NUMBER;
    v_cout NUMBER(10,2);
    v_solde_actuel NUMBER(10,2);

    -- Exception personnalisée
    ex_heure_invalide EXCEPTION;

BEGIN
    -- Saisie utilisateur
    v_numTel := '&NumTel';
    v_date_comm := TO_DATE('&DateComm', 'YYYY-MM-DD');
    v_heure_debut := '&HeureDebut'; -- format 'HH24:MI:SS'
    v_heure_fin := '&HeureFin';     -- format 'HH24:MI:SS'

    -- Vérification validité des heures
    IF TO_DATE(v_heure_fin, 'HH24:MI:SS') < TO_DATE(v_heure_debut, 'HH24:MI:SS') THEN
        RAISE ex_heure_invalide;
    END IF;

    -- Calcul durée et coût
    v_duree_minutes := (TO_DATE(v_heure_fin, 'HH24:MI:SS') - TO_DATE(v_heure_debut, 'HH24:MI:SS')) * 24 * 60;
    v_cout := v_duree_minutes * 0.25;

    -- Vérifier solde actuel
    SELECT solde INTO v_solde_actuel FROM user_telephone WHERE numtel = v_numTel;

    IF v_solde_actuel < v_cout THEN
        DBMS_OUTPUT.PUT_LINE('Solde insuffisant pour effectuer la communication.');
    ELSE
        -- Enregistrement dans la table communication
        INSERT INTO communication (numTel, date_communication, heure_debut_communication, heure_fin_communication)
        VALUES (v_numTel, v_date_comm, v_heure_debut, v_heure_fin);

        -- Mise à jour du solde
        UPDATE user_telephone
        SET solde = solde - v_cout
        WHERE numtel = v_numTel;

        DBMS_OUTPUT.PUT_LINE('Communication enregistrée avec succès.');
        DBMS_OUTPUT.PUT_LINE('Durée: ' || ROUND(v_duree_minutes, 2) || ' minutes');
        DBMS_OUTPUT.PUT_LINE('Coût: ' || ROUND(v_cout, 2) || ' DT');
    END IF;

-- Gestion de l’exception
EXCEPTION
    WHEN ex_heure_invalide THEN
        DBMS_OUTPUT.PUT_LINE('Erreur: Heure de fin inférieure à l''heure de début !');
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Erreur : Numéro introuvable.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erreur inconnue : ' || SQLERRM);
END;
/

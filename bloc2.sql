SET SERVEROUTPUT ON;

DECLARE
    -- Déclaration des variables
    v_fourniseur user_telephone.fourniseur%TYPE;
    v_mois NUMBER(2);
    v_revenu NUMBER(10,2);
    
    -- Curseur pour parcourir les communications et calculer le revenu par fournisseur et mois
    CURSOR c_revenu_fournisseur IS
        SELECT ut.fourniseur, 
               EXTRACT(MONTH FROM c.date_communication) AS mois, 
               SUM((TO_DATE(c.heure_fin_communication, 'HH24:MI:SS') - TO_DATE(c.heure_debut_communication, 'HH24:MI:SS')) * 24 * 60 * 0.25) AS revenu
        FROM communication c
        JOIN user_telephone ut ON c.numTel = ut.numtel
        GROUP BY ut.fourniseur, EXTRACT(MONTH FROM c.date_communication)
        ORDER BY ut.fourniseur, mois;

BEGIN
    -- Ouverture du curseur
    FOR rec IN c_revenu_fournisseur LOOP
        -- Afficher les résultats
        DBMS_OUTPUT.PUT_LINE('Fournisseur: ' || rec.fourniseur);
        DBMS_OUTPUT.PUT_LINE('Mois: ' || rec.mois);
        DBMS_OUTPUT.PUT_LINE('Revenu: ' || ROUND(rec.revenu, 2) || ' DT');
        DBMS_OUTPUT.PUT_LINE('------------------------------');
    END LOOP;
    
END;
/

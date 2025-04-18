SET SERVEROUTPUT ON;

-- Création de la procédure stockée
CREATE OR REPLACE PROCEDURE invertisemnt AS
    CURSOR c_clients IS
        SELECT nom, prenom, numtel, solde
        FROM user_telephone
        WHERE solde < 0; -- Sélectionner uniquement les utilisateurs avec un solde négatif

BEGIN
    -- Parcours du curseur pour chaque client avec un solde négatif
    FOR client IN c_clients LOOP
        -- Affichage du message d'invitation pour chaque client
        DBMS_OUTPUT.PUT_LINE('Cher client ' || client.nom || ' ' || client.prenom || ', titulaire de numéro de téléphone ' || client.numtel || ', il faut charger votre crédit dans le bref délai.');
    END LOOP;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erreur inconnue : ' || SQLERRM);
END invertisemnt;
/

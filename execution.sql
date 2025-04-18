-- Activation de la sortie DBMS_OUTPUT
SET SERVEROUTPUT ON;

-- Exécution du script de création des tables
@ "C:\Users\dridi\OneDrive\Bureau\SGBD Semaine 1\creation1.sql";

-- Exécution du script d'insertion des données
@ "C:\Users\dridi\OneDrive\Bureau\SGBD Semaine 1\insertion.sql";

-- Exécution du script de création de la table communication
@ "C:\Users\dridi\OneDrive\Bureau\SGBD Semaine 1\creation2.sql";

-- Exécution du script de la procédure bloc1 (pour gérer les communications et calcul du coût)
@ "C:\Users\dridi\OneDrive\Bureau\SGBD Semaine 1\bloc1.sql";

-- Exécution du script de la procédure bloc2 (pour afficher les revenus par fournisseur et mois)
@ "C:\Users\dridi\OneDrive\Bureau\SGBD Semaine 1\bloc2.sql";

-- Exécution du script de la procédure bloc3 (pour effectuer un nouveau chargement)
@ "C:\Users\dridi\OneDrive\Bureau\SGBD Semaine 1\bloc3.sql";

-- Exécution du script de la procédure bloc4 (pour afficher un message d'invitation pour les soldes négatifs)
@ "C:\Users\dridi\OneDrive\Bureau\SGBD Semaine 1\block4.sql";

-- Si tout s'est bien passé, afficher un message
DBMS_OUTPUT.PUT_LINE('Tous les scripts ont été exécutés avec succès.');


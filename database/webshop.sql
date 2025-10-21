-- ============================================================
-- ACTIVATION DES CLÉS ÉTRANGÈRES
-- ============================================================
PRAGMA foreign_keys = ON;
 
-- ============================================================
-- TABLE : utilisateur
-- ============================================================
CREATE TABLE utilisateur (
    idutilisateur INTEGER PRIMARY KEY AUTOINCREMENT,
    nomutilisateur TEXT NOT NULL,
    prenomutilisateur TEXT NOT NULL,
    emailutilisateur TEXT NOT NULL UNIQUE,
    motdepasseutilisateur TEXT NOT NULL,
    adresseutilisateur TEXT
);
 
-- ============================================================
-- TABLE : contact
-- ============================================================
CREATE TABLE contact (
    idcontact INTEGER PRIMARY KEY AUTOINCREMENT,
    sujetcontact TEXT NOT NULL,
    messagecontact TEXT NOT NULL,
    dateenvoie TEXT DEFAULT (datetime('now')),
    idutilisateur INTEGER NOT NULL,
    FOREIGN KEY (idutilisateur) REFERENCES utilisateur(idutilisateur)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
 
-- ============================================================
-- TABLE : produit
-- ============================================================
CREATE TABLE produit (
    referenceprod INTEGER PRIMARY KEY AUTOINCREMENT,
    imageprod DECIMAL(10,2),                -- Ajout de l'image avant le nom
    nomprod TEXT NOT NULL,
    prixprod REAL NOT NULL CHECK (prixprod >= 0),
    tailleprod TEXT,
    couleurprod TEXT,
    categorieprod TEXT,
    descriptionprod TEXT,
    descriptionsupprod TEXT,
    informationsupprod TEXT,
    avisprod TEXT,
    dateajoutprod TEXT DEFAULT (datetime('now'))
);
 
-- ============================================================
-- TABLE : paiement
-- ============================================================
CREATE TABLE paiement (
    idpaiement INTEGER PRIMARY KEY AUTOINCREMENT,
    totalpaiement REAL NOT NULL CHECK (totalpaiement >= 0),
    datepaiement TEXT DEFAULT (datetime('now')),
    moyenpaiement TEXT,
    idutilisateur INTEGER NOT NULL,
    FOREIGN KEY (idutilisateur) REFERENCES utilisateur(idutilisateur)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
 
-- ============================================================
-- TABLE D’ASSOCIATION : paiement_produit
-- ============================================================
CREATE TABLE paiement_produit (
    idpaiement INTEGER NOT NULL,
    referenceprod INTEGER NOT NULL,
    quantite INTEGER DEFAULT 1 CHECK (quantite > 0),
    PRIMARY KEY (idpaiement, referenceprod),
    FOREIGN KEY (idpaiement) REFERENCES paiement(idpaiement)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (referenceprod) REFERENCES produit(referenceprod)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
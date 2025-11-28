-- ============================================================
-- TABLE : utilisateur
-- ============================================================
CREATE TABLE utilisateur (
    idutilisateur INT AUTO_INCREMENT PRIMARY KEY,
    nomutilisateur VARCHAR(100) NOT NULL,
    prenomutilisateur VARCHAR(100) NOT NULL,
    emailutilisateur VARCHAR(255) NOT NULL UNIQUE,
    motdepasseutilisateur VARCHAR(255) NOT NULL,
    adresseutilisateur TEXT
) ENGINE=InnoDB;

-- ============================================================
-- TABLE : contact
-- ============================================================
CREATE TABLE contact (
    idcontact INT AUTO_INCREMENT PRIMARY KEY,
    sujetcontact VARCHAR(255) NOT NULL,
    messagecontact TEXT NOT NULL,
    dateenvoie DATETIME DEFAULT CURRENT_TIMESTAMP,
    idutilisateur INT NOT NULL,
    FOREIGN KEY (idutilisateur) REFERENCES utilisateur(idutilisateur)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- ============================================================
-- TABLE : produit
-- ============================================================
CREATE TABLE produit (
    referenceprod INT AUTO_INCREMENT PRIMARY KEY,
    imageprod VARCHAR(255),               -- chemin ou URL de l'image
    nomprod VARCHAR(255) NOT NULL,
    prixprod DECIMAL(10,2) NOT NULL CHECK (prixprod >= 0),
    tailleprod VARCHAR(50),
    couleurprod VARCHAR(50),
    categorieprod VARCHAR(100),
    descriptionprod TEXT,
    descriptionsupprod TEXT,
    informationsupprod TEXT,
    avisprod TEXT,
    dateajoutprod DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- ============================================================
-- TABLE : paiement
-- ============================================================
CREATE TABLE paiement (
    idpaiement INT AUTO_INCREMENT PRIMARY KEY,
    totalpaiement DECIMAL(10,2) NOT NULL CHECK (totalpaiement >= 0),
    datepaiement DATETIME DEFAULT CURRENT_TIMESTAMP,
    moyenpaiement VARCHAR(50),
    idutilisateur INT NOT NULL,
    FOREIGN KEY (idutilisateur) REFERENCES utilisateur(idutilisateur)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- ============================================================
-- TABLE D’ASSOCIATION : paiement_produit
-- ============================================================
CREATE TABLE paiement_produit (
    idpaiement INT NOT NULL,
    referenceprod INT NOT NULL,
    quantite INT DEFAULT 1 CHECK (quantite > 0),
    PRIMARY KEY (idpaiement, referenceprod),
    FOREIGN KEY (idpaiement) REFERENCES paiement(idpaiement)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (referenceprod) REFERENCES produit(referenceprod)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;

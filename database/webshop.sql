-- ============================================================
-- BASE DE DONNÉES : webshop
-- ============================================================
CREATE DATABASE IF NOT EXISTS webshop CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE webshop;

-- ============================================================
-- TABLE : utilisateur
-- ============================================================
CREATE TABLE IF NOT EXISTS utilisateur (
    idutilisateur INT AUTO_INCREMENT PRIMARY KEY,
    nomutilisateur VARCHAR(100) NOT NULL,
    prenomutilisateur VARCHAR(100) NOT NULL,
    emailutilisateur VARCHAR(150) NOT NULL UNIQUE,
    motdepasseutilisateur VARCHAR(255) NOT NULL,
    adresseutilisateur VARCHAR(255),
    villeutilisateur VARCHAR(100),
    codepostalutilisateur VARCHAR(20),
    paysutilisateur VARCHAR(100) DEFAULT 'Mauritius',
    telephoneutilisateur VARCHAR(20)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
-- TABLE : contact
-- ============================================================
CREATE TABLE IF NOT EXISTS contact (
    idcontact INT AUTO_INCREMENT PRIMARY KEY,
    sujetcontact VARCHAR(255) NOT NULL,
    messagecontact TEXT NOT NULL,
    dateenvoie DATETIME DEFAULT CURRENT_TIMESTAMP,
    idutilisateur INT NOT NULL,
    FOREIGN KEY (idutilisateur) REFERENCES utilisateur(idutilisateur)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
-- TABLE : produit
-- ============================================================
CREATE TABLE IF NOT EXISTS produit (
    referenceprod INT AUTO_INCREMENT PRIMARY KEY,
    imageprod VARCHAR(255),   -- URL ou chemin de l'image
    nomprod VARCHAR(150) NOT NULL,
    prixprod DECIMAL(10,2) NOT NULL CHECK (prixprod >= 0),
    tailleprod VARCHAR(50),
    couleurprod VARCHAR(50),
    categorieprod VARCHAR(100),
    descriptionprod TEXT,
    descriptionsupprod TEXT,
    informationsupprod TEXT,
    avisprod TEXT,
    dateajoutprod DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
-- TABLE : paiement
-- ============================================================
CREATE TABLE IF NOT EXISTS paiement (
    idpaiement INT AUTO_INCREMENT PRIMARY KEY,
    totalpaiement DECIMAL(10,2) NOT NULL CHECK (totalpaiement >= 0),
    datepaiement DATETIME DEFAULT CURRENT_TIMESTAMP,
    moyenpaiement VARCHAR(50),
    idutilisateur INT NOT NULL,
    FOREIGN KEY (idutilisateur) REFERENCES utilisateur(idutilisateur)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
-- TABLE D’ASSOCIATION : paiement_produit
-- ============================================================
CREATE TABLE IF NOT EXISTS paiement_produit (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

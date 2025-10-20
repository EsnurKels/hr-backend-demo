/*
  Warnings:

  - Made the column `firstName` on table `Candidate` required. This step will fail if there are existing NULL values in that column.
  - Made the column `lastName` on table `Candidate` required. This step will fail if there are existing NULL values in that column.

*/
-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Candidate" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "firstName" TEXT NOT NULL,
    "lastName" TEXT NOT NULL,
    "phone" TEXT,
    "email" TEXT NOT NULL,
    "github" TEXT,
    "linkedin" TEXT,
    "educationLevel" TEXT,
    "schoolName" TEXT,
    "gpa" REAL,
    "about" TEXT,
    "cvPath" TEXT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO "new_Candidate" ("about", "cvPath", "educationLevel", "email", "firstName", "github", "gpa", "id", "lastName", "linkedin", "phone", "schoolName") SELECT "about", "cvPath", "educationLevel", "email", "firstName", "github", "gpa", "id", "lastName", "linkedin", "phone", "schoolName" FROM "Candidate";
DROP TABLE "Candidate";
ALTER TABLE "new_Candidate" RENAME TO "Candidate";
CREATE UNIQUE INDEX "Candidate_email_key" ON "Candidate"("email");
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;

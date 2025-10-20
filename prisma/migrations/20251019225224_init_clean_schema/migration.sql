/*
  Warnings:

  - You are about to drop the column `name` on the `Candidate` table. All the data in the column will be lost.

*/
-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Candidate" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "firstName" TEXT,
    "lastName" TEXT,
    "phone" TEXT,
    "email" TEXT NOT NULL,
    "github" TEXT,
    "linkedin" TEXT,
    "educationLevel" TEXT,
    "schoolName" TEXT,
    "gpa" REAL,
    "about" TEXT,
    "cvPath" TEXT
);
INSERT INTO "new_Candidate" ("about", "cvPath", "educationLevel", "email", "firstName", "github", "gpa", "id", "lastName", "linkedin", "phone", "schoolName") SELECT "about", "cvPath", "educationLevel", "email", "firstName", "github", "gpa", "id", "lastName", "linkedin", "phone", "schoolName" FROM "Candidate";
DROP TABLE "Candidate";
ALTER TABLE "new_Candidate" RENAME TO "Candidate";
CREATE UNIQUE INDEX "Candidate_email_key" ON "Candidate"("email");
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;

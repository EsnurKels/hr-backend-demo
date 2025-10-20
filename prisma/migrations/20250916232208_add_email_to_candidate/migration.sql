/*
  Warnings:

  - You are about to drop the column `createdAt` on the `Candidate` table. All the data in the column will be lost.
  - You are about to drop the column `skills` on the `Candidate` table. All the data in the column will be lost.
  - You are about to drop the column `yearsExp` on the `Candidate` table. All the data in the column will be lost.
  - Added the required column `email` to the `Candidate` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Candidate" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL
);
INSERT INTO "new_Candidate" ("id", "name") SELECT "id", "name" FROM "Candidate";
DROP TABLE "Candidate";
ALTER TABLE "new_Candidate" RENAME TO "Candidate";
CREATE UNIQUE INDEX "Candidate_email_key" ON "Candidate"("email");
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;

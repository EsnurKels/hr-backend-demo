const prisma = require('../prismaClient');

async function main() {
  await prisma.candidate.createMany({
    data: [
      { name: "Alice", email: "alice@example.com" },
      { name: "Bob", email: "bob@example.com" }
    ]
  });
}

main()
  .then(() => console.log("Seed complete"))
  .catch(e => console.error(e))
  .finally(async () => await prisma.$disconnect());

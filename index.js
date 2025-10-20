const express = require("express");
const cors = require("cors");
const multer = require("multer");
const path = require("path");
const prisma = require('./prismaClient');

const app = express();

//Middleware
app.use(cors());
app.use(express.json());

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, path.join(__dirname, "uploads"));
  },
  filename: (req, file, cb) => {
    const ext = path.extname(file.originalname); // .pdf
    const uniqueName = Date.now() + "-" + Math.round(Math.random() * 1e9) + ext;
    cb(null, uniqueName);
  },
});

const upload = multer({ storage });


app.post("/upload-cv/:id", upload.single("cv"), async (req, res) => {
  const {id} = req.params;
  const file = req.file;

  if(!file) return res.status(400).json({error : " Dosya yüklenmedi."});

  const updated = await prisma.candidate.update({
    where: { id: Number(id) },
    data: { cvPath: file.filename },
  });

  res.json({message: "Cv yüklendi.", candidate: updated})
})

app.use("/uploads", express.static(path.join(__dirname, "uploads")));

app.get("/candidates", async (req, res) => {
  try{
    const rows = await prisma.candidate.findMany();
    res.json(rows);
  } catch(error) {
    console.error("Veri alınırken hata:", error);
    res.status(500).json({error: "Sunucu hatası"});
  }

})

app.post("/candidates", async (req, res) => {
  try {
    const {
      firstName,
      lastName,
      phone,
      email,
      github,
      linkedin,
      educationLevel,
      schoolName,
      gpa,
      about,
    } = req.body;
    const newCandidate = await prisma.candidate.create({
      data: { 
        firstName,
        lastName, 
        phone, 
        email, 
        github, 
        linkedin, 
        educationLevel, 
        schoolName, 
        gpa: gpa ? parseFloat(gpa) : null, 
        about 
      },
    });
    
    res.json(newCandidate);
  } catch (error) {
    console.error("Aday ekleme hatası:", error);
    res.status(500).json({ error: "Aday eklenemedi" });
  }
});


app.listen(3000, () => {
    console.log("Sunucu 3000 portunda çalışıyor...");
    
})

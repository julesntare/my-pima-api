import express, { json } from "express";
const app = express();
import usersRouter from "./routes/users.routes.mjs";
const PORT = process.env.PORT || 6000;

app.use(json());

app.get("/api", (req, res) => {
  res.send("Hello, My PIMA API Service!");
});

app.use('/api/users', usersRouter);

app.listen(PORT, () => {
  console.log(`Server listening on port ${PORT}`);
});

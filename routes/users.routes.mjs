import { Router } from "express";
import User from "../models/users.model.mjs";
const router = Router();

// GET /users
router.get("/", async (req, res) => {
  try {
    const users = await User.findAll();
    res.json(users);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Server error" });
  }
});

export default router;

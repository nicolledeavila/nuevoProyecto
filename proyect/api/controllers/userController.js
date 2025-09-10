const User = require("../models/userModel");

exports.registerUser = (req, res) => {
  const { name, email, password } = req.body;

  if (!name || !email || !password) {
    return res.status(400).json({ error: "Todos los campos son requeridos" });
  }

  const newUser = { id: Date.now(), name, email, password };
  const savedUser = User.create(newUser);

  return res.status(201).json(savedUser);
};

exports.getUsers = (req, res) => {
  res.json(User.getAll());
};

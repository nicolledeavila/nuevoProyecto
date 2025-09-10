let users = [];

module.exports = {
  create(user) {
    users.push(user);
    return user;
  },
  getAll() {
    return users;
  }
};

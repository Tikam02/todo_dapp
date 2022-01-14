const TodoList = artifacts.require("TodoList"); // Enter your Contract Name not File name

module.exports = function(deployer) {
  deployer.deploy(TodoList);
};
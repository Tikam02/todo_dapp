pragma solidity ^0.5.0;

contract TodoList {
  uint public taskCount = 0;

  struct Task {
    uint id;
    string content;
    bool completed;
  }

  mapping(uint => Task) public tasks;


  constructor() public {
    createTask("Check out dappuniversity.com");
  }

  function createTask(string memory _content) public {
    taskCount ++;
    tasks[taskCount] = Task(taskCount, _content, false);
  }

}


// Here taskCount is a special kind of variable called a "state variable".
// Any data that we store inside this state variable is written to storage on the blockchain. It changes the smart contract's state, and has scope within the entire smart contract, as opposed to local variables which only have scope inside of functions. We can set a default value



// Now, we can create a way to access the value of this state variable outside of the contract. We can do this with a special modifier keyword called public in Solidity. When we do this, Solidity will magically create a taskCount() function so that we can access this variable's value outside of the 



// uint id - this is the unique identifier for the struct. It will have an id, just like a traditional database record. Note, we declare the data type for this identifiers as a uint, which stands for "unsigned integer". This simply means that it is a non-negative integer. It has no "sign", i.e. a - or + sign, in front of it, implying that it is always positive.
// string content - this is the text of the task in the todo list contained in a string.
// bool completed - this is the checkbox status of the todo list, which is true/false. If it is true, the task will be "completed" or checked off from the todo list.



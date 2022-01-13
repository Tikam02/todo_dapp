# todo_dapp
DAPP Todo 



********

#### Smart Contract
- Smart contract in thi D-App will be responsible for fetching all of the tasks in our todo list from the blockchain, adding new tasks, and completing tasks.

- Smart contracts are written in a programming language called Solidity, which looks a lot like JavaScript. All of the code in the smart contract is immutable, or unchangeable. Once we deploy the smart contract to the blockchain, we won't be able to change or update any of the code. This is a design feature that ensures that the code is trustless and secure. I often compare smart contracts to microservices on the web. They act as an interface for reading and writing data from the blockchain, as well as executing business logic. They're publicly accessible, meaning anyone with access to the blockchian can access their interface.



#### How Blockchain Todo List Works
Let's recap to understand how the application will work that we'll build in this tutorial. We'll create a client side application for the todo list that will talk directly to the blockchain. We'll use the Ethereum blockchain in this tutorial, which we can access by connecting our client side application to a single Ethereum node. We'll write a smart contract in Solidity that powers the todo list, and we'll deploy it to the Ethereum blockchain. We'll also connect to the blockchain network with our personal account using an Ethereum wallet in order to interact with the todo list application.



Ganache Personal Blockchain
The dependency is a personal blockchain, which is a local development blockchain that can be used to mimic the behavior of a public blockchain. I recommend using Ganache as your personal blockchain for Ethereum development. It will allow you to deploy smart contracts, develop applications, and run tests. It is available on Windows, Mac, and Linux as as a desktop application and a command line tool!


Truffle Framework
Now let's install the Truffle Framework, which provides a suite of tools for developing Ethereum smart contacts with the Solidity programming language.


Here is an overview of all the functionality we'll get with the Truffle Framework:

- Smart Contract Management - write smart contracts with the Solidity programming language and compile them down to bytecode that be run on the Ethereum Virtal Machine (EVM).
- Automated Testing - write tests against your smart contracts to ensure that they behave the way you want them to. These tests can be written in JavaScript or Solidity, and can be run against any network configured by Truffle, including public blockchain networks.
- Deployment & Migrations - write scripts to migrate and deploy smart contracts to any public Ethereum blockchain network.
- Network Management - connect to any public Ethereum blockchain network, as well as any personal blockchain network you might use for development purposes.
- Development Console - interact with smart contracts inside a JavaScript runtime environment with the Truffle Console. You can connect to any blockchain network that you've specified within your network configuration to do this.
- Script Runner - write custom scripts that can run against a public blockchain network with JavaScript. You can write any arbitrary code inside this file and run it within your project.
- Client Side Development - configure your truffle project to host client side applications that talk to your smart contracts deployed to the blockchain.


File Directories:
- contracts directory: this is where all smart contacts live. We already have a Migration contract that handles our migrations to the blockchain.
- migrations directory: this is where all of the migration files live. These migrations are similar to other web development frameworks that require migrations to change the state of a database. Whenever we deploy smart contracts to the blockchain, we are updating the blockchain's state, and therefore need a migration.
- node_modules directory: this is the home of all of our Node dependencies we just installed.
- test directory: this is where we'll write our tests for our smart contract.
- truffle-config.js file: this is the main configuration file for our Truffle project, where we'll handle things like network configuration.





Comiple contract with 

``` 
truffle compile
```

check the compilation success build/contracts/TodoList.json file 


`./build/contracts/TodoList.json`. This file is the smart contract ABI file, which stands for "Abstract Binary Interface". This file has many responsibilities, but two that I will highlight here:

- It contains the compiled bytecode version of the Solidity smart contract code that can be run on a the Ethereum Virtual Machine (EVM), i.e., an Ethereum Node.
- It contains a JSON representation of the smart contract functions that can be exposed to external clients, like client-side JavaScript applications.



To talk to the smart contract on the personal blockchain network inside the Truffle console, we must do a few things:

- Update our project's configuration file to specify the personal blockchain network we want to connect to (Ganache).
- Create a migration script that tells Truffle how to deploy the smart contract to the personal blockchain network.
- Run the newly created migration script, deploying the smart contract to the personal blockchain network.




create a migration script inside the migrations directory to deploy the smart contract to the personal blockchain network. From your project root, create a new file from the command line like this:

```
$ touch migrations/2_deploy_contracts.js
```

2_deploy_contracts.js 

Any time we create a new smart contract, we are updating the state of the blockchain. Remember, I said that a blockchain fundamentally is a database. Hence, whenever we permanently change it, we must migrate it from one state to another. This is very similar to a database migration that you might have performed in other web application development frameworks.

Notice that we number all of our files inside the migrations directory with numbers so that Truffle knows which order to execute them in. Inside this newly created migration file, you can use this code to deploy the smart contract:


```
var TodoList = artifacts.require("./TodoList.sol");

module.exports = function(deployer) {
  deployer.deploy(TodoList);
};
```


**************

TodoList.sol

Solidity allows you to define your own data types with structs. We can model any arbitrary data with this powerful feature. We'll use a struct to model the task for our todo list like this:


```
pragma solidity ^0.5.0;

contract TodoList {
  uint public taskCount = 0;

  struct Task {
    uint id;
    string content;
    bool completed;
  }
}
```

Now that we've modeled a task, we need a place to put all of the tasks in the todo list! We want to put them in storage on the blockchain so that the state of the smart contract will be persistent. We can access the blockchain's storage with with a state variable, just like we did with taskCount. We'll create a tasks state variable. It will use a special kind of Solidity data structure called a mapping like this:

```
pragma solidity ^0.5.0;

contract TodoList {
  uint public taskCount = 0;

  struct Task {
    uint id;
    string content;
    bool completed;
  }

  mapping(uint => Task) public tasks;
}
```

A mapping in Solidity is a lot like an associative array or a hash in other programming languages. It creates key-value pairs that get stored on the blockchain. We'll use a unique id as the key. The value will be the task it self. This will allow us to look up any task by id!

Now let's create a function for creating tasks. This will allow us to add new tasks to the todo list by default so that we can list them out in the console.

```
  function createTask(string memory _content) public {
    taskCount ++;
    tasks[taskCount] = Task(taskCount, _content, false);
```


- First, we create the function with the function keyword, and give it a name createTask()
- We allow the function to accept one argument called _content, which will be the text for the task. We specify that this argument will be of string data type, and that it will persist in memory
- We set the function visibility to public so that it can be called outside of the smart contract, like in the console, or from the client side for example
- Inside the function, we create an id for the new task. We simply take the existing taskCount and increment it by 1.
- Now we create a new task struct by calling Task(taskCount, _content, false); and passing in the values for the new task.
- Next, we store the new task on the blockchain by adding it to the tasks mapping like this: task[taskCount] = ....


Now we want to add one task to the todo list whenever the smart contract is deployed to the blockchain so that it will have a default task that we can inspect in the console. We can do this by calling the createTask() function inside of the smart contract's constructor function like this:


```
    contract TodoList {
      // ....

      constructor() public {
        createTask("Check out dappuniversity.com");
      }

      // ....

    }
```

We create the constructor function with the constructor keyword as you can see above. This function will get run only once, whenever the contract is initialized, i.e., deployed to the blockchain. Inside of this function, we have created one new default task with the string content "Check out dappuniversity.com".
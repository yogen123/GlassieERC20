// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


interface ERC20Interface{

    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
   // function decimals() external view returns (uint8);
    function totalSupply() external view returns (uint256);
    function balanceOf(address _owner) external view returns (uint256 balance);
    function transfer(address _to, uint256 _value) external returns (bool success);
    function transferFrom(address _from, address _to, uint256 _value) external returns (bool success);
    function approve(address _spender, uint256 _value) external returns (bool success);
    function allowance(address _owner, address _spender) external view returns (uint256 remaining);

    event Transfer(address indexed sender, address to, uint amount);
    event Approve(address  indexed owner, address indexed spender, uint amount);

}

contract Glassie is ERC20Interface{

    string public override name = "Glassie";
    string public override symbol = "GLSS";
    uint256 public override totalSupply;

    address public founder;
    mapping(address => uint) public balances;   

    mapping(address => mapping(address=>uint)) allowed;



    constructor(){
        totalSupply = 100000;
        founder = msg.sender;
        balances[founder]=totalSupply;
    }

    // function name()public pure override returns(string memory){
    //     return "Glassie";

    // }
    // function symbol() public pure override returns (string memory){
    //     return "GLSS";
    // }
    // function decimals() public pure override returns (uint8){
    //     return 1;
    // }
    // function totalSupply() public pure override returns (uint256){
    //     return 100000;
    // }

    function balanceOf(address _owner) public override view returns (uint256 balance){
        return balances[_owner];

    }


    function transfer(address _to, uint256 _value) public override returns(bool){
        require(balances[msg.sender] >=  _value);
        balances[_to] += _value;

        emit Transfer(msg.sender, _to, _value);

        return true;
    }


    function allowance(address _owner, address _spender) public override view returns (uint256 remaining){
        return allowed[_owner][_spender];

    }
    function approve(address _spender, uint256 _value) public override returns (bool success){
        require(balances[msg.sender] >= _value);
        require(_value >0);

        allowed[msg.sender][_spender]= _value;

        emit Approve(msg.sender, _spender, _value);

        return true;
    }
    function transferFrom(address _from, address _to, uint256 _value) public override returns (bool success){
        require(allowed[_from][_to]>= _value);
        require(balances[_from] >= _value);

        balances[_from] -= _value;
        balances[_to] += _value;
        allowed[_from][_to] -= _value;

        return true;

    }









}
// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";


contract KeringEvo is ERC721Enumerable, Ownable{  
  using Strings for uint256;

  string public baseURI;
  string public baseExtension = ".json";
  uint256 public maxSupply = 2000;

  address public moderateur1 = 0x36C2B714De2cBbBFd01499E9e53699f87d5cd6a7;
  address public moderateur2 = 0x36C2B714De2cBbBFd01499E9e53699f87d5cd6a7;
  address public moderateur3 = 0x36C2B714De2cBbBFd01499E9e53699f87d5cd6a7;
  address public moderateur4 = 0x58837d141e8eCe9f443D8C0b280B637D08741e46;
  address public moderateur5 = 0xF2872E0c9D5D183A39CF31D0c2647197B06Fd11C;
  address public moderateur6 = 0x84ACF8F51505dD47a13A62b908a22b9483DE8F80;
  address public moderateur7 = 0x1d8eAD750d3Ae3b3d66fB57fB71C46c5d8dF6Aea;
  address public dev = 0x36C2B714De2cBbBFd01499E9e53699f87d5cd6a7;
  address public own = 0x36C2B714De2cBbBFd01499E9e53699f87d5cd6a7;

  uint level = 2 ; 
  mapping(uint => uint) public Goodpoints; // TokenID => Point Niveau
  mapping(uint => uint[]) public manytokens; // Point Niveau => Token ID
  
   

  constructor() ERC721("Kering Owl Gang", "KOG") {
    setBaseURI("ipfs://QmPGyP2nAdn312CfxzBEM1Ax1dPMvuK3dUdstEgnX6YoMh/");
    _transferOwnership(msg.sender); // Vrai propriétaire : 0x36C2B714De2cBbBFd01499E9e53699f87d5cd6a7
    mint(msg.sender, 150);
  }


    modifier onlyDev() {
      require(dev == msg.sender);
      _;
    }

     modifier onlyModerateur() {
     require(moderateur1 == msg.sender || moderateur2 == msg.sender || moderateur3 == msg.sender || moderateur4 == msg.sender
     || moderateur5 == msg.sender || moderateur6 == msg.sender || moderateur7 == msg.sender);
      _;
    }


  /// internal
  function _baseURI() internal view virtual override returns (string memory) {
     return baseURI;
  }

  

  //// public
  function mint(address _to, uint _mintAmount)  public onlyOwner {
    
    uint256 supply = totalSupply();
    require(supply + _mintAmount <= maxSupply);
    
    for (uint256 i = 1; i <= _mintAmount; i++) {
      
      Goodpoints[i] = 2;
      _safeMint(_to, supply + i);
    }

    
  }

  function addpointsofMint(uint base, uint max) public onlyOwner{

  for (uint256 tokenId = base; tokenId <= max ; tokenId++) {
      require(Goodpoints[tokenId]< 2);
      Goodpoints[tokenId] += 2;
    }


  }

 


  function walletOfOwner(address _owner)
    public
    view
    returns (uint256[] memory)
  {
    uint256 ownerTokenCount = balanceOf(_owner);
    uint256[] memory tokenIds = new uint256[](ownerTokenCount);
    for (uint256 i; i < ownerTokenCount; i++) {
      tokenIds[i] = tokenOfOwnerByIndex(_owner, i);
    }
    return tokenIds;
  }

  function tokenURI(uint256 tokenId) public view virtual override returns (string memory)
  {
    require( _exists(tokenId),"ERC721Metadata: URI query for nonexistent token");
    
  
    uint levels = Goodpoints[tokenId];
    string memory currentBaseURI = _baseURI();
    return bytes(currentBaseURI).length > 0
        ? string(abi.encodePacked(currentBaseURI, (levels).toString(), baseExtension))
        : "";
  }



  //// only owner

function addlevel(uint tokenId) public returns(bool){
    
    require (dev == msg.sender || moderateur1 == msg.sender || moderateur2 == msg.sender || moderateur3 == msg.sender || moderateur4 == msg.sender
     || moderateur5 == msg.sender || moderateur6 == msg.sender || moderateur7 == msg.sender || own == msg.sender );
       
       uint point = 1;
       require(Goodpoints[tokenId] < 11);
        Goodpoints[tokenId] += point;
        return true ; 
}

function addsLevel(uint[] memory tokenId, uint[] memory points) public returns(bool){
    require (dev == msg.sender || moderateur1 == msg.sender || moderateur2 == msg.sender || moderateur3 == msg.sender || moderateur4 == msg.sender
     || moderateur5 == msg.sender || moderateur6 == msg.sender || moderateur7 == msg.sender || own == msg.sender );
    require (tokenId.length == points.length);
    
    for (uint256 i = 0; i < tokenId.length; i++){ 
     require (points[i] < 12);
     require(Goodpoints[tokenId[i]] < 12);
     Goodpoints[tokenId[i]] += points[i];
    }
    
    return true;
}



function points(uint[] memory tokenId, uint points) public  returns(bool)  {
    require (dev == msg.sender || moderateur1 == msg.sender || moderateur2 == msg.sender || moderateur3 == msg.sender || moderateur4 == msg.sender
     || moderateur5 == msg.sender || moderateur6 == msg.sender || moderateur7 == msg.sender || own == msg.sender );
   
    for (uint256 i = 0; i < tokenId.length; i++){ 
     Goodpoints[tokenId[i]] = points;
    }
    
    return true;
}

function points11(uint[] memory tokenId) public  returns(bool){
    require (dev == msg.sender || moderateur1 == msg.sender || moderateur2 == msg.sender || moderateur3 == msg.sender || moderateur4 == msg.sender
     || moderateur5 == msg.sender || moderateur6 == msg.sender || moderateur7 == msg.sender || own == msg.sender );
   
    for (uint256 i = 0; i < tokenId.length; i++){ 
     Goodpoints[tokenId[i]] = 11;
    }
    
    return true;
}

function points10(uint[] memory tokenId) public  returns(bool){
    require (dev == msg.sender || moderateur1 == msg.sender || moderateur2 == msg.sender || moderateur3 == msg.sender || moderateur4 == msg.sender
     || moderateur5 == msg.sender || moderateur6 == msg.sender || moderateur7 == msg.sender || own == msg.sender );
   
    for (uint256 i = 0; i < tokenId.length; i++){ 
     Goodpoints[tokenId[i]] = 10;
    }
    
    return true;
}


function points9(uint[] memory tokenId) public  returns(bool){
    require (dev == msg.sender || moderateur1 == msg.sender || moderateur2 == msg.sender || moderateur3 == msg.sender || moderateur4 == msg.sender
     || moderateur5 == msg.sender || moderateur6 == msg.sender || moderateur7 == msg.sender || own == msg.sender );
   
    for (uint256 i = 0; i < tokenId.length; i++){ 
     Goodpoints[tokenId[i]] = 9;
    }
    
    return true;
}

function points8(uint[] memory tokenId) public  returns(bool){
    require (dev == msg.sender || moderateur1 == msg.sender || moderateur2 == msg.sender || moderateur3 == msg.sender || moderateur4 == msg.sender
     || moderateur5 == msg.sender || moderateur6 == msg.sender || moderateur7 == msg.sender || own == msg.sender );
   
    for (uint256 i = 0; i < tokenId.length; i++){ 
     Goodpoints[tokenId[i]] = 8;
    }
    
    return true;
}


function points7(uint[] memory tokenId) public  returns(bool){
    require (dev == msg.sender || moderateur1 == msg.sender || moderateur2 == msg.sender || moderateur3 == msg.sender || moderateur4 == msg.sender
     || moderateur5 == msg.sender || moderateur6 == msg.sender || moderateur7 == msg.sender || own == msg.sender );
   
    for (uint256 i = 0; i < tokenId.length; i++){ 
     Goodpoints[tokenId[i]] = 7;
    }
    
    return true;
}

function points6(uint[] memory tokenId) public  returns(bool){
    require (dev == msg.sender || moderateur1 == msg.sender || moderateur2 == msg.sender || moderateur3 == msg.sender || moderateur4 == msg.sender
     || moderateur5 == msg.sender || moderateur6 == msg.sender || moderateur7 == msg.sender || own == msg.sender );
   
    for (uint256 i = 0; i < tokenId.length; i++){ 
     Goodpoints[tokenId[i]] = 6;
    }
    
    return true;
}

function points5(uint[] memory tokenId) public  returns(bool){
    require (dev == msg.sender || moderateur1 == msg.sender || moderateur2 == msg.sender || moderateur3 == msg.sender || moderateur4 == msg.sender
     || moderateur5 == msg.sender || moderateur6 == msg.sender || moderateur7 == msg.sender || own == msg.sender );
   
    for (uint256 i = 0; i < tokenId.length; i++){ 
     Goodpoints[tokenId[i]] = 5;
    }
    
    return true;
}

function points4(uint[] memory tokenId) public  returns(bool){
    require (dev == msg.sender || moderateur1 == msg.sender || moderateur2 == msg.sender || moderateur3 == msg.sender || moderateur4 == msg.sender
     || moderateur5 == msg.sender || moderateur6 == msg.sender || moderateur7 == msg.sender || own == msg.sender );
   
    for (uint256 i = 0; i < tokenId.length; i++){ 
     Goodpoints[tokenId[i]] = 4;
    }
    
    return true;
}

function points3(uint[] memory tokenId) public  returns(bool){
    require (dev == msg.sender || moderateur1 == msg.sender || moderateur2 == msg.sender || moderateur3 == msg.sender || moderateur4 == msg.sender
     || moderateur5 == msg.sender || moderateur6 == msg.sender || moderateur7 == msg.sender || own == msg.sender );
   
    for (uint256 i = 0; i < tokenId.length; i++){ 
     Goodpoints[tokenId[i]] = 3;
    }
    
    return true;
}

function points2(uint[] memory tokenId) public  returns(bool){
    require (dev == msg.sender || moderateur1 == msg.sender || moderateur2 == msg.sender || moderateur3 == msg.sender || moderateur4 == msg.sender
     || moderateur5 == msg.sender || moderateur6 == msg.sender || moderateur7 == msg.sender || own == msg.sender );
   
    for (uint256 i = 0; i < tokenId.length; i++){ 
     Goodpoints[tokenId[i]] = 2;
    }
    
    return true;
}


    function setBaseURI(string memory _newBaseURI) public {
       require (dev == msg.sender || own == msg.sender);
        baseURI = _newBaseURI;
    }

    function setBaseExtension(string memory _newBaseExtension) public { // .json
        require (dev == msg.sender || own == msg.sender);
        baseExtension = _newBaseExtension;
    }

     function setMaxSupply(uint _maxSupply) public { 
        require (dev == msg.sender || own == msg.sender);
        maxSupply = _maxSupply;
    }


 function gift(address[] calldata addresses, uint[] memory tokenId) public returns(bool) {
      require (dev == msg.sender || own == msg.sender);  
      require(addresses.length > 0, "Need to gift at least 1 NFT");
        
        for (uint256 i = 0; i < addresses.length; i++) {        
          require( _exists(tokenId[i]),"Nonexistent token");
          safeTransferFrom(msg.sender, addresses[i], tokenId[i]);
        }

        return true;
    }
 
 function changemoderateur(address _moderateur1, address _moderateur2, address _moderateur3, address _moderateur4, address _moderateur5, 
      address _moderateur6, address _moderateur7) public  {
        
        require (dev == msg.sender || own == msg.sender);
        moderateur1 = _moderateur1;
        moderateur2 = _moderateur2;
        moderateur3 = _moderateur3;
        moderateur4 = _moderateur4;
        moderateur5 = _moderateur5;
        moderateur6 = _moderateur6;
        moderateur7 = _moderateur7;

 }

    function changeDev(address _dev) public onlyOwner returns(bool){

            dev = _dev;
            return true; 
    }

    function changeOwn(address _own) public onlyOwner returns(bool){

            own = _own;
            return true; 
    }
}

pragma solidity >=0.4.21 <0.6.0;

import "./RegistrationTrans.sol";

contract AccessOwner {
     uint public a;
     //uint public requiredlookupId=100;
 
    address datachain_address;
    struct details{
        uint _data_id;
        uint _owner_id;
        string _owner_name;
        string _owner_type;
    }
 
   RegistrationTrans public dc;
 
    constructor(address data) public {
        //Just create a new auxiliary contract. We will use it to check if the part or product really exist
        datachain_address=data;
        dc = RegistrationTrans(data);
    }
 
 
 
    function get_interactionId(uint lookup_id1)view public returns (bytes32,uint,uint,uint,uint,uint){
         uint b_id;
        uint d_id;
        uint o_id;
        uint flag;
        //string smartcontract_name;
        //address datachain_address;
        bytes32 interactionId;
        uint _timeStamp;
        (b_id,o_id,interactionId,_timeStamp,flag) = dc.lookups(lookup_id1);
     
        return (interactionId,b_id,d_id,o_id,_timeStamp,flag);
    }
 
 
 
    function get_lookupId(uint buyerid,uint dataid,uint selectedownerid,uint[] data_id1) public view returns (uint,uint,uint,uint[]){
        uint[] memory d_id;
        uint b_id;
        uint lookup_Id;
       // uint b;
        uint selected_id;
        //uint currentlookupId;
        //uint current_owner_id;
        uint _owner_id;
       // uint _owner_id1;
        bool val=false;
       
       
        //if(val==true){
            for(_owner_id=0 ;_owner_id< dc.get_lookupId() ;_owner_id++)
            {
                (b_id,selected_id,lookup_Id)=dc.verifylookups(_owner_id);
                d_id= dc.get_verifylookup_data_id(_owner_id);
                if(data_id1.length==d_id.length){
                for(uint j=0;j<data_id1.length;j++){
                   
                      if(data_id1[j]==d_id[j]){
                        val=true;
                    }else
                    {
                      val=false;
                      break;
                    }
                    }
                }

                if(val==true){
                    if(buyerid == b_id){
                            if(selectedownerid ==selected_id){
                                return (b_id,selected_id,lookup_Id,d_id);
                            }
                    }
                }
            }  
    }
   
    function check_lookupId(uint currentlookupId) public view returns (uint,uint,uint,uint){
        uint d_id;
        uint b_id;
        uint selected_id;
    (b_id,selected_id,currentlookupId)= dc.verifylookups(currentlookupId);
     return (d_id,b_id,selected_id,currentlookupId);
    }
    /*
     function get_data_hash(uint hhi,bytes32 interactionId ) public view returns (string){
     string data_hash;
     uint d_id;
    (data_hash)= dc.datas[d_id]._data_hash;
     return (data_hash);
    }
    */
} 

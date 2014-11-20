package hra.types
{
	import mx.formatters.DateFormatter;

	public class Registrace extends Object
	{
		[Bindable]
		public var username:String = "";
		public var password:String = "";
		public var password2:String = "";
		public var ticket:String = "";
				
		public var street:String = "";
		public var city:String = "";
		public var country:String = "";
		public var birthday:String = "";
		public var email:String = "";
		public var phone:String = "";

		public var odeslano:String = "";
		public var uid:String = "";
		public var key:String = "";
		
		public var agreement1:Date = null;
		public var agreement2:Date = null;
		public var agreement3:Date = null;
		
		public var credit:String = "0";
		public var fullname:String = "";
		
		
		public function Registrace(o:Object = null)
		{
			super();
			if (o == null) return;
			var dfo:DateFormatter = new DateFormatter;
			dfo.formatString="YYYY-MM-DD JJ:NN:SS";
			
			this.username =   o.username;   
			this.password =   o.password;   
			this.password2 =  o.password2;  
			this.ticket =     o.ticket;  
			this.fullname =   o.fullname;      
			this.street =     o.street;     
			this.city =       o.city;       
			this.country =    o.country;    
			this.birthday =   o.birthday;   
			this.email =      o.email;      
			this.phone =      o.phone;      
			this.odeslano =   o.odeslano;   
			this.uid =        o.uid;        
			this.key =        o.key;        
			this.agreement1 = (o.agreement1 != null)?(new Date(Date.parse(String(o.agreement1).replace(/\-/g, "/")))):null; 
			this.agreement2 = (o.agreement2 != null)?(new Date(Date.parse(String(o.agreement2).replace(/\-/g, "/")))):null; 
			this.agreement3 = (o.agreement3 != null)?(new Date(Date.parse(String(o.agreement3).replace(/\-/g, "/")))):null;
			this.credit = 	  o.credit;
		}
		
		
		public function agreementsAccepted():Boolean {
			return ((agreement1 != null) && (agreement2 != null) && (agreement3 != null));  
		}
		
	}
}
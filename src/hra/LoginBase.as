package hra
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import hra.types.Registrace;
	
	import spark.components.CheckBox;
	import spark.components.TabbedViewNavigator;
	import spark.components.TextInput;
	import spark.components.View;
	
	import views.betNewView;
	import views.betsView;
	import views.gameIntroView;
	import views.loginView;
	import views.regAcceptView;

	
		
	
	
	
	public class LoginBase extends View
	{
		
		public var txtUsername:TextInput;
		public var txtPassword:TextInput;
		public var txtPassword2:TextInput;
		public var txtFullname:TextInput;
		public var txtStreet:TextInput;
		public var txtCity:TextInput;
		public var txtCountry:TextInput;
		public var txtBirthday:TextInput;
		public var txtEmail:TextInput;
		public var txtPhone:TextInput;
				
		public var txtLoginUsername:TextInput;
		public var txtLoginPassword:TextInput;
		public var cbPermamentLogin:CheckBox;
		
		
		[Bindable]
		public var model:Model = Model.getInstance();
		
		[Bindable]
		public var oRegistarce:Registrace;
		
		public function LoginBase() {
			oRegistarce = new Registrace();
		}
		
		
		public function goRegister():void {

			if (txtUsername.text == "") {
				model.okno("Registrace", "Username nesmí být prázdné", true, false, false);
				return;
			}
			
			if (txtPassword.text == "") {
				model.okno("Registrace", "Username nesmí být prázdné", true, false, false);
				return;
			}
			
			if (txtPassword.text != txtPassword2.text) {
				model.okno("Registrace", "Heslo musí být stejné", true, false, false);
				return;
			}
			
			if (txtFullname.text == "") {
				model.okno("Registrace", "Jméno nesmí být prázdné", true, false, false);
				return;
			}
			
			if (txtStreet.text == "") {
				model.okno("Registrace", "Ulice nesmí být prázdné", true, false, false);
				return;
			}
			
			if (txtCity.text == "") {
				model.okno("Registrace", "Město nesmí být prázdné", true, false, false);
				return;
			}

			if (txtCountry.text == "") {
				model.okno("Registrace", "Země musí být uvedena", true, false, false);
				return;
			}

			if (txtBirthday.text == "") {
				model.okno("Registrace", "Vyplňte datum narození", true, false, false);
				return;
			}
			
			if (txtEmail.text == "") {
				model.okno("Registrace", "Vyplňte email", true, false, false);
				return;
			}

			var emailExpression:RegExp = /^[\w.-]+@\w[\w.-]+\.[\w.-]*[a-z][a-z]$/i;
			if (!txtEmail.text.match(emailExpression)) {
				model.okno("Registrace", "Uveďte platný email", true, false, false);
				return;
			}
			
			
			if (txtPhone.text == "") {
				model.okno("Registrace", "Vyplňte telefonní číslo", true, false, false);
				return;
			}
			
			
			model.okno("Registrace","Ukládám",false,false,true);
			
			var variables:URLVariables = new URLVariables();
			variables.username=txtUsername.text;
			variables.password=txtPassword.text;
			variables.password2=txtPassword2.text;
			variables.fullname=txtFullname.text;
			variables.street=txtStreet.text;
			variables.city=txtCity.text;
			variables.country=txtCountry.text;
			
			variables.birthday=txtBirthday.text;
			
			variables.email=txtEmail.text;
			variables.phone=txtPhone.text;
			model.apiCall("registerUser", variables, registraceHandler);
			
		}
	
		private function registraceHandler(res:Object):void
		{
			if (res.status != "ok" ) {
				model.okno('Chyba!', res.msg,true,false,false);
				return;
			}
			model.alertWindow.close();
			model.loginUser(res, false);
			trace("Registrace ulozena do CRX!");
			navigator.pushView(regAcceptView);			
		}
		
		
		public function goLogin():void {
			var variables:URLVariables = new URLVariables();
			variables.username=txtLoginUsername.text;
			variables.password=txtLoginPassword.text;			
			model.apiCall("login", variables, loginHandler);
		}

		private function loginHandler(res:Object):void
		{
			if (res.status != "ok" ) {
				model.okno('Chyba!', res.msg,true,false,false);
				if (!this.data) this.data = new Object(); 
				data.logged = false;
				return;
			}
			model.alertWindow.close();
			model.loginUser(res, cbPermamentLogin.selected);
			trace("Registrace ulozena do CRX!");

			// pro viewNavigator
			if (data && data.onloginview) {
				navigator.replaceView(data.onloginview, data.onlogindata);
				return;
			}
			
			// pro tabbedViewNavigator
			if (data && data.onLoginIndex) {
				TabbedViewNavigator(navigator.parentNavigator).selectedIndex = data.onLoginIndex;
				navigator.popView();
				return;
			}
			
			
//			navigator.popToFirstView();
//			data.logged = true;
			navigator.popView();
		}
		
		override public function createReturnObject():Object {
			if (data == null) {
				// neco musim vratit
				data = new Object();
				data.asd = 1;
			}
			return data;
		}
		
		
	}
}
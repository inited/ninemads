package hra
{
	import avm2.intrinsics.memory.mfence;
	
	import com.distriqt.extension.pushnotifications.PushNotifications;
	import com.distriqt.extension.pushnotifications.events.PushNotificationEvent;
	
	import components.popUpWindow;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestDefaults;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.utils.Timer;
	
	import hra.types.Registrace;
	
	import mx.collections.ArrayList;
	import mx.formatters.DateFormatter;
	
	import spark.components.TabbedViewNavigator;
	import spark.components.TabbedViewNavigatorApplication;
	import spark.components.ViewNavigator;
	import spark.events.PopUpEvent;
	import spark.managers.PersistenceManager;


	[Bindable]
	public class Model
	{
//		public var serverURL:String = "http://asaf:8888/";
		public var serverURL:String = "http://ninemads27.appspot.com/";
		public var develMode:Boolean = false;
		public var verzeApp:String = "0.0.36"; 
		
	
		// vsechno, co souvisi s uzivatelem
		public var logged:Boolean = false;
		public var fullName:String = "Pepa Přihlášeny";
		public var creditMsg:String = "234,- Kč";
		public var activeBets:int = 12;
		public var gameCreditMsg:String = "120";
		public var soundOn:Boolean = true;
		public var gameKey:String = "";
		public var gameMode:String = "";
		public var betUsername:String = "";
		public var betFullname:String = "";
		public var betAmount:String = "";
		public var betKey:String = "";
		public var questionSet:String = "1+2=3;2+3=5;3+4=7;4+2=6;5+3=8;6+3=9;7+1=8;8+1=9;9-8=1";
		
		public var alertWindow:popUpWindow = new popUpWindow();
		
		public var mNavigator:ViewNavigator;
		private var pManager:PersistenceManager = new PersistenceManager();
		public var mRegistrace:Registrace;
	
		private var app:TabbedViewNavigatorApplication;
		public var appDPI:Number = 0;
		public var appHeight:Number;
		public var appWidth:Number;

		// push notifikace		
		private const DEV_KEY : String = "a95cb5c9288dceac783021d52ed24107c45e48f0BndL53Ei3PQ5uK7LWqJNT1mb6aUE0KiH/cHQIeDcT2xGDoBiDhIEnOO7HfMc8RpyECrdJKhMopbk+O9Pecv3lw==";		
		private const GCM_SENDER_ID 	: String = "714817175453";
		private var pnRegId : String = null;
		private var pnRegFlag : Boolean = false;
		
		
		
		public var res:Static = new Static();
		
		[Embed(source="../sound/beep-07.mp3")]
		//[Bindable] //Not required. Just an example of using multiple meta tags.  
		public var soundShort:Class;
		[Embed(source="../sound/beep-01a.mp3")]
		//[Bindable] //Not required. Just an example of using multiple meta tags.  
		public var soundLong:Class;	
		
		private static var instance:Model;
	
		private var tmrUpdater : Timer;

		public var gameResults : ArrayList;		
		
		public function Model(access:SingletonEnforcer) {
			if (access==null) {
				throw new Error("Cannot instantiate Model");
			}
			instance=this;			
			pManager.load();
			var o:Object = pManager.getProperty("registrace");
			if (o == null) {
				mRegistrace = new Registrace();
			} else {
				reLoginUser(o, false);	
			}
			
			tmrUpdater = new Timer(10*1000);
			tmrUpdater.addEventListener(TimerEvent.TIMER, updateFromServer);
			tmrUpdater.start();			
			updateFromServer();
			
			PushNotifications.init( DEV_KEY );
//			if (PushNotifications.isSupported) {
				PushNotifications.service.addEventListener( PushNotificationEvent.REGISTER_SUCCESS, pn_registerSuccessHandler );
//				PushNotifications.service.addEventListener( PushNotificationEvent.UNREGISTERED, 	pn_unregisterSuccessHandler );
				PushNotifications.service.addEventListener( PushNotificationEvent.NOTIFICATION, 	pn_notificationHandler );
				PushNotifications.service.addEventListener( PushNotificationEvent.ERROR,			pn_errorHandler );				
				PushNotifications.service.register( GCM_SENDER_ID );				
//			} else {
//				trace("Push notification not supported");
//			}

			
		}
		
	
		public static function getInstance():Model {
			if (instance==null) {
				instance = new Model(new SingletonEnforcer() );
			}
			return instance;
		}

/*		
		public function setNavigator(vn:TabbedViewNavigator):void {
			mNavigator = vn;
		}	
*/		
		public function setApp(a:TabbedViewNavigatorApplication):void {
			app=a;
		}
		
		public function okno(titleText:String, messageText:String, OKButtonVisible:Boolean, CancelButtonVisible:Boolean, BusyIndicatorVisible:Boolean, onMyClose:Function = null):void
		{
//			var owner:DisplayObjectContainer = mNavigator.activeView;
			var owner:DisplayObjectContainer = app;
			alertWindow.open(owner, true);
			alertWindow.msg.text = messageText;
			alertWindow.tWindow.text = titleText;
			//alertWindow.btOK.addEventListener(MouseEvent.CLICK,neco);
			alertWindow.btCancel.visible = CancelButtonVisible;
			alertWindow.btCancel.includeInLayout = CancelButtonVisible;
			alertWindow.btOK.visible = OKButtonVisible;
			alertWindow.btOK.includeInLayout = OKButtonVisible;
			alertWindow.bi.visible = BusyIndicatorVisible;
			alertWindow.bi.includeInLayout = BusyIndicatorVisible;
			alertWindow.validateNow();
			alertWindow.x = owner.width/2 - alertWindow.width/2;
			alertWindow.y = owner.height/2 - alertWindow.height/2;
			if (onMyClose != null) alertWindow.addEventListener(PopUpEvent.CLOSE , function (e:Event):void {
				alertWindow.removeEventListener(PopUpEvent.CLOSE, arguments.callee);
				onMyClose(e);
			});
		}		
		
		public function ioErrorHandler(event:IOErrorEvent):void {
			trace("ioErrorHandler: " + event);
			//this.log.appendText("ioErrorHandler: " + event + "\n");
			alertWindow.close();
			okno('Chyba!','Problém s odesláním:\nJste připoje k síti?\nDetail:' + event,true,false,false);
		}		
		
		public function setCredit(s:String):void {
			creditMsg = s + " EUR";
		}
		
		public function loginUser(o:Object, permanent:Boolean):void {
			mRegistrace = new Registrace(o);
			logged = true;
			fullName = mRegistrace.fullname;
			setCredit(mRegistrace.credit);
			if (permanent) {
				pManager.setProperty("registrace", mRegistrace);
				pManager.save();
			}

			var variables:URLVariables = new URLVariables();
			variables.token=pnRegId;
			variables.username=mRegistrace.username;
			apiCall("pnRegister", variables, function(o:Object):void {});

		}
		
		public function reLoginUser(o:Object, permanent:Boolean):void {
			mRegistrace = new Registrace(o);
			var variables:URLVariables = new URLVariables();
			variables.username = mRegistrace.username;
			variables.ticket   = mRegistrace.ticket;
			apiCall("login", variables, gotRelogin, gotReloginError);
		}
		
		private function gotRelogin(res:Object):void
		{
			if (res.status != "ok" ) {
				gotReloginError(res);
				return;
			}
			loginUser(res, false);
			trace("Uspesne relogovan");
		}		
		
		private function gotReloginError(res:Object):void
		{
			trace("Relogin error");
			//TODO: co tady budu delat?
			
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		public function logoutUser():void {
			apiCall("logout",null,gotLogout,gotLogout);
		}
		
		public function gotLogout(res:Object):void {
			pManager.setProperty("registrace", null);
			pManager.save();
			mRegistrace = new Registrace();
			logged = false;
			fullName = "";
			setCredit("");
		}
		
		// ulozi informace o akceptovani podminek hry
		public function saveAcceptance():void {
			//TODO: zobrazit tocitko
			
			var dfo:DateFormatter = new DateFormatter;
			dfo.formatString="YYYY-MM-DD JJ:NN:SS";
			
			var urlRequest:URLRequest = new URLRequest(serverURL + "api/setAcceptance");
			urlRequest.method = URLRequestMethod.GET;
			
			var variables:URLVariables = new URLVariables();
			variables.agreement1 = (mRegistrace.agreement1 == null)?"null":dfo.format(mRegistrace.agreement1);
			variables.agreement2 = (mRegistrace.agreement2 == null)?"null":dfo.format(mRegistrace.agreement2);
			variables.agreement3 = (mRegistrace.agreement3 == null)?"null":dfo.format(mRegistrace.agreement3);
			
			urlRequest.data = variables;
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.BINARY;			
			loader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			loader.addEventListener(Event.COMPLETE, saveAcceptanceHandler);
			loader.load(urlRequest);	
		}
		
		private function saveAcceptanceHandler(event:Event):void
		{
			var res:Object = JSON.parse(event.target.data);
			if (res.status != "ok" ) {
				okno('Chyba!', res.msg,true,false,false);
				return;
			}
		}		
		
		public function apiCall(fce:String, variables:URLVariables, onOk:Function, onError:Function = null ):void
		{
			if ((fce != "getInfo") && app) {
				okno("Pracuji", "Pracuji", false, false, true);
			}
			
			var urlRequest:URLRequest = new URLRequest(serverURL + "api/" + fce);
			urlRequest.method = URLRequestMethod.GET;
			
			if (onError == null) onError = ioErrorHandler;
			
			if (variables == null) variables = new URLVariables();
			urlRequest.data = variables;
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.BINARY;			
			loader.addEventListener(IOErrorEvent.IO_ERROR, function (event:IOErrorEvent):void {
				if ((fce != "getInfo") && app) {
					alertWindow.close();
				}
				try {
					var res:Object = JSON.parse(event.target.data);
					if (res.code == "not logged" ) {
						trace("resit prihlasnei");
						logged=false;
						return;
					}
				} catch (e:Error) {
					trace("chyba pri parsovani chyby:" + e);
				}
			});
			loader.addEventListener(Event.COMPLETE, function (event:Event):void {
				if ((fce != "getInfo") && app) {
					alertWindow.close();
				}
				var res:Object = JSON.parse(event.target.data);
				onOk(res);
			});
			loader.load(urlRequest);	
		}
		
		public function updateFromServer(evt:TimerEvent = null):void {
			var v:URLVariables = new URLVariables();
			if (mRegistrace.username != "") {
				v.username = mRegistrace.username;
			}
			apiCall("getInfo", v, gotUpdateInfo, function (e:Event):void {});			
		}
		protected function gotUpdateInfo(o:Object):void {
			gameCreditMsg = o.gameCredit;
			questionSet = o.questionset;
			creditMsg = o.credit + " EUR";
			trace("Update: gameCredit:" +  gameCreditMsg);
		}


		private function pn_registerSuccessHandler( event:PushNotificationEvent ):void
		{
			trace( "PN registration succeeded with reg ID: \n" + event.data  );
			pnRegId = event.data;
			var variables:URLVariables = new URLVariables();
			variables.token=event.data;
			apiCall("pnRegister", variables, function(o:Object):void {});
		}		
		
		private function pn_notificationHandler( event:PushNotificationEvent ):void
		{
			trace("Remote notification received!" );
		}

		private function pn_errorHandler( event:PushNotificationEvent ):void
		{
			trace("pnError:"+event.data);
		}

		
	}
}

class SingletonEnforcer {}


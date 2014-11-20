package hra
{
	import flash.events.Event;
	import flash.net.URLVariables;
	
	import spark.components.View;
	import spark.components.ViewNavigator;
	
	import views.betNewView;
	import views.betsView;
	import views.gameIntroView;
	import views.loginView;
	
	public class HomeBase extends View
	{
		[Bindable]
		public var model:Model = Model.getInstance();

		protected function goTry():void {
			navigator.pushView(gameIntroView, {gameMode:'try'});
		}
		
		protected function goPlay():void {
			if (!model.logged) {
				model.okno("Nejste přihlášeni","Pro vstup do sekce musíte být přihlášeni",true,false,false, function (e:Event):void {
					model.mNavigator.pushView(loginView, {
						onloginview: gameIntroView,
						onlogindata: {gameMode:'game', gameAmount: model.gameCreditMsg, gamePartner:""}
					});
				});
				return;
			}
			navigator.pushView(gameIntroView, {gameMode:'game', gameAmount: model.gameCreditMsg, gamePartner:""});
		}
		
		protected function goNewBid():void {
			if (!model.logged) {
				model.okno("Nejste přihlášeni","Pro vstup do sekce musíte být přihlášeni",true,false,false, function (e:Event):void {
					model.mNavigator.pushView(loginView, {
						onloginview: betNewView,
						onlogindata: {}
					});
				});
				return;
			}
			navigator.pushView(betNewView);
		}

		protected function goMyBids():void {
			if (!model.logged) {
				model.okno("Nejste přihlášeni","Pro vstup do sekce musíte být přihlášeni",true,false,false, function (e:Event):void {
					model.mNavigator.pushView(loginView, {
						onloginview: betsView,
						onlogindata: {}
					});
				});
				return;
			}
			navigator.pushView(betsView);
		}

		protected function goLogin():void {
			navigator.pushView(loginView);
			
		}



		
		
	}
}
package octane.api.integration;

import octane.api.IDestroyable;
import octane.types.Currency;
//import superslick.externs.common.gamebridge.GameBridge.TrackPageEventParams;
//import superslick.externs.common.gamebridge.GameBridge.TrackPageViewParams;

/**
 * ...
 * @author Dylan Heyes
 */
interface IIntegrator extends IDestroyable
{
	/**
	 * Tells the wrapper to hide chat.
	 */
	function chatOff():Void;
	
	
	/**
	 * Tells the wrapper to display chat.
	 */
	function chatOn():Void;
	
	
	/**
	 * Tells the wrapper whether to show a confirmation alert when a player 
	 * tries to exit the game or not.
	 */
	function confirmExit():Void;
	
	
	/**
	 * Tells the wrapper that the game lost connection which shows a 
	 * connection error popup with an option to retry.
	 * 
	 * Note that pressing `retry` button will trigger `RESET` event.
	 */
	function disconnectedError():Void;
	
	
	/**
	 * Tells the wrapper to show eligibility alert window with title and 
	 * content passed in as arguments.
	 * 
	 * Player can only go back to the lobby from the window.
	 */
	function eligibilityAlert():Void;
	
	
	/**
	 * Tells the wrapper to exit which takes the player back to lobby.
	 * 
	 * If `confirmExit(true)` was called with true before calling exit then a 
	 * confirmation alert will appear for the player to confirm they wish to exit.
	 */
	function exit():Void;
	
	
	/**
	 * Tells the wrapper that the game is in busy state.
	 * For example, when the reels are spinning.
	 */
	function gameBusy():Void;
	
	
	/**
	 * Tells the wrapper that the game is not busy.
	 */
	function gameNotBusy():Void;
	
	
	/**
	 * Dispatches the game loaded event to the wrapper, to inform it that the 
	 * game has finished loading.
	 * 
	 * This should be sent when the game finishes loading all the assets.
	 */
	function gameLoaded():Void;
	
	
	/**
	 * Tells the wrapper that the game is ready.
	 * 
	 * This should be sent when the game is setup and ready to display the 
	 * loading screen.
	 */
	function gameReady():Void;
	
	
	/**
	 * Tells the wrapper to show a generic error popup with an option to go to 
	 * lobby or retry.
	 * 
	 * Note that pressing `retry` button will trigger `RESET` event.
	 */
	function genericError():Void;
	
	
	/**
	 * Tells the wrapper to take the player to deposit page.
	 */
	function goToDeposit():Void;
	
	
	/**
	 * Tells the wrapper to hide the home/profile button.
	 */
	function hideHomeButton():Void;
	
	
	/**
	 * Tells the wrapper to hide the orientation blocker.
	 * 
	 * The game should use the wrappers gameBridge.ORIENTATION_CHANGE event to 
	 * determine when the orientation has change (not window events) and check 
	 * that common.deviceInfo.orientation is supported.
	 * 
	 * If the orientation is supported and the orientation blocker has 
	 * previously been shown, the game should request that the orientation 
	 * blocker is hidden.
	 */
	function hideOrientationBlocker():Void;
	
	
	/**
	 * Tells the wrapper to remove the pay table. 
	 * 
	 * The paytable usually includes it's own close button but, if for any 
	 * reason the game is required to close the pay table, this method can 
	 * be used.
	 */
	function hidePaytable():Void;
	
	
	/**
	 * Tells the wrapper to hide the resize blocker.
	 * 
	 * If a game only supports certain sizes and it's not calling the 
	 * scaleToFit method, then it's the games responsibility to tell the 
	 * wrapper to display the resize blocker.
	 */
	function hideResizeBlocker():Void;
	
	
	/**
	 * Tells the wrapper that the player doesn't have enough funds which in 
	 * turn shows a popup with the option of going to deposit page or cancel.
	 */
	function insufficientFundsError():Void;
	
	
	/**
	 * Tells the wrapper to keep the session alive.
	 */
	function keepAlive():Void;
	
	
	/**
	 * Dispatches the load game event to the wrapper, which in turn triggers 
	 * a post message to the client to tell it to ask it to load the game 
	 * defined by the `gameKey` argument.
	 */
	function loadGame(gameKey:String):Void;
	
	
	/**
	 * Tells the wrapper that the player is not logged in which in turn shows a 
	 * popup with the option of going to lobby or login screen.
	 */
	function notLoggedInError():Void;
	
	
	/**
	 * Tells the wrapper to play for real which shows a confirmation alert to 
	 * be displayed.
	 */
	function playForReal():Void;
	
	
	/**
	 * Tells the wrapper to show sound preference popup.
	 * 
	 * It is recommended to call this before game starts loading any assets.
	 */
	function requestSoundPreferences():Void;
	
	
	/**
	 * Tells the wrapper to scale iFrame to the size passed in.
	 */
	function scaleToFit():Void;
	
	
	/**
	 * Tells the wrapper that the screen size is not supported which shows 
	 * the blocker.
	 * 
	 * To be called if the screen is smaller than the min size of the smallest 
	 * bucket or if the screen is larger than the max size of the largest bucket.
	 * 
	 * In both cases that game should not be loaded.
	 */
	function screenSizeNotSupported():Void;
	
	
	/**
	 * Tells the wrapper to set players balance.
	 * 
	 * This should always be called whenever there is an update on the balance 
	 * to reflect the correct balance on player's account page.
	 */
	function setBalance(amount:Currency):Void;
	
	
	/**
	 * Tells the wrapper to show the home/profile button.
	 */
	function showHomeButton():Void;
	
	
	/**
	 * Tells the wrapper to display the orientation blocker. 
	 * 
	 * If a game only supports certain orientations it is the games 
	 * responsibility to tell the wrapper to display the orientation blocker.
	 * 
	 * The game should use the wrappers gameBridge.ORIENTATION_CHANGE event 
	 * to determine when the orientation has change (not window events) and 
	 * check that common.deviceInfo.orientation is supported.
	 * 
	 * If the orientation is not supported the game should request that 
	 * the orientation blocker is displayed.
	 */
	function showOrientationBlocker():Void;
	
	
	/**
	 * Tells the wrapper to display the paytable.
	 * 
	 * It is the games responsibility to tell the wrapper to show the paytable 
	 * when the paytable button is clicked.
	 * 
	 * This could be in a event triggered from the gameUI or a custom paytable 
	 * button within the game.
	 */
	function showPaytable():Void;
	
	
	/**
	 * Tells the wrapper to display the resize blocker.
	 * 
	 * If a game only supports certain sizes and it's not calling the 
	 * scaleToFit method, then it's the games responsibility to tell the 
	 * wrapper to display the resize blocker.
	 */
	function showResizeBlocker():Void;
	
	
	/**
	 * Tells the wrapper that the sound is off.
	 * 
	 * This will set `gameProperties.sound` property to `false` when the 
	 * game is reloaded.
	 */
	function soundOff():Void;
	
	
	/**
	 * Tells the wrapper that the sound is on.
	 * 
	 * This will set `gameProperties.sound` property to `true` when the 
	 * game is reloaded.
	 */
	function soundOn():Void;
	
	
	/**
	 * Tells the wrapper to track page events.
	 */
	//function trackPageEvent(params:TrackPageEventParams):Void;
	
	
	/**
	 * Tells the wrapper to track page views.
	 */
	//function trackPageView(params:TrackPageViewParams):Void;
	
	
	/**
	 * Helper function to unlock audio on iOS devices.
	 */
	function unlockAudio():Void;
	
	
	/**
	 * (Undocumented, assumingly shows player profile).
	 */
	function showProfile():Void;
}
/* build index page */
var express = require('express');
var router = express.Router();
var root_page_title = "Real Time";
var default_zoom = 13;
var thisUser, recent_lat, recent_lng;

// if authenticated, respond to get index page
router.get('/', ensureAuthenticated, infoReady, function(req, res){
	res.render('root', {
		title:	root_page_title,
		user:	req.user._doc,
		lat:  recent_lat,
    	lng:  recent_lng,
    	zm:   default_zoom
	});
});

// check authentication status upon request comeing in
function ensureAuthenticated(req, res, next){
	if(req.isAuthenticated()){
		console.log("root.js -> User is logged in: %s", req.user._doc.username);
		thisUser = req.user._doc;
		return next();
	} else {
		console.log("root.js -> User is not logged in, redirect to /users/login...");
    	//req.flash('error_msg','You are not logged in');
		res.redirect('/users/login');
	}
}

// get needed info for this user
function infoReady(req, res, next){
	//console.log("index.js -> thisUser: %s", JSON.stringify(thisUser));
	recent_lat = 37.379322;
	recent_lng = -121.941046;
	return next();
}

module.exports = router;
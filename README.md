RcVAPI
======

an (unofficial) API for recoveryversion.org

returns verse text (only) for both OT and NT. support for footnotes and cross-references is not planned.

the official API can be found here: http://api.lsm.org/ and offers the same functionality, except it returns data in XML instead of JSON (and has different endpoints)

demo: rcvapi.herokuapp.com 

## Endpoints

Right now, the main goal is to support [OSIS](http://www.ccel.org/refsys/refsys.html) format, aiming at compatibility with [openbibleinfo](https://github.com/openbibleinfo/)'s [Bible Passage Reference Parser](https://github.com/ricefield/Bible-Passage-Reference-Parser), so the endpoints have been designed with that in mind. That being said, adding more endpoints is pretty trivial. Submit a pull request if you'd like to add an endpoint that would make your life easier.

* `/v/[book]/[chapter]/[verse]`

	example:  `http://rcvapi.herokuapp.com/v/john/3/16`

	returns:
	
	```
	{
		request: "john3:16",
		url: "http://online.recoveryversion.org/getScripture.asp?vinfo=john3:16",
		verses: {
			john.3.16: "For God so loved the world that He gave His only begotten Son, that every one who believes into Him would not perish, but would have eternal life."
		}
	}
	```
	
* `/vv/[begbook]/[begchapter]/[begverse]/[endbook]/[endchapter]/[endverse]`

	example: `http://rcvapi.herokuapp.com/vv/2cor/3/16/2cor/3/18`
	
	
	returns:
	
	```
	{
		request: "2cor3:16-2cor3:18",
		url: "http://online.recoveryversion.org/getScripture.asp?vinfo=2cor3:16-2cor3:18",
		verses: {
			2cor.3.16: "But whenever their heart turns to the Lord, the veil is taken away.",
			2cor.3.17: "And the Lord is the Spirit; and where the Spirit of the Lord is, there is freedom.",
			2cor.3.18: "But we all with unveiled face, beholding and reflecting like a mirror the glory of the Lord, are being transformed into the same image from glory to glory, even as from the Lord Spirit."
		}
	}
	```


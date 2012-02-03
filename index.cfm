<!--- ################## --->
<!--- chessPlay SETTINGS --->
<!--- ################## --->
    <cfset objChess = CreateObject('component', 'chess')>
    <cfparam name="fen" default="rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR">
    <cfparam name="cFen" default="rnbqkbnr/pppppppp/11111111/11111111/11111111/11111111/PPPPPPPP/RNBQKBNR">
    <cfparam name="activeTab" default="0">
    <!--- POSITION OF THE TOP OF BOARD px --->
    <cfset posTop = 8>
    <!--- POSITION OF THE LEFT OF BOARD px --->
    <cfset posLeft = 8>
    <!--- SIZE OF A BOARD SQUARE px --->
    <cfset posSq = 80>
    <!--- GET THE STARTING POSITIONS ( IT'S AN ARRAY OF STRINGS - THE STRINGS ARE THE CLASSES OF THE BOARD ELEMENTS --->
    <cfset aryChessboard = objChess.getStartingPositons() />
<!DOCTYPE html>
<head>
  <link rel='stylesheet' type='text/css' href='css/default.css' media='screen'/>
  <script src='http://code.jquery.com/jquery-1.7.1.min.js'></script>
  <script src='https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.16/jquery-ui.min.js'></script>
  <!--- LOAD THE JQUERY/JAVASCRIPT --->
  <cfinclude template="chessJS.cfm">
</head>
<body>
  <div id="content">
    <form name="frmControls" action="index.cfm" method="post" enctype="multipart/form-data">
      Fen Code
      <input name="fen" id="fen" size="50" value="<cfoutput>#fen#</cfoutput>">
      <input type="hidden" name="cFen" id="cFen" value="<cfoutput>#cFen#</cfoutput>">
      <input type="hidden" name="pieceMoved" id="pieceMoved" value="">
      <input type="hidden" name="pMoved" id="pMoved" value="">
      <input type="hidden" name="pFrom" id="pFrom" value="">
      <cfinclude template="chessPlay.cfm">
    </form>
  </div>
</body>
</html>